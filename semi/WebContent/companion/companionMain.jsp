<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<script type="text/javascript" src="../index.js"></script>
<link rel="stylesheet" type="text/css" href="../index.css">
<script type="text/javascript" src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<style type="text/css">
.center {
	margin-top: 10px width: 250px;
}

#body {
	width: 100%;
}

.section {
	width: 100%;
	height: 500px;
	background-color:rgb(224, 210, 210); 
	color:black
}

#sectionLeft {
	font-size: large;
	font-weight: bold;
}

.sample {
	width: 70%;
	height: 400px;
	border-radius: 10px;
	opacity: 1;
}

#sectionRight {
	background-image:
		url("<%=request.getContextPath()%>/img/companion/sample3.jpeg");
	background-size: 80% 80%;
}
#img3 {
	width: 100%;
	background-size: 100% 100%;
}
.guide-img {
	width:65%;
	height:650px;
	border-radius: 50px; 
}

<!-- 슬라이드 css -->
ul, li {
	list-style: none;
}
.slide {
	height: 300px;
	overflow: hidden;
}
.slide ul {
	position: relative;
	height: 100%;
}
.slide li {
	position: absolute;
	left: 0;
	right: 0;
	top: 0;
	bottom: 0;
	opacity: 0;
	animation: fade 30s infinite;
}
.slide li:nth-child(1) {
	animation-delay: 0s;
}
.slide li:nth-child(2) {
	animation-delay: 6s;
}
.slide li:nth-child(3) {
	animation-delay: 12s;
}
.slide li:nth-child(4) {
	animation-delay: 18s;
}
.slide li:nth-child(5) {
	animation-delay: 24s;
}

@keyframes fade {
      0% {opacity:0;}
      5% {opacity:1;}
      25% {opacity:1;}
      30% {opacity:0;}
      100% {opacity:0;}
}
</style>

<script type="text/javascript">
$(document).ready(function(){
	var list;
	var start = 0;
	
	$.ajax({
		url:"../blog.do?command=bloglist",
		method: "post",
		dataType: "json",
		success:function(data){
			for(var i = 0; i < data.length; i++){
			
				if(i == 3) return;
				$(".card").eq(i).find("img").eq(0).prop("src", data[i].path);
				var str = "";
				for(var j = data[i].penalty; j < 3; j++){str += "★";}
				for(var j = 0; j < data[i].penalty; j++){str += "☆";}
				$(".card").eq(i).find("p").eq(0).html(data[i].userid + "&nbsp;" + str);
				$(".card").eq(i).find("span").eq(0).html(data[i].mindate + " ~ " + data[i].maxdate);
				$(".card").eq(i).find("b").eq(0).html(data[i].area);
				$(".card").eq(i).find("h6").html(data[i].title);
				$(".card").eq(i).find("p").eq(1).html(data[i].content);
				$(".card").eq(i).find("button").attr("onclick","location.href='../blog.do?command=selectone&blogseq=" + data[i].blogseq + "&user_id=" + data[i].userid + "'");
				$(".card").eq(i).find("span").eq(1).html(data[i].blogheart);
				$(".card").eq(i).find("span").eq(2).html(data[i].comment);
				$(".card").eq(i).find("span").eq(3).html(data[i].hits);
			}
		}
	});
});

function findCompanion() {
	location.href = "../blog/blog_main.jsp";
}
</script>

<body>
	<div id="header">
		<%@ include file="/form/header.jsp"%>
	</div>

	<div id="body">
		<div id="sectionLeft" class="section">
			<div class="display-4 text-center"><br><br>
				<b style="letter-spacing: 10px; line-height: 100px;"> 혼자일때 보다<br>누군가와 함께하고 싶을 순간</b>
			</div>
		</div>
	</div>
	<div class="container-fluid" id="img2" style="padding:7%;">
		<div class="row">
			<h1 class="display-5" style="text-align: center;"><b>지금 함께할 여행메이트를 찾아보세요!</b></h1>
		</div>
		<br><br>
		<div class="row align-items-center">
			<!-- 썸네일1 -->
			<div class="col-lg-3" style="float: none; margin: 0 auto;">
				<div class="card img-thumbnail" id="left_thumbnail">
					<div class="embed-responsive embed-responsive-4by3">
						<img src="" class="card-img-top embed-responsive-item"
							width="100%" height="350px;">
					</div>
					<div class="card-body" style="padding: 15px;">
						<p></p>
						<div style="font-size: 11pt;">
							<span></span><br>여행지 : <b></b>
						</div>
						<hr style="color: gray;">
						<h6 class="card-title" id="title"></h6>
						<p id="content"></p>
						<div style="float: left;">
							<img src="../img/icons/heart-fill.svg" alt="Bootstrap" width="21"
								height="21"> <span
								style="font-weight: bold; font-size: 12pt;"></span> &nbsp; <img
								src="../img/icons/chat-right-dots.svg" alt="Bootstrap"
								width="21" height="21"> <span
								style="font-weight: bold; font-size: 12pt;"></span> &nbsp; <img
								src="../img/icons/eye-fill.svg" alt="Bootstrap" width="21"
								height="21"> <span
								style="font-weight: bold; font-size: 12pt;"></span> &nbsp;
						</div>
						<div style="float: right;">
							<button type="button" class="detail" onclick="">상세보기</button>
						</div>
					</div>
				</div>
			</div>
			<!-- 썸네일2 -->
			<div class="col-lg-3" style="float: none; margin: 0 auto;">
				<div class="card img-thumbnail">
					<div class="embed-responsive embed-responsive-4by3">
						<img src="" class="card-img-top embed-responsive-item"
							width="100%" height="350px;">
					</div>
					<div class="card-body" style="padding: 15px;">
						<p></p>
						<div style="font-size: 11pt;">
							<span></span><br>여행지 : <b></b>
						</div>
						<hr style="color: gray;">
						<h6 class="card-title" id="title"></h6>
						<p id="content"></p>
						<div style="float: left;">
							<img src="../img/icons/heart-fill.svg" alt="Bootstrap" width="21"
								height="21"> <span
								style="font-weight: bold; font-size: 12pt;"></span> &nbsp; <img
								src="../img/icons/chat-right-dots.svg" alt="Bootstrap"
								width="21" height="21"> <span
								style="font-weight: bold; font-size: 12pt;"></span> &nbsp; <img
								src="../img/icons/eye-fill.svg" alt="Bootstrap" width="21"
								height="21"> <span
								style="font-weight: bold; font-size: 12pt;"></span> &nbsp;
						</div>
						<div style="float: right;">
							<button type="button" class="detail" onclick="">상세보기</button>
						</div>
					</div>
				</div>
			</div>
			<!-- 썸네일3 -->
			<div class="col-lg-3" style="float: none; margin: 0 auto;">
				<div class="card img-thumbnail" id="right_thumbnail">
					<div class="embed-responsive embed-responsive-4by3">
						<img src="" class="card-img-top embed-responsive-item"
							width="100%" height="350px;">
					</div>
					<div class="card-body" style="padding: 15px;">
						<p></p>
						<div style="font-size: 11pt;">
							<span></span><br>여행지 : <b></b>
						</div>
						<hr style="color: gray;">
						<h6 class="card-title" id="title"></h6>
						<p id="content"></p>
						<div style="float: left;">
							<img src="../img/icons/heart-fill.svg" alt="Bootstrap" width="21"
								height="21"> <span
								style="font-weight: bold; font-size: 12pt;"></span> &nbsp; <img
								src="../img/icons/chat-right-dots.svg" alt="Bootstrap"
								width="21" height="21"> <span
								style="font-weight: bold; font-size: 12pt;"></span> &nbsp; <img
								src="../img/icons/eye-fill.svg" alt="Bootstrap" width="21"
								height="21"> <span
								style="font-weight: bold; font-size: 12pt;"></span> &nbsp;
						</div>
						<div style="float: right;">
							<button type="button" class="detail" onclick="">상세보기</button>
						</div>
					</div>
				</div>
			</div>
			<div class="row" style="margin-top:30px;">
				<div class="col-md-12 text-center" style="padding-top:30px;">
					<button type="button" class="btn-primary btn-lg" onclick="findCompanion();">동행 찾으러가기!</button>
				</div>
			</div>
		</div>
	</div>
	<div style="padding-top: 80px; background-color: rgb(221, 246, 255);">
		<div id="guideSection" class="container-fluid text-center" style="padding: 0; padding-bottom:200px;">
			<div style="margin-bottom: 50px;">
				<h1 class="display-4" style="text-align: center;"><b>이용하는 법을 알아볼까요?</b></h1>
			</div>
			<div style="height:700px; padding-top:10px; background-color: rgb(221, 246, 255)">
				<div class="slide" style="height:100%;">
					<ul id="ul">
						<li><img src="../img/companion/info1.png" alt="info1" id="imgOne" class="guide-img"></li>
						<li><img src="../img/companion/info2.png" alt="info2" id="imgTwo" class="guide-img"></li>
						<li><img src="../img/companion/info3.png" alt="info3" id="imgThree" class="guide-img"></li>
						<li><img src="../img/companion/info4.png" alt="info4" id="imgFour" class="guide-img"></li>
						<li><img src="../img/companion/info5.png" alt="info5" id="imgFour" class="guide-img"></li>
					</ul>
				</div>
			</div>
		</div>
	</div>
	<div id="footer">
		<%@ include file="/form/footer.jsp"%>
	</div>

</body>
</html>