class FileLineInfo < ActiveRecord::Base
  belongs_to :lineable, polymorphic: true
end
