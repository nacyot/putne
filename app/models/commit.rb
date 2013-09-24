class Commit < ActiveRecord::Base
  belongs_to :repository
  has_one :report, dependent: :destroy

  validates_presence_of :committed_at
  validates_uniqueness_of :commit_hash
  
  validates :commit_hash, :uniqueness => {
    :scope => :repository_id,
    :message => 'cannot have two category with same path and report_id'}
  
  def rebase
    Dir.chdir Rails.root
    Dir.chdir repository.workspace_path
    `git reset --hard #{commit_hash}`
  end
  
end

