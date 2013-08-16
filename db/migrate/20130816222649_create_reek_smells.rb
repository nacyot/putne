class CreateReekSmells < ActiveRecord::Migration
  def change
    create_table :reek_smells do |t|
      t.string :message
      t.string :type
      t.integer :target_method_id

      t.timestamps
    end
  end
end
