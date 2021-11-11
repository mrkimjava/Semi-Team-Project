<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>   
<%@ page import="com.mvc.dto.blogDto" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.util.LinkedHashMap" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.Map.Entry" %>
<%@ page import="java.util.Arrays" %>
<%
	blogDto bdto = (blogDto)request.getAttribute("bdto");
	String userid = bdto.getUser_id();
	int penalty = bdto.getUser_penalty();
	String createdate = bdto.getBlog_create_date().toString().split("\\.")[0];
	String title = bdto.getTitle();
	String content = bdto.getContent();
	String thumbnail = bdto.getThumbnailPath();
	String area[] = bdto.getAreaname().split(",");
	String areaFull = "";
	for(String s : area){areaFull += s + " ";}
	int heartcount = bdto.getHeart_count();
	int commentcount = bdto.getComment();
	int hits = bdto.getHits();
	int blogseq = bdto.getBlog_seq();
	
	Iterator<Entry<Date, String>> linkedIter = bdto.getMap().entrySet().iterator();
	int length = bdto.getMap().size();
	
	Date date[] = new Date[length];
	String string[] = new String[length];
	int idx = 0;
	
	while(linkedIter.hasNext()){
		Entry<Date, String> entry = linkedIter.next();
		date[idx] = entry.getKey();
		string[idx] = entry.getValue();
		idx++;
	}
	
	UserDto userdto = (UserDto)session.getAttribute("dto");
	String sessionId = "";
	int sessionPenalty = -1;//세션 유저의 페널티
	if(userdto != null){
		sessionId = userdto.getUser_id();
		sessionPenalty = userdto.getPanalty();
	}
	String None = "none";
	String Yes = "display";
	
	System.out.println(userid);
	System.out.println(sessionId);
%>
    
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.css" integrity="sha512-3pIirOrwegjM6erE5gPSwkUzO+3cTjpnV9lexlNZqvupR64iZBnOOTiiLPb9M36zpMScbmUNIcHUqKD47M719g==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<script type="text/javascript" src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script defer src="https://use.fontawesome.com/releases/v5.15.4/js/all.js" integrity="sha384-rOA1PnstxnOBLzCLMcre8ybwbTmemjzdNlILg8O7z1lUkLXozs4DHonlDtnE7fpc" crossorigin="anonymous"></script>
<script type="text/javascript" src="http://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>
<script src="<%=request.getContextPath() %>/json/country.json" type="text/javascript"></script>
<meta charset="UTF-8">
<title>Insert title here</title>

<style type="text/css">
.right{
	text-align: right;
}

#container-top a, #container-top a{
	font-size: 100% !important;
}

.bottomBtn {
	border: 1px solid gray;
	text-align: center;
	background-color: white;
	border-radius: 22px;
	padding: 8px;
	margin-bottom: 5px;
}

.commentbtn{
	border: 1px solid gray;
	text-align: center;
	background-color: white;
	border-radius: 8px;
	padding: 8px;
	margin-bottom: 5px;
}

#map {
	width: 100%;
	height: 500px;
}

.toast-success {
	background-color: #77ca8a !important;
	font-weight: bold !important;
	font-size: 12pt !important; 
}

.toast-error {
	background-color: #BD362F !important;
	font-weight: bold !important;
	font-size: 12pt !important; 
}

.toast-info {
	background-color: #2F96B4 !important;
	font-weight: bold !important;
	font-size: 12pt !important; 
}

.toast-warning {
	background-color: #F89406 !important;
	font-weight: bold !important;
	font-size: 12pt !important; 
}

.toast-top-right {
	top: 7%;
}

</style>




<style type="text/css">
/* -------------------------------- 

Primary style

-------------------------------- */
@import url(https://fonts.googleapis.com/css?family=Source+Sans+Pro);
*,
*::after,
*::before {
  box-sizing: border-box;
}

html {
  font-size: 62.5%;
}

body {
  font-size: 1.6rem;
  font-family: "Source Sans Pro", sans-serif;
  color: #383838;
  background-color: #f8f8f8;
}

a {
  color: #7b9d6f;
  text-decoration: none;
}

/* -------------------------------- 

Main Components 

-------------------------------- */
.cd-horizontal-timeline {
  opacity: 0;
  margin: 2em auto;
  -webkit-transition: opacity 0.2s;
  -moz-transition: opacity 0.2s;
  transition: opacity 0.2s;
}
.cd-horizontal-timeline::before {
  /* never visible - this is used in jQuery to check the current MQ */
  content: "mobile";
  display: none;
}
.cd-horizontal-timeline.loaded {
  /* show the timeline after events position has been set (using JavaScript) */
  opacity: 1;
}
.cd-horizontal-timeline .timeline {
  position: relative;
  height: 100px;
  width: 90%;
  max-width: 1100px;
  margin: 0 auto;
}
.cd-horizontal-timeline .events-wrapper {
  position: relative;
  height: 100%;
  margin: 0 40px;
  overflow: hidden;
}
.cd-horizontal-timeline .events-wrapper::after,
.cd-horizontal-timeline .events-wrapper::before {
  /* these are used to create a shadow effect at the sides of the timeline */
  content: "";
  position: absolute;
  z-index: 2;
  top: 0;
  height: 100%;
  width: 20px;
}
.cd-horizontal-timeline .events-wrapper::before {
  left: 0;
  background-image: -webkit-linear-gradient(
    left,
    #f8f8f8,
    rgba(248, 248, 248, 0)
  );
  background-image: linear-gradient(to right, #f8f8f8, rgba(248, 248, 248, 0));
}
.cd-horizontal-timeline .events-wrapper::after {
  right: 0;
  background-image: -webkit-linear-gradient(
    right,
    #f8f8f8,
    rgba(248, 248, 248, 0)
  );
  background-image: linear-gradient(to left, #f8f8f8, rgba(248, 248, 248, 0));
}
.cd-horizontal-timeline .events {
  /* this is the grey line/timeline */
  position: absolute;
  z-index: 1;
  left: 0;
  top: 49px;
  height: 2px;
  /* width will be set using JavaScript */
  background: #dfdfdf;
  -webkit-transition: -webkit-transform 0.4s;
  -moz-transition: -moz-transform 0.4s;
  transition: transform 0.4s;
}
.cd-horizontal-timeline .filling-line {
  /* this is used to create the green line filling the timeline */
  position: absolute;
  z-index: 1;
  left: 0;
  top: 0;
  height: 100%;
  width: 100%;
  background-color: #7b9d6f;
  -webkit-transform: scaleX(0);
  -moz-transform: scaleX(0);
  -ms-transform: scaleX(0);
  -o-transform: scaleX(0);
  transform: scaleX(0);
  -webkit-transform-origin: left center;
  -moz-transform-origin: left center;
  -ms-transform-origin: left center;
  -o-transform-origin: left center;
  transform-origin: left center;
  -webkit-transition: -webkit-transform 0.3s;
  -moz-transition: -moz-transform 0.3s;
  transition: transform 0.3s;
}
.cd-horizontal-timeline .events a {
  position: absolute;
  bottom: 0;
  z-index: 2;
  text-align: center;
  font-size: 1.3rem;
  padding-bottom: 15px;
  color: #383838;
  /* fix bug on Safari - text flickering while timeline translates */
  -webkit-transform: translateZ(0);
  -moz-transform: translateZ(0);
  -ms-transform: translateZ(0);
  -o-transform: translateZ(0);
  transform: translateZ(0);
}
.cd-horizontal-timeline .events a::after {
  /* this is used to create the event spot */
  content: "";
  position: absolute;
  left: 50%;
  right: auto;
  -webkit-transform: translateX(-50%);
  -moz-transform: translateX(-50%);
  -ms-transform: translateX(-50%);
  -o-transform: translateX(-50%);
  transform: translateX(-50%);
  bottom: -5px;
  height: 12px;
  width: 12px;
  border-radius: 50%;
  border: 2px solid #dfdfdf;
  background-color: #f8f8f8;
  -webkit-transition: background-color 0.3s, border-color 0.3s;
  -moz-transition: background-color 0.3s, border-color 0.3s;
  transition: background-color 0.3s, border-color 0.3s;
}
.no-touch .cd-horizontal-timeline .events a:hover::after {
  background-color: #7b9d6f;
  border-color: #7b9d6f;
}
.cd-horizontal-timeline .events a.selected {
  pointer-events: none;
}
.cd-horizontal-timeline .events a.selected::after {
  background-color: #7b9d6f;
  border-color: #7b9d6f;
}
.cd-horizontal-timeline .events a.older-event::after {
  border-color: #7b9d6f;
}
@media only screen and (min-width: 1100px) {
  .cd-horizontal-timeline {
    margin: 6em auto;
  }
  .cd-horizontal-timeline::before {
    /* never visible - this is used in jQuery to check the current MQ */
    content: "desktop";
  }
}

.cd-timeline-navigation a {
  /* these are the left/right arrows to navigate the timeline */
  position: absolute;
  z-index: 1;
  top: 50%;
  bottom: auto;
  -webkit-transform: translateY(-50%);
  -moz-transform: translateY(-50%);
  -ms-transform: translateY(-50%);
  -o-transform: translateY(-50%);
  transform: translateY(-50%);
  height: 34px;
  width: 34px;
  border-radius: 50%;
  border: 2px solid #dfdfdf;
  /* replace text with an icon */
  overflow: hidden;
  color: transparent;
  text-indent: 100%;
  white-space: nowrap;
  -webkit-transition: border-color 0.3s;
  -moz-transition: border-color 0.3s;
  transition: border-color 0.3s;
}
.cd-timeline-navigation a::after {
  /* arrow icon */
  content: "";
  position: absolute;
  height: 16px;
  width: 16px;
  left: 50%;
  top: 50%;
  bottom: auto;
  right: auto;
  -webkit-transform: translateX(-50%) translateY(-50%);
  -moz-transform: translateX(-50%) translateY(-50%);
  -ms-transform: translateX(-50%) translateY(-50%);
  -o-transform: translateX(-50%) translateY(-50%);
  transform: translateX(-50%) translateY(-50%);
/*   background: url(../img/cd-arrow.svg) no-repeat 0 0; */
}
.cd-timeline-navigation a.prev {
  left: 0;
  -webkit-transform: translateY(-50%) rotate(180deg);
  -moz-transform: translateY(-50%) rotate(180deg);
  -ms-transform: translateY(-50%) rotate(180deg);
  -o-transform: translateY(-50%) rotate(180deg);
  transform: translateY(-50%) rotate(180deg);
}
.cd-timeline-navigation a.next {
  right: 0;
}
.no-touch .cd-timeline-navigation a:hover {
  border-color: #7b9d6f;
}
.cd-timeline-navigation a.inactive {
  cursor: not-allowed;
}
.cd-timeline-navigation a.inactive::after {
  background-position: 0 -16px;
}
.no-touch .cd-timeline-navigation a.inactive:hover {
  border-color: #dfdfdf;
}

.cd-horizontal-timeline .events-content {
  position: relative;
  width: 100%;
  margin: 2em 0;
  overflow: hidden;
  -webkit-transition: height 0.4s;
  -moz-transition: height 0.4s;
  transition: height 0.4s;
}
.cd-horizontal-timeline .events-content li {
  position: absolute;
  z-index: 1;
  width: 100%;
  left: 0;
  top: 0;
  -webkit-transform: translateX(-100%);
  -moz-transform: translateX(-100%);
  -ms-transform: translateX(-100%);
  -o-transform: translateX(-100%);
  transform: translateX(-100%);
  padding: 0 5%;
  opacity: 0;
  -webkit-animation-duration: 0.4s;
  -moz-animation-duration: 0.4s;
  animation-duration: 0.4s;
  -webkit-animation-timing-function: ease-in-out;
  -moz-animation-timing-function: ease-in-out;
  animation-timing-function: ease-in-out;
}
.cd-horizontal-timeline .events-content li.selected {
  /* visible event content */
  position: relative;
  z-index: 2;
  opacity: 1;
  -webkit-transform: translateX(0);
  -moz-transform: translateX(0);
  -ms-transform: translateX(0);
  -o-transform: translateX(0);
  transform: translateX(0);
}
.cd-horizontal-timeline .events-content li.enter-right,
.cd-horizontal-timeline .events-content li.leave-right {
  -webkit-animation-name: cd-enter-right;
  -moz-animation-name: cd-enter-right;
  animation-name: cd-enter-right;
}
.cd-horizontal-timeline .events-content li.enter-left,
.cd-horizontal-timeline .events-content li.leave-left {
  -webkit-animation-name: cd-enter-left;
  -moz-animation-name: cd-enter-left;
  animation-name: cd-enter-left;
}
.cd-horizontal-timeline .events-content li.leave-right,
.cd-horizontal-timeline .events-content li.leave-left {
  -webkit-animation-direction: reverse;
  -moz-animation-direction: reverse;
  animation-direction: reverse;
}
.cd-horizontal-timeline .events-content li > * {
  max-width: 1000px;
  margin: 0 auto;
}
.cd-horizontal-timeline .events-content h2 {
  font-weight: bold;
  font-size: 2.6rem;
  font-family: "Playfair Display", serif;
  font-weight: 700;
  line-height: 1.2;
}
.cd-horizontal-timeline .events-content em {
  display: block;
  font-style: italic;
  margin: 10px auto;
}
.cd-horizontal-timeline .events-content em::before {
  content: "- ";
}
.cd-horizontal-timeline .events-content p {
  font-size: 1.4rem;
  color: #959595;
}
.cd-horizontal-timeline .events-content em,
.cd-horizontal-timeline .events-content p {
  line-height: 1.6;
}
@media only screen and (min-width: 768px) {
  .cd-horizontal-timeline .events-content h2 {
    font-size: 7rem;
  }
  .cd-horizontal-timeline .events-content em {
    font-size: 2rem;
  }
  .cd-horizontal-timeline .events-content p {
    font-size: 1.8rem;
  }
}

@-webkit-keyframes cd-enter-right {
  0% {
    opacity: 0;
    -webkit-transform: translateX(100%);
  }
  100% {
    opacity: 1;
    -webkit-transform: translateX(0%);
  }
}
@-moz-keyframes cd-enter-right {
  0% {
    opacity: 0;
    -moz-transform: translateX(100%);
  }
  100% {
    opacity: 1;
    -moz-transform: translateX(0%);
  }
}
@keyframes cd-enter-right {
  0% {
    opacity: 0;
    -webkit-transform: translateX(100%);
    -moz-transform: translateX(100%);
    -ms-transform: translateX(100%);
    -o-transform: translateX(100%);
    transform: translateX(100%);
  }
  100% {
    opacity: 1;
    -webkit-transform: translateX(0%);
    -moz-transform: translateX(0%);
    -ms-transform: translateX(0%);
    -o-transform: translateX(0%);
    transform: translateX(0%);
  }
}
@-webkit-keyframes cd-enter-left {
  0% {
    opacity: 0;
    -webkit-transform: translateX(-100%);
  }
  100% {
    opacity: 1;
    -webkit-transform: translateX(0%);
  }
}
@-moz-keyframes cd-enter-left {
  0% {
    opacity: 0;
    -moz-transform: translateX(-100%);
  }
  100% {
    opacity: 1;
    -moz-transform: translateX(0%);
  }
}
@keyframes cd-enter-left {
  0% {
    opacity: 0;
    -webkit-transform: translateX(-100%);
    -moz-transform: translateX(-100%);
    -ms-transform: translateX(-100%);
    -o-transform: translateX(-100%);
    transform: translateX(-100%);
  }
  100% {
    opacity: 1;
    -webkit-transform: translateX(0%);
    -moz-transform: translateX(0%);
    -ms-transform: translateX(0%);
    -o-transform: translateX(0%);
    transform: translateX(0%);
  }
}

</style>














</head>
<script type="text/javascript">
let Data = new Array();

</script>
<%
	for(int i = 0; i < length; i++){
%>
	<script type="text/javascript">
		var object = new Object();
		object.date = "<%= date[i].toString() %>";
		object.place = "<%= string[i].toString() %>";
	
		Data.push(object);
	</script>		
<%	
	}
%>

<script type="text/javascript">
//세션아이디
let sessionid = "<%=sessionId %>";
//작성자
let userid = "<%=userid %>";
//기타
let none = "none";
let yes = "display";
let writer = "작성자";
let pointer = "pointer";
let dfcursor = "default";
let noshowanswer = "";
let showanswer_ = "showanswer(this)";
let white = "";
let gray = "table-light";
let blue = "rgb(126, 167, 233)";
let black = "black";
//dtolist
let dayandplace = new Array();
//날씨변수
let key = "7a1ac041d1f72d9c0178aea6efe0543c";
//코로나 api 변수
let covid;
let tripCountry = "<%=bdto.getAreaname() %>";
let tripCountryList = tripCountry.split(",");
let jsonData = JSON.parse(JSON.stringify(data)); //국가코드 json파일
//map

//init Map
let map;
let infowindow;
let markerlist = []; //{lat : ?? , lng : ??}
let markers = []; //마커 객체배열
let infowindows = []; //인포윈도우 객체배열
//인포윈도우 띄울내용
let infocontent = [];

	$(function(){
		
		//--찜여부 초반표시
		if(sessionid != ""){
			$.ajax({
				url:"<%=request.getContextPath()%>/blog.do?command=confirmblogheart&sessionId=<%=sessionId%>&blogId=<%=userid%>&blogSeq=<%=blogseq%>",
				method: "post",
				success:function(data){
					if(data == "true"){
						$("#btnheart").removeAttr("onclick");
						$("#btnheart").attr("onclick","rmheart();");
						$("#heartimg").prop("src","<%=request.getContextPath()%>/img/icons/suit-heart-fill.svg");
						$("#heart").html("해제");
					}else{
						$("#btnheart").removeAttr("onclick");
						$("#btnheart").attr("onclick","addheart();");
						$("#heartimg").prop("src","<%=request.getContextPath()%>/img/icons/suit-heart.svg");
						$("#heart").html("추가");
					}
				},
				error:function(){
					$("#heart").html("에러");
				}
			});
		}	
		
		
		//------------------------데이터 입력
		for(var i = 0; i < Data.length; i++){
			
			var tempObj = new Object();
			tempObj.date = Data[i].date;
			tempObj.place = new Array();
			
			var placelist = Data[i].place.split("^");
			placelist.splice(placelist.length-1, 1);
			
			for(var j = 0; j < placelist.length; j++){
				
				var placedetail = placelist[j].split("|");
				placedetail.splice(placedetail.length-1, 1);
				
				var placeobj = new Object();
				placeobj.time = placedetail[0];
				placeobj.name = placedetail[1];
				placeobj.addr = placedetail[2];
				placeobj.url = placedetail[3];
				placeobj.src = placedetail[4];
				placeobj.lng = placedetail[5];
				placeobj.lat = placedetail[6];
				
				tempObj.place.push(placeobj);
			}
			
			dayandplace.push(tempObj);
		}
		
		console.log(dayandplace);
		
		
		//날짜생성--------------------------------------------------------------------------------
		var length = dayandplace.length;
		for(var i = 0; i < length; i++){
			
			$(".events").eq(0).find("ol").append(createli(toDate(dayandplace[i].date), i+1, dayandplace[i].date));
			$(".events-content").eq(0).find("ol").append(createLi(toDate(dayandplace[i].date)));
		}
		
		//날짜에 해당하는 데이터--------------------------------------------------------------------------------
		var count = 1;
		for(var i = 0; i < length; i++){

			var html = "";
			
			for(var j = 0; j < dayandplace[i].place.length; j++){
				
				
				html += createDetail(count++,
								     dayandplace[i].place[j].name ,
									 dayandplace[i].place[j].addr ,
						             ((dayandplace[i].place[j].time=='00:00')? '미정' : visitTime(dayandplace[i].place[j].time)) ,
						             dayandplace[i].place[j].src ,
						             dayandplace[i].place[j].url ,
						             dayandplace[i].place[j].lat ,
						             dayandplace[i].place[j].lng ,
						             );
				
			}
			
			$(".events-content").eq(0).find("li").eq(i).append(html);
			
		}
		
		$(".events").eq(0).find("a").eq(0).attr("class","selected");
		$(".events-content").eq(0).find("li").eq(0).attr("class","selected");
		
		//날씨데이터추가
		$(".events-content").eq(0).find("li").each(function(){
			
			var date = $(this).find("h3").html().split("의")[0];
			
			$(this).find(".row").each(function(){
			
				var lat = $(this).find("input[name=lat]").val();
				var lng = $(this).find("input[name=lng]").val();
				var location = $(this);
				
				getWeather(location, date, lat, lng);
				
			});
			
		});
		
		

		//코로나 데이터 추가--------------------------------------------------------------------------------
		
		var settings = {
				  "url": "https://api.covid19api.com/summary",
				  "method": "GET",
				  "timeout": 0,
				  /* "async":false, */
				};

				$.ajax(settings).done(function (response) {
				  covid = response;
				  console.log(covid);
				  
				  
				  //국가코드 인덱스 참고용
				  let index = [];
				  for (let x in jsonData) { 
					  index.push(x); 
				  } 
					
				  //covid country배열
				  var arr = covid.Countries;
					
				  for(var i = 0; i < tripCountryList.length; i++){
					  for(var j = 0; j < index.length; j++){
						  var cname = tripCountryList[i].replace(/(\s*)/g, "");
						  var CnameKR = jsonData[index[j]].CountryNameKR.replace(/(\s*)/g, "");
						  var CnameEN = jsonData[index[j]].CountryNameEN.replace(/(\s*)/g, "");
						  var CnameOr = jsonData[index[j]].CountryNameOriginal.replace(/(\s*)/g, "");

						  if(CnameKR == cname || CnameEN == cname || CnameOr == cname){
								
							  var str = jsonData[index[j]]["2digitCode"];
							  var idx = arr.findIndex(x => x.CountryCode == str);
								
							  if(idx != -1){
								  var html2 = createTr(covid.Countries[idx].Country,
									  covid.Countries[idx].TotalConfirmed,
									  covid.Countries[idx].NewConfirmed,
									  covid.Countries[idx].TotalDeaths,
									  covid.Countries[idx].NewDeaths);
								  $("#visitCountry").append(html2);
							  }
						  }
					  }
				  } 
				
				  //date
				  $(".reportdate").each(function(){
					  $(this).html(covid.Global.Date.split("T")[0]);
				  });
					
				  //totalreport
				  var html = createTotalTr(covid.Global.TotalConfirmed.toLocaleString(),
							   covid.Global.TotalDeaths.toLocaleString(),
							   covid.Global.NewConfirmed.toLocaleString(),
							   covid.Global.NewDeaths.toLocaleString());
				  $("#totalCountry").append(html);
			    });

		//-----------------------------------------------------------------------------------------		
				

				//마커---------------------------------------------------------------------------------------
				
				
				for(var i = 0; i < dayandplace.length; i++){
				
					for(var j = 0; j < dayandplace[i].place.length; j++){
					
						var tmp = {lat : parseFloat(dayandplace[i].place[j].lat), 
								   lng : parseFloat(dayandplace[i].place[j].lng)};
						markerlist.push(tmp);				
						
						var obj = new Object();
						obj.pname = dayandplace[i].place[j].name;
						obj.time = dayandplace[i].place[j].time;
						obj.pdate = dayandplace[i].date;
						
						infocontent.push(obj);
					}
					
				}
		
				for(var i = 0; i < markerlist.length; i++){
					$("#start").append(createSelect(i, i));
					$("#end").append(createSelect(i, i));
				}
		
				//map
				initMap();
				/* createMarker(markerlist); */
				

						
				
				
				
				
	});

	function visitTime(time){
		var timesplit = time.split(":");
		return timesplit[0] + "시 " + timesplit[1] + "분";		
	}
	
	
	function toDate(date){
		var val = date.split("-");
		var toDate = val[2] + "/" + val[1] + "/" + val[0];
		return toDate;
	}
	
	function toDate2(date){
		var val = date.split("/");
		var toDate2 = val[2] + "-" + val[1] + "-" + val[0];
		return toDate2;
	}
	
	function createli(todate, i, date){
		var html = "";
		html = "<li><a href='#0' data-date='"+ todate +"'>Day"+ i +"</a>"+ date +"</li>";
		return html;
	}
	
	function createLi(todate){
		var html = "";
		html = "<li data-date='" + todate + "'>" + 
			   "<br><h3 style='font-family: Arial !important; font-size:29pt !important;'>"+ toDate2(todate) +"의 일정</h2><br><br><br>" + 
			   "</li>";
		return html;
	}
	
	function createDetail(i, placename, addr, time, src, url, lat, lng){
		var html = "";
		html = "<div class='row'><div class='col-lg-1'></div><div class='col-lg-6'><img class='img-thumbnail rounded' src='"+ src +"' style='width:100%; border-radius:10px !important;'></div><div class='col-lg-4'><h3><b>"+ i +". "+ placename +"</b></h3><h5>"+ addr +"</h5><span id='weather' style='font-size: 15pt; color:rgb(31,210,127);'></span><br><br><h4><b>방문예정 시각 : "+ time +"</b></h4><br><a href='"+ url +"' style='font-size:12pt; text-decoration:none; color:black;'><img src='<%=request.getContextPath()%>/img/icons/caret-right-fill.svg' alt='Bootstrap'>상세정보</a></div><div class='col-lg-1'></div>" +
               "<input type = 'hidden' name='lat' value='"+ lat +"'>" + 
               "<input type = 'hidden' name='lng' value='"+ lng +"'></div><br><br>"; 
		return html;
	}
	
	function getWeather(location, date, lat, lng){
		
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
		let url = "https://api.openweathermap.org/data/2.5/onecall?lat="+ lat +"&lon="+ lng +"&appid="+key+"&exclude=hourly,minutely&units=metric";
		
		$.ajax({
			url : url,
			dataType : "json",
			method : "GET",
			success : function(resp) {
				
				console.log(resp);
				
				var idx = -1;
				
				for(var i = 0; i < resp.daily.length; i++){
					
					var dt = resp.daily[i].dt;
					var dtdate = new Date(dt*1000);
					if(date == dtdate.toISOString().split("T")[0]){
						idx = i;
						console.log(date);
						console.log(dtdate.toISOString().split("T")[0]);
						break;
					}
				}
				
				if(idx == -1){
					return;
				}

				var icon = (resp.daily[idx].weather[0].icon).substring(0,2);
				var desc = resp.daily[idx].weather[0].description;
				var maxtemp = Math.floor(resp.daily[idx].temp.max) + "º";
				var mintemp = Math.floor(resp.daily[idx].temp.min) + "º";
				
				let temphtml = "";
				
				temphtml += '<i class="' + weatherIcon[icon] + '"></i> &nbsp;';
				temphtml += desc + "&nbsp;";
				temphtml += "↑" + maxtemp + "&nbsp;";
				temphtml += "↓" + mintemp;
				
				location.find("span").eq(0).html(temphtml);
				return;
				
			},
			error : function(){
				alert("실패");
			}
		});
		
	}
	
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
	
	function createSelect(lnglat, i){
		var html = "";
		html = "<option value='"+ lnglat +"'>"+ (i+1) +"번째 장소</option>";
		return html;
	}
	
</script>





<script type="text/javascript">
jQuery(document).ready(function($){
	var timelines = $('.cd-horizontal-timeline'),
		eventsMinDistance = 60;

	(timelines.length > 0) && initTimeline(timelines);

	function initTimeline(timelines) {
		timelines.each(function(){
			var timeline = $(this),
				timelineComponents = {};
			//cache timeline components 
			timelineComponents['timelineWrapper'] = timeline.find('.events-wrapper');
			timelineComponents['eventsWrapper'] = timelineComponents['timelineWrapper'].children('.events');
			timelineComponents['fillingLine'] = timelineComponents['eventsWrapper'].children('.filling-line');
			timelineComponents['timelineEvents'] = timelineComponents['eventsWrapper'].find('a');
			timelineComponents['timelineDates'] = parseDate(timelineComponents['timelineEvents']);
			timelineComponents['eventsMinLapse'] = minLapse(timelineComponents['timelineDates']);
			timelineComponents['timelineNavigation'] = timeline.find('.cd-timeline-navigation');
			timelineComponents['eventsContent'] = timeline.children('.events-content');

			//assign a left postion to the single events along the timeline
			setDatePosition(timelineComponents, eventsMinDistance);
			//assign a width to the timeline
			var timelineTotWidth = setTimelineWidth(timelineComponents, eventsMinDistance);
			//the timeline has been initialize - show it
			timeline.addClass('loaded');

			//detect click on the next arrow
			timelineComponents['timelineNavigation'].on('click', '.next', function(event){
				event.preventDefault();
				updateSlide(timelineComponents, timelineTotWidth, 'next');
			});
			//detect click on the prev arrow
			timelineComponents['timelineNavigation'].on('click', '.prev', function(event){
				event.preventDefault();
				updateSlide(timelineComponents, timelineTotWidth, 'prev');
			});
			//detect click on the a single event - show new event content
			timelineComponents['eventsWrapper'].on('click', 'a', function(event){
				event.preventDefault();
				timelineComponents['timelineEvents'].removeClass('selected');
				$(this).addClass('selected');
				updateOlderEvents($(this));
				updateFilling($(this), timelineComponents['fillingLine'], timelineTotWidth);
				updateVisibleContent($(this), timelineComponents['eventsContent']);
			});

			//on swipe, show next/prev event content
			timelineComponents['eventsContent'].on('swipeleft', function(){
				var mq = checkMQ();
				( mq == 'mobile' ) && showNewContent(timelineComponents, timelineTotWidth, 'next');
			});
			timelineComponents['eventsContent'].on('swiperight', function(){
				var mq = checkMQ();
				( mq == 'mobile' ) && showNewContent(timelineComponents, timelineTotWidth, 'prev');
			});

			//keyboard navigation
			$(document).keyup(function(event){
				if(event.which=='37' && elementInViewport(timeline.get(0)) ) {
					showNewContent(timelineComponents, timelineTotWidth, 'prev');
				} else if( event.which=='39' && elementInViewport(timeline.get(0))) {
					showNewContent(timelineComponents, timelineTotWidth, 'next');
				}
			});
		});
	}

	function updateSlide(timelineComponents, timelineTotWidth, string) {
		//retrieve translateX value of timelineComponents['eventsWrapper']
		var translateValue = getTranslateValue(timelineComponents['eventsWrapper']),
			wrapperWidth = Number(timelineComponents['timelineWrapper'].css('width').replace('px', ''));
		//translate the timeline to the left('next')/right('prev') 
		(string == 'next') 
			? translateTimeline(timelineComponents, translateValue - wrapperWidth + eventsMinDistance, wrapperWidth - timelineTotWidth)
			: translateTimeline(timelineComponents, translateValue + wrapperWidth - eventsMinDistance);
	}

	function showNewContent(timelineComponents, timelineTotWidth, string) {
		//go from one event to the next/previous one
		var visibleContent =  timelineComponents['eventsContent'].find('.selected'),
			newContent = ( string == 'next' ) ? visibleContent.next() : visibleContent.prev();

		if ( newContent.length > 0 ) { //if there's a next/prev event - show it
			var selectedDate = timelineComponents['eventsWrapper'].find('.selected'),
				newEvent = ( string == 'next' ) ? selectedDate.parent('li').next('li').children('a') : selectedDate.parent('li').prev('li').children('a');
			
			updateFilling(newEvent, timelineComponents['fillingLine'], timelineTotWidth);
			updateVisibleContent(newEvent, timelineComponents['eventsContent']);
			newEvent.addClass('selected');
			selectedDate.removeClass('selected');
			updateOlderEvents(newEvent);
			updateTimelinePosition(string, newEvent, timelineComponents, timelineTotWidth);
		}
	}

	function updateTimelinePosition(string, event, timelineComponents, timelineTotWidth) {
		//translate timeline to the left/right according to the position of the selected event
		var eventStyle = window.getComputedStyle(event.get(0), null),
			eventLeft = Number(eventStyle.getPropertyValue("left").replace('px', '')),
			timelineWidth = Number(timelineComponents['timelineWrapper'].css('width').replace('px', '')),
			timelineTotWidth = Number(timelineComponents['eventsWrapper'].css('width').replace('px', ''));
		var timelineTranslate = getTranslateValue(timelineComponents['eventsWrapper']);

        if( (string == 'next' && eventLeft > timelineWidth - timelineTranslate) || (string == 'prev' && eventLeft < - timelineTranslate) ) {
        	translateTimeline(timelineComponents, - eventLeft + timelineWidth/2, timelineWidth - timelineTotWidth);
        }
	}

	function translateTimeline(timelineComponents, value, totWidth) {
		var eventsWrapper = timelineComponents['eventsWrapper'].get(0);
		value = (value > 0) ? 0 : value; //only negative translate value
		value = ( !(typeof totWidth === 'undefined') &&  value < totWidth ) ? totWidth : value; //do not translate more than timeline width
		setTransformValue(eventsWrapper, 'translateX', value+'px');
		//update navigation arrows visibility
		(value == 0 ) ? timelineComponents['timelineNavigation'].find('.prev').addClass('inactive') : timelineComponents['timelineNavigation'].find('.prev').removeClass('inactive');
		(value == totWidth ) ? timelineComponents['timelineNavigation'].find('.next').addClass('inactive') : timelineComponents['timelineNavigation'].find('.next').removeClass('inactive');
	}

	function updateFilling(selectedEvent, filling, totWidth) {
		//change .filling-line length according to the selected event
		var eventStyle = window.getComputedStyle(selectedEvent.get(0), null),
			eventLeft = eventStyle.getPropertyValue("left"),
			eventWidth = eventStyle.getPropertyValue("width");
		eventLeft = Number(eventLeft.replace('px', '')) + Number(eventWidth.replace('px', ''))/2;
		var scaleValue = eventLeft/totWidth;
		setTransformValue(filling.get(0), 'scaleX', scaleValue);
	}

	function setDatePosition(timelineComponents, min) {
		for (i = 0; i < timelineComponents['timelineDates'].length; i++) { 
		    var distance = daydiff(timelineComponents['timelineDates'][0], timelineComponents['timelineDates'][i]),
		    	distanceNorm = Math.round(distance/timelineComponents['eventsMinLapse']) + 2;
		    timelineComponents['timelineEvents'].eq(i).css('left', distanceNorm*min+'px');
		}
	}

	function setTimelineWidth(timelineComponents, width) {
		var timeSpan = daydiff(timelineComponents['timelineDates'][0], timelineComponents['timelineDates'][timelineComponents['timelineDates'].length-1]),
			timeSpanNorm = timeSpan/timelineComponents['eventsMinLapse'],
			timeSpanNorm = Math.round(timeSpanNorm) + 4,
			totalWidth = timeSpanNorm*width;
		timelineComponents['eventsWrapper'].css('width', totalWidth+'px');
		updateFilling(timelineComponents['timelineEvents'].eq(0), timelineComponents['fillingLine'], totalWidth);
	
		return totalWidth;
	}

	function updateVisibleContent(event, eventsContent) {
		var eventDate = event.data('date'),
			visibleContent = eventsContent.find('.selected'),
			selectedContent = eventsContent.find('[data-date="'+ eventDate +'"]'),
			selectedContentHeight = selectedContent.height();

		if (selectedContent.index() > visibleContent.index()) {
			var classEnetering = 'selected enter-right',
				classLeaving = 'leave-left';
		} else {
			var classEnetering = 'selected enter-left',
				classLeaving = 'leave-right';
		}

		selectedContent.attr('class', classEnetering);
		visibleContent.attr('class', classLeaving).one('webkitAnimationEnd oanimationend msAnimationEnd animationend', function(){
			visibleContent.removeClass('leave-right leave-left');
			selectedContent.removeClass('enter-left enter-right');
		});
		eventsContent.css('height', selectedContentHeight+'px');
	}

	function updateOlderEvents(event) {
		event.parent('li').prevAll('li').children('a').addClass('older-event').end().end().nextAll('li').children('a').removeClass('older-event');
	}

	function getTranslateValue(timeline) {
		var timelineStyle = window.getComputedStyle(timeline.get(0), null),
			timelineTranslate = timelineStyle.getPropertyValue("-webkit-transform") ||
         		timelineStyle.getPropertyValue("-moz-transform") ||
         		timelineStyle.getPropertyValue("-ms-transform") ||
         		timelineStyle.getPropertyValue("-o-transform") ||
         		timelineStyle.getPropertyValue("transform");

        if( timelineTranslate.indexOf('(') >=0 ) {
        	var timelineTranslate = timelineTranslate.split('(')[1];
    		timelineTranslate = timelineTranslate.split(')')[0];
    		timelineTranslate = timelineTranslate.split(',');
    		var translateValue = timelineTranslate[4];
        } else {
        	var translateValue = 0;
        }

        return Number(translateValue);
	}

	function setTransformValue(element, property, value) {
		element.style["-webkit-transform"] = property+"("+value+")";
		element.style["-moz-transform"] = property+"("+value+")";
		element.style["-ms-transform"] = property+"("+value+")";
		element.style["-o-transform"] = property+"("+value+")";
		element.style["transform"] = property+"("+value+")";
	}

	//based on http://stackoverflow.com/questions/542938/how-do-i-get-the-number-of-days-between-two-dates-in-javascript
	function parseDate(events) {
		var dateArrays = [];
		events.each(function(){
			var dateComp = $(this).data('date').split('/'),
				newDate = new Date(dateComp[2], dateComp[1]-1, dateComp[0]);
			dateArrays.push(newDate);
		});
	    return dateArrays;
	}

	function parseDate2(events) {
		var dateArrays = [];
		events.each(function(){
			var singleDate = $(this),
				dateComp = singleDate.data('date').split('T');
			if( dateComp.length > 1 ) { //both DD/MM/YEAR and time are provided
				var dayComp = dateComp[0].split('/'),
					timeComp = dateComp[1].split(':');
			} else if( dateComp[0].indexOf(':') >=0 ) { //only time is provide
				var dayComp = ["2000", "0", "0"],
					timeComp = dateComp[0].split(':');
			} else { //only DD/MM/YEAR
				var dayComp = dateComp[0].split('/'),
					timeComp = ["0", "0"];
			}
			var	newDate = new Date(dayComp[2], dayComp[1]-1, dayComp[0], timeComp[0], timeComp[1]);
			dateArrays.push(newDate);
		});
	    return dateArrays;
	}

	function daydiff(first, second) {
	    return Math.round((second-first));
	}

	function minLapse(dates) {
		//determine the minimum distance among events
		var dateDistances = [];
		for (i = 1; i < dates.length; i++) { 
		    var distance = daydiff(dates[i-1], dates[i]);
		    dateDistances.push(distance);
		}
		return Math.min.apply(null, dateDistances);
	}

	/*
		How to tell if a DOM element is visible in the current viewport?
		http://stackoverflow.com/questions/123999/how-to-tell-if-a-dom-element-is-visible-in-the-current-viewport
	*/
	function elementInViewport(el) {
		var top = el.offsetTop;
		var left = el.offsetLeft;
		var width = el.offsetWidth;
		var height = el.offsetHeight;

		while(el.offsetParent) {
		    el = el.offsetParent;
		    top += el.offsetTop;
		    left += el.offsetLeft;
		}

		return (
		    top < (window.pageYOffset + window.innerHeight) &&
		    left < (window.pageXOffset + window.innerWidth) &&
		    (top + height) > window.pageYOffset &&
		    (left + width) > window.pageXOffset
		);
	}

	function checkMQ() {
		//check if mobile or desktop device
		return window.getComputedStyle(document.querySelector('.cd-horizontal-timeline'), '::before').getPropertyValue('content').replace(/'/g, "").replace(/"/g, "");
	}
});


</script>









  	
<body>
	<!-- 고정(헤더) -->
	<div id="header">
		<%@ include file="/form/header.jsp"%>
	</div>
	
	<br>
	<div class="container" id="container-top" style="font-size:12pt;">
		<div class="row">
			<div class="col-lg-4">
				<h3><span id="userid" onclick="" style="cursor: pointer;"><b><%=userid %></b></span> 님의 일정 살펴보기</h3>
			</div>
			<div class="col-lg-8" style="text-align: right;">
				작성일&nbsp;<span id="createDate"><%=createdate %></span>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;
				조회수&nbsp;<span id="hits"><%=hits %></span>
			</div>
		</div>
		
		<div class="row">
			<hr style="margin-top: 5px; margin-bottom: 5px;">
		</div>
		<div class="row">
			<div class="col-lg-12">
				<br><p id="title" style="text-align: center; font-size:20pt;">여행지 : <%=areaFull %></p><br>
			</div>
			<div class="col-lg-12">
				<br><p id="title" style="text-align: center; font-size:30pt;"><%=title %></p><br>
			</div>
			
			<div class="col-lg-12" style="text-align: center; font-size: 15pt;">
				<%=content %>
			</div>					
		</div>
	</div>
	
	<!--  -->
	<section class="cd-horizontal-timeline">
  	<div class="timeline">
    <div class="events-wrapper">
      <div class="events">
        <ol>
        </ol>

        <span class="filling-line" aria-hidden="true"></span>
      </div> <!-- .events -->
    </div> <!-- .events-wrapper -->

    <ul class="cd-timeline-navigation">
      <li><a href="#0" class="prev inactive">Prev</a></li>
      <li><a href="#0" class="next">Next</a></li>
    </ul> <!-- .cd-timeline-navigation -->
  	</div> <!-- .timeline -->

  	<div class="events-content">
    	<ol>
    	</ol>
  	</div> <!-- .events-content -->
	</section>
	<!--  -->



	<br><br><br>
	
	<!-- map -->
	
	<div class="container">
		<div class="row">
			<div class="col-lg-2"></div>
			<div class="col-lg-8">
				<div style='font-size: 15pt;'>※ Travel route</div>
				    <div id="floating-panel">
      <b>Start: </b>
      <select id="start">

      </select>
      <b>End: </b>
      <select id="end">
      
      </select>
    </div>
				<div id="map" class="rounded"></div>
				<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyD91v0jFyq9OujfSgguW_LeoicC-wATfNI&callback=initMap&v=weekly" async></script>
			</div>
			<div class="col-lg-2"></div>
		</div>
	</div>
	
	
	
	
	
	
	
	
	<br><br><br>
	<br><br><br>
	<br><br><br>
	
	<!-- 코로나 -->
	<div class="container" style="font-size:12pt !important;">
	<div class="row">
		<div class="col-lg-3"></div>
		<div class="col-lg-6" style="text-align: left;">
			<h3 style="font-size:20pt !important;">※Global covid-19 report&nbsp;(<span class="reportdate" style="color:blue; font-size:15pt;"></span>)</h3>
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
			<h3 style="font-size:20pt !important;">※Travel Area covid-19 report&nbsp;(<span class="reportdate" style="color:blue; font-size:15pt;"></span>)</h3>
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
	
	<br><br><br><br><br>


	<div class="container" style="font-size: 12pt;">
		<div class="row">
			<div class="col-lg-12" style="text-align: right;">
				<span>&nbsp;<input type="button" class="bottomBtn" value="블로그 메인" onclick="location.href='<%=request.getContextPath()%>/blog/blog_main.jsp'" /></span>
				<span style="display: <%=(sessionId.equals(userid))? None:Yes %>;">&nbsp;<input type="button" class="bottomBtn" value="동행신청하기" onclick="func_prompt()"/></span>
				<span style="display: <%=(sessionId.equals(userid))? None:Yes %>;">&nbsp;<button type="button" id="btnheart" class="bottomBtn" onclick="addheart();"><img id="heartimg" src="<%=request.getContextPath()%>/img/icons/suit-heart.svg" alt="Bootstrap"><span id="heart">추가</span></button></span>
				<span style="display: <%=(sessionId.equals(userid))? Yes:None %>;">&nbsp;<button type="button" class="bottomBtn" onclick="delBlog();"><img src="<%=request.getContextPath()%>/img/icons/trash.svg" alt="Bootstrap">삭제</button></span>
			</div>
		</div>
		<div class="row">
			<hr style="margin-top: 5px; margin-bottom: 5px;"><br>
		</div>
		<div class="row">
			<div class='col-lg-1'></div>
			
			
			<div class='col-lg-10'>
				<span>
				<textarea id="textarea" placeholder="댓글을 입력하세요." name="comment" maxlength="150" style="resize: none; width:80%; height:100px; vertical-align: top; outline: none; border-radius: 8px;"></textarea>
				<button class='commentbtn' id="submit" type="submit" style="width: 19%;">등록</button>
				</span>
			</div>
			
			<!-- submit -->
			<script type="text/javascript">
				$('#textarea').keypress(function(event){
					if(event.which == 13){
						$('#submit').click();
						return false;
					}
				});
				
				$('#submit').click(function(){
					
 					if(sessionid == ""){
					  	  toastr.options.positionClass = "toast-top-right";
						  toastr.warning("로그인이 필요합니다.");
						  return;
					} 
					
 					var content = $('#textarea').val();
 					
					if(content.trim() == "" || content == null){
						alert("공백만 입력되었습니다.");
						return;
					} 
					
					
  					$.ajax({
						url:'blog.do?command=addcomment&blogid=<%=userid%>&blogseq=<%=blogseq%>',
						method: "post",
						data: {"commentid" : sessionid,
							   "content" : content.trim()},
						dataType: "json",
						success:function(data){
							
							$('#commentbody').html("");
							for(var i = 0; i < data.length; i++){
								$("#commentbody").append(createComment(data[i].commentid, data[i].content, data[i].commentdate, data[i].commentseq, data[i].groupno, data[i].groupseq));
							}
							
							$('#textarea').val("");
						},
						error:function(){
							$("#heart").html("에러");
						}
					});	  
					
					
				});
				
			</script>
			<!-- submit -->
			
			<div class='col-lg-1'></div>
		</div>
		<br>
		
		<div class="row">
			<div class='col-lg-1'></div>
			<div class='col-lg-10'>
				<table class="table align-middle">
					<colgroup>
						<col width = "15%">
						<col width = "77%">
						<col width = "5%">
						<col width = "3%">
					</colgroup>					
					<tbody id='commentbody'>
					</tbody>
				</table>
			</div>
			<div class='col-lg-1'></div>
		</div>
	</div>
	
			<!-- 댓글가져오기 -->
		<script type="text/javascript">
			$.ajax({
				url:'blog.do?command=comment&blogid=<%=userid%>&blogseq=<%=blogseq%>',
				method: "post",
				dataType: "json",
				success:function(data){
					
					for(var i = 0; i < data.length; i++){
						$("#commentbody").append(createComment(data[i].commentid, data[i].content, data[i].commentdate, data[i].commentseq, data[i].groupno, data[i].groupseq));
					}
					
				},
				error:function(){
					$("#heart").html("에러");
				}
			});	
		
		</script>

<script type="text/javascript">
//건든 내용
   function func_prompt () {
	
	  //세션없으면 로그인필요안내
	  if(sessionid == ""){
	  	  toastr.options.positionClass = "toast-top-right";
		  toastr.warning("로그인이 필요합니다.");
		  return;
	  }
	
	  //세션유저의 페널티가 3이면 동행신청 불가
	  var sessionpenalty = <%=sessionPenalty %>;
	  if(sessionpenalty == 3){
		  alert("페널티가 3이므로 동행 신청이 불가합니다.");
		  return;
	  }
	
      var comment = prompt("상대방에 동행신청을 남겨주세요!");
        console.log(comment);
        
        //유효성검사
        if (comment.trim() == "" || comment == null) {
           alert("메세지를 입력하셔야 동행신청이 가능합니다.");
           return;
        }
        //현재 페이지의 작성자 아이디 가져와야함. 페이지 상에서 DISPLAY NONE으로 TEXT값 넣어줘서 만들어놔야함
        var con_id = "<%=userid %>"; 
        console.log(con_id);
        
        $.ajax({
           url:"message.do?command=blogAsk",
           type:"post",
           data: {
              "con_id":con_id,
              "comment":comment
           },
           success:function(msg) {
        	  console.log(typeof msg);
              console.log(msg);

              if (msg == "이미 연결된 회원입니다.") {
            	  alert(msg);
            	  return;
              }

              if (msg == "성공") {
                 alert("동행 신청을 완료했습니다.\n상대방 수락 시 채팅창이 연결됩니다!");
              } else {
               alert("동행 신청을 실패했습니다.")                 
              }
           },
           error:function(msg) {
              console.log(msg);
           }
        });
   }
   
   
   function delBlog(){
	   
	   if(confirm("삭제 시 복구가 불가능합니다. 계속 진행하시겠습니까?")){
		   location.href='blog.do?command=delblog&userid=<%=userid %>&blogseq=<%=blogseq %>';
	   }
   }
   
   function addheart(){
		if(sessionid == ""){
		  	toastr.options.positionClass = "toast-top-right";
			toastr.warning("로그인이 필요합니다.");
			return;
		}	   
		
		$.ajax({
			url:"<%=request.getContextPath()%>/blog.do?command=addblogheart&sessionId=<%=sessionId%>&blogId=<%=userid%>&blogSeq=<%=blogseq%>&title=<%=title%>",
			method: "post",
			success:function(data){
				
				if(data == "success"){
					toastr.options.positionClass = "toast-top-right";
					toastr.success("찜 목록에 추가되었습니다");
				
					$("#btnheart").removeAttr("onclick");
					$("#btnheart").attr("onclick","rmheart();");
					$("#heartimg").prop("src","./img/icons/suit-heart-fill.svg");
					$("#heart").html("해제");
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
			url:"<%=request.getContextPath()%>/blog.do?command=rmblogheart&sessionId=<%=sessionId%>&blogId=<%=userid%>&blogSeq=<%=blogseq%>",
			method: "post",
			success:function(data){
				
				if(data == "success"){
					toastr.options.positionClass = "toast-top-right";
					toastr.success("찜 해제 완료되었습니다.");
					
					$("#btnheart").removeAttr("onclick");
					$("#btnheart").attr("onclick","addheart();");
					$("#heartimg").prop("src","./img/icons/suit-heart.svg");
					$("#heart").html("추가");
				}
				
			},
			error: function(){
				toastr.options.positionClass = "toast-top-right";
				toastr.warning("통신 실패");
			}
		});
   }
   
   //groupseq = 2 이상
   function createComment(commentid, content, date, seq, groupno, groupseq){
	   var html = "";
	   html = "<tr class='"+ ((groupseq == 1)? white : gray) +"'>"+
		    "<td nowrap='nowrap'><span style='color:"+ ((commentid==userid)? blue:black) +"'><b>"+ ((commentid==userid)? writer:commentid) +"</b></span></td>" + 
			"<td style='word-break:break-all; cursor: "+ ((groupseq == 1)? pointer : dfcursor) +";' onclick='"+ ((groupseq == 1)? showanswer_ : noshowanswer)+";'><img style='display:"+ ((groupseq == 1)? none : yes) +";' src='<%=request.getContextPath()%>/img/icons/arrow-return-right.svg' width='22' height='22' alt='Bootstrap' ><span style='display:"+ ((groupseq == 1)? none : yes) +";'>&nbsp;&nbsp;</span>"+ content +"</td>" + 
			"<td nowrap='nowrap' class='right'>"+ date.split(".")[0] +"</td>" + 
			"<td class='right'><img id='heartimg'  style='display:"+ ((sessionid==commentid)? yes:none)  + "; cursor:pointer;' onclick='delcomment(this);' src='<%=request.getContextPath()%>/img/icons/x.svg' width='30' height='30' alt='Bootstrap'></td>" + 
			"<input type='hidden' id='seq' value='"+ seq +"'>" + 
			"<input type='hidden' id='groupno' value='"+ groupno +"'>" + 
			"<input type='hidden' id='groupseq' value='"+ groupseq +"'>" + 
			"</tr>";
   	   return html;
   }
   
   
   function delcomment(doc){
	   
	   	var commentseq = $(doc).closest('tr').find('#seq').val();
	   	var groupno = $(doc).closest('tr').find('#groupno').val();
	   	var groupseq = $(doc).closest('tr').find('#groupseq').val();
		
 			$.ajax({
				url:'blog.do?command=delcomment&blogid=<%=userid%>&blogseq=<%=blogseq%>',
				method: "post",
				data : {"commentseq" : commentseq,
						"groupno" : groupno,
						"groupseq" : groupseq},
				dataType: "json",
				success:function(data){
					
					$('#commentbody').html("");
					for(var i = 0; i < data.length; i++){
						$("#commentbody").append(createComment(data[i].commentid, data[i].content, data[i].commentdate, data[i].commentseq, data[i].groupno, data[i].groupseq));
					}
				},
				error:function(){
					$("#heart").html("에러");
				}
			});	  	
	   
   }
   
   function showanswer(doc){
	   
	   if($(doc).closest('tr').next().attr('class')=='answer'){
		   $(doc).closest('tr').next().remove();
		   return;
	   }
	   
	   $('.answer').each(function(){
		  $(this).remove(); 
	   });
	   
	   $(doc).closest('tr').after(addanswerDoc());
	   
   }
   
   function addanswerDoc(){
	   
	   var html = "";
	   html = 
		   "<tr class='answer'>" + 
		   "<td colspan='2'><img src='<%=request.getContextPath()%>/img/icons/arrow-return-right.svg' width='22' height='22' alt='Bootstrap' >&nbsp;&nbsp;<textarea id='answertextarea' placeholder='답글을 입력하세요.' name='answer' maxlength='100' style='resize: none; width:95%; height:70px; vertical-align: top; outline:none; border-radius: 8px; margin-top:5px; margin-bottom:10px;'></textarea></td>" + 
			"<td colspan='2'><button class='commentbtn' id='answersubmit' type='submit' onclick='addanswer(this)' style='width: 45%; margin-right: 5px;'>등록</button><button type='button' class='commentbtn' style='width: 45%;' onclick='cancel(this)'>취소</button></td>" + 
			"</tr>";
	   return html;
   }
   
   function cancel(doc){
	   
	   $(doc).closest('tr').remove();
	   
   }
   
   function test(){
	   alert("test");
   }

   function addanswer(doc){
	   
		if(sessionid == ""){
			toastr.options.positionClass = "toast-top-right";
			toastr.warning("로그인이 필요합니다.");
			return;
		}
		
	    var answer = $(doc).closest('tr').find('textarea').eq(0).val();
		if(answer.trim() == "" || answer == null){
			alert("공백만 입력되었습니다.");
			return;
		} 
	    
		var groupno = $(doc).closest('tr').prev().find('#groupno').val();
	    console.log(answer);
	    console.log(groupno);
	    
			$.ajax({
				url:'blog.do?command=addanswer&blogid=<%=userid%>&blogseq=<%=blogseq%>',
				method: "post",
				data: {"commentid" : sessionid,
					   "answer" : answer.trim(),
					   "groupno" : groupno},
				dataType: "json",
				success:function(data){
					
					$('#commentbody').html("");
					for(var i = 0; i < data.length; i++){
						$("#commentbody").append(createComment(data[i].commentid, data[i].content, data[i].commentdate, data[i].commentseq, data[i].groupno, data[i].groupseq));
					}
					
				},
				error:function(){
					$("#heart").html("에러");
				}
			});	 
   }
   
   

   function initMap() {
	   var directionsService = new google.maps.DirectionsService();
	   var directionsRenderer = new google.maps.DirectionsRenderer();
	   
   	  map = new google.maps.Map(document.getElementById("map"), {
   	    center: { lat: -33.866, lng: 151.196 },
   	    zoom: 15,
   	  });
   		directionsRenderer.setMap(map);
   	  /* console.log(markerlist); */
   	  
	   for(var i = 0; i < markerlist.length; i++){
		   
		   //숫자가 10 이상일경우 charcode연결필요
		   var charcodeText = "";
		   if(i >= 9){
			   var str = (i+1).toString();
			   for(var j = 0; j < str.length; j++){
				   charcodeText += String.fromCharCode(str[j].charCodeAt(0));
			   }
		   }else{
			   charcodeText += String.fromCharCode((i+1).toString().charCodeAt(0));
		   }
		   
		   var marker = new google.maps.Marker({
				  position: markerlist[i],
			   	  icon: {
		             url: 'https://maps.google.com/mapfiles/ms/micons/green.png',
		             labelOrigin: new google.maps.Point(15, 10)
		          },
		          label: {
		             text: charcodeText
		          }
				  
			   });
		   		
		   	   markers.push(marker);
		   
		   	   //마커 세팅
			   marker.setMap(map);
		   	   
		   	   //마커 1번을 처음으로 안내
			   if(i == 0){
			     map.setCenter(marker.getPosition());
			   }
	   }
	   
	   console.log("markers" + markers);
	   console.log(infocontent[0].pname);
	   
	   //마커 객체 리스트 이벤트 추가
	   for(var i = 0; i < markers.length; i++){
		   var zerotime = '00:00';
		   var noTime = '미정';
		   
		   //let으로 선언해주어야 for문돌때마다 변수변경적용 -> 마커클릭이벤트에 해당 문구적용
		   let infostring = "<b style='font-size:13pt;'>"+ infocontent[i].pdate +"</b><br><br>"  + "<b>" + infocontent[i].pname + "</b><br>" + "방문 시각 : " + ((infocontent[i].time==zerotime)? noTime: infocontent[i].time);
		   
		   google.maps.event.addListener(markers[i], 'click', function(){
			   
			   //인포윈도우 객체를 모두 해제해야 다른 마커 클릭 시 새로운 인포윈도우
			   for(var j = 0; j < infowindows.length; j++){
				   infowindows[j].close();
			   }
			   
			   map.setCenter(this.getPosition());
			   map.setZoom(16);
			   
			   //infostring
			   var infowindow = new google.maps.InfoWindow({
			   		content : infostring
			   });
			   infowindow.open(map, this);   
			   
			   infowindows.push(infowindow);
		   });
		   
	   }
	   
 	   var flightPath = new google.maps.Polyline({
		   path: markerlist,
		    geodesic: true,
		    strokeColor: "#c20000",
		    strokeOpacity: 0.8,
		    strokeWeight: 2,
		   });
	   flightPath.setMap(map); 
	   
	   
	   
	   const onChangeHandler = function () {
		    calculateAndDisplayRoute(directionsService, directionsRenderer);
		  };

		  document.getElementById("start").addEventListener("change", onChangeHandler);
		  document.getElementById("end").addEventListener("change", onChangeHandler);
	   
	   
	   function calculateAndDisplayRoute(directionsService, directionsRenderer, ) {
		   directionsService
		     .route({
		       origin: markerlist[parseInt(document.getElementById("start").value)],
		       destination: markerlist[parseInt(document.getElementById("end").value)],
		       travelMode: google.maps.TravelMode.TRANSIT,
		     })
		     .then((response) => {
		       directionsRenderer.setDirections(response);
		     })
		     .catch((e) => window.alert("Directions request failed due to " + status));
		 }
	   
   }
   

   
   
</script>         
	














	<br>
	<br>



	<!-- 고정(푸터) -->
	<div id="footer">
		<%@ include file="/form/footer.jsp"%>
	</div>
</body>
</html>