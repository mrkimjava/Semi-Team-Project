<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>탈퇴</title>
<style type="text/css">
	div{
		text-align: center;
	}
	span{
		font-size: 5pt;
	}
</style>
<script type="text/javascript">
	function passwdChk(){
		var pw = document.getElementsByName("rPasswd")[0]; //db에 저장된 현재비밀번호
		var pw1 = document.getElementsByName("passwd")[0]; //입력한 현재 비밀번호
		
		if(pw1.value.trim()==""|| pw1.value==null){
			alert("현재비밀번호를 입력해 주세요");
			return false;
		}else if(pw.value.trim() != pw1.value.trim()){
			document.getElementById("pw_equal").innerHTML = "<b><font color='red'>"+"비밀번호가 다릅니다."+"</font></b>";
			return false;
		}else if(pw.value.trim() == pw1.value.trim()){
			document.getElementById("pw_equal").innerHTML = "";
			return true;
		}
	}	

	function pop_close(){
		window.close();
		self.close();
	}
	
	
</script>
</head>

<body>
	<form action="<%=request.getContextPath()%>/mypage.do?" method="post" onsubmit="return passwdChk();">
		<input type="hidden" name="command" value="deleteUser">
		<input type="hidden" name="user_id" value="${dto.user_id }">
		<div>
			<p>비밀번호를 입력하세요.</p>
			<input type="hidden" name="rPasswd" value="${dto.passwd }">
			<input type="password" name="passwd"><br>
			<span id="pw_equal"></span>
			<br><br>
			<input type="submit" value="OK">
			<input type="button" value="CANCEL" onclick="pop_close();">
		</div>
	</form>
	
</body>
</html>