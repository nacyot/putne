class Report < ActiveRecord::Base
  belongs_to :branch
  belongs_to :commit
  belongs_to :repository
  belongs_to :project
  
  has_many :target_files
  has_many :target_classes
  has_many :target_methods

  validates_presence_of :project, :branch, :commit, :repository

  def register_churn
    report = MetricFuReport::ChurnParser.new(target: Rails.root.join('tmp', 'metric_fu', 'sample_data.yml'))
    report.parse_file_churns.each do |churn|
      pp churn
      file_path = churn[:file_path]
      times_changed = churn[:times_changed]

      TargetFile.create!(name: File.basename(file_path),
                         path: file_path,
                         report: self,
                         churn: Churn.create!(times_changed: times_changed,
                                              )
                         )

    end
  end
end
