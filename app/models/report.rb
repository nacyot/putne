class Report < ActiveRecord::Base
  belongs_to :branch
  belongs_to :commit
  belongs_to :repository
  belongs_to :project
  
  has_many :target_files
  has_many :target_classes
  has_many :target_methods

  validates_presence_of :project, :branch, :commit, :repository

  def register_files_churn
    report = MetricFuReport::ChurnParser.new(target: Rails.root.join('tmp', 'metric_fu', 'sample_data.yml'))
    report.parse_files_churn.each do |churn|
      file_path = churn[:file_path]
      times_changed = churn[:times_changed]

      TargetFile.create(name: File.basename(file_path),
                        path: file_path,
                        report: self,
                        churn: Churn.create(times_changed: times_changed,
                                             )
                        )

    end
  end

  def register_classes_churn
    report = MetricFuReport::ChurnParser.new(target: Rails.root.join('tmp', 'metric_fu', 'sample_data.yml'))
    report.parse_classes_churn.each do |churn|
      file_path = churn["klass"]["file"]
      class_name = churn["klass"]["klass"]
      times_changed = churn["times_changed"]

      target_file = TargetFile.find_or_create_by path: file_path, report: self, name: File.basename(file_path)
      target_class = TargetClass.create name: class_name, report: self, target_file: target_file
      target_class.churn = Churn.create(times_changed: times_changed)
    end
  end

  def register_methods_churn
    report = MetricFuReport::ChurnParser.new(target: Rails.root.join('tmp', 'metric_fu', 'sample_data.yml'))
    report.parse_methods_churn.each do |churn|
      file_path = churn["method"]["file"]
      class_name = churn["method"]["klass"]
      method_name = churn["method"]["method"]
      times_changed = churn["times_changed"]

      target_file = TargetFile.find_or_create_by path: file_path, report: self, name: File.basename(file_path)
      target_class = TargetClass.find_or_create_by name: class_name, report: self, target_file_id: target_file.id
      target_method = TargetMethod.create name: method_name, report: self, target_class_id: target_class.id
      target_method.churn = Churn.create(times_changed: times_changed)
    end
  end
end
