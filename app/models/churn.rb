class Churn < ActiveRecord::Base
  belongs_to :report
  belongs_to :targetable, polymorphic: true

  scope :file_churns, -> { where(targetable_type: "TargetFile") }
  scope :class_churns, -> { where(targetable_type: "TargetClass") }
  scope :method_churns, -> { where(targetable_type: "TargetMethod") }
end
