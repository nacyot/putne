class CreateSmells < ActiveRecord::Migration
  def change
    create_table :smells do |t|
      t.string :type
      t.string :smell
      t.references :target, polymorphic: true

      t.timestamps
    end
  end
end
