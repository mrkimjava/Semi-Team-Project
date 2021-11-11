<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<% request.setCharacterEncoding("UTF-8");%>
<% response.setContentType("text/html; charset=UTF-8");%>
<%
	String keyword = request.getParameter("search");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.css" integrity="sha512-3pIirOrwegjM6erE5gPSwkUzO+3cTjpnV9lexlNZqvupR64iZBnOOTiiLPb9M36zpMScbmUNIcHUqKD47M719g==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<script type="text/javascript" src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="http://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>

<style type="text/css">
#searchbtn {
	text-align: center;
	background-color: white;
	border-radius: 23px;
	padding: 8px;
	width: 50px;
	height: 50px;
}

#searchbtn:hover {
	background-color: rgb(105, 231, 175);
	border: 1px solid rgb(105, 231, 175);
}

.btn_1{
	border: 1px solid gray;
	border-radius: 25px;
	text-align: center;
	background-color: white;
	padding: 8px;
}

.detail {
	padding: 5px;
	padding-left: 10px;
	padding-right: 10px;
	border: solid 1px gray;
	background-color: white;
	border-radius: 25px;
	color: gray;
}

.img {
	cursor: pointer;
}

.btn_heart {
	padding: 5px;
	padding-left: 7px;
	padding-right: 7px;
	border: 1px solid white;
	border-radius: 30px;
	text-align: center;
	background-color: white;
}

.toast-success {
	background-color: #77ca8a !important;
	font-weight: bold !important;
	font-size: 12pt !important;
}

.toast-error {
	background-color: #BD362F !important;
}

.toast-info {
	background-color: #2F96B4 !important;
}

.toast-warning {
	background-color: #F89406 !important;
}

.toast-top-right {
	top: 7%;
}

#map {
	width: 100%;
	height: 350px;
}
#url{
	display:-webkit-box; 
    word-wrap:break-word; 
    -webkit-line-clamp:1; 
    -webkit-box-orient:vertical; 
    overflow:hidden; 
    text-overflow:ellipsis;
}
#staticBackdrop{
	font-family: Consolas;
}

</style>

<!-- 장소api -->
<script type="text/javascript"
	src="https://maps.googleapis.com/maps/api/js?key=AIzaSyD91v0jFyq9OujfSgguW_LeoicC-wATfNI&libraries=places"></script>
<script type="text/javascript">

//init Map
let map;
let infowindow;
let markerlist = [];

function initMap() {
	  infowindow = new google.maps.InfoWindow();
	  map = new google.maps.Map(document.getElementById("map"), {
	    center: { lat: -33.866, lng: 151.196 },
	    zoom: 15,
	  });
}

function createMarker(place) {
	  if (!place.geometry || !place.geometry.location) return;
	  //기존마커 삭제
	  if(markerlist.length != 0){
		  markerlist[0].setMap(null);
		  markerlist = []; //배열초기화 필수
	  }
	  //마커 재할당
	  marker = new google.maps.Marker({
	    map,
	    position: place.geometry.location,
	  });
	  markerlist.push(marker);
	  
	  google.maps.event.addListener(marker, "click", () => {
		infoString = "<a href='"+ place.url +"'>" +place.name + " (" + place.address_components[2].long_name +")</a><br>";
	    infowindow.setContent(infoString);
	    infowindow.open(map,marker);
	  });
	  
	  //맵에 현재마커위치로 이동
	  map.setCenter(marker.getPosition());
}

//photo관련
let photopath = 'https://maps.googleapis.com/maps/api/place/photo?maxwidth=1000&photo_reference=';
let apikey = '&key=AIzaSyBURtfwi-GrNQHLcH9QSc0MJgEzhVdXfzg';


//place관련
let resultlist = [];
let service;
let count = 0;
let random1 = 0;
let ran1 = 0;
let ran2 = 0;
let ran3 = 0;
let randomloc = [ran1,ran2,ran3];
const au = new google.maps.LatLng(-25, 133.8);
const br = new google.maps.LatLng(-14.2, -51.9);
const ca = new google.maps.LatLng(62, -110.0);
const fr = new google.maps.LatLng(46.2, 2.2);
const de = new google.maps.LatLng(51.2, 10.4);
const mx = new google.maps.LatLng(23.6, -102.5);
const nz = new google.maps.LatLng(-40.9, 174.9);
const it = new google.maps.LatLng(41.9, 12.6);
const za = new google.maps.LatLng(-30.6, 22.9);
const es = new google.maps.LatLng(40.5, -3.7);
const pt = new google.maps.LatLng(39.4, -8.2);
const us = new google.maps.LatLng(37.1, -95.7);
const uk = new google.maps.LatLng(54.8, -4.6);
const loc = [au,br,ca,fr,de,mx,nz,it,za,es,pt,us,uk];
const querys = ['hotel','restaurant','attraction'];

//특정
function searchall(loc, querys){
	  clear();
	  resultlist = [];
	  random1 = Math.floor(Math.random() * 13);
	  
	  var totalFields = ['place_id','geometry'];
	  
	  for(var i = 0; i < querys.length; i++){
	  var query = querys[i];
	  console.log(query);
	  let request = {
		location: loc[random1],
		radius: '150000',	  
	    query: query,
	    fields: totalFields,
	  };

	  service = new google.maps.places.PlacesService(document.createElement('div'));
	  service.textSearch(request, callback);
	  
	  function callback(results, status) {
		  if (status == google.maps.places.PlacesServiceStatus.OK) {
		    for (var i = 0; i < results.length; i++) {
		      var place = results[i];
			  var image = place.hasOwnProperty('photos')? place.photos[0].getUrl() : place.icon;
			  
			  resultlist.push(place);
			  $(".content").append(addDiv(image, place.name, resultlist.length-1)); 
		    }
		    console.log(resultlist);
		    $(".content").children().css({"opacity":"0"});
			opacity(count);
			
		  }else if(status == google.maps.places.PlacesServiceStatus.INVALID_REQUEST){
		        console.log('INVALID_REQUEST ', status);
		  }else if(status == google.maps.places.PlacesServiceStatus.ERROR){
		        console.log('ERROR ', status);
		  }else if(google.maps.places.PlacesServiceStatus.ZERO_RESULTS){
		        console.log('ZERO_RESULTS ', status);
		        $(".content").append("검색 결과가 없습니다.");
		  }
		}	
	  }
}

//search ex)로컬은 지역 위도경도 리스트중 랜덤으로 선정하되, 쿼리는 하나인경우(호텔, 등) 
function searchone(loc, query){
	  clear();
	  resultlist = [];
	  
	  for(var i = 0; i < randomloc.length; i++){
		  randomloc[i] = Math.floor(Math.random() * 13);
		  for(var j = 0; j < i; j++){
			  if(randomloc[i] == randomloc[j]){
				  i--;
				  break;
			  }
		  }
	  }
	  
	  var totalFields = ['place_id','geometry'];
	  
	  for(var i = 0; i < randomloc.length; i++){
	  var ranloc = loc[randomloc[i]];
	  console.log(query);
	  let request = {
		location: ranloc,
		radius: '150000',	  
	    query: query,
	    fields: totalFields,
	  };

	  service = new google.maps.places.PlacesService(document.createElement('div'));
	  service.textSearch(request, callback);
	  
	  function callback(results, status) {
		  if (status == google.maps.places.PlacesServiceStatus.OK) {
		    for (var i = 0; i < results.length; i++) {
		      var place = results[i];
			  var image = place.hasOwnProperty('photos')? place.photos[0].getUrl() : place.icon;
			  
			  resultlist.push(place);
			  $(".content").append(addDiv(image, place.name, resultlist.length-1)); 
		    }
		    console.log(resultlist);
		    $(".content").children().css({"opacity":"0"});
			opacity(count);
			
		  }else if(status == google.maps.places.PlacesServiceStatus.INVALID_REQUEST){
		        console.log('INVALID_REQUEST ', status);
		  }else if(status == google.maps.places.PlacesServiceStatus.ERROR){
		        console.log('ERROR ', status);
		  }else if(google.maps.places.PlacesServiceStatus.ZERO_RESULTS){
		        console.log('ZERO_RESULTS ', status);
		        $(".content").append("검색 결과가 없습니다.");
		  }
		}	
	  }
}

//search ex) 하와이에있는 호텔 등 특정 지역이나 문장을 썼을때 호출
function search(latlng, query){
	  clear();
	  resultlist = [];
	  var totalFields = ['place_id','geometry'];
	  
	  const request = {
		location: latlng,
		radius: '150000',	  
	    query: query,
	    fields: totalFields,
	  };

	  service = new google.maps.places.PlacesService(document.createElement('div'));
	  service.textSearch(request, callback);
	  
	  function callback(results, status) {
		  if (status == google.maps.places.PlacesServiceStatus.OK) {
		    for (var i = 0; i < results.length; i++) {
		      var place = results[i];
			  var image = place.hasOwnProperty('photos')? place.photos[0].getUrl() : place.icon;
			  resultlist.push(place);
			  $(".content").append(addDiv(image, place.name, resultlist.length-1)); 
		    }
		    console.log(resultlist);
		    $(".content").children().css({"opacity":"0"});
			opacity(count);
			
		  }else if(status == google.maps.places.PlacesServiceStatus.INVALID_REQUEST){
		        console.log('INVALID_REQUEST ', status);
		  }else if(status == google.maps.places.PlacesServiceStatus.ERROR){
		        console.log('ERROR ', status);
		  }else if(google.maps.places.PlacesServiceStatus.ZERO_RESULTS){
		        console.log('ZERO_RESULTS ', status);
		        $(".content").append("검색 결과가 없습니다.");
		  }
		}	
}

//순서대로나오게
function opacity(count){
	var next = count + 1;
	if(next > resultlist.length){
		return;
	}
	$(".content").children().eq(count).animate({opacity:"1"},130, function(){
		opacity(next);
	});
}

// 장소 ID로 상세 정보 받기
function getPlaceDetail(placeid){

    // 받고 싶은 필드 목록
    var basicFields = ['address_component', 'adr_address', 'alt_id', 'formatted_address', 'geometry', 'icon', 'id', 'name', 'permanently_closed', 'photo', 'place_id', 'plus_code', 'scope', 'type', 'url', 'utc_offset', 'vicinity'];
    var contactFields = ['formatted_phone_number', 'international_phone_number', 'opening_hours', 'website'];
    var atomosphereFields = ['price_level', 'rating', 'review'];

    var totalFields = ['address_component', 'adr_address', 'alt_id', 'formatted_address', 'geometry', 'icon', 'id', 'name',
    'permanently_closed', 'photo', 'place_id', 'plus_code', 'scope', 'type', 'url', 'utc_offset', 'vicinity', 'formatted_phone_number',
    'international_phone_number', 'opening_hours', 'website', 'price_level', 'rating', 'review'];
    var coustomFields = [''];
    
    var request = {
            placeId: placeid,
            fields: totalFields
        };
    
    service.getDetails(request, function(results, status){
        if (status == google.maps.places.PlacesServiceStatus.OK) {
			console.log(results);
			$("#staticBackdropLabel").html(results.name);
			$("#heartcount").html("");
			$("#userlist").html("");
			
			//찜여부확인 ajax로 가져오기
			$.ajax({
				url:"<%=request.getContextPath()%>/search.do?command=confirmheart",
				method: "post",
				data: {"placeid": results.place_id},
				success:function(data){
					if(data == "true"){
						$("#btnheart").removeAttr("onclick");
						$("#btnheart").attr("onclick","rmheart();");
						$("#heartimg").prop("src","./img/icons/suit-heart-fill.svg");
						$("#heart").html("&nbsp;장소 찜 해제&nbsp;");
					}else{
						$("#btnheart").removeAttr("onclick");
						$("#btnheart").attr("onclick","addheart();");
						$("#heartimg").prop("src","./img/icons/suit-heart.svg");
						$("#heart").html("&nbsp;장소 찜 추가&nbsp;");
					}
				},
				error:function(){
					$("#heart").html("에러");
				}
			});
			
			//찜한 회원수 ajax로 가져오기
			$.ajax({
				url:"<%=request.getContextPath()%>/search.do?command=heartcount",
				method: "post",
				data: {"placeid": results.place_id},
				success:function(data){
					$("#heartcount").html("<b>"+data+"</b>&nbsp명");
				},
				error:function(){
					$("#heartcount").html("<b>"+확인불가+"</b>");
				}
			});
			//여행지에 추가한 회원(가능 시)
			
			
			//마커
			createMarker(results);
			
			
			var start = 0;
			$(".carousel-inner").eq(0).children().each(function(){
				if(results.hasOwnProperty('photos') && results.photos[start] != null){
					$(this).find("img").prop("src",results.photos[start].getUrl());
				}else{
					$(this).find("img").prop("src",results.icon);
				}
				start++;
			});
			
			/* var image = results.hasOwnProperty('photos')? results.photos[0].getUrl() : results.icon;
			$(".modal-body").eq(0).find("img").prop("src",image); */
			
			$(".modal-body").eq(0).find("p").html("<br>");
			$(".modal-body").eq(0).find("p").append("<img src='./img/icons/shop.svg' alt='Bootstrap' width='21' height='21'>&nbsp;&nbsp;" + results.formatted_address + "<br>");
			$(".modal-body").eq(0).find("p").append("<div id='url'><img src='./img/icons/link.svg' alt='Bootstrap' width='21' height='21'>&nbsp;&nbsp;<a href='"+ results.website +"'>"+ (results.hasOwnProperty('website')? results.website:'') +"</a></div>");
			$(".modal-body").eq(0).find("p").append("<img src='./img/icons/telephone-fill.svg' alt='Bootstrap' width='21' height='21'>&nbsp;&nbsp;" + (results.hasOwnProperty('international_phone_number')? results.international_phone_number:'') + "<br>");
			if(results.hasOwnProperty('opening_hours')){
				for(var i = 0; i < results.opening_hours.weekday_text.length; i++){
					$(".modal-body").eq(0).find("p").append(results.opening_hours.weekday_text[i] + "<br>");
				}
			}
			$(".modal-body").eq(0).find("p").append("<hr>total review ★" + (results.hasOwnProperty('rating')? results.rating:'') + "<br><br>");
			if(results.hasOwnProperty('reviews')){
				for(var i = 0; i < results.reviews.length; i++){
					var star = "";
					for(var j = 0; j < results.reviews[i].rating; j++){star += "★";}
					for(var j = results.reviews[i].rating; j < 5; j++){star += "☆";}
					$(".modal-body").eq(0).find("p").append("<b>"+ results.reviews[i].author_name + "</b> " + star + "<br>");
					$(".modal-body").eq(0).find("p").append(results.reviews[i].text + "<br><hr>");
				}
			}
			var image = results.hasOwnProperty('photos')? results.photos[0].getUrl() : results.icon;
			if(!(image.includes('icon'))){
				var totalPath = photopath + photoRf(image) + apikey;
				$("#thumbnail").val(totalPath);
			}else{
				$("#thumbnail").val(image);
			}
			$("#address").val(results.formatted_address);
			$("#placename").val(results.name);
			$("#latitude").val(results.geometry.location.lat());
			$("#longtitude").val(results.geometry.location.lng());
			$("#placeid").val(results.place_id);
			for(var i = 0; i < results.address_components.length; i++){
				if(results.address_components[i].types[0] == 'country'){
					$("#nation").val(results.address_components[i].long_name); break;
				}	
			}
			for(var i = 0; i < results.address_components.length; i++){
				if(results.address_components[i].types[0] == 'administrative_area_level_1'){
					$("#city").val(results.address_components[i].long_name); break;
				}	
			}
			
			
        }else if(status == google.maps.places.PlacesServiceStatus.INVALID_REQUEST){
            console.log('INVALID_REQUEST ', status);
        }else if(status == google.maps.places.PlacesServiceStatus.ERROR){
            console.log('ERROR ', status);
        }else if(google.maps.places.PlacesServiceStatus.ZERO_RESULTS){
            console.log('ZERO_RESULTS ', status);
        }
    });
}

//찜 추가 -> session id 와 modal상의 hidden데이터를 테이블로 전송 (성공여부에따라 toast출력)
function addheart(){
	
	//ajax로 데이너 넘기기
	var sendData = {"placeid" : $("#placeid").val(),
					"thumbnail" : $("#thumbnail").val(),
					"placename" : $("#placename").val(),
					"latitude" : $("#latitude").val(),
					"longtitude" : $("#longtitude").val(),
					"address" : $("#address").val(),
					"nation" : $("#nation").val(),
					"city" : $("#city").val()};
	$.ajax({
		url:"<%=request.getContextPath()%>/search.do?command=addheart",
		method: "post",
		data: sendData,
		success:function(data){ 
			if(data != "-1" && data != "no_id"){
				toastr.options.positionClass = "toast-top-right";
				toastr.success("찜 목록에 추가되었습니다");
				$("#btnheart").removeAttr("onclick");
				$("#btnheart").attr("onclick","rmheart();");
				$("#heartimg").prop("src","./img/icons/suit-heart-fill.svg");
				$("#heart").html("&nbsp;장소 찜 해제&nbsp;");
				$("#heartcount").html("<b>"+data+"</b>&nbsp명");
				
			}else if(data == "-1"){
				/* toastr.options.positionClass = "toast-top-right";
				toastr.error("추가 실패"); */
			}else{//noid
				toastr.options.positionClass = "toast-top-right";
				toastr.warning("로그인이 필요합니다.");
			}
		},
		error: function(){
			toastr.options.positionClass = "toast-top-right";
			toastr.warning("통신 실패");
		}
	});
}

function rmheart(){
	$.ajax({
		url:"<%=request.getContextPath()%>/search.do?command=rmheart",
		method: "post",
		data: {"placeid": $("#placeid").val()},
		success:function(data){ 
			if(data != "-1" && data != "세션종료"){
				toastr.options.positionClass = "toast-top-right";
				toastr.success("찜 해제 완료되었습니다.");
				$("#btnheart").removeAttr("onclick");
				$("#btnheart").attr("onclick","addheart();");
				$("#heartimg").prop("src","./img/icons/suit-heart.svg");
				$("#heart").html("&nbsp;장소 찜 추가&nbsp;");
				$("#heartcount").html("<b>"+data+"</b>&nbsp명");
				
			}else if(data == "-1"){
				/* toastr.options.positionClass = "toast-top-right";
				toastr.error("찜 삭제 실패"); */
				
			}else{//세션종료
				toastr.options.positionClass = "toast-top-right";
				toastr.warning("로그인이 필요합니다.");
				$("#btnheart").removeAttr("onclick");
				$("#btnheart").attr("onclick","addheart();");
				$("#heartimg").prop("src","./img/icons/suit-heart.svg");
				$("#heart").html("&nbsp;장소 찜 추가&nbsp;");
			}
		},
		error: function(){
			toastr.options.positionClass = "toast-top-right";
			toastr.warning("통신 실패");
		}
	});
}

//포토레퍼런스추출
function photoRf(path){
	var temp = path.split("Photo?1s");
	console.log(temp);
	
	var temp2 = temp[1].split("&callback");
	console.log(temp2);
	
	return(temp2[0]);
}


//content 클리어
function clear(){
	$(".content").html("");
}

//div 생성문
function addDiv(image, title, value){
	var html = "";
	html = "<div class='col' style='position:relative; padding-bottom:30px;'>" + 
		   "<img src='"+ image +"' width='100%' height='350px' style='border-radius:15px;'>" +
		   "<figcaption style='font-weight:bold; font-size:13pt; font-family:Consolas;'>"+ title +"</figcaption>" +
		   "<div style='position: absolute; top:5%; left:8%'>" +
		   "<button class='btn_heart' onclick='modal(this.value)' data-bs-toggle='modal' data-bs-target='#staticBackdrop' value='"+ value +"'><img class='img'  src='./img/icons/suit-heart.svg' alt='Bootstrap' width='20' height='20'></button>" +
		   "</div>"+
		   "</div>";
	return html;
}

//검색
function searchcall(){
	if($("#search").val()==""){
		searchall(loc, querys);
	}else{
		var title = $("#search").val();
		if(title=="hotel" || title=="호텔"){
			searchone(loc,"hotel");
			return;
		}
		if(title=="맛집" || title=="푸드" || title=="food" || title=="restaurant"){
			searchone(loc,"restaurant");
			return;
		}
		if(title=="관광명소" || title=="관광지" || title=="관광" || title=="명소" || title=="attraction"){
			searchone(loc,"attraction");
			return;
		}
		var random = Math.floor(Math.random() * 13);
		search(loc[random], $("#search").val());
	}
	
 	$.ajax({
		
	}); 
}

//인기키워드 버튼으로 검색시
function buttoncall(value){
	searchone(loc,value);
}


function modal(value){
	var placeid = resultlist[value].place_id;
	getPlaceDetail(placeid);
	$("#Modalcarousel").carousel(0); //슬라이드 초기화
}


//windows onload
$(function(){
	initMap();
	
	if($("#search").val()==""){
		searchall(loc, querys);
		
	}else{
		var title = $("#search").val();
		if(title=="hotel" || title=="호텔"){
			searchone(loc,"hotel");
			return;
		}
		if(title=="맛집" || title=="푸드" || title=="food" || title=="restaurant"){
			searchone(loc,"restaurant");
			return;
		}
		if(title=="관광명소" || title=="관광지" || title=="관광" || title=="명소" || title=="attraction"){
			searchone(loc,"attraction");
			return;
		}
		var random = Math.floor(Math.random() * 13);
		search(loc[random], $("#search").val());
	}
});

</script>










</head>
<body>
	<!-- 고정(헤더) -->
	<div id="header">
		<%@ include file="./form/header.jsp"%>
	</div>
	<br>
	<div class="searchcontainer container">
		<div class="row">
			<div class="col-xs-12" style="text-align: left;">
				<form class="box" action="javascript:searchcall();" method="post"
					id="searchform">
					<input id="search" type="search" name="search"
						placeholder="키워드로 검색하세요. ex)시드니 호텔, 제주도 카페" value="<%=keyword%>"
						aria-label="Search" autocomplete="off"
						style="width: 400px; height: 50px; border-radius: 30px; border: solid 1px #d3d3d3; outline: none; text-indent: 15px;">
					<button id="searchbtn" type="submit"
						style="border: solid 1px #d3d3d3;">
						<img src="./img/icons/search.svg" alt="Bootstrap" width="21"
							height="21">
					</button>
				</form>
			</div>
		</div>
		<br>
		<div class="row">
			<div class="col-xs-12" style="text-align: left;">
				여묻 추천 키워드 &nbsp; : &nbsp;&nbsp;
				<button type="button" class="detail"
					onclick="buttoncall(this.value)" value="hotel">호텔</button>
				&nbsp;&nbsp;
				<button type="button" class="detail"
					onclick="buttoncall(this.value)" value="food">맛집</button>
				&nbsp;&nbsp;
				<button type="button" class="detail"
					onclick="buttoncall(this.value)" value="attraction">관광명소</button>
			</div>
		</div>
		<div class="row">
			<div class="col-xs-12">
				<hr>
			</div>
		</div>
		<div class="content row row-cols-3"></div>
		<br>
		<br>
	</div>






	<div class="modal fade" style="height: 100%;" id="staticBackdrop"
		data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1"
		aria-labelledby="staticBackdropLabel" aria-hidden="true">
		<div
			class="modal-dialog modal-dialog-centered modal-dialog-scrollable modal-xl">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="staticBackdropLabel"></h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<div class="row row-cols-2">
						<div class='col'>
							<!-- col1 -->
							<div id="Modalcarousel" class="carousel slide"
								data-bs-ride="carousel">
								<div class="carousel-indicators">
									<button type="button" data-bs-target="#Modalcarousel"
										data-bs-slide-to="0" class="active" aria-current="true"
										aria-label="Slide 1"></button>
									<button type="button" data-bs-target="#Modalcarousel"
										data-bs-slide-to="1" aria-label="Slide 2"></button>
									<button type="button" data-bs-target="#Modalcarousel"
										data-bs-slide-to="2" aria-label="Slide 3"></button>
									<button type="button" data-bs-target="#Modalcarousel"
										data-bs-slide-to="3" aria-label="Slide 4"></button>
									<button type="button" data-bs-target="#Modalcarousel"
										data-bs-slide-to="4" aria-label="Slide 5"></button>
									<button type="button" data-bs-target="#Modalcarousel"
										data-bs-slide-to="5" aria-label="Slide 6"></button>
									<button type="button" data-bs-target="#Modalcarousel"
										data-bs-slide-to="6" aria-label="Slide 7"></button>
									<button type="button" data-bs-target="#Modalcarousel"
										data-bs-slide-to="7" aria-label="Slide 8"></button>
									<button type="button" data-bs-target="#Modalcarousel"
										data-bs-slide-to="8" aria-label="Slide 9"></button>
									<button type="button" data-bs-target="#Modalcarousel"
										data-bs-slide-to="9" aria-label="Slide 10"></button>
								</div>
								<div class="carousel-inner" role="listbox">
									<div class="carousel-item active">
										<img src="" class="d-block w-100 rounded" alt="..." height="350px;">
									</div>
									<div class="carousel-item">
										<img src="" class="d-block w-100 rounded" alt="..." height="350px;">
									</div>
									<div class="carousel-item">
										<img src="" class="d-block w-100 rounded" alt="..." height="350px;">
									</div>
									<div class="carousel-item">
										<img src="" class="d-block w-100 rounded" alt="..." height="350px;">
									</div>
									<div class="carousel-item">
										<img src="" class="d-block w-100 rounded" alt="..." height="350px;">
									</div>
									<div class="carousel-item">
										<img src="" class="d-block w-100 rounded" alt="..." height="350px;">
									</div>
									<div class="carousel-item">
										<img src="" class="d-block w-100 rounded" alt="..." height="350px;">
									</div>
									<div class="carousel-item">
										<img src="" class="d-block w-100 rounded" alt="..." height="350px;">
									</div>
									<div class="carousel-item">
										<img src="" class="d-block w-100 rounded" alt="..." height="350px;">
									</div>
									<div class="carousel-item">
										<img src="" class="d-block w-100 rounded" alt="..." height="350px;">
									</div>
								</div>
								<button class="carousel-control-prev" type="button"
									data-bs-target="#Modalcarousel" data-bs-slide="prev">
									<span class="carousel-control-prev-icon" aria-hidden="true"></span>
									<span class="visually-hidden">Previous</span>
								</button>
								<button class="carousel-control-next" type="button"
									data-bs-target="#Modalcarousel" data-bs-slide="next">
									<span class="carousel-control-next-icon" aria-hidden="true"></span>
									<span class="visually-hidden">Next</span>
								</button>
							</div>
							<p></p>
							<!-- /col1 -->
						</div>
						<!-- emoji-heart-eyes -->
						<div class='col'>
							<!-- col2 -->
							<div id="map" class="rounded"></div>
							<br>
							<img class='img' src='./img/icons/bookmark-heart.svg' alt='Bootstrap' width='20' height='20'>&nbsp;이 장소를 찜한 회원 수 : <span id="heartcount"></span>
							<hr>
							<img class='img' src='./img/icons/pin-fill.svg' alt='Bootstrap' width='20' height='20'>&nbsp;여행지에 추가한 회원 리스트 <br>
							<div id="userlist"></div>
							<!-- col2 -->
						</div>

					</div>
				</div>
				<div class="modal-footer">
					<input type="hidden" id="thumbnail" value=""> 
					<input type="hidden" id="address" value=""> 
					<input type="hidden" id="placename" value="">
					<input type="hidden" id="latitude" value=""> 
					<input type="hidden" id="longtitude" value="">
					<input type="hidden" id="placeid" value="">
					<input type="hidden" id="nation" value="">
					<input type="hidden" id="city" value="">
					<button type="button" class="btn" data-bs-dismiss="modal" style="outline: none;">닫기</button>
					<button type="button" id="btnheart" class="btn_1" onclick=""><img class='img' id="heartimg" src='./img/icons/suit-heart.svg' alt='Bootstrap' width='20' height='20'><span id="heart">&nbsp;장소 찜 추가&nbsp;</span></button>&nbsp;&nbsp;
				</div>
			</div>
		</div>
	</div>














	<br>
	<br>
	<br>
	<!-- 고정(푸터) -->
	<div id="footer">
		<%@ include file="./form/footer.jsp"%>
	</div>
</body>
</html>