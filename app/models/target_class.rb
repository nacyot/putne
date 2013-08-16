class TargetClass < ActiveRecord::Base
  belongs_to :report
  belongs_to :target_file
  has_one :churn, as: :targetable
  has_many :target_methods

  default_scope  order("name")
end
