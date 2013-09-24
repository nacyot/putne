class SmellCategory < ActiveRecord::Base
  has_many :smells

  validates_presence_of :name
end
