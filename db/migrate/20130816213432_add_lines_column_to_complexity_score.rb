class AddLinesColumnToComplexityScore < ActiveRecord::Migration
  def change
    add_column :complexity_scores, :lines, :integer
  end
end
