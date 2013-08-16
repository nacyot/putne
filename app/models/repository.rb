class Repository < ActiveRecord::Base
  has_many :branches
  has_many :commits
end
