class MainController < ApplicationController
  def index
    @projects = current_user.projects if signed_in?
    @commits = current_user.commits.page(params[:page]).per(20) if signed_in?
  end

  def about
  end
end
