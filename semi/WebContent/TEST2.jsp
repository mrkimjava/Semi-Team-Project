<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

?>
<!DOCTYPE html>
<html>
<head>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>



<script type="text/javascript">


	function photoRf(path){
		
		var temp = path.split("Photo?1s");
		console.log(temp);
		
		var temp2 = temp[1].split("&callback");
		console.log(temp2);
		
		return(temp2[0]);
	}

	$(function(){
		
		photoRf("https://maps.googleapis.com/maps/api/place/js/PhotoService.GetPhoto?1sAap_uEAomG5mlLTS8ERhBClhdlBNlUklabAXFRChbeQ5j53rkMAAJPaYEGWJFb3ijVOz_pVAR7o0hIKR6vTHnStl5NHAwDpRrf1HFn6gH0C_m5gz9MCcAI8ERwbqAj_JUBMTcca1Y53cpMstGV2rDlWsHWDLYJsNCXI3O-xWlj8-Cyz4639H&3u400&4u400&5m1&2e1&callback=none&key=AIzaSyDEOFLxuHpLh-ga2m0oiOm5C66luLW65QQ&token=100301");
		
		
	});
	
</script>

<body>
<img id="thumbnail" src="">
</body>
</html>



































