class Smells < ActiveRecord::Base
  belongs_to :report
  belongs_to :smell_category
  belongs_to :smell_source
  belongs_to :targetable, polymorphic: true
end
