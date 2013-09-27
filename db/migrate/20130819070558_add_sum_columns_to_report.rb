class AddSumColumnsToReport < ActiveRecord::Migration
  def change
    add_column :reports, :churn_stat, :integer, default: 0
    add_column :reports, :complexity_stat, :integer, default: 0
    add_column :reports, :duplication_stat, :integer, default: 0
    add_column :reports, :smell_stat, :integer, default: 0
    add_column :reports, :branche_stat, :integer, default: 0
    add_column :reports, :commit_stat, :integer, default: 0
    add_column :reports, :file_stat, :integer, default: 0
    add_column :reports, :class_stat, :integer, default: 0
    add_column :reports, :method_stat, :integer, default: 0
  end
end
