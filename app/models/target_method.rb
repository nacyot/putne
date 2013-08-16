class TargetMethod < ActiveRecord::Base
  belongs_to :report
  belongs_to :target_class
  has_one :churn, as: :targetable
  has_one :flog_score

  default_scope order('name')
end
