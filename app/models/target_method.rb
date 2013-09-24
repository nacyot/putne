class TargetMethod < ActiveRecord::Base
  belongs_to :report
  belongs_to :target_class

  has_many :scores, as: :targetable, dependent: :destroy
  has_many :smells, as: :targetable, dependent: :destroy
  
  validates_presence_of :report, :target_class, :name
  validates :name, :format => { with: /[#:]/ } 
end
