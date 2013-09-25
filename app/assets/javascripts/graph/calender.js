// This code based on d3 example(http://mbostock.github.io/d3/talk/20111018/calendar.html).

function calender_view(selector, data_file){
    var m = [29, 20, 20, 19], // top right bottom left margin
    w = 620 - m[1] - m[3], // width
    h = 90 - m[0] - m[2], // height
    z = 11; // cell size

    var day = d3.time.format("%w"),
    week = d3.time.format("%U"),
    percent = d3.format(".1%"),
    flightData,
    stockData,
    formatDate = d3.time.format("%Y-%m-%d"),
    formatNumber = d3.format(",d"),
    formatPercent = d3.format("+.1%");

    var svg = d3.select(selector).selectAll(".year")
        .data(d3.range(1995, 2009))
        .enter().append("div")
        .attr("class", "year")
        .style("width", w + m[1] + m[3] + "px")
        .style("height", h + m[0] + m[2] + "px")
        .style("display", "inline-block")
        .append("svg:svg")
        .attr("width", w + m[1] + m[3])
        .attr("height", h + m[0] + m[2])
        .attr("class", "RdYlGn")
        .append("svg:g")
        .attr("transform", "translate(" + (m[3] + (w - z * 53) / 2) + "," + (m[0] + (h - z * 7) / 2) + ")");

    svg.append("svg:text")
        .attr("transform", "translate(-6," + z * 3.5 + ")rotate(-90)")
        .attr("text-anchor", "middle")
        .text(String);

    var rect = svg.selectAll("rect.day")
        .data(function(d) { return d3.time.days(new Date(d, 0, 1), new Date(d + 1, 0, 1)); })
        .enter().append("svg:rect")
        .attr("class", "day")
        .attr("width", z)
        .attr("height", z)
        .attr("x", function(d) { return week(d) * z; })
        .attr("y", function(d) { return day(d) * z; });

    rect.append("svg:title");

    svg.selectAll("path.month")
        .data(function(d) { return d3.time.months(new Date(d, 0, 1), new Date(d + 1, 0, 1)); })
        .enter().append("svg:path")
        .attr("class", "month")
        .attr("d", monthPath);

    d3.csv(data_file, function(csv) {
        stockData = d3.nest()
            .key(function(d) { return (d.date = formatDate.parse(d.Date)).getFullYear(); })
            .key(function(d) { return d.date; })
            .rollup(function(d) { return d.value = (d[0].Close - d[0].Open) / d[0].Open; })
            .map(csv);

        d3.select("select").on("change", function() {
            display(this.value === "flights" ? flightData : stockData);
        });
    });

    d3.csv("flights-departed.csv", function(csv) {
        flightData = d3.nest()
            .key(function(d) { return (d.date = formatDate.parse(d.date)).getFullYear(); })
            .key(function(d) { return d.date; })
            .rollup(function(d) { return +d[0].value; })
            .map(csv);

        display(flightData);
    });

    function display(data, title) {

        if (data === flightData) {
            var formatValue = formatNumber,
            title = "U.S. Commercial Flights",
            color = d3.scale.quantile();

        } else {
            var formatValue = formatPercent,
            title = "Dow Jones",
            color = d3.scale.quantize();
        }

        d3.select("#footer span")
            .text(title);

        svg.each(function(year) {
            color
                .domain(data === flightData ? d3.values(data[year]) : [-.05, .05])
                .range(d3.range(9));

            d3.select(this).selectAll("rect.day")
                .attr("class", function(d) { return "day q" + color(data[year][d]) + "-9"; })
                .select("title")
                .text(function(d) { return formatDate(d) + ": " + formatValue(data[year][d]); });
        });
    }

    function monthPath(t0) {
        var t1 = new Date(t0.getFullYear(), t0.getMonth() + 1, 0),
        d0 = +day(t0), w0 = +week(t0),
        d1 = +day(t1), w1 = +week(t1);
        return "M" + (w0 + 1) * z + "," + d0 * z
            + "H" + w0 * z + "V" + 7 * z
            + "H" + w1 * z + "V" + (d1 + 1) * z
            + "H" + (w1 + 1) * z + "V" + 0
            + "H" + (w0 + 1) * z + "Z";
    }
}
