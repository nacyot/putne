class SourceCategory < ActiveRecord::Base
  has_many :scores
  has_many :smells
end
