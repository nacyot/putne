class Project < ActiveRecord::Base
  belongs_to :user
  has_many :reports
  has_one :repository

  validates_presence_of :user_id, :title
  accepts_nested_attributes_for :repository
  


  def create_repository
    repository = Repository.create!
    repository.create_workspace
  end

  def create_recent_report
    report = Report.new
    report.project = self
    create_repository
    branch = Branch.create! name: master, repository: reository
    commit = Commit.create! commit_hash: repository.recent_commit.id, repository: epository
    report.save!
    report.register_report
  end
end
