class AddNameToScoreCategory < ActiveRecord::Migration
  def change
    add_column :score_categories, :name, :string
  end
end
