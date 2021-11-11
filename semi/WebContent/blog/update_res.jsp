<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %> 

<%@ page import="com.mvc.dto.BlognewsboardDto" %> 
 <%@ page import="com.mvc.dao.BlogDao" %>
 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<!-- 고정(헤더) -->
	<div id="header">
		<%@ include file="/form/header.jsp"%>
	</div>
	
<%
	int seq = Integer.parseInt(request.getParameter("seq"));
	String title = request.getParameter("title");
	String content = request.getParameter("content");
	
	BlognewsboardDto blognews = new BlognewsboardDto();
	blognews.setSeq(seq);
	blognews.setTitle(title);
	blognews.setContent(content);
	
	BlogDao dao = new BlogDao();
	int res = dao.update(blognews);
	
	if(res>0){
%>
	<script type="text/javascript">
		alert("게시글 수정이 완료되었습니다.");
		location.href="newslist.jsp";
	</script>
<%
	}else{
%>
	<script type="text/javascript">
		alert("게시글 수정에 실패하였습니다.");
		location.href="update.jsp";
	</script>
<%		
	}
%>

		<!-- 고정(푸터) -->
	<div id="footer">
		<%@ include file="/form/footer.jsp"%>
	</div>



</body>
</html>