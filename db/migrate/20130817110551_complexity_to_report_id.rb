class ComplexityToReportId < ActiveRecord::Migration
  def change
    add_column :complexity_scores, :report_id, :integer
  end
end
