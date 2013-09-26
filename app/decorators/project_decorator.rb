class ProjectDecorator < Draper::Decorator
  delegate_all

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end

  def flog_scores_for_two_level_sunburst_data
    flogs = latest_report.flog_scores.group_by { |score| File.dirname(score[:path]) }
    flogs.map {|key, content| {name: key, children: content} }
  end

  def flog_scores_for_klass_donut_data
    latest_report.flog_scores
  end

  def stats_line_data
    tmp = reports.map do |report|
      {
        date: report.commit.committed_at.strftime("%Y%m%d"),
        date_original: report.commit.committed_at,
        complexity: 0,
        duplication: report.duplication_stat,
        smell: 0,
        churn: report.churn_stat
      }
    end

    tmp.sort { |a,b| a[:date_original] <=> b[:date_original] } 
  end
end
