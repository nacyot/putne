// This code based on d3 example(http://bl.ocks.org/mbostock/910126).

this.d3_sunburst_chart = function(selector, data_file = "/d3js/flare.json") {
    var target = d3.select(selector);
    var width = target[0][0].parentNode.clientWidth;
    var height = width;
    var radius = Math.min(width, height) / 2;
    var color = d3.scale.category20c();

    var svg = target.append("svg")
        .attr("width", width)
        .attr("height", height)
        .append("g")
        .attr("transform", "translate(" + width / 2 + "," + height * .52 + ")");

    var partition = d3.layout.partition()
        .sort(null)
        .size([2 * Math.PI, radius * radius])
        .value(function(d) { return 1; });

    var arc = d3.svg.arc()
        .startAngle(function(d) { return d.x; })
        .endAngle(function(d) { return d.x + d.dx; })
        .innerRadius(function(d) { return Math.sqrt(d.y); })
        .outerRadius(function(d) { return Math.sqrt(d.y + d.dy); });

    d3.json(data_file, function(error, root) {
        var g = svg.datum(root).selectAll("g")
            .data(partition.nodes)
            .enter().append("g");
        
        g.append("path")
            .attr("display", function(d) { return d.depth ? null : "none"; }) // hide inner ring
            .attr("d", arc)
            .style("stroke", "#fff")
            .style("fill", function(d) { return color((d.children ? d : d.parent).name); })
            .style("fill-rule", "evenodd")
            .each(stash);
        
        g.append("text")
            .attr("transform", function(d) { return "rotate(" + (d.x + d.dx / 2 - Math.PI / 2) / Math.PI * 180 + ")"; })
            .attr("x", function(d) { return Math.sqrt(d.y); })
            .attr("dx", "6") // margin
            .attr("dy", ".35em") // vertical-align
            .attr("font-size", "10px")
            .text(function(d) { return d.name; });

        d3.selectAll("input").on("change", function change() {
            var value = this.value === "count"
                ? function() { return 1; }
            : function(d) { return d.size; };

            path
                .data(partition.value(value).nodes)
                .transition()
                .duration(1500)
                .attrTween("d", arcTween);
        });
    });

    // Stash the old values for transition.
    function stash(d) {
        d.x0 = d.x;
        d.dx0 = d.dx;
    }

    // Interpolate the arcs in data space.
    function arcTween(a) {
        var i = d3.interpolate({x: a.x0, dx: a.dx0}, a);
        return function(t) {
            var b = i(t);
            a.x0 = b.x;
            a.dx0 = b.dx;
            return arc(b);
        };
    }

    d3.select(self.frameElement).style("height", height + "px");

}
