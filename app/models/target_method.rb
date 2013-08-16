class TargetMethod < ActiveRecord::Base
  belongs_to :report
  belongs_to :target_class
  has_one :churn, as: :targetable
  has_one :complexity_score
  has_many :reek_smells

  default_scope order('name')
end
