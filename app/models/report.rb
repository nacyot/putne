class Report < ActiveRecord::Base
  belongs_to :branch
  belongs_to :commit
  belongs_to :repository
  
  has_many :target_files
  has_many :target_classes
  has_many :target_methods
end
