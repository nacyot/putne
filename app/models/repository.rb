class Repository < ActiveRecord::Base
  belongs_to :project
  
  has_many :branches
  has_many :commits

  def create_workspace
    Dir.chdir Rails.root
    `mkdir -p tmp/workspace`
    Dir.chdir 'tmp/workspace'
    `git clone #{ project.repository_url }`
  end

  def remove_workspace
    Dir.chdir Rails.root
    `rm -rf tmp/workspace/#{ project.project_name }`
  end

end
