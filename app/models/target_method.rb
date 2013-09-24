class TargetMethod < ActiveRecord::Base
  belongs_to :report
  belongs_to :target_class

  has_many :scores, as: targetable
  has_many :smells, as: targetable
  
  # decapreted!
  has_one :churn, as: :targetable
  has_one :complexity_score
  has_many :reek_smells

  validates_presence_of :report, :target_class, :name
  validates :name, :format => { with: /[#:]/ } 

end
