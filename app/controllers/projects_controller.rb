class ProjectsController < ApplicationController
  load_and_authorize_resource
  before_action :set_project, only: [:show, :edit, :update, :destroy]
  layout "layouts/sidebar", only: :show

  # GET /projects
  # GET /projects.json
  def index
    @projects = Project.all

  end

  # GET /projects/1
  # GET /projects/1.json
  def show
    @project = Project.find params[:id]
    @title = "Project - #{@project.title}"
    @report = @project.reports.sort { |report| report.commit.committed_at }[-1]
  end

  # GET /projects/new
  def new
    @title = "New project"
    @project = Project.new
    @project.repository = Repository.new
  end

  # GET /projects/1/edit
  def edit
    
  end

  # POST /projects
  # POST /projects.json
  def create
    @project = Project.create!(project_params)
    @project.repository = Repository.create!(params[:project][:repository_attributes])
    InitRepositoryWorker.perform_async(@project.repository.id)

    respond_to do |format|
      if @project.id?
        format.html { redirect_to @project, notice: 'Project was successfully created.' }
        format.json { render action: 'show', status: :created, location: @project }
      else
        format.html { render action: 'new' }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /projects/1
  # PATCH/PUT /projects/1.json
  def update
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to @project, notice: 'Project was successfully updated.' }
        format.json #{ head :no_content }
      else
        format.html #{ render action: 'edit' }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end
  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    @project.destroy
    respond_to do |format|
      format.html { redirect_to projects_url }
      format.json { head :no_content }
    end
  end

  def settings
  end

  def commit_hook
    puts params[:project_id]
    @project = Project.find params[:project_id]
    key = @project.user.secret_key.key
    ReportWorker.perform_async @project.repository.id, params[:hash] if params[:ci_key] == key

    respond_to do |format|
      if @project.id?
        format.html { render text: "aoeuaeou" }
        format.json { render action: 'show', status: :created, location: @project }
      else
        format.html { render action: 'new' }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end

  end

  def commit_hook_url
    @project = Project.find params[:project_id]
    @user = current_user
    NotificationMailer.welcome_email(current_user).deliver
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def project_params
      params.require(:project).permit(:title, :description, :language, :user_id,
                                      repository_attributes: [:repository_url, :repository_type]
                                      )
    end
end
