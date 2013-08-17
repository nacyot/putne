class CreateRoodis < ActiveRecord::Migration
  def change
    create_table :roodis do |t|
      t.integer :target_file_id
      t.integer :report_id

      t.timestamps
    end
  end
end
