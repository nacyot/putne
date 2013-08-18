class GitController < ApplicationController
  load_and_authorize_resource class: Project
  
  def branches
    @project = Project.find params[:project_id]
  end

  def commits
    @project = Project.find params[:project_id]
    @repository = Git.new(@project.repository)
  end
end
