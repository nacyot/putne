class Score < ActiveRecord::Base
  belongs_to :score_category
  belongs_to :report
  belongs_to :targetable, polymorphic: true

  validates_presence_of :targetable_id, :targetable_type, :report, :score, :score_category

  # scope :file_churns, -> { where(targetable_type: "TargetFile") }
  # scope :class_churns, -> { where(targetable_type: "TargetClass") }
  # scope :method_churns, -> { where(targetable_type: "TargetMethod") }
end
