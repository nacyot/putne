class TargetFile < ActiveRecord::Base
  belongs_to :report
  has_one :churn, as: :targetable
end
