<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>      
    
<!DOCTYPE html>
<html>
<head>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script defer src="https://use.fontawesome.com/releases/v5.15.4/js/all.js" integrity="sha384-rOA1PnstxnOBLzCLMcre8ybwbTmemjzdNlILg8O7z1lUkLXozs4DHonlDtnE7fpc" crossorigin="anonymous"></script>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
	var key = "73ba5abe8af88dbcd7e38268a7747f94";
	var lat = "48.8581126";
	var lon = "2.3529277";
	
	var uri = "https://api.openweathermap.org/data/2.5/onecall?lat="+ lat +"&lon="+ lon +"&appid="+key+"&exclude=hourly,minutely&units=metric";
	
	
 	$(function(){
 		
 		let weatherIcon = {
 				'01' : 'fas fa-sun',
 				'02' : 'fas fa-cloud-sun',
 				'03' : 'fas fa-cloud',
 				'04' : 'fas fa-cloud-meatball',
 				'09' : 'fas fa-cloud-sun-rain',
 				'10' : 'fas fa-cloud-showers-heavy',
 				'11' : 'fas fa-poo-storm',
 				'13' : 'far fa-snowflake',
 				'50' : 'fas fa-smog'
 		};
 		let url = 'http://api.openweathermap.org/data/2.5/weather?q=Seoul&appid=' + key + "&units=metric"; 
 		
		$("#btn").click(function(){
			let html = "";
			
			$.ajax({
				url : uri,
				dataType : "json",
				method : "GET",
				success : function(resp) {
					console.log(resp);
					var icon = (resp.daily[0].weather[0].icon).substring(0,2);
					var desc = resp.daily[0].weather[0].description;
					var maxtemp = Math.floor(resp.daily[0].temp.max) + "º";
					var mintemp = Math.floor(resp.daily[0].temp.min) + "º";
					
					var temphtml = "";
					
					temphtml += '<i class="' + weatherIcon[icon] + '"></i> &nbsp;';
					temphtml += desc + "&nbsp;";
					temphtml += "↑" + maxtemp + "&nbsp;";
					temphtml += "↓" + mintemp;
					
					html = temphtml;
					$("#weather").html(html);
				},
				error : function(){
					alert("실패");
				}
			});
			console.log(html);
			
		});	
		
		
	}); 
	
</script>
</head>

					<!-- console.log(resp);
					
					var d = new Date(1635937200 * 1000);
					console.log(d.toISOString()); -->

<body>
	<button id="btn" onclick="click();">시작</button>
	<div id="weather" style="font-size: 15pt; color: rgb(31, 210, 127);"></div>

</body>
</html>














