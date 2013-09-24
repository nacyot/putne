class TargetClass < ActiveRecord::Base
  belongs_to :report
  belongs_to :target_file

  has_many :target_methods
  has_many :scores, as: :targetable
  has_many :smells, as: :targetable

  validates_presence_of :report, :name, :target_file
  
  default_scope order("name")
end
