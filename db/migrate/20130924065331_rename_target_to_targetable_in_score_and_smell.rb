class RenameTargetToTargetableInScoreAndSmell < ActiveRecord::Migration
  def change
    rename_column :scores, :target_id, :targetable_id
    rename_column :scores, :target_type, :targetable_type
    rename_column :smells, :target_id, :targetable_id
    rename_column :smells, :target_type, :targetable_type
  end
end
