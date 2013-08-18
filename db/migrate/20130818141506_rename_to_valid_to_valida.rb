class RenameToValidToValida < ActiveRecord::Migration
  def change
    rename_column :repositories, :valid, :valida
  end
end
