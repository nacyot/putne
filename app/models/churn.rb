class Churn < ActiveRecord::Base
  belongs_to :targetable, polymorphic: true
end
