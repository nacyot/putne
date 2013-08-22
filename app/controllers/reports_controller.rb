class ReportsController < ApplicationController
  load_and_authorize_resource class: Report
  before_action :set_report, only: [:show, :edit, :update, :destroy]

  # GET /reports
  # GET /reports.json
  def index
    @project = Project.find params[:project_id]
    @reports = @project.reports
    @report = @project.reports.sort { |report| report.commit.committed_at }[-1]
    @graph = ReportSummaryTimeSeries.new
  end

  # GET /reports/1
  # GET /reports/1.json
  def show
    @project = Project.find params[:project_id]
    @report = Report.find params[:id]
  end

  # GET /reports/new
  def new
    @report = Report.new
  end

  # GET /reports/1/edit
  def edit
  end

  # POST /reports
  # POST /reports.json
  def create
    @project = Project.find params[:project_id]
    ReportWorker.perform_async @project.repository.id, params[:hash]   
    redirect_to :back
  end

  # PATCH/PUT /reports/1
  # PATCH/PUT /reports/1.json
  def update
    respond_to do |format|
      if @report.update(report_params)
        format.html { redirect_to @report, notice: 'Report was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @report.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reports/1
  # DELETE /reports/1.json
  def destroy
    @report.destroy
    respond_to do |format|
      format.html { redirect_to reports_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_report
      @report = Report.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def report_params
      params.require(:report).permit(:repository_id, :branch_id, :commit_id, :project_id)
    end
end
