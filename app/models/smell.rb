class Smell < ActiveRecord::Base
  belongs_to :report
  belongs_to :smell_category
  belongs_to :smell_source
  belongs_to :targetable, polymorphic: true
  has_one :file_line_info, dependent: :destroy

  validates_presence_of :targetable_id, :targetable_type, :report, :smell_category, :smell_source

  # Ruby smell
  scope :reeks, -> { where(smell_category: SmellCategory.find_by(name: "SMELL"), smell_source: SmellSource.find_by(name: "REEK") ) }
  scope :roodis, -> { where(smell_category: SmellCategory.find_by(name: "SMELL"), smell_source: SmellSource.find_by(name: "ROODI") ) }
end
