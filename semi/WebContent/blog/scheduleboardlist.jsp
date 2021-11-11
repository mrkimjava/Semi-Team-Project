<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>  

 <%@ page import="com.mvc.dto.BlognewsboardDto" %> 
<%@ page import="java.util.List" %>
<%@ page import="com.mvc.dto.blogDto" %>
 <%@ page import="com.mvc.dao.BlogDao" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script type="text/javascript" src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="http://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
</head>

<style>
@import url(//fonts.googleapis.com/earlyaccess/jejugothic.css);
</style>

<style type="text/css">
.table{
font-size:13px;
}
thead{
background-color:#DCE2F0;
 color:#50586C; 
 border:0px solid;">
}
#keyword{
width:250px;
height:25px;
font-size:13px;
text-align:center;
}
</style>

<script type="text/javascript">
$(document).ready(function() {
    $("#keyword").keyup(function() {
        var k = $(this).val();
        $("#user-table > tbody > tr").hide();
        var temp = $("#user-table > tbody > tr > td:nth-child(5n+3):contains('" + k + "')");
        $(temp).parent().show();
        var temp = $("#user-table > tbody > tr > td:nth-child(5n+2):contains('" + k + "')");
        
        $(temp).parent().show();
    })
})
</script>

<body style="font-family: 'Jeju Gothic', sans-serif;">

	<!-- 고정(헤더) -->
	<div id="header">
		<%@ include file="/form/header.jsp"%>
	</div>

	<br>
	<br>
	<h1 style="margin-left:50px;"><strong>이달의 인기일정&nbsp;🎈</strong></h1>
	<br>
	<br>

<%
	BlogDao dao = new BlogDao();
	List<blogDto> list = dao.scheduleboardlist();
	
	int count= 0;
	int number=0;
	
	int cnt = dao.ScheduleboardAllCount();
	
	int pageSize = 7;
	
	String pageNum = request.getParameter("pageNum");
	
	if(pageNum == null){
		pageNum = "1";
	}
	int currentPage = Integer.parseInt(pageNum);
	
	int startRow = (currentPage-1)*pageSize +1;
	int endRow = currentPage * pageSize;
	
	
	System.out.println(dao.scheduleboardlist());
	List<blogDto> scheduleboardlist = null;
	
	if(cnt != 0){
		scheduleboardlist = dao.scheduleboardlist(startRow, endRow);
	}
%>	

        <div id="input-form" style="margin-left:800px;">
            <input type="text" id="keyword"  placeholder="유저명/일정명으로 검색 하세요🔍">
        </div>    

	
	<br>
	<table class="table table-bordered" style="width:800px; margin-left:250px;" id="user-table">
		<col width="100"><col width="100"><col width="500"><col width="100"><col width="100">
		<thead align="center">
		<tr align="center">
			<th >번호</th>
			<th >유저명</th>
			<th >일정명</th>
			<th>여행시작일</th>
			<th>여행종료일</th>
		</tr>
		</thead>
<%
	for(int i=0;i<scheduleboardlist.size();i++){
		blogDto bloglist = (blogDto) scheduleboardlist.get(i);
%>
	<tbody>
		<tr align="center">
			<td><%=bloglist.getBlog_seq()%></td>
			<td><%=bloglist.getUser_id()%></td>
			<td><a href="<%=request.getContextPath() %>/blog.do?command=selectone&user_id=<%=bloglist.getUser_id()%>&blogseq=<%=bloglist.getBlog_seq()%>&pageNum=<%=pageNum%>"><%=bloglist.getTitle() %></a></td>
			<td><%=bloglist.getMindate() %></td>
			<td><%=bloglist.getMaxdate() %></td>
	</tr>
	</tbody>
		
<%
	}
%>		
            
<%
		if(cnt != 0){
			int pageCount = cnt/pageSize + (cnt%pageSize == 0? 0:1);
			int pageBlock = 3;
			int startPage = ((currentPage-1)/pageBlock) * pageBlock + 1;
			
			int endPage = startPage + pageBlock - 1;
			if(endPage > pageCount){
				endPage = pageCount;
		}
			
%>

		
	</table>
	</div>
	<div style="font-size:12px;"align="center">        
	<div id="pageBlock">
	<%
	if(startPage > pageBlock){
		%>
		<a href="scheduleboardlist.jsp?pageNum=<%=startPage-pageBlock%>">   이전   </a>
		<%
	}
	
	//숫자
	for(int i=startPage; i<=endPage; i++){
		%>
		<a href ="scheduleboardlist.jsp?pageNum=<%=i%>">   <%=i%>   </a>
		<%
	}
	//다음
	if(endPage < pageCount){
		%>
		<a href ="scheduleboardlist.jsp?pageNum=<%=startPage+pageBlock%>">   다음   </a>
		<%
	}
	%>
	</div>
<%
		}
%>	
		</div>	
		
		<div style=margin-left:890px;>
			총 게시글 : <%=cnt %> 개 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<input type = "button" value="돌아가기" onclick="location.href='blog_main.jsp'" 
				style="background-color: #7b9acc; color:#FCF6F5; width:70px; height:30px; font-size:12px; border:0px;">
		</div>
		<br>
		<br>
	
		<!-- 고정(푸터) -->
	<div id="footer">
		<%@ include file="/form/footer.jsp"%>
	</div>
	
	
	
</body>
</html>