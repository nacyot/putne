class CreateSourceCategories < ActiveRecord::Migration
  def change
    create_table :source_categories do |t|
      t.string :name

      t.timestamps
    end
  end
end
