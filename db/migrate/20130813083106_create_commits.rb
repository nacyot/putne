class CreateCommits < ActiveRecord::Migration
  def change
    create_table :commits do |t|
      t.string :hash
      t.integer :repository_id

      t.timestamps
    end
  end
end
