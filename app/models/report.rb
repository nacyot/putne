class Report < ActiveRecord::Base
  include RegisterReport

  belongs_to :branch
  belongs_to :commit
  belongs_to :repository
  belongs_to :project
   
  has_many :target_files, dependent: :destroy
  has_many :target_classes, dependent: :destroy
  has_many :target_methods, dependent: :destroy
  has_many :scores, dependent: :destroy
  has_many :smells, dependent: :destroy

  has_many :duplications, dependent: :destroy

  validates_presence_of :project, :branch, :commit, :repository
  validates_uniqueness_of :commit

  default_scope -> { order("") }
  
  def input_stats
    update_attributes(churn_stat: sum_churns,
                      complexity_stat: sum_complexities,
                      duplication_stat: sum_duplications,
                      smell_stat: sum_smells,
                      commit_stat: sum_commits,
                      branche_stat: sum_branches,
                      file_stat: sum_files,
                      class_stat: sum_classes,
                      method_stat: sum_methods
                      )
  end

  def sum_churns
    scores.churns.sum(:score)
  end

  def sum_complexities
    scores.flogs.type_method.sum(:score)
  end

  def sum_duplications
    duplications.count
  end

  def sum_smells
    smells.reeks.count
  end

  def sum_branches
    repository.git.branches.count
  end
  
  def sum_commits
    repository.git.stats.count
  end

  def sum_files
    target_files.count
  end

  def sum_classes
    target_classes.count
  end

  def sum_methods
    target_methods.count
  end

  def register_class_scores(category, source)
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

  def flog_scores
    target_classes.map { |klass| {name: klass.name, size: klass.scores.flogs[0].score, path: klass.target_file.path } }
      .delete_if { |hash| hash[:size] == 0} 
    
  end

  def flog_scores_group_by_path
    flogs = flog_scores.group_by { |score| File.dirname(score[:path]) }
    flogs.map {|key, content| {name: key, children: content} }
  end
end

