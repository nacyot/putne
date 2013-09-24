class CreateScoreCategories < ActiveRecord::Migration
  def change
    create_table :score_categories do |t|

      t.timestamps
    end
  end
end
