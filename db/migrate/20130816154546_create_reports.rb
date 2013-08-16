class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
      t.string :repository_id
      t.string :branch_id
      t.string :commit_id
      t.string :project_id

      t.timestamps
    end
  end
end
