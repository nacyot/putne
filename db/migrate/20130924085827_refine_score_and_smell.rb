class RefineScoreAndSmell < ActiveRecord::Migration
  def change
    add_column :scores, :score_category_id, :integer
    add_column :scores, :score_soucre_id, :integer
    add_column :smells, :smell_category_id, :integer
    add_column :smells, :smell_soucre_id, :integer
  end
  
  def up
    remove_column :scores, :smell_category_id
  end

  def down
    add_column :scores, :smell_category_id, :integer
  end
end
