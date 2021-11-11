<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- 캘린더API -->
 <link href='<%=request.getContextPath()%>/fullcalendar/main.css' rel='stylesheet' />
<script src='<%=request.getContextPath()%>/fullcalendar/main.js'></script>
 
<script>

  document.addEventListener('DOMContentLoaded', function() {
     
      var p_time = []; //시간(String 값 받아옴)
      var p_loc = [];
      var substr = []; //string -> 나누기
      var date = []; //나눈값 date로 받기
	  var size = document.getElementsByName("p_time").length;
      
      for(var i=0; i<size; i++ ){
         p_time[i] = document.getElementsByName("p_time")[i].value;
         p_loc[i] = document.getElementsByName("p_loc")[i].value;
         console.log(p_time[i]);
         console.log(p_loc[i]);
         
         substr[i] = p_time[i].substring(0, p_time[i].lastIndexOf('/')).split("/").join("-") + " " + p_time[i].substring(p_time[i].lastIndexOf('/')+1, p_time[i].length-1).split("시")[0]+":00:00";
          console.log("나눴따!!!"+substr[i]);
          
          date[i] = new Date(substr[i]);
           console.log("date!!! "+date[i]); 

      } 
      
      
    


   var calendarEl = document.getElementById('calendar');
    var calendar = new FullCalendar.Calendar(calendarEl, {
         events: [
            <c:forEach items="${travel_list }" var="blogDto">
              {   title: "${blogDto.title}",
               start: "${blogDto.mindate}",
               end : "${blogDto.maxdate}"},
              </c:forEach>
             

               
              <c:forEach var="i" begin="0" end="100">
               {   title:p_loc[${i}],
                  start: date[${i}]
               },
               </c:forEach>
         ]
       });
    
   
    calendar.render();
  });

</script>
 <!--  -->
<style type="text/css">

	.link, .link :visited, .link :hover{ 
	text-decoration:none;
	color: black
	}
   ul {
      list-style-type : none;
       margin: 0px;
       padding: 0px;
       width: 200px;
       background-color: white;
   }
   li a {
       display: block;
       color: #000;
       padding: 8px 16px;
       text-decoration: none;
   }
   li a:hover {
       background-color: green;
       color: white;
       position : 
   }
   .flex-container{
      display: flex;
      float:right;
      flex-direction: column;   
         
   }
   .header, .sidebar,
   .footer, .flex-container {
     display: flex;
     align-items: center;
     justify-content: center;
   }
   .sidebar {
     width: 15%;
     float: left;
     height: 50%;
     margin-left:100px;
   }
   .t_list{
      margin: 20px 0px;
   }
   h3 {
      padding: 0;
      margin: 0;
   }
   body {
      margin: 0;
      padding: 0;
   }
   .blank_list{
      text-align: center;
   }
   .table th, .table td{
      border:1px solid black;
   }

</style>
<script type="text/javascript">
   function popup(){
      window.open("user/unregister_1.jsp","_blank","width=300px, height=150px");
      
   }
</script>
<title>Insert title here</title>
</head>
<body>
   <!-- 고정(헤더) -->
   <div id="header">
      <%@ include file="/form/header.jsp"%>
   </div>
   
    
   <br>
   <div style="text-align: center;">마이페이지</div>
   <br>

   <!-- 사이드바 -->
   <div id="left" class="sidebar">
      <ul>
         <li><a href="<%=request.getContextPath()%>/mypage.do?command=mypage">내여행</a></li>
         <hr>
         <li><a href="<%=request.getContextPath()%>/mypage.do?command=infoUpdate">정보수정</a></li>
         <hr>
         <li><a href="javascript:popup();">회원탈퇴</a></li>   
         <hr>
         <li><a href="<%=request.getContextPath()%>/message.do?command=message">채팅하기</a></li>   
      </ul>
   </div>
   
   
   <!-- 메인 -->
   <div id="right" class="flex_container" style="margin-left:350px;">
      <!-- 달력 -->   
      <div style='float:center;width:650px;height:500px;font-size:0.6em; margin-left:40px;' id='calendar'></div>
      <br><hr style="width:800px">
      
      
      <!-- 나의여행 목록 -->
      <div class="t_list">
         <h3>나의여행<a href="mypage.do?command=myTravel"><img src="<%=request.getContextPath()%>/img/plus_icon.png" width="30" height="30"></a></h3>
         <table class="table" style="width:750px;">
            <col width="100px">
            <col width="60px">
            <col width="400px">
            
            <tr>
               <th>작성날짜</th>
               <th style="text-align:center">♡</th>
               <th>여행지</th>
            </tr>
            <c:choose>
               <c:when test="${empty travel_list }">
                  <tr>
                     <td colspan="3" class="blank_list"> 여행일정이 없습니다.</td>
                  </tr>
               </c:when>
               <c:otherwise>
                  <c:forEach items="${travel_list }" var="blogDto" end="4">
                     
                     <tr>
                        <td>${blogDto.blog_create_date }</td>
                        <td style="text-align:center">♥${blogDto.heart_count }</td>
                        <td><a class="link" href="blog.do?command=selectone&blogseq=${blogDto.blog_seq}&user_id=${blogDto.user_id}">${blogDto.areaname }</a></td>
                     </tr>
                  </c:forEach>
               </c:otherwise>
            </c:choose>   
               
         </table>
      </div>
      <br><hr style="width:800px">
      
      
            
      
      <!-- 블로그찜목록 -->
      <div class="t_list">
         <h3>내가 찜한 블로그<a href="mypage.do?command=wishedBlog"><img src="<%=request.getContextPath()%>/img/plus_icon.png" width="30" height="30"></a></h3>
         <table class="table" style="width:750px;">
            <col width="100px">
            <col width="100px">
            <col width="350px">
            <tr>
               <th>작성날짜</th>
               <th>작성자</th>
               <th>여행지</th>
            </tr>
            <c:choose>
               <c:when test="${empty wishedB_list }">
                  <tr>
                     <td colspan="3" class="blank_list"> 여행일정이 없습니다.</td>
                  </tr>
               </c:when>
               <c:otherwise>
                  <c:forEach items="${wishedB_list }" var="blogHeartDto" end="4">
                     <tr>
                        <td>${blogHeartDto.regdate }</td>
                        <td>${blogHeartDto.blogid }</td>
                        <td><a class="link" href="blog.do?command=selectone&blogseq=${blogHeartDto.blogseq}&user_id=${blogHeartDto.blogid}">${blogHeartDto.blogNickname }</a></td>
                     </tr>
                  </c:forEach>
               </c:otherwise>
            </c:choose>   
         </table>
      </div>
      <br><hr style="width:800px">
      
      <!-- 찜목록 -->
      <div class="t_list">
         <h3>내가 찜한 여행지 & 일정<a href="mypage.do?command=wishedTravel"><img src="<%=request.getContextPath()%>/img/plus_icon.png" width="30" height="30"></a></h3>
         <table class="table" style="width:750px;">
            <col width="150px">
            <col width="150px">
            <col width="300px">
            <tr>
               <th>국가</th>
               <th>장소이름</th>
               <th>주소</th>
            </tr>
            <c:choose>
               <c:when test="${empty wished_list }">
                  <tr>
                     <td colspan="3" class="blank_list"> 여행일정이 없습니다.</td>
                  </tr>
               </c:when>
               <c:otherwise>
                  <c:forEach items="${wished_list }" var="HeartDto" end="4">
                     <tr>
                        <td>${HeartDto.nation }</td>
                        <td>${HeartDto.place_name }</td>
                        <td style="font-size:10pt">${HeartDto.place_address }</td>
                     </tr>
                  </c:forEach>
               </c:otherwise>
            </c:choose>   
         </table>
      </div>
      <br><hr style="width:800px">
      
      <!-- 약속일정 -->
      <div class="t_list">
         <h3>나의 약속<a href="mypage.do?command=myCompanion"><img src="<%=request.getContextPath()%>/img/plus_icon.png" width="30" height="30"></a></h3>
         <table class="table" style="width:750px;">         
            <col width="100px">
            <col width="100px">
            <col width="300px">
            
            <tr>
               <th>날짜</th>
               <th>장소</th>
               <th>comment</th>
            </tr>
            <c:choose>
               <c:when test="${empty companion_list }">
                  <tr>
                     <td colspan="3" class="blank_list" end="4"> 약속이 없습니다.</td>
                  </tr>
               </c:when>
               <c:otherwise>
                  <c:forEach items="${companion_list }" var="PromiseDto">
                  <input type="hidden" name="p_time" value="${PromiseDto.p_time }">
                  <input type="hidden" name="p_loc" value="${PromiseDto.p_loc }">
                  
                     <tr>
                        <td>${PromiseDto.p_time }</td>
                        <td>${PromiseDto.p_loc }</td>
                        <td>${PromiseDto.p_comment }</td>
                     </tr>
                  </c:forEach>
               </c:otherwise>
            </c:choose>   
         </table>
      
      </div>
   </div>

   <!-- 고정(푸터) -->
   <div id="footer">
      <%@ include file="/form/footer.jsp"%>
   </div>
</body>
</html>