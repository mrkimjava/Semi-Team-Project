<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>   

 <%@ page import="com.mvc.dto.BlognewsboardDto" %> 
 <%@ page import="java.util.List" %>
 <%@ page import="com.mvc.dto.UserDto" %>
 <%@ page import="com.mvc.dao.Dao" %>
 <%@ page import="com.mvc.dao.DaoImpl" %>
 <%@ page import="com.mvc.dao.mypage.MypageDaoImpl" %>
  <%@ page import="com.mvc.dao.mypage.MypageDao" %>
 <%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
 <%@ page import="com.mvc.dto.blogDto" %>
 <%@ page import="com.mvc.dao.BlogDao" %>
 <%@ page import="java.util.Date" %>
 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
</head>

<style>
	@import url(//fonts.googleapis.com/earlyaccess/jejugothic.css);
</style>

<style type="text/css">
.image{
float: left; 
padding: 20px; 
margin-left: 35px;
margin-rignt: 35px;
font-size: 15px;
}

.clear{
clear: left;
}

.title{
margin-left:30px;
color:#50586C;
}

.button{
background-color: #7b9acc; 
color:#FCF6F5; 
width:70px; 
height:30px; 
font-size:12px; 
border:0px;
margin-left:1150px;
}

.table{ 
font-size:15px;
}
</style>

	


<body style="font-family: 'Jeju Gothic', sans-serif; margin: auto; ">
		<!-- 고정(헤더) -->
	<div id="header">
		<%@ include file="/form/header.jsp"%>
	</div>
	
	<!--  이달의 인기 일정/여행지 -->
	
	<br><br><br><br>
	<h1 class="title" ><strong>이달의 인기 일정/여행지&nbsp;🎈</strong></h1>
	<br><br>
<%
	BlogDao imgdao = new BlogDao();
	List<blogDto> imglist = imgdao.bestlist();
	for(int i=0; i<4; i++){
%>
	<div class="image">
		<figure>
				<a href="<%=request.getContextPath() %>/blog.do?command=selectone&user_id=<%=imglist.get(i).getUser_id()%>&blogseq=<%=imglist.get(i).getBlog_seq()%>">
					<img src =<%=imglist.get(i).getThumbnailPath() %> style="hspace:10px; object-fit:cover; width:220px; height:220px;" ></a>
						<figcaption><%=imglist.get(i).getTitle() %>&nbsp;&nbsp;&nbsp;</figcaption>
							<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-heart-fill" viewBox="0 0 16 16">
  								<path fill-rule="evenodd" d="M8 1.314C12.438-3.248 23.534 4.735 8 15-7.534 4.736 3.562-3.248 8 1.314z"/>
							</svg>&nbsp;&nbsp;<%=imglist.get(i).getHeart_count() %><br>
							<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-chat-right-dots" viewBox="0 0 16 16">
  								<path d="M2 1a1 1 0 0 0-1 1v8a1 1 0 0 0 1 1h9.586a2 2 0 0 1 1.414.586l2 2V2a1 1 0 0 0-1-1H2zm12-1a2 2 0 0 1 2 2v12.793a.5.5 0 0 1-.854.353l-2.853-2.853a1 1 0 0 0-.707-.293H2a2 2 0 0 1-2-2V2a2 2 0 0 1 2-2h12z"/>
  									<path d="M5 6a1 1 0 1 1-2 0 1 1 0 0 1 2 0zm4 0a1 1 0 1 1-2 0 1 1 0 0 1 2 0zm4 0a1 1 0 1 1-2 0 1 1 0 0 1 2 0z"/>
							</svg>&nbsp;&nbsp;<%=imglist.get(i).getComment() %><br>
							<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-eye-fill" viewBox="0 0 16 16">
  								<path d="M10.5 8a2.5 2.5 0 1 1-5 0 2.5 2.5 0 0 1 5 0z"/>
  								<path d="M0 8s3-5.5 8-5.5S16 8 16 8s-3 5.5-8 5.5S0 8 0 8zm8 3.5a3.5 3.5 0 1 0 0-7 3.5 3.5 0 0 0 0 7z"/>
							</svg>&nbsp;&nbsp;<%=imglist.get(i).getHits() %>
		</figure>
	</div>
<%
	}
%>

	
	<div class="clear">
		<a href='scheduleboardlist.jsp'><button  class="button" >더보기</button></a>
	</div>

<!-- ----------------------------------------------------------------------------------------------------------------------- -->	
	
	<!--  여묻 소식 -->
	<br>
	<br>
	<br>
	<h1 class="title"><strong>여묻 소식 TOP 5&nbsp;📢</strong></h1>
	<br>
	<br>
	<br>
	
	<table class="table " style="width:900px; height: 250px; margin-left:200px;">
		<col width="20"><col width="300"><col width="20">
		<thead style="background-color:#DCE2F0; color:#50586C; border:0px solid;">
		<tr align="center">
			<th>번호</th>
			<th>제목</th>
			<th>조회수</th>
		</tr>
		</thead>
<%
	BlogDao dao = new BlogDao();
	List<BlognewsboardDto> list = dao.toprank();
	
	for(int i=0; i<5; i++){
		
	
%>
		<tr align="center">
			<td><%=list.get(i).getSeq()%></td>
			<td><a href="selectone.jsp?seq=<%=list.get(i).getSeq()%>"><%=list.get(i).getTitle() %></a></td>
			<td><%=list.get(i).getViewcnt() %></td>
		</tr>
<%
	}
%>		
	</table>
	
	<br>
	<br>
	<div class="clear">
	<a href="newslist.jsp"><button class="button">더보기</button></a>
	</div>

<!-- ----------------------------------------------------------------------------------------------------------------------- -->
	<br>
	<br>
	<br>
	<h1 class="title"><strong>나의 일정&nbsp;💬</strong></h1>
	<br>
	<br>

	
	
	<%
	UserDto id = (UserDto)session.getAttribute("dto"); 
	if(dto !=null){
	%>
	
	<div style=
	"margin-left:200px;  background:#DCE2F0; height: 200px; width: 900px; text-align:center;
	font-size:15px; color:#50586C;" >
	<br><br><br><br>
	<a href="<%=request.getContextPath() %>/mypage.do?command=mypage">다가오는 여행 일정을 확인해보세요.</a>
	<br>
	</div>
	

<%
	}else{	
%>
	
	<div style=
	"margin-left:200px;  background:#DCE2F0; height: 200px; width: 900px; text-align:center;
	line-height:100px;font-size:15px; color:#50586C;" >
	아직 저장된 일정이 없습니다. 
	<br>
	<a href="/semi/login/login.jsp">로그인</a>후 더 많은 일정을 공유하세요.
	</div>
	
	<br>
	<br>
<%
	}
%>
 
 <br><br>
<!-- ----------------------------------------------------------------------------------------------------------------------- -->
	<!-- 고정(푸터) -->
	<div id="footer">
		<%@ include file="/form/footer.jsp"%>
	</div>
</body>


</html>