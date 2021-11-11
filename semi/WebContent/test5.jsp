<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>       
<!DOCTYPE html>
<html>
<head>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<script type="text/javascript">
	var date = "2021/11/11/17시";
	
	
	
	
	
	function formatdate(date){
		
		var sbstr = date.substring(0, date.lastIndexOf('/')).split("/").join("-") + " "
					+ date.substring(date.lastIndexOf('/')+1, date.length-1).split("시")[0]+":00:00";
		
		console.log(sbstr);
	}
	
	formatdate(date);

</script>
<body>
	



</body>
</html>