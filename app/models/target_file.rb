class TargetFile < ActiveRecord::Base
  belongs_to :report
  has_many :churns, as: :targetable
end
