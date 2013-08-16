class Repository < ActiveRecord::Base
  belongs_to :project
  
  has_many :branches
  has_many :commits
end
