class CreateFlogScores < ActiveRecord::Migration
  def change
    create_table :flog_scores do |t|
      t.integer :target_method_id
      t.integer :score
      t.text :operators

      t.timestamps
    end
  end
end
