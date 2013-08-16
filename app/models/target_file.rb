class TargetFile < ActiveRecord::Base
  belongs_to :report
  has_one :churn, as: :targetable
  has_many :target_classes

  validates :path, :uniqueness => {
    :scope => :report_id,
    :message => 'cannot have two category with same path and report_id
'}

end
