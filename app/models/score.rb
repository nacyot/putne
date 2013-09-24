class Score < ActiveRecord::Base
  belongs_to :report
  belongs_to :target
  belongs_to :report
  
  # scope :file_churns, -> { where(targetable_type: "TargetFile") }
  # scope :class_churns, -> { where(targetable_type: "TargetClass") }
  # scope :method_churns, -> { where(targetable_type: "TargetMethod") }
end
