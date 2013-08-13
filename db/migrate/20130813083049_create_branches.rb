class CreateBranches < ActiveRecord::Migration
  def change
    create_table :branches do |t|
      t.string :name
      t.integer :repository_id

      t.timestamps
    end
  end
end
