class AddCommittedAtToCommit < ActiveRecord::Migration
  def change
    add_column :commits, :committed_at, :date
  end
end
