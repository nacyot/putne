class Project < ActiveRecord::Base
  has_many :reports
  has_one :repository

  def register_sample_report
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
      report.register_flogs
    end
  end

  def register_report
    unless id.nil?
      report = Report.new
      report.project = self
      report.branch = Branch.create!
      report.repository = Repository.create!
      report.commit = Commit.create!
      report.save!

      report.register_files_churn target: get_metrics_from_github
      report.register_classes_churn target: get_metrics_from_github
      report.register_methods_churn target: get_metrics_from_github
      report.register_flogs target: get_metrics_from_github
    end
  end

  def get_metrics_from_github
    project_name = extract_project_name(repository_url)
    
    `cd #{ Rails.root }`
    `mkdir -p tmp/workspace`
    `cd tmp/workspace`
    `rm -rf #{ project_name }`
    `git clone #{ repository_url }`
    `cd #{ project_name }`
    `metric_fu -r`

    Rails.root.join("tmp", "workspace", project_name, "tmp", "metric_fu", "output.yml")
  end

  def extract_project_name(target)
    target.split("/")[-1].split(".git")[0]
  end
end
