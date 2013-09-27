class CommitHookController < ApplicationController
  protect_from_forgery with: :null_session

  def hook
    puts params[:project_id]
    @project = Project.find params[:project_id]
    key = @project.user.secret_key.key
    puts "key_org : " + key.to_s
    puts "key_rem : " + params[:ci_key].to_s
    #TODO : refine params name
    ReportWorker.perform_async @project.repository.id, params["after"] if params[:ci_key] == key

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

  def hook_url
    @project = Project.find params[:project_id]
  end
end
