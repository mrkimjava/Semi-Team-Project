<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- 네이버 로그인 API -->
 <title>네이버 로그인</title>
  <script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js" charset="utf-8"></script>
  <script type="text/javascript" src="http://code.jquery.com/jquery-1.11.3.min.js"></script>

<title>Insert title here</title>
</head>
<body>
	<!-- 네이버 로그인 버튼 노출 영역 -->
 	<div id="naver_id_login"></div>
 	<!-- //네이버 로그인 버튼 노출 영역 -->
  <script type="text/javascript">
  	var naver_id_login = new naver_id_login("pQjjGzIKSFC97IFwO7C5", "http://localhost:8787/semi/login/naverCallback.jsp");
  	var state = naver_id_login.getUniqState();
  	naver_id_login.setButton("green", 3,53);
  	naver_id_login.setDomain("http://localhost:8787/semi/index.jsp");
  	naver_id_login.setState(state);
  	//naver_id_login.setPopup();
  	naver_id_login.init_naver_id_login();
  </script>

</body>
</html>