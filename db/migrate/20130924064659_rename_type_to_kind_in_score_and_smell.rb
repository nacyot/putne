class RenameTypeToKindInScoreAndSmell < ActiveRecord::Migration
  def change
    rename_column :scores, :type, :kind
  end
end
