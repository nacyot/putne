class FileLineInfo < ActiveRecord::Base
  belongs_to :lineable, polymorphic: true
  belongs_to :target_file
end
