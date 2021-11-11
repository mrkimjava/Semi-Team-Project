<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html charset=UTF-8"); %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
	window.onload=function(){
		var id = opener.document.getElementsByName("user_id")[0].value;
		
		document.getElementsByName("id")[0].value = id; //중복확인 팝업 안의 id값
	}
	
	function confirm(bool){
		if(bool == "true"){
			opener.document.getElementsByName("passwd")[0].focus();
			opener.document.getElementsByName("user_id")[0].title="y";
		}else{
			opener.document.getElementsByName("user_id")[0].focus();
		}
		self.close();
	}
</script>
<style type="text/css">
#id{
	border:0;
	border-bottom: 2px solid;
}

.btn {
	border: 2px solid grey;
	padding : 5px 10px;
	width:130px;
	background-color: white;
}
.btn:hover{
	background-color: grey;
}
</style>
</head>
<%
	String idnotused = request.getParameter("idnotused");
%>
<body>
	<table>
		<tr>
			<td><input type="text" id="id" name="id"></td>
		</tr>
		<tr>
			<td><%=idnotused.equals("true")?"입력하신 아이디는 생성 가능합니다":"중복된 아이디가 존재합니다" %></td>
		</tr>
		<tr>
			<td>
				<input type="button" class="btn" value="확인" onclick="confirm('<%=idnotused%>');">
			</td>
		</tr>
	</table>
</body>
</html>