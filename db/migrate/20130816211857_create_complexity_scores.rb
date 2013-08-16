class CreateComplexityScores < ActiveRecord::Migration
  def change
    create_table :complexity_scores do |t|
      t.integer :score
      t.integer :target_method_id
      t.text :operators

      t.timestamps
    end
  end
end
