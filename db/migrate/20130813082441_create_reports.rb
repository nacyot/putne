class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
      t.integer :repository_id
      t.integer :branch_id
      t.integer :commit_id
      t.integer :project_id

      t.timestamps
    end
  end
end
