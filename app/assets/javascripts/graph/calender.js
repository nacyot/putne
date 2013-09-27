// This code based on d3 example(http://mbostock.github.io/d3/talk/20111018/calendar.html).

this.d3_calendar_chart = function(selector, data_file = "/d3js/dji.csv"){
    var target = d3.select(selector);
    var parentWidth = target[0][0].parentNode.clientWidth;

    var width = parentWidth;
    var height = parentWidth * 0.16;
    var cellSize = 13.5; // cell size

    var day = d3.time.format("%w"),
    week = d3.time.format("%U"),
    percent = d3.format(".1%"),
    format = d3.time.format("%Y-%m-%d");

    var color = d3.scale.quantize()
        .domain([-1.0, 1.0])
        .range(d3.range(11).map(function(d) { return "q" + d + "-11"; }));

    var svg = target.selectAll("svg")
        .data(d3.range(2013, 2014))
        .enter().append("svg")
        .attr("width", width)
        .attr("height", height)
        .attr("class", "RdYlGn")
        .append("g")
        .attr("transform", "translate(" + ((width - cellSize * 53) / 2) + "," + (height - cellSize * 8 - 1) + ")");

    svg.append("text")
        .attr("transform", "translate(-6," + cellSize * 3.5 + ")rotate(-90)")
        .style("text-anchor", "middle")
        .text(function(d) { return d; });

    var rect = svg.selectAll(".day")
        .data(function(d) { return d3.time.days(new Date(d, 0, 1), new Date(d + 1, 0, 1)); })
        .enter().append("rect")
        .attr("class", "day")
        .attr("width", cellSize)
        .attr("height", cellSize)
        .attr("x", function(d) { return week(d) * cellSize; })
        .attr("y", function(d) { return day(d) * cellSize; })
        .datum(format);

    rect.append("title")
        .text(function(d) { return d; });

    svg.selectAll(".month")
        .data(function(d) { return d3.time.months(new Date(d, 0, 1), new Date(d + 1, 0, 1)); })
        .enter().append("path")
        .attr("class", "month")
        .attr("d", monthPath);

    d3.csv(data_file, function(error, csv) {
        var data = d3.nest()
            .key(function(d) { return d.Date; })
            .rollup(function(d) { return minmax(d[0].Value); })
            .map(csv);

        rect.filter(function(d) { return d in data; })
            .attr("class", function(d) { return "day " + color(data[d]); })
            .select("title")
            .text(function(d) { return d + ": " + percent(data[d]); });
    });


    function minmax(data){
        if(data > 20){
            return 1;
        }else if(data <= 20){
            return data / 20.0;
        }else{
            return 0;
        }
    }

    function monthPath(t0) {
        var t1 = new Date(t0.getFullYear(), t0.getMonth() + 1, 0),
        d0 = +day(t0), w0 = +week(t0),
        d1 = +day(t1), w1 = +week(t1);
        return "M" + (w0 + 1) * cellSize + "," + d0 * cellSize
            + "H" + w0 * cellSize + "V" + 7 * cellSize
            + "H" + w1 * cellSize + "V" + (d1 + 1) * cellSize
            + "H" + (w1 + 1) * cellSize + "V" + 0
            + "H" + (w0 + 1) * cellSize + "Z";
    }

    d3.select(self.frameElement).style("height", "2910px"); 
}




