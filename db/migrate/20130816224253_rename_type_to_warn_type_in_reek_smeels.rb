class RenameTypeToWarnTypeInReekSmeels < ActiveRecord::Migration
  def change
    rename_column :reek_smells, :type, :warn_type
  end
end

