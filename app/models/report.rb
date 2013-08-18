class Report < ActiveRecord::Base
  include RegisterReport

  belongs_to :branch
  belongs_to :commit
  belongs_to :repository
  belongs_to :project
  
  has_many :target_files
  has_many :target_classes
  has_many :target_methods

  has_many :churns
  has_many :reek_smells
  has_many :roodis
  has_many :duplications
  has_many :complexity_scores

  validates_presence_of :project, :branch, :commit, :repository


end
