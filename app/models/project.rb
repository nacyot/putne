class Project < ActiveRecord::Base
  belongs_to :user
  has_many :reports
  has_one :repository

  validates_presence_of :user_id, :title, :repository_type, :repository_url

  def project_name
    repository_url.split("/")[-1].split(".git")[0]
  end

  def create_recent_report
    report = Report.new
    report.project = self
    report.branch = Branch.create!
    report.repository = Repository.create!
    report.commit = Commit.create!
    report.save!

    report.register_report
  end
end
