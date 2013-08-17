class Roodi < ActiveRecord::Base
  belongs_to :report
  has_one :file_line_info, as: :lineable
end
