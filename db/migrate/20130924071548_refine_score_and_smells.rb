class RefineScoreAndSmells < ActiveRecord::Migration
  def change
    # add_column :scores, :smell_category_id, :integer
    rename_column :smells, :type, :source
    rename_column :scores, :kind, :source
  end
end
