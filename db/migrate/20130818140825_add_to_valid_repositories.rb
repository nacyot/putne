class AddToValidRepositories < ActiveRecord::Migration
  def change
    add_column :repositories, :valid, :boolean
  end
end
