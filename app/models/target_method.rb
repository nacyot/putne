class TargetMethod < ActiveRecord::Base
  belongs_to :report
  belongs_to :target_class

  has_many :scores, as: :targetable
  has_many :smells, as: :targetable
  
  validates_presence_of :report, :target_class, :name
  validates :name, :format => { with: /[#:]/ } 
end
