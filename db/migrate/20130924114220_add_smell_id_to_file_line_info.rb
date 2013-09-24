class AddSmellIdToFileLineInfo < ActiveRecord::Migration
  def change
    add_column :file_line_infos, :smell_id, :integer
  end
end
