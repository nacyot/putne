class AddAuthorNameAndEmailToCommits < ActiveRecord::Migration
  def change
    add_column :commits, :author_name, :string
    add_column :commits, :author_email, :string
  end
end
