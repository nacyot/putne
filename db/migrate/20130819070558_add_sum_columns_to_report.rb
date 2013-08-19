class AddSumColumnsToReport < ActiveRecord::Migration
  def change
    add_column :reports, :churn_stat, :integer
    add_column :reports, :complexity_stat, :integer
    add_column :reports, :duplication_stat, :integer
    add_column :reports, :smell_stat, :integer
    add_column :reports, :branche_stat, :integer
    add_column :reports, :commit_stat, :integer
    add_column :reports, :file_stat, :integer
    add_column :reports, :class_stat, :integer
    add_column :reports, :method_stat, :integer
  end
end
