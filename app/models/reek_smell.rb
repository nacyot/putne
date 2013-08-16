class ReekSmell < ActiveRecord::Base
  belongs_to :target_method
  belongs_to :report
end
