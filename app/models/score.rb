class Score < ActiveRecord::Base
  belongs_to :report
  belongs_to :target
end
