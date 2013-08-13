class CreateTargetClasses < ActiveRecord::Migration
  def change
    create_table :target_classes do |t|
      t.string :name
      t.integer :report_id

      t.timestamps
    end
  end
end
