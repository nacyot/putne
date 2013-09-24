class RenameColumnsInScores < ActiveRecord::Migration
  def change
    rename_column :scores, :score_soucre_id, :score_source_id
    rename_column :smells, :smell_soucre_id, :smell_source_id
  end
end
