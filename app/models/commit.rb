class Commit < ActiveRecord::Base
  belongs_to :repository

  validates_uniqueness_of :commit_hash
end
