class Commit < ActiveRecord::Base
  belongs_to :repository
  has_one :report

  validates_uniqueness_of :commit_hash

  def rebase
    Dir.chdir Rails.root
    Dir.chdir repository.workspace_path
    `git reset --hard #{commit_hash}`
  end
  
end

