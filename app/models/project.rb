class Project < ActiveRecord::Base
  belongs_to :user
  has_many :reports, dependent: :destroy
  has_one :repository, dependent: :destroy

  validates_presence_of :user_id, :title
  accepts_nested_attributes_for :repository
  acts_as_taggable
end
