class CreateTargetMethods < ActiveRecord::Migration
  def change
    create_table :target_methods do |t|
      t.string :name
      t.string :full_name
      t.integer :report_id
      t.integer :class_id

      t.timestamps
    end
  end
end
