class AddTargetsToReek < ActiveRecord::Migration
  def change
    add_column :reek_smells, :target_file_id, :integer
    add_column :reek_smells, :target_class_id, :integer
  end
end
