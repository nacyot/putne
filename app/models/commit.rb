class Commit < ActiveRecord::Base
  belongs_to :repository
  has_one :report

  validates_uniqueness_of :commit_hash
end

