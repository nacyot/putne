class CreateTargetFiles < ActiveRecord::Migration
  def change
    create_table :target_files do |t|
      t.string :name
      t.string :path
      t.integer :report_id

      t.timestamps
    end
  end
end
