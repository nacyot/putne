class Project < ActiveRecord::Base
  has_many :reports
  has_one :repository

  def register_report
    unless id.nil?
      report = Report.new
      report.project = self
      report.branch = Branch.create!
      report.repository = Repository.create!
      report.commit = Commit.create!
      report.save!

      report.register_files_churn
      report.register_classes_churn
      report.register_methods_churn
    end
  end
end
