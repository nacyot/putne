# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


@jsonTest = () ->
        d3.json "/projects/4/reports.json", drawGraph

@myData = () ->
        series1 = []
        series2 = []
        for i in [1..100]
                series1.push
                        x : i, 
                        y : 100 / i
                series2.push
                        x : i
                        y : 50

                        
        return [{
                key: "Series #1",
                values: series1,
                color: "#0000ff"
                },
                {
                key: "Series #2",
                values: series2,
                color: "#ff0000"
                }
                ]
@drawGraph = (error, data) ->
        console.log(data)
        nv.addGraph ->
                chart = nv.models.lineChart()
                chart.xAxis.axisLabel("Time")
                chart.yAxis.axisLabel("Y-axis Label").tickFormat(d3.format("d"))

                d3.select("svg#reports-summary-graph").datum(data).transition().duration(500).call(chart)
                nv.utils.windowResize -> chart.update()
                return chart;

$ ->
        jsonTest() 
