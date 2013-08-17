class Project < ActiveRecord::Base
  belongs_to :user
  has_many :reports
  has_one :repository

  validates_presence_of :user_id, :title, :repository_type, :repository_url

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
      target = report_directory
      
      report = Report.new
      report.project = self
      report.branch = Branch.create!
      report.repository = Repository.create!
      report.commit = Commit.create!
      report.save!

      create_reports report, target
     
      rm_github_repository
    end
  end

  def create_reports(report, target)
    report.register_files_churn target
    report.register_classes_churn target
    report.register_methods_churn target
    report.register_flogs target
    report.register_saikuro target
    report.register_reeks target
    report.register_roodi target
    report.register_duplication target
  end
  
  def get_metrics_from_github
    Dir.chdir Rails.root
    `mkdir -p tmp/workspace`
    Dir.chdir 'tmp/workspace'
    `git clone #{ repository_url }`
    puts Dir.pwd
    Dir.chdir "#{ project_name }"
    puts Dir.pwd
    `metric_fu -r --format yaml`
  end
  
  def report_directory
    Rails.root.join("tmp", "workspace", project_name, "tmp", "metric_fu", "report.yml") 
  end
  
  def rm_github_repository
    Dir.chdir Rails.root
    #`rm -rf tmp/workspace/#{ project_name }`
  end

  def project_name
    extract_project_name(repository_url)
  end
  
  def extract_project_name(target)
    target.split("/")[-1].split(".git")[0]
  end
end
