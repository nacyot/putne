class CreateRepositories < ActiveRecord::Migration
  def change
    create_table :repositories do |t|
      t.string :name
      t.string :repository_type
      t.string :repository_url
      t.integer :project_id

      t.timestamps
    end
  end
end
