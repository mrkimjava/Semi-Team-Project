<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>      
<!DOCTYPE html>
<html>
<head>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-/bQdsTh/da6pkI1MST/rWKFNjaCP5gBSY4sEBT38Q/9RBh9AH40zEOg7Hlq2THRZ" crossorigin="anonymous"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-F3w7mX95PdgyTmZZMECAngseQB83DfGTowi0iMjiWaeVhAn4FJkqJByhZMI3AhiU" crossorigin="anonymous">
<script src="<%=request.getContextPath() %>/json/country.json" type="text/javascript"></script>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<script>
let covid;

var settings = {
		  "url": "https://api.covid19api.com/summary",
		  "method": "GET",
		  "timeout": 0,
		  "async":false,
		};

		$.ajax(settings).done(function (response) {
		  covid = response;
		});

var array = ['대한민국', '미국'];
		
var jsonData = JSON.parse(JSON.stringify(data));
console.log(jsonData);

let index = [];
for (let x in jsonData) { 
	index.push(x); 
}

let KrCode = new Array();

console.log(jsonData[index[0]].CountryNameKR);
console.log(jsonData[index[0]]["2digitCode"]);

for(var i = 0; i < array.length; i++){
	
	for(var j = 0; j < index.length; j++){
		if(jsonData[index[j]].CountryNameKR == array[i]){
			var str = jsonData[index[j]]["2digitCode"];
			KrCode.push(str);
		}
	}
}

console.log(KrCode);
console.log(covid);









function createTotalTr(totalCo, totalDe, newCo, newDe){
	var html = "";
	html = "<tr>" + 
		   "<td>"+ totalCo +"<br><span style='color:red'>"+ newCo +"▲</span></td>" + 
		   "<td>"+ totalDe +"<br><span style='color:red'>"+ newDe +"▲</span></td>" + 
		   "</tr>";		   
	return html;
}

function createTr(Country, totalCo, newCo, totalDe, newDe){
	var html = "";
	html = "<tr>" + 
		   "<th>"+ Country.toLocaleString() +"</th>" +
		   "<td>"+ totalCo.toLocaleString() +"</td>" +
		   "<td><span style='color:red'>"+ newCo +"▲</span></td>" +		   
		   "<td>"+ totalDe.toLocaleString() +"<br>("+ ((totalDe/totalCo)*100).toFixed(1) +"%)</td>" +		   
		   "<td><span style='color:red'>"+ newDe.toLocaleString() +"▲</span></td>" +		   
		   "</tr>";
	return html;
}

$(function(){
	var html = createTotalTr(covid.Global.TotalConfirmed.toLocaleString(),
			   covid.Global.TotalDeaths.toLocaleString(),
			   covid.Global.NewConfirmed.toLocaleString(),
			   covid.Global.NewDeaths.toLocaleString());
	$("#totalCountry").append(html);
			   
	$(".reportdate").each(function(){
		$(this).html(covid.Global.Date.split("T")[0]);
	});
	
	for(var i = 0; i < covid.Countries.length; i++){
		for(var j = 0; j < KrCode.length; j++){
			if(covid.Countries[i].CountryCode == KrCode[j]){
				var html2 = createTr(covid.Countries[i].Country,
									covid.Countries[i].TotalConfirmed,
									covid.Countries[i].NewConfirmed,
									covid.Countries[i].TotalDeaths,
									covid.Countries[i].NewDeaths);
				$("#visitCountry").append(html2);
			}
		}
	}
	
	
});




</script>








<div class="container">
	<div class="row">
		<div class="col-lg-3"></div>
		<div class="col-lg-6" style="text-align: left;">
			<h3>※Global covid-19 report&nbsp;(<span class="reportdate" style="color:blue; font-size:15pt;"></span>)</h3>
		</div>
		<div class="col-lg-3"></div>
	</div>
	<div class="row">
		<div class="col-lg-3"></div>
		<div class="col-lg-6">
		<table class="table" style="text-align: center;">
			<thead class="table-dark">
				<tr>
					<th>확진환자</th>
					<th>사망자</th>
				</tr>
			</thead>
			<tbody id="totalCountry">
			</tbody>
		</table>
		</div>
		<div class="col-lg-3"></div>
	</div>
	<br>
	<div class="row">
		<div class="col-lg-3"></div>
		<div class="col-lg-6" style="text-align: left;">
			<h3>※Travel Area covid-19 report&nbsp;(<span class="reportdate" style="color:blue; font-size:15pt;"></span>)</h3>
		</div>
		<div class="col-lg-3"></div>
	</div>
	<div class="row">
		<div class="col-lg-3"></div>
		<div class="col-lg-6">
		<table class="table" style="text-align: center;">
			<thead class="table-dark">
				<tr>
					<th>방문국가명</th>
					<th>누적확진자</th>
					<th>일일확진자</th>
					<th>누적사망자</th>
					<th>일일사망자</th>
				</tr>
			</thead>
			<tbody id="visitCountry" style="vertical-align: middle;">
			</tbody>
		</table>
		</div>
		<div class="col-lg-3"></div>
	</div>
</div>










</body>
</html>































