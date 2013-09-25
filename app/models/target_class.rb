class TargetClass < ActiveRecord::Base
  belongs_to :report
  belongs_to :target_file

  has_many :target_methods, dependent: :destroy
  has_many :scores, as: :targetable, dependent: :destroy
  has_many :smells, as: :targetable, dependent: :destroy

  validates_presence_of :report, :name, :target_file
  
  default_scope order("name")

end
