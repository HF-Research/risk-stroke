// !preview r2d3 data=c(0.3, 0.6, 0.8, 0.95, 0.40, 0.20)
//
// r2d3: https://rstudio.github.io/r2d3
//

// Help from: https://www.visualcinnamon.com/2016/05/smooth-color-legend-d3-svg-gradient.html
var barHeight = Math.ceil(height / data.length);

svg.selectAll('rect')
  .data(data)
  .enter().append('rect')
    .attr('width', function(d) { return d * width; })
    .attr('height', barHeight)
    .attr('y', function(d, i) { return i * barHeight; })
    .attr('fill', 'steelblue');

////Append a defs (for definition) element to your SVG
var defs = svg.append("defs");

var linearGradient = defs.append("linearGradient")
  .attr("id", "linear-gradient");

// Horizontal gradient
linearGradient
  .attr("x1", "0%")
  .attr("y1", "0%")
  .attr("x2", "100%")
  .attr("y2", "0%");

// Set color for start (0%)
linearGradient.append("stop")
  .attr("offset", "0%")
  .attr("stop-color", "green");

// Set color for end (100%)
linearGradient.append("stop")
  .attr("offset", "100%")
  .attr("stop-color", "#8b0000");

svg.append("rect")
  .attr("width", width)
  .attr("height", 10)
  .style("fill", "url(#linear-gradient");


//set up needle
var needle = svg.selectAll( ".needle" )
	.data( [0] )
	.enter()
	.append( 'line' )
	.attr( "x1", 0 )
	.attr( "x2", -78 )
	.attr( "y1", 0 )
	.attr( "y2", 0 )
	.classed("needle", true)
	.style( "stroke", "black" )
	.attr( "transform", function( d ) {
		return " translate(200,200) rotate(" + d + ")"
	} );
