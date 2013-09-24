class Smells < ActiveRecord::Base
  belongs_to :report
  belongs_to :source_category
  belongs_to :targetable, polymorphic: true
end
