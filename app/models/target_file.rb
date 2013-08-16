class TargetFile < ActiveRecord::Base
  belongs_to :report
  has_one :churns, as: :targetable
end
