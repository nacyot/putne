class AddReportIDtoSmell < ActiveRecord::Migration
  def change
    add_column :smells, :report_id, :integer
  end
end
