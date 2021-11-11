<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>
<%@ page import="com.mvc.dto.UserDto" %>
<!DOCTYPE html>
<html>
<head>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-/bQdsTh/da6pkI1MST/rWKFNjaCP5gBSY4sEBT38Q/9RBh9AH40zEOg7Hlq2THRZ" crossorigin="anonymous"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-F3w7mX95PdgyTmZZMECAngseQB83DfGTowi0iMjiWaeVhAn4FJkqJByhZMI3AhiU" crossorigin="anonymous">
<script src="https://www.gstatic.com/dialogflow-console/fast/messenger/bootstrap.js?v=1"></script>
<df-messenger
  intent="WELCOME"
  chat-title="TripBot"
  agent-id="5b2dbcd7-707b-479f-a55b-d811d71de776"
  language-code="ko"
></df-messenger>

<style type="text/css">
#button-header{
  text-align: center;
  border: solid 1.5px gray;
  background-color: white;
  border-radius: 23px;
  padding: 8px;
}

#button-header:hover{
	border: solid 1.5px rgb(105, 231, 175);
	background-color: rgb(105, 231, 175);
}

#header button{
    font-size: 12pt;
}

</style>

<meta charset="UTF-8">
<title>Insert title here</title>
<% 
//	UserDto userdto = new UserDto();
//	userdto.setUser_id("SUNGTAE");
//	session.setAttribute("UserDto", userdto);
//	session.setMaxInactiveInterval(30*60);
//	String profilePath = "";

	UserDto dto = (UserDto)session.getAttribute("dto");
	String profilePath = request.getContextPath() + "/img/icons/person-circle.svg";
%>

</head>
<body>
	<br>
	<div class="container-lg" id="header">
		<div class="row" style="font-size: 12pt;">
			<div class="col-lg-6" style="text-align: left;">
				<a href="<%=request.getContextPath()%>/index.jsp"><img src="<%=request.getContextPath()%>/img/logo_new_2.png" width="240"
					height="65" style="margin-bottom: 20px;"></a>
			</div>
			<div class="col-lg-6" style="text-align: right;">
				<%
					if (dto != null) {
				%>
					${dto.nickname } 님, 여행을 미리 즐겨보세요.
					
					&nbsp;&nbsp;&nbsp;
					<a href="<%=request.getContextPath()%>/message.do?command=message"><img src="<%=request.getContextPath()%>/img/icons/envelope.svg" alt="Bootstrap" width="24" height="24"></a>
					&nbsp;&nbsp;&nbsp;
					<a href=""><img src="<%=request.getContextPath()%>/img/icons/bell.svg" alt="Bootstrap" width="24" height="24"></a>
				<%
					} else {
				%>
					로그인이 필요합니다.
				<%
					}
				%>
				
				&nbsp;&nbsp;
				<div class="btn-group">
					<button type="button" id="button-header" data-bs-toggle="dropdown" data-bs-display="static" aria-expanded="false">
						<img src="<%=request.getContextPath()%>/img/icons/list.svg" alt="Bootstrap" width="21" height="21">
						<img src="<%=profilePath %>" alt="Bootstrap" width="27" height="27">
					</button>
					<ul class="dropdown-menu dropdown-menu-lg-end" style="width:170px">
						
						<%
							if (dto != null) {
						%>
							<li><button class="dropdown-item" type="button" onclick="location.href='<%=request.getContextPath()%>/loginController.do?command=logout'">로그아웃</button></li>
							<li><button class="dropdown-item" type="button" onclick="location.href='<%=request.getContextPath()%>/mypage.do?command=mypage'">마이페이지</button></li>
						<%
							} else {
						%>
							<li><button class="dropdown-item" type="button" onclick="location.href='<%=request.getContextPath()%>/login/login.jsp'">로그인</button></li>
							<li><button class="dropdown-item" type="button" onclick="location.href='<%=request.getContextPath()%>/loginController.do?command=registform'">회원가입</button></li>
						

						<%
							}
						%>
						
					</ul>
				</div>
			</div>
		</div>
	</div>
	<br>



	

</body>
</html>