class Smells < ActiveRecord::Base
  belongs_to :report
  belongs_to :targetable, polymorphic: true
end
