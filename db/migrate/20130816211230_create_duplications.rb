class CreateDuplications < ActiveRecord::Migration
  def change
    create_table :duplications do |t|
      t.integer :report_id

      t.timestamps
    end
  end
end
