class Report < ActiveRecord::Base
  include RegisterReport

  belongs_to :branch
  belongs_to :commit
  belongs_to :repository
  belongs_to :project
  
  has_many :target_files
  has_many :target_classes
  has_many :target_methods

  has_many :churns
  has_many :reek_smells
  has_many :roodis
  has_many :duplications
  has_many :complexity_scores

  validates_presence_of :project, :branch, :commit, :repository

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
    churns.file_churns.sum(:times_changed)
  end

  def sum_complexities
    complexity_scores.sum(:flog_score)
  end

  def sum_duplications
    duplications.count
  end

  def sum_smells
    reek_smells.count
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
end
