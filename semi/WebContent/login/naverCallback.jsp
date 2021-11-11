<%@page import="com.mvc.dto.UserDto"%>
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
<script type="text/javascript" src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.0.js"></script>
<script type="text/javascript" src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
</head>
<body>
	<form name= "form" action="../loginController.do" method="post"> 
		<input type="hidden" id="command" name="command" value="naverLogin">
		<input type="hidden" id="pw" name="pw" value="naver">
		<input type="hidden" id="email" name="email" value="">
		<input type="hidden" id="name" name="name" value="">
		<input type="hidden" id="id" name="id" value="">
		<input type="hidden" id="nickname" name="nickname" value="">
		<input type="hidden" id="gender" name="gender" value="">
	</form>

<div id="naver_id_login"></div>

	<script type="text/javascript">
  		var naver_id_login = new naver_id_login("pQjjGzIKSFC97IFwO7C5", "http://localhost:8787/semi/login/naverCallback.jsp");

  		// 네이버 사용자 프로필 조회
  		naver_id_login.get_naver_userprofile("naverSignInCallback()");
  
  		//네이버 사용자 프로필 조회 이후 프로필정보를 처리할 callback fuction
  		naver_id_login.get_naver_userprofile("naverSignInCallback()");
  		
  		var email, name, id, nickname, gender;
  		
  		
  		
		function naverSignInCallback() {
			//토큰에 있는 프로필 정보 가져와서 저장
			email = naver_id_login.getProfileData('email'); 	//이메일
			name = naver_id_login.getProfileData('name'); 		//이름
			id = naver_id_login.getProfileData('id');			//id
			nickname = naver_id_login.getProfileData('nickname');//별명
			gender = naver_id_login.getProfileData('gender');	//성별
			

			document.form.email.value = email;
			document.form.name.value = name;
			document.form.id.value = id;
			document.form.nickname.value = nickname;
			document.form.gender.value = gender;
			//debugger;
			document.form.submit();

			//opener.parent.location.replace("../loginController.do?command=login_t");

			//window.close();
			//self.close();
		}

  	</script>
</body>

</html>