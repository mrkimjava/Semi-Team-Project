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
.main{
	display: flex;
  align-items: center; /* 수직 정렬 */
  flex-direction: row; /* default: row */
  justify-content: center; /* flex direction에 대해서 정렬방식 선택 */
  margin-top: 20px;
  margin-bottom: 20px;
}
.btn {
	width:113px;
}

</style>

<title>Insert title here</title>
</head>
<body>
	<!-- 고정(헤더) -->
	<div id="header">
		<%@ include file="/form/header.jsp"%>
	</div>
	

	<div class="main">
		<div class="main-inner">
		
			<h1 style="text-align:center" > L O G I N</h1>
			<form action="../loginController.do" method="post">
				<input type="hidden" name="command" value="login">
				<table>
					<col width="50px"> <col width="100px">
					<tr>
						<td>I D</td>
						<td><input type="text" name="id"></td>
					</tr>
					<tr>
						<td>P W</td>
						<td><input type="password" name="pw"></td>
					</tr>
					<tr>
						<td style="text-align:center" colspan="2">
							<input type="submit" class="btn" style="border: 2px solid grey;" value="로그인" >
							<input type="button" class="btn" style="border: 2px solid grey;" value="회원가입" onclick="location.href='../loginController.do?command=registform'">
						</td>
					</tr>
				</table>
			</form>
			<br>
			<%@ include file="/login/naverLogin.jsp"%>
		</div>
	</div>
	
	<!-- 고정(푸터) -->
	<div id="footer">
		<%@ include file="/form/footer.jsp"%>
	</div>
</body>
</html>