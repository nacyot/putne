module RegisterReport
  extend ActiveSupport::Concern

  def get_metrics
    Dir.chdir repository.workspace_path
    `echo "MetricFu::Configuration.run { |config| config.flog = config.flog.merge({continue: true}) }" > .metrics`
    `metric_fu -r --format yaml`
  end
   
  def report_directory
    Rails.root.join("tmp", "workspace", repository.git_project_name, "tmp", "metric_fu", "report.yml") 
  end
  
  def register_report  
    if id?
      get_metrics
      
      register_files_churn 
      register_classes_churn 
      register_methods_churn 
      register_flogs 
      register_saikuro 
      register_reeks 
      register_roodi 
      register_duplication 

      #rm_github_repository
    end
  end

  def register_files_churn
    report = MetricFuReport::ChurnParser.new report_directory
    report.parse_files_churn.each do |churn|
      file_path = churn[:file_path]
      times_changed = churn[:times_changed]

      TargetFile.create(name: File.basename(file_path),
                        path: file_path,
                        report: self,
                        churn: Churn.create(times_changed: times_changed, report: self )
                        )

    end
  rescue
  end

  def register_classes_churn
    report = MetricFuReport::ChurnParser.new report_directory   
    report.parse_classes_churn.each do |churn|
      file_path = churn["klass"]["file"]
      class_name = churn["klass"]["klass"]
      times_changed = churn["times_changed"]

      target_file = TargetFile.find_or_create_by path: file_path, report: self, name: File.basename(file_path)
      target_class = TargetClass.create name: class_name, report: self, target_file_id: target_file.id
      target_class.churn = Churn.create(times_changed: times_changed, report: self)
    end
  rescue
  end

  def register_methods_churn
    report = MetricFuReport::ChurnParser.new report_directory
    report.parse_methods_churn.each do |churn|
      file_path = churn["method"]["file"]
      class_name = churn["method"]["klass"]
      method_name = churn["method"]["method"]
      times_changed = churn["times_changed"]

      target_file = TargetFile.find_or_create_by path: file_path, report: self, name: File.basename(file_path)
      target_class = TargetClass.find_or_create_by name: class_name, report: self, target_file_id: target_file.id
      target_method = TargetMethod.create name: method_name, report: self, target_class_id: target_class.id
      target_method.churn = Churn.create(times_changed: times_changed, report: self)
    end
  rescue
  end

  def register_flogs
    report = MetricFuReport::FlogParser.new report_directory
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
        target_method.complexity_score = ComplexityScore.create! flog_score: method[1][:score], report: self
      end
    end
    rescue
  end

  def register_reeks
    report = MetricFuReport::ReekParser.new report_directory
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
        ReekSmell.create(message: message,
                         warn_type: warn_type,
                         report: self,
                         target_class: target_class,
                         target_method: target_method,
                         target_file: target_file)
      end
    end
    rescue
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
    report.methods.each do |method|
      method_name = method[:name]
      class_name = method[:name].split("#")[0]
      lines = method[:lines]
      saikuro_score = method[:complexity]

      target_class = TargetClass.find_or_create_by name: class_name, report: self
      target_method = TargetMethod.find_or_create_by name: method_name, report: self, target_class_id: target_class.id
      if target_method.complexity_score.nil?
        target_method.complexity_score = ComplexityScore.create saikuro_score: saikuro_score, lines: lines, report: self
      else
        target_method.complexity_score.saikuro_score = saikuro_score
        target_method.complexity_score.lines = lines
        target_method.complexity_score.save
      end
    end
    rescue
  end

  def register_roodi
    report = MetricFuReport::RoodiParser.new report_directory
    report.problems.each do |problem|

      file_path = problem[:file]
      line_num = problem[:line]
      message = problem[:problem]

      target_file = TargetFile.find_or_create_by path: file_path, report: self, name: File.basename(file_path)
      Roodi.create report: self, message: message, file_line_info: FileLineInfo.create(line_num: line_num, target_file_id: target_file.id)

    end
  rescue
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
  rescue
  end
end

 
