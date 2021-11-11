<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<style type="text/css">
	ul {
		list-style-type : none;
	    margin: 0px;
	    padding: 0px;
	    width: 200px;
	    background-color: white;
	}
	li a {
	    display: block;
	    color: #000;
	    padding: 8px 16px;
	    text-decoration: none;
	}
	li a:hover {
	    background-color: green;
	    color: white;
	    position : 
	}
	.flex-container{
		display: flex;
		float:right;
		flex-direction: column;	
		
	}
	.header, .sidebar,
	.footer, .flex-container {
	  display: flex;
	  align-items: center;
	  justify-content: center;
	}
	.sidebar {
	  width: 15%;
	  float: left;
	  height: 50%;
	}

	.t_list{
		margin: 20px;
	}
	h3 {
		padding: 0;
		margin: 0;
	}
	body {
		margin: 0;
		padding: 0;
	}
 
	
	<!--table--> 
</style>
<script type="text/javascript">
	function popup(){
		window.open("user/unregister_1.jsp","_blank","width=300px, height=150px");
		
	}
</script>
<title>Insert title here</title>
</head>
<body>
	<!-- 고정(헤더) -->
	<div id="header">
		<%@ include file="/form/header.jsp"%>
	</div>
	

	<br>
	<div style="text-align: center;">나의 여행</div>
	<br>

	<!-- 사이드바 -->
	<div id="left" class="sidebar">
		<ul>
			<li><a href="<%=request.getContextPath()%>/mypage.do?command=mypage">내여행</a></li>
			<hr>
			<li><a href="<%=request.getContextPath()%>/mypage.do?command=infoUpdate">정보수정</a></li>
			<hr>
			<li><a href="javascript:popup();">회원탈퇴</a></li>	
			<hr>
			<li><a href="<%=request.getContextPath()%>/message.do?command=message">채팅하기</a></li>	
		</ul>
	</div>
	
	
	<!-- 메인 -->
	<div id="right" class="flex_container" style="margin-left:250px; height:400px;">
	

	<!-- 날짜검색 -->
		<div id="search" style="height:700px;"> 
		<%@ include file="save_blog_picker.jsp"%>
		</div> 
	</div>
	
	<div id="blank" style="width:900px;height:700px;"></div>

	<!-- 고정(푸터) -->
	<div id="footer">
		<%@ include file="/form/footer.jsp"%>
	</div>
</body>
</html>