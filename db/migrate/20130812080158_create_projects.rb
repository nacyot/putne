class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :title
      t.text :description
      t.string :language
      t.string :repository_type
      t.string :repository_url

      t.timestamps
    end
  end
end
