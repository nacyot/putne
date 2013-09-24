class CreateSmellCategories < ActiveRecord::Migration
  def change
    create_table :smell_categories do |t|

      t.timestamps
    end
  end
end
