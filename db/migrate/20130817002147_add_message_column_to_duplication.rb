class AddMessageColumnToDuplication < ActiveRecord::Migration
  def change
    add_column :duplications, :message, :string
  end
end
