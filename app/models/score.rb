class Score < ActiveRecord::Base
  belongs_to :report
  belongs_to :score_category
  belongs_to :score_source
  belongs_to :targetable, polymorphic: true

  validates_presence_of :targetable_id, :targetable_type, :report, :score, :score_category, :score_source

  scope :flogs, -> { where(score_category: ScoreCategory.find_by(name: "COMPLEXITY"), score_source: ScoreSource.find_by(name: "FLOG"))  }
  scope :saikuros, -> { where(score_category: ScoreCategory.find_by(name: "COMPLEXITY"), score_source: ScoreSource.find_by(name: "SAIKURO")) }
  scope :locs, -> { where(score_category: ScoreCategory.find_by(name: "LOC"), score_source: ScoreSource.find_by(name: "SAIKURO"))  }
end
