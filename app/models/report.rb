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

  def sum_churn
    churns.file_churns.sum(:times_changed)
  end

  def sum_complexity
    complexity_scores.sum(:flog_score)
  end

  def sum_duplication
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
