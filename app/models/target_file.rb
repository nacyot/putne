class TargetFile < ActiveRecord::Base
  belongs_to :report
  has_one :churn, as: :targetable

  has_many :scores, as: targetable
  has_many :smells, as: targetable
  
  # decapreted
  has_many :roodi
  has_many :target_classes
  has_many :reek_smells

  validates :path, :uniqueness => {
    :scope => :report_id,
    :message => 'cannot have two category with same path and report_id'}

  validates_presence_of :path, :report, :name
 
  default_scope order('path')

end
