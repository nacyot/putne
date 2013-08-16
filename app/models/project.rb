class Project < ActiveRecord::Base
  has_many :reports
  has_one :repository
end
