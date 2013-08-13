class CreateChurns < ActiveRecord::Migration
  def change
    create_table :churns do |t|
      t.integer :times_change
      t.integer :report_id
      t.integer :targetable_id
      t.string :targetable_type

      t.timestamps
    end
  end
end
