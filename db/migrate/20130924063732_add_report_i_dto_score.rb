class AddReportIDtoScore < ActiveRecord::Migration
  def change
    add_column :scores, :report_id, :integer
  end
end
