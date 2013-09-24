class SmellSource < ActiveRecord::Base
  has_many :smells, dependent: :destroy

  validates_presence_of :name
  validates_uniqueness_of :name
end
