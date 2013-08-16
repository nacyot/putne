class Project < ActiveRecord::Base
  has_many :reports
  has_one :repository

  def register_report
    unless id.nil?
      report = Report.new
      report.projcet = self
      report.branch = Branch.create!
      report.repository = project.repository
      report.commit = Commit.create!
    end

    report.register_churn
  end
end
