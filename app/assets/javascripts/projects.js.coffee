# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
        sparkline();

@sparkline = () ->
        myvalues = [10,8,4,8,9,8,8,9,0,7,0,9,8,7,6,8,9,8,7,6,5,8,9,7,6];
        $('.sparkline-test').sparkline(myvalues, {tooltipClassname: "sparkline-tooltip"});
