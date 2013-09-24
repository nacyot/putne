class ScoreSource < ActiveRecord::Base
  has_many :scores

  validates_presence_of :name
  validates_uniqueness_of :name
end
