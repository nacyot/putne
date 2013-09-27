class MainController < ApplicationController
  def index
    @projects = ProjectsDecorator.decorate(current_user.projects.order("id desc").page(params[:page]).per(5)) if signed_in?
    # @commits = current_user.commits.page(params[:page]).per(10) if signed_in?
  end

  def about
  end

  def help
    
  end
end
