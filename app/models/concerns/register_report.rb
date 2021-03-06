module RegisterReport
  extend ActiveSupport::Concern

  def get_metrics
    Dir.chdir Rails.root
    Dir.chdir repository.workspace_path
    #`echo "MetricFu::Configuration.run { |config| config.flog = config.flog.merge({continue: true}) }" > .metrics`
    `echo "MetricFu.configuration { |config| config.configure_metric(:flog) { |flog| flog.continue = true }}" > .metrics`
    `metric_fu -r --format yaml`
  end
   
  def report_directory
    Rails.root.join("tmp", "workspace", repository.git_project_name, "tmp", "metric_fu", "report.yml") 
  end
  
  def register_report  
    if id?
      get_metrics

      puts "========================"
      register_files_churn 
      register_classes_churn 
      register_methods_churn 
      register_flogs 
      register_saikuro 
      register_reeks 
      register_roodi 
      register_duplication
      puts "========================"

      register_class_scores
      #rm_github_repository
    end
  end

  def register_files_churn
    report = MetricFuReport::ChurnParser.new report_directory

    score_category = ScoreCategory.find_or_create_by name: "CHURN"
    score_source = ScoreSource.find_or_create_by name: "FILE_CHURN"

    pp score_category
    pp score_source
    
    report.parse_files_churn.each do |churn|
      file_path = churn[:file_path]
      times_changed = churn[:times_changed]

      target_file = TargetFile.find_or_create_by path: file_path, report: self, name: File.basename(file_path)
       Score.create!(score_category: score_category,
                     score_source: score_source,
                     score: times_changed,
                     report: self,
                     targetable: target_file
                     )
    
    end
  rescue => e
    puts "Raise error"
    puts e
  end

  def register_classes_churn
    report = MetricFuReport::ChurnParser.new report_directory
    score_category = ScoreCategory.find_or_create_by name: "CHURN"
    score_source = ScoreSource.find_or_create_by name: "CLASS_CHURN"

    report.parse_classes_churn.each do |churn|
      file_path = churn["klass"]["file"]
      class_name = churn["klass"]["klass"]
      times_changed = churn["times_changed"]

      target_file = TargetFile.find_or_create_by path: file_path, report: self, name: File.basename(file_path)
      target_class = TargetClass.create name: class_name, report: self, target_file_id: target_file.id

      Score.create(score_category: score_category,
                   score_source: score_source,
                   score: times_changed,
                   report: self,
                   targetable: target_class
                   )
    end
  rescue => e
    puts "Raise error"
    puts e
  end

  def register_methods_churn
    report = MetricFuReport::ChurnParser.new report_directory
    score_category = ScoreCategory.find_or_create_by name: "CHURN"
    score_source = ScoreSource.find_or_create_by name: "METHOD_CHURN"
    
    report.parse_methods_churn.each do |churn|
      file_path = churn["method"]["file"]
      class_name = churn["method"]["klass"]
      method_name = churn["method"]["method"]
      times_changed = churn["times_changed"]

      target_file = TargetFile.find_or_create_by path: file_path, report: self, name: File.basename(file_path)
      target_class = TargetClass.find_or_create_by name: class_name, report: self, target_file_id: target_file.id
      target_method = TargetMethod.create name: method_name, report: self, target_class_id: target_class.id

      Score.create(score_category: score_category,
                   score_source: score_source,
                   score: times_changed,
                   report: self,
                   targetable: target_method
                   )
    end
  rescue => e
    puts "Raise error"
    puts e
  end

  def register_flogs
    report = MetricFuReport::FlogParser.new report_directory

    score_category = ScoreCategory.find_or_create_by name: "COMPLEXITY"
    score_source = ScoreSource.find_or_create_by name: "FLOG"
    
    report.klasses.each do |klass|
      klass_name = klass[:name]
      file_path = klass[:path]
      total_score = klass[:total_score]
      highest_score = klass[:highist_score]
      average_score = klass[:average_score]

      if klass_name == "main"
        next
      end

      unless klass_name.split("::")[-1] =~ /[A-Z]/
        klass_name = klass_name.split("::")[0..-2].join("::")
      end

      target_file = TargetFile.find_or_create_by path: file_path, report: self, name: File.basename(file_path)
      target_class = TargetClass.find_or_create_by name: klass_name, report: self, target_file_id: target_file.id

      klass[:methods].each do |method|
        if method[0] =~ /#/ or method[0] =~ /^[a-zA-Z]+$/
          method_name = method[0]
        else
          method_name = method[0].split("::")[0..-2].join("::") + "#self." + method[0].split("::")[-1]
        end

        target_method = TargetMethod.find_or_create_by name: method_name, report: self, target_class_id: target_class.id
        Score.create(score_category: score_category,
                     score_source: score_source,
                     score: method[1][:score],
                     report: self,
                     targetable: target_method
                     )
      end
    end
  rescue => e
    puts "Raise error"
    puts e
  end

  def register_reeks
    report = MetricFuReport::ReekParser.new report_directory
    smell_category = SmellCategory.find_or_create_by name: "SMELL"
    smell_source = SmellSource.find_or_create_by name: "REEK"
    
    report.matches.each do |match|
      file_path = match[:file_path]

      target_file = TargetFile.find_or_create_by path: file_path, report: self, name: File.basename(file_path)

      match[:code_smells].each do |smell|
        method_name = smell[:method]
        if smell[:method] =~ /#/
          klass_name = smell[:method].split("#")[0]
        else
          klass_name = smell[:method]
        end
        message = smell[:message]
        warn_type = smell[:type]
        
        target_class = TargetClass.find_or_create_by(name: klass_name, report: self, target_file_id: target_file.id)
        target_method = TargetMethod.find_or_create_by(name: method_name, report: self, target_class_id: target_class.id)

        Smell.create(
                     smell_category: smell_category,
                     smell_source: smell_source,
                     smell: warn_type,
                     message: message,
                     report: self,
                     targetable: target_class
                     )
        

        Smell.create(
                     smell_category: smell_category,
                     smell_source: smell_source,
                     smell: warn_type,
                     message: message,
                     report: self,
                     targetable: target_method
                     )                             
      end
    end
    
  rescue => e
    puts "Raise error"
    puts e
  end

  # def register_saikuro(target = nil)
  #   report = MetricFuReport::SaikuroParser.new report_directory
  #   report.files.each do |method|
  #     method_name = method[:name]
  #     class_name = method[:name].split("#")[0] if method[:name] =~ /#/
  #     lines = method[:lines]
  #     saikuro_score = method[:complexity]

      
  #     target_class = TargetClass.find name: class_name, report: self
  #     target_method = TargetMethod.find_or_create_by name: method_name, report: self, target_class_id: target_class.id
  #     if target_method.complexity_score.nil?
  #       target_method.complexity_score = ComplexityScore.create!(saikuro_score: saikuro_score, lines: lines)
  #     else
  #       target_method.complexity_score.saikuro_score = saikuro_score
  #       target_method.complexity_score.lines = lines
  #       target_method.complexity_score.save
  #     end
  #   end
  # end

  def register_saikuro
    report = MetricFuReport::SaikuroParser.new report_directory
    score_category = ScoreCategory.find_or_create_by name: "COMPLEXITY"
    score_category_loc = ScoreCategory.find_or_create_by name: "LOC"
    score_source = ScoreSource.find_or_create_by name: "SAIKURO"

    report.methods.each do |method|
      method_name = method[:name]
      class_name = method[:name].split("#")[0]
      lines = method[:lines]
      saikuro_score = method[:complexity]

      target_class = TargetClass.find_or_create_by name: class_name, report: self
      target_method = TargetMethod.find_or_create_by name: method_name, report: self, target_class_id: target_class.id

      Score.create(
                   score_category: score_category,
                   score_source: score_source,
                   score: saikuro_score,
                   report: self,
                   targetable: target_method
                   )

      Score.create(
                   score_category: score_category_loc,
                   score_source: score_source,
                   score: lines,
                   report: self,
                   targetable: target_method
                   )
    end
  rescue => e
    puts "Raise error"
    puts e
  end

  def register_roodi
    report = MetricFuReport::RoodiParser.new report_directory

    smell_category = SmellCategory.find_or_create_by name: "SMELL"
    smell_source = SmellSource.find_or_create_by name: "ROODI"

    report.problems.each do |problem|

      file_path = problem[:file]
      line_num = problem[:line]
      message = problem[:problem]

      target_file = TargetFile.find_or_create_by path: file_path, report: self, name: File.basename(file_path)
      Smell.create(
                   smell_category: smell_category,
                   smell_source: smell_source,
                   smell: warn_type,
                   message: message,
                   report: self,
                   targetable: target_file,
                   file_line_info: FileLineInfo.create(line_num: line_num, target_file: target_file)
                   )
    end
  rescue => e
    puts "Raise error"
    puts e
  end

  def register_duplication
    report = MetricFuReport::FlayParser.new report_directory
    report.matches.each do |match|
      reason = match[:reason]

      dup = Duplication.create report: self, message: reason
       
      match[:matches].each do |file|
        file_path = file[:name]
        line_num = file[:line]
        
        target_file = TargetFile.find_or_create_by path: file_path, report: self, name: File.basename(file_path)
        dup.file_line_infos << FileLineInfo.create(line_num: line_num, target_file_id: target_file.id)
      end
    end

  rescue => e
    puts "Raise error"
    puts e
  end

  def register_class_scores
    register_class_score("COMPLEXITY", "FLOG")
    register_class_score("COMPLEXITY", "SAIKURO")
    register_class_score("LOC", "SAIKURO")
  end
  
  def register_class_score(category, source)
    category = ScoreCategory.find_by(name: category) if category.instance_of?(String)
    source = ScoreSource.find_by(name: source) if source.instance_of?(String)
    
    target_classes.includes(:target_methods).each do |klass|
      class_score =  klass.target_methods.includes(:scores).inject(0) do |sum, method|
        method_score = method.scores.find_by(score_category: category, score_source: source)
        sum += method_score.nil? ? 0 : method_score.score
      end
      
      Score.create!(score_category: category,
                    score_source: source,
                    score: (class_score ? class_score : 0),
                    report: self,
                    targetable: klass
                    )

      
    end
  end
 
end
