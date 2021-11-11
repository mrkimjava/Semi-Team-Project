<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>   
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="smarteditor/js/service/HuskyEZCreator.js" charset="utf-8"></script>
<script type="text/javascript" src="//code.jquery.com/jquery-1.11.0.min.js"></script>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
</head>

<style>
	@import url(//fonts.googleapis.com/earlyaccess/jejugothic.css);
</style>

<body style="font-family: 'Jeju Gothic', sans-serif;">
	<!-- 고정(헤더) -->
	<div id="header">
		<%@ include file="/form/header.jsp"%>
	</div>
	<br>
	<br>
	<br>
	

<form id="frm" action="insert_res.jsp" method="post" >
	<table class="table" style="align:center; font-size:15px; width:900px; height: 500px; margin-left:auto; margin-right:auto;">
		<tr>
			<th>작성자</th>
			<td><input type="text" name="writer"></td>
		</tr>
		<tr>
			<th>제목</th>
			<td><input type="text" name="title" id="title"></td>
		</tr>
		<tr>
			<th>내용</th>
				<td><textarea name="content" id="content" rows="20" cols="80" ></textarea></td>
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
	    bUseToolbar : true, 
		bUseVerticalResizer : false, 
		bUseModeChanger : false 
	    }
	});
</script>

<script type="text/javascript" src = "resources/js/notice-write.js"></script>
		<div style="margin-left:920px;">
			<button onclick="save();" value="입력" 
			style="background-color: #7b9acc; color:#FCF6F5; width:70px; height:30px; font-size:12px; border:0px;">입력</button>
			<input type="button" value="취소" onclick="location.href='newslist.jsp'"
			style="background-color: #7b9acc; color:#FCF6F5; width:70px; height:30px; font-size:12px; border:0px;">
		</div>

<script type="text/javascript">


function save(){
	oEditors.getById["content"].exec("UPDATE_CONTENTS_FIELD", []);  
	submit();
}
</script>	
	
	</form>

	<br>
	<br>
		<!-- 고정(푸터) -->
	<div id="footer">
		<%@ include file="/form/footer.jsp"%>
	</div>
</body>
</html>