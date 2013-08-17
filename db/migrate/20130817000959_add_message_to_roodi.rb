class AddMessageToRoodi < ActiveRecord::Migration
  def change
    add_column :roodis, :message, :string
  end
end
