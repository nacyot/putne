class ComplexityScore < ActiveRecord::Base
  belongs_to :report
  belongs_to :target_method
end
