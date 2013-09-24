class CreateScoreSources < ActiveRecord::Migration
  def change
    create_table :score_sources do |t|
      t.string :name

      t.timestamps
    end
  end
end
