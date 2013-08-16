class CreateFileLines < ActiveRecord::Migration
  def change
    create_table :file_lines do |t|
      t.string :file_id

      t.timestamps
    end
  end
end
