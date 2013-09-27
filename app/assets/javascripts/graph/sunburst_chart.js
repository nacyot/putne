// This code based on d3 example(http://bl.ocks.org/mbostock/910126).

this.d3_sunburst_chart = function(selector, data_file = "/d3js/flare.json") {
    var target = d3.select(selector);
    var width = target[0][0].parentNode.clientWidth - 40 ;
    var height = width + 40;
    var radius = (Math.min(width, height) - 50) / 2;
    var color = d3.scale.category20c();
    
    var tooltip = d3.select("body")
        .append("div")
        .style("position", "absolute")
        .style("visibility", "hidden");

    var svg = target.append("svg")
        .attr("width", width)
        .attr("height", height)
        .append("g")
        .attr("transform", "translate(" + width / 2 + "," + height * .52 + ")");

    var partition = d3.layout.partition()
        .sort(null)
        .size([2 * Math.PI, radius * radius])
        .value(function(d) { return d.size; });

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
            .on("mouseover", function(d, i) {
                d3.select(this);
                tooltip
                    .html('<div class="mini-helper well well-lg"><span style="font-size:1.6em;font-family:Patua One;">'+d.name+'<br></span><span style="font-family:Open Sans;">' + (d.size ? d.size : "") );
                if(tooltip.style("visibility") == "hidden" ){
                    return tooltip
                        .style("visibility", "visible")
                        .style("top", (d3.event.pageY - 100) + "px")
                        .style("left",(d3.event.pageX - 13) + "px");
                }
                })
            .on("mousemove", function(d, i){
                
            })
            .on("mouseout", function(d, i) {
                d3.select(this)
                    .style("opacity","1");
                return tooltip.style("visibility", "hidden");
                })
            .each(stash);
        
        g.append("text")
            .attr("transform", function(d) { return "rotate(" + (d.x + (d.dx / 2) - Math.PI / 2) / Math.PI * 180 + ")";})
                //return "rotate(" + (d.x + (d.dx / 2) - Math.PI / 2) / Math.PI * 180 + ")"; 
            .attr("x", function(d) { return d.children ? Math.sqrt(d.y)- 50 : Math.sqrt(d.y) + 0; })
            .attr("dx", "6") // margin
            .attr("dy", ".35em") // vertical-align
            .attr("font-size", "10px")
            .text(function(d) { return d.name; });

        d3.selectAll("input").on("change", function change() {
            var value = function(d) { return d.size; };

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
