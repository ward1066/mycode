<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<title>Highcharts Example</title>
		
		
		<!-- 1. Add these JavaScript inclusions in the head of your page -->
		<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.3.2/jquery.min.js"></script>
		<script type="text/javascript" src="./highcharts219/js/highcharts.js"></script>
		<!--[if IE]>
			<script type="text/javascript" src="./highcharts219/js/excanvas.compiled.js"></script>
		<![endif]-->`
		
		
		<!-- 2. Add the JavaScript to initialize the chart on document ready -->
		<script type="text/javascript">
		$(document).ready(function() {
			

			var options = {
				chart: {
					renderTo: 'container',
					defaultSeriesType: 'column'
				},
				title: {
					text: 'Trades by Month'
				},
				xAxis: {
					categories: []
				},
				yAxis: {
					title: {
						text: 'Units'
					}
				},
				series: []
			};
			
			/*
			 Load the data from the CSV file. This is the contents of the file:
			 
				Apples,Pears,Oranges,Bananas,Plums
				John,8,4,6,5
				Jane,3,4,2,3
				Joe,86,76,79,77
				Janet,3,16,13,15
				
			 */ 
			$.get('./trade-by-month.csv', function(data) {
				// Split the lines
				var lines = data.split('\n');
				$.each(lines, function(lineNo, line) {
					var items = line.split(',');
					
					// header line containes categories
					if (lineNo == 0) {
						$.each(items, function(itemNo, item) {
							if (itemNo > 0) options.xAxis.categories.push(item);
						});
					}
					
					// the rest of the lines contain data with their name in the first position
					else {
						var series = { 
							data: []
						};
						$.each(items, function(itemNo, item) {
							if (itemNo == 0) {
								series.name = item;
							} else {
								series.data.push(parseFloat(item));
							}
						});
						
						options.series.push(series);

					}
					
				});
				
				var chart = new Highcharts.Chart(options);
			});
			
			
		});
		</script>
		
	</head>
	<body>
		
		<!-- 3. Add the container -->
		<div id="container" style="width: 800px; height: 400px; margin: 0 auto"></div>
		
				
	</body>
</html>