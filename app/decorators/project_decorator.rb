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
    reports.map do |report|
      {
        date: report.commit.committed_at.strftime("%Y%m%d"),
        date_original: report.commit.committed_at,
        complexity: report.complexity_stat,
        duplication: report.duplication_stat,
        smell: report.smell_stat,
        churn: report.churn_stat
      }
    end.sort { |a,b| a[:date_original] <=> b[:date_original] } 
  end

  def smell_count_by_klass_data
    reports.last.smells.includes(:targetable).type_class.group_by(&:targetable)
      .map{ |item| {name: item[0].name, count: item[1].count} }
  end

  def smell_count_by_smell_data
    reports.last.smells.group_by(&:smell).map{ |item| {name: item[0], count: item[1].count} } 
  end

  # for sparkline
  def get_stats(name, limit = 30)
    reports.limit(limit).map do |report|
      report[name].nil? ? 0 : report[name]
    end.reverse
  end

  def get_stats_by_day(name, limit = 30)
    reports_by_day.map do |report|
      report[name].nil? ? 0 : report[name]
    end.reverse
  end

  def latest_commit_day
    latest_report.commit.committed_at.strftime("%Y-%m-%d") if latest_report
  end
end

