<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>
<%@ page import="com.mvc.dto.blogDto" %>
<%@ page import="java.util.ArrayList" %>    
<!DOCTYPE html>
<html>
<head>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://code.jquery.com/ui/1.13.0/jquery-ui.js"></script>
<script type="text/javascript" src="index.js"></script>
<link rel="stylesheet" type="text/css" href="index.css">

<meta charset="UTF-8">
<title>Insert title here</title>
</head>

<body>
	<!-- 고정(헤더) -->
	<div id="header">
		<%@ include file="./form/header.jsp"%>
	</div>
	


	<!-- 검색&배경 -->
	<div>
		<div style="position:relative;">
			<div class="container-fluid" id="img" style="text-align: center;"></div>
			<div class="container-fluid" id="searchdiv" style="text-align:center; position:absolute; top:5%;">
				<br><br>
				<h4>어디든 상관없이 떠나고 싶을 때 여행을묻다가 도와드립니다!</h4><br>
				<form class="box" action="search.jsp" method="post" id="searchform">
					<input id="search" type="search" name="search"
						placeholder="유연한 검색" aria-label="Search" autocomplete="off" readonly="readonly"
						style="width: 170px; height:50px; border-radius: 30px; border:solid 1px #d3d3d3; outline: none; cursor:pointer; text-align: center; font-size:12pt;">
					<button id="searchbtn" type="submit" style="display: none; border:solid 1px #d3d3d3;">
						<img id="searchbtnimg" src="./img/icons/search.svg" alt="Bootstrap" width="21" height="21">
					</button>
				</form>
			</div>
		</div>
	</div>

	<!-- 일정짜기 -->
	<div class="container">
		<br><br><br><br>
		<div class="row">
			<h2>
				나만의 여행 일정을 만들어보세요&nbsp;&nbsp;<button type="button" class="btn btn-light" id="btn" onclick="location.href='<%=request.getContextPath()%>/schedule.do?command=schedule'">&nbsp;여행짜기&nbsp;<img src="./img/icons/arrow-right-circle-fill.svg" alt="Bootstrap" width="30" height="30"></button>
			</h2>
		</div>
		<br><br>
		<div class="row">
			<div class="col-lg-6"><img class="rounded-start shadow-lg p-3 mb-5 bg-body rounded" src="img/index1.PNG" width="100%" height="500px"><br></div>
			<div class="col-lg-6"><img class="rounded-start shadow-lg p-3 mb-5 bg-body rounded" src="img/index2.PNG" width="100%" height="500px"></div>
		</div>
		<br>
		<div class="row">
			<div class="col-lg-6"><img class="rounded-start shadow-lg p-3 mb-5 bg-body rounded" src="img/index4.PNG" width="100%" height="500px"><br></div>
			<div class="col-lg-6"><img class="rounded-start shadow-lg p-3 mb-5 bg-body rounded" src="img/index3.PNG" width="100%" height="500px"></div>
		</div>
		
	</div>
	
	<br><br><br><br>
	
	<!-- 일정참고 -->
	<div class="container-fluid" id="img2" style="padding: 7%;">
		<div class="row">
			<h2 style="text-align: center;">다른 회원의 여행 일정을 구경해보세요</h2>
		</div>
		<br><br>
		<!-- 썸네일 -->
		<div class="row align-items-center">
		
			<!-- left -->
			<div class="col-lg-1" style="text-align: center; float: none; margin: 0 auto;">
				<a href="javascript:left();"><img src="./img/icons/chevron-double-left.svg" alt="Bootstrap" width="40" height="40"></a>
			</div>
			
			<!-- 썸네일1 -->
			<div class="col-lg-3" style="float: none; margin: 0 auto;" >
				<div class="card img-thumbnail" id="left_thumbnail">
					<div class="embed-responsive embed-responsive-4by3">
						<img src="" class="card-img-top embed-responsive-item" width="100%" height="350px;" style="border-radius:10px !important;">
					</div>
					<div class="card-body" style="padding: 15px;">
						<p></p>
						<div style="font-size: 11pt;" id="period">
							<span></span>
						</div>
						<div style="font-size: 11pt;" id="place">
							여행지 : <b class="place"></b>
						</div>
						
						<hr style="color: gray;">
						<h6 class="card-title" id="title"></h6>
						<p id="content"></p>
						<div style="float: left;">
							<img src="./img/icons/heart-fill.svg" alt="Bootstrap" width="21" height="21"> 
							<span style="font-weight: bold; font-size: 12pt;"></span> &nbsp; 
							<img src="./img/icons/chat-right-dots.svg" alt="Bootstrap" width="21" height="21"> 
							<span style="font-weight: bold; font-size: 12pt;"></span> &nbsp;
							<img src="./img/icons/eye-fill.svg" alt="Bootstrap" width="21" height="21"> 
							<span style="font-weight: bold; font-size: 12pt;"></span> &nbsp;
						</div>
						<div style="float: right;">
							<button type="button" class="detail" onclick="">상세보기</button>
						</div>
					</div>
				</div>
			</div>
			<!-- 썸네일2 -->
			<div class="col-lg-3" style="float: none; margin: 0 auto;" >
				<div class="card img-thumbnail" >
					<div class="embed-responsive embed-responsive-4by3">
						<img src="" class="card-img-top embed-responsive-item" width="100%" height="350px;" style="border-radius:10px !important;">
					</div>
					<div class="card-body" style="padding: 15px;">
						<p></p>
						<div style="font-size: 11pt;" id="period">
							<span></span>
						</div>
						<div style="font-size: 11pt;" id="place">
							여행지 : <b class="place"></b>
						</div>
						
						<hr style="color: gray;">
						<h6 class="card-title" id="title"></h6>
						<p id="content"></p>
						<div style="float: left;">
							<img src="./img/icons/heart-fill.svg" alt="Bootstrap" width="21" height="21"> 
							<span style="font-weight: bold; font-size: 12pt;"></span> &nbsp; 
							<img src="./img/icons/chat-right-dots.svg" alt="Bootstrap" width="21" height="21"> 
							<span style="font-weight: bold; font-size: 12pt;"></span> &nbsp;
							<img src="./img/icons/eye-fill.svg" alt="Bootstrap" width="21" height="21"> 
							<span style="font-weight: bold; font-size: 12pt;"></span> &nbsp;
						</div>
						<div style="float: right;">
							<button type="button" class="detail" onclick="">상세보기</button>
						</div>
					</div>
				</div>				
			</div>
			<!-- 썸네일3 -->
			<div class="col-lg-3" style="float: none; margin: 0 auto;" >
				<div class="card img-thumbnail" id="right_thumbnail">
					<div class="embed-responsive embed-responsive-4by3">
						<img src="" class="card-img-top embed-responsive-item" width="100%" height="350px;" style="border-radius:10px !important;">
					</div>
					<div class="card-body" style="padding: 15px;">
						<p></p>
						<div style="font-size: 11pt;" id="period">
							<span></span>
						</div>
						<div style="font-size: 11pt;" id="place">
							여행지 : <b class="place"></b>
						</div>
						
						<hr style="color: gray;">
						<h6 class="card-title" id="title"></h6>
						<p id="content"></p>
						<div style="float: left;">
							<img src="./img/icons/heart-fill.svg" alt="Bootstrap" width="21" height="21"> 
							<span style="font-weight: bold; font-size: 12pt;"></span> &nbsp; 
							<img src="./img/icons/chat-right-dots.svg" alt="Bootstrap" width="21" height="21"> 
							<span style="font-weight: bold; font-size: 12pt;"></span> &nbsp;
							<img src="./img/icons/eye-fill.svg" alt="Bootstrap" width="21" height="21"> 
							<span style="font-weight: bold; font-size: 12pt;"></span> &nbsp;
						</div>
						<div style="float: right;">
							<button type="button" class="detail" onclick="">상세보기</button>
						</div>
					</div>
				</div>	
			</div>
			
			<!-- right -->
			<div class="col-lg-1" style="text-align: center;">
				<a href="javascript:right();"><img src="./img/icons/chevron-double-right.svg" alt="Bootstrap" width="40" height="40"></a>
			</div>
			
		</div>
		<!-- 블로그 main 링크 -->
		<br><br><br>
		<div class="row">
			 <div class="col-lg-9"></div>
			 <div class="col-lg-3" style="text-align: right; float: none; margin: 0 auto;">
			 	<a style="text-decoration: none; color:black;" href="blog/blog_main.jsp">
			 	<span style="font-weight:bold;">전체 보기</span>&nbsp;
			 	<img src="./img/icons/arrow-right-circle-fill.svg" alt="Bootstrap" width="26" height="26">
			 	</a>
			 </div>
		</div>
	</div>
	
	<br><br><br><br><br><br>
	
	<!-- 동행구하기 -->
	<div class="container">
		<div class="row">
			<div class="col-lg-7">
				<img class="img-fluid rounded border border-secondary" src="img/partner/partner_1.jpg" width="100%" height="450px">
				<br><br><br><br><br><br>
			</div>
			<div class="col-lg-5" style="text-align: left;">
				<h3>여행 파트너를 구해보세요</h3><br>
				<p>
				혼자 여행을 해야한다면 고민을 해야할 때가 있습니다. 
				어떻게하면 효율적으로 여행을 해야 좋을지 고민되시나요?
				</p>
				<p>
				여행을 떠나보고 싶은데, 어디를 어떻게 여행해야할지
				모를때 여행 파트너와 함께하세요.
				</p>
				<br>
			</div>
		</div>
		
		<div class="row">
			<div class="col-lg-5" style="text-align: left;">
				<h3>편리하게 동행을 구해보세요.</h3><br>
				<p>
				어떻게 구할지 모르시겠다구요? <br>
				여묻이 도와드립니다.
				</p>
				<p>
				약속잡기, 동행신청 기능을 통해 간단한 약속부터 상세한 여행일정까지 동행자와 함께해보세요.		
				</p>
				<br>
				<p style="text-align: left;">
				<a href="./companion/companionMain.jsp" style="text-decoration: none; color:black;" href="companion/companion.jsp">
			 		<span style="font-weight:bold;">동행 구하기</span>&nbsp;
			 		<img src="./img/icons/arrow-right-circle-fill.svg" alt="Bootstrap" width="26" height="26">
			 	</a>
			 	</p>
			</div>
			<div class="col-lg-7">
				<img id="partner_img" class="rounded border border-secondary" src="img/partner2/part_1.png" width="100%" height="450px">
				<br><br>
				<div style="text-align: center;">
					<button class="partner" value="1"></button>&nbsp;
					<button class="partner" value="2"></button>&nbsp;
					<button class="partner" value="3"></button>&nbsp;
					<button class="partner" value="4"></button>&nbsp;
					<button class="partner" value="5"></button>
				</div>
				<br><br><br><br><br><br>
			</div>
		</div>
	</div>













	<!-- 고정(푸터) -->	
	<div id="footer">
		<%@ include file="./form/footer.jsp"%>
	</div>


</body>
</html>