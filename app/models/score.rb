class Score < ActiveRecord::Base
  belongs_to :report
  belongs_to :score_category
  belongs_to :score_source
  belongs_to :targetable, polymorphic: true

  validates_presence_of :targetable_id, :targetable_type, :report, :score, :score_category, :score_source

  scope :ordered, -> { order "score" }
  scope :reverse_ordered, -> { order "score desc" }

  scope :type_file, -> { where(targetable_type: "Targetfile") }
  scope :type_class, -> { where(targetable_type: "TargetClass") }
  scope :type_method, -> { where(targetable_type: "TargetMethod") }

  scope :churns, -> { where(score_category: ScoreCategory.find_by(name: "CHURN")) }
  scope :file_churns, -> { where(score_source: ScoreSource.find_by(name: "FILE_CHURN"))  }
  scope :class_churns, -> { where(score_source: ScoreSource.find_by(name: "CLASS_CHURN"))  }
  scope :method_churns, -> { where(score_source: ScoreSource.find_by(name: "METHOD_CHURN"))  }

  scope :flogs, -> { where(score_category: ScoreCategory.find_by(name: "COMPLEXITY"), score_source: ScoreSource.find_by(name: "FLOG"))  }
  scope :saikuros, -> { where(score_category: ScoreCategory.find_by(name: "COMPLEXITY"), score_source: ScoreSource.find_by(name: "SAIKURO")) }
  scope :locs, -> { where(score_category: ScoreCategory.find_by(name: "LOC"), score_source: ScoreSource.find_by(name: "SAIKURO"))  }
end
