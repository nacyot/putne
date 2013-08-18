class MainController < ApplicationController
  def index
    @projects = current_user.projects if signed_in?
    @repository = @projects.first.repository if signed_in?
  end

  def about
  end
end
