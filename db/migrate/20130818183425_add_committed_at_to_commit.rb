class AddCommittedAtToCommit < ActiveRecord::Migration
  def change
    add_column :commits, :commited_at, :date
  end
end
