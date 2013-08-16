class CreateFileLineInfos < ActiveRecord::Migration
  def change
    create_table :file_line_infos do |t|
      t.integer :target_file_id
      t.integer :line_num
      t.string :lineable_type
      t.integer :lineable_id

      t.timestamps
    end
  end
end
