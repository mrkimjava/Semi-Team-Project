<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>탈퇴</title>
<style type="text/css">
	div{
		text-align: center;
	}

</style>
<script type="text/javascript">
	function pop_close(){
		opener.parent.location.replace("loginController.do?command=logout");
		window.close();
		self.close();
	}
</script>

</head>

<body>
	<div>
		<p>탈퇴 되었습니다.<br>
		여행을 묻다와 여행을 해주셔서<br>
		감사했습니다.</p>
		<input type="button" value="OK" onclick="pop_close();">
	</div>
	
</body>
</html>