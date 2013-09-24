class RefineScoreAndSmell < ActiveRecord::Migration
  def change
    remove_column :scores, :smell_category_id
    add_column :scores, :score_category_id, :integer
    add_column :scores, :score_soucre_id, :integer
    add_column :smells, :smell_category_id, :integer
    add_column :smells, :smell_soucre_id, :integer
end
end
