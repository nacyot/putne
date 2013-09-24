class SmellSource < ActiveRecord::Base
  has_many :smells

  validates_presence_of :name
  validates_uniqueness_of :name
end
