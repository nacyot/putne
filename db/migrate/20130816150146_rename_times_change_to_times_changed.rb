class RenameTimesChangeToTimesChanged < ActiveRecord::Migration
  def change
    rename_column :churns, :times_change, :times_changed
  end
end
