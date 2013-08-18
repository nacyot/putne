class Project < ActiveRecord::Base
  belongs_to :user
  has_many :reports
  has_one :repository

  validates_presence_of :user_id, :title
  accepts_nested_attributes_for :repository

  after_create :create_recent_report
  
end
