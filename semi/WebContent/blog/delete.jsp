<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>

 <%@ page import="com.mvc.dao.BlogDao" %>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	int seq = Integer.parseInt(request.getParameter("seq"));

	BlogDao dao = new BlogDao();
	int res = dao.delete(seq);
	
	if(res>0){
%>
	<script type="text/javascript">
		alert("삭제 완료 되었습니다.");
		location.href="newslist.jsp";
	</script>
<%		
	}else{
%>	
	<script type="text/javascript">
	alert("삭제 실패 하였습니다.");
	location.href="newslist.jsp";
	</script>	
<%
	}
%>
</body>
</html>