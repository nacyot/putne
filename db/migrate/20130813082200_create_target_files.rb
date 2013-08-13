class CreateTargetFiles < ActiveRecord::Migration
  def change
    create_table :target_files do |t|
      t.string :name
      t.string :path
      t.string :report_id

      t.timestamps
    end
  end
end
