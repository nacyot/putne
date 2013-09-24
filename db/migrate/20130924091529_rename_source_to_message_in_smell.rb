class RenameSourceToMessageInSmell < ActiveRecord::Migration
  def change
    rename_column :smells, :source, :message
  end
end
