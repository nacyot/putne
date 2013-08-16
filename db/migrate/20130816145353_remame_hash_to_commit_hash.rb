class RemameHashToCommitHash < ActiveRecord::Migration
  def change
    rename_column :commits, :hash, :commit_hash
  end
end
