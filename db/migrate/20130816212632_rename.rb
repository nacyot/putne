class Rename < ActiveRecord::Migration
  def change
    rename_column :complexity_scores, :score, :flog_score
    add_column :complexity_scores, :saikuro_score, :integer
  end
end
