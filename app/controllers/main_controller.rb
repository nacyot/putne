class MainController < ApplicationController
  load_and_authorize_resource class: User  

  def index
    @projects = current_user.projects if signed_in?
  end

  def about
  end
end
