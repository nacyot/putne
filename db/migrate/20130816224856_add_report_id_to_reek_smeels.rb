class AddReportIdToReekSmeels < ActiveRecord::Migration
  def change
    add_column :reek_smells, :report_id, :integer
  end
end
