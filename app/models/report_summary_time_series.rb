class ReportSummaryTimeSeries
  attr_reader :complexities
  
  def initialize(reports)
    @complexities = []
    
    reports.each_with_index do |report, i|
      @complexities << {x: i + 1, y: report.complexity_stat}
    end
  end
end
