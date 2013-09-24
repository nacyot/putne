class TargetFile < ActiveRecord::Base
  belongs_to :report

  has_many :target_classes, dependent: :destroy
  has_many :scores, as: :targetable, dependent: :destroy
  has_many :smells, as: :targetable, dependent: :destroy
  
  validates :path, :uniqueness => {
    :scope => :report_id,
    :message => 'cannot have two category with same path and report_id'}

  validates_presence_of :path, :report, :name
 
  default_scope order('path')

end
