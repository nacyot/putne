class CreateTargetMethods < ActiveRecord::Migration
  def change
    create_table :target_methods do |t|
      t.string :name
      t.integer :report_id

      t.timestamps
    end
  end
end
