class Project < ActiveRecord::Base
  belongs_to :user
  has_many :reports
  has_one :repository

  validates_presence_of :user_id, :title
  accepts_nested_attributes_for :repository

  def create_recent_report
    reports << Report.create!(project: self,
                              repository: repository,
                              branch: Branch.find_or_create_by!(repository: repository, name: "master"), 
                              commit: Commit.create!(repository: repository, commit_hash: repository.recent_commit.id)
                              )
                              
    reports.last.register_report
  end
end
