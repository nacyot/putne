class CreateSmellSources < ActiveRecord::Migration
  def change
    create_table :smell_sources do |t|
      t.string :name

      t.timestamps
    end
  end
end
