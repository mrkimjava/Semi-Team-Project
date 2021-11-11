<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>
<%@ page import="com.mvc.dto.HeartDto" %>
<%@ page import="com.mvc.biz.BizImpl" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>

<%
	int temp[] = {1,2,3,4,5,6,7,8,9};
%>

<script type="text/javascript">
var array = new Array();
</script>
<% 
	for(int i = 0; i < temp.length; i++){
%>
	<script type="text/javascript">
		var jsonObj = new Object();
		jsonObj.number = <%=temp[i] %>;
		jsonObj = JSON.stringify(jsonObj);
		array.push(JSON.parse(jsonObj));
	</script>

<%
	}

	ArrayList<HeartDto> heartlist = new BizImpl().getHeart("ILNAM");
%>
<script type="text/javascript">
	

</script>


<body>
	이미지 테스트 (테스트 완료)
	
		<%
			for(int i = 0; i < heartlist.size(); i++){
		%>
			<img id="thumbnail" src="<%=heartlist.get(i).getThumbnail() %>">
		<%
			}
		%>

</body>
</html>