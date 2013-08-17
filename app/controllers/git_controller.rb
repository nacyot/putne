class GitController < ApplicationController
  def branches
    @project = Project.find params[:project_id]
  end

  def commits
    @project = Project.find params[:project_id]
    @repository = Git.new(@project.title)
  end
end
