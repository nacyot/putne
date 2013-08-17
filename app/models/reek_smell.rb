class ReekSmell < ActiveRecord::Base
  belongs_to :target_file
  belongs_to :target_method
  belongs_to :target_class
  belongs_to :report
end
