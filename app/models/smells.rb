class Smells < ActiveRecord::Base
  belongs_to :report
  belongs_to :target
  belongs_to :report
end
