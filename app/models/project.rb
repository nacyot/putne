class Project < ActiveRecord::Base
  belongs_to :user
  has_many :reports, dependent: :destroy
  has_one :repository, dependent: :destroy

  validates_presence_of :user_id, :title
  accepts_nested_attributes_for :repository
  acts_as_taggable

  def reports_by_day
    reports.includes(:commit).to_a.uniq{ |report| report.commit.committed_at.strftime("%Y%m%d")}
  end

  def latest_report
    reports.includes(:commit).to_a.uniq{ |report| report.commit.committed_at.strftime("%Y%m%d")}[-1]
  end
end
