class Duplication < ActiveRecord::Base
  belongs_to :report
  has_many :file_line_infos, as: :lineable
end
