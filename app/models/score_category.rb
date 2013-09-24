class ScoreCategory < ActiveRecord::Base
  has_many :scores, dependent: :destroy
  
  validates_presence_of :name
  validates_uniqueness_of :name
end
