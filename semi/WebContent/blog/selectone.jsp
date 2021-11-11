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
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<script type="text/javascript" src="smarteditor/js/service/HuskyEZCreator.js" charset="utf-8"></script>
<script type="text/javascript" src="//code.jquery.com/jquery-1.11.0.min.js"></script>
</head>

<style>
@import url(//fonts.googleapis.com/earlyaccess/jejugothic.css);
</style>

	
<body style="font-family: 'Jeju Gothic', sans-serif;">
	<!-- 고정(헤더) -->
	<div id="header">
		<%@ include file="/form/header.jsp"%>
	</div>
	<br><br><br>
<%
	int seq = Integer.parseInt(request.getParameter("seq") );
	BlogDao dao = new BlogDao();
	BlognewsboardDto blognews = dao.selectOne(seq);
%>


<table class="table" style="align:center; font-size:15px; width:900px; height: 500px; margin-left:auto; margin-right:auto;">
		<tr>
			<th>작성자</th>
			<td><%=blognews.getWriter() %></td>
		</tr>
		<tr>
			<th>제목</th>
			<td><%=blognews.getTitle() %></td>
		</tr>
		<tr>
			<th>내용</th>
			<td><textarea rows="20" cols="80" id="content" name="content" readonly="readonly"><%=blognews.getContent()%></textarea></td>
		</tr>
</table>
<script id="smartEditor" type="text/javascript"> 
	var oEditors = [];
	nhn.husky.EZCreator.createInIFrame({
	    oAppRef: oEditors,
	    elPlaceHolder: "content",  //textarea ID 입력
	    sSkinURI: "smarteditor/SmartEditor2Skin.html",  
	    fCreator: "createSEditor2",
	    htParams : { 
	    bUseToolbar : false, 
		bUseVerticalResizer : false, 
		bUseModeChanger : false 
	    }
	});
</script>
<script type="text/javascript" src = "resources/js/notice-write.js"></script>
		<div style="margin-left:550px;">
				<button onclick="location.href='update.jsp?seq=<%=blognews.getSeq()%>'" 
					style="background-color: #7b9acc; color:#FCF6F5; width:70px; height:30px; font-size:12px; border:0px;">수정</button>&nbsp;&nbsp;
				<button onclick="location.href='delete.jsp?seq=<%=blognews.getSeq()%>'"
					style="background-color: #7b9acc; color:#FCF6F5; width:70px; height:30px; font-size:12px; border:0px;">삭제</button>&nbsp;&nbsp;
				<button onclick="location.href='newslist.jsp'"
					style="background-color: #7b9acc; color:#FCF6F5; width:70px; height:30px; font-size:12px; border:0px;">목록</button>&nbsp;
		</div>
	
		<br>
		<br>
		<br>
		
		
		<!-- 고정(푸터) -->
	<div id="footer">
		<%@ include file="/form/footer.jsp"%>
	</div>
	
</body>
</html>