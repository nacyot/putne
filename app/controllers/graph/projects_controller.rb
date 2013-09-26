class Graph::ProjectsController < ApplicationController
  def sunburst_chart
    project = Project.find(params[:project_id]).decorate
    render :json => {name: project.title, children: project.flog_scores_for_two_level_sunburst_data }
  end

  def class_donut_chart
    project = Project.find(params[:project_id]).decorate
    text = CSV.generate do |csv|
      csv << %w(Klass Complexity)
      text = project.flog_scores_for_klass_donut_data.each { |complexity| csv << [complexity[:name], complexity[:size]] }
    end
    
    render text: text, content_type: 'text/html'
  end

  def stats_line_chart
    project = Project.find(params[:project_id]).decorate
    columns = params[columns].nil? ? params[:columns].split(",") : %w(date Complexity Duplication Smell Churn)
    
    text = CSV.generate(col_sep: "\t") do |csv|
      csv << columns
      text = project.stats_line_data.each do |stats|
        data = []
        columns.each {|column| data << stats[column.downcase.to_sym] }
        csv << data
      end
    end
    
    render text: text, content_type: 'text/html'
    
    # churn, complexity, duplication, smell, commit, branches, file,
    # classes, methods
  end
end
