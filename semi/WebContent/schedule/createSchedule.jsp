<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>       
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>
 <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>

<title>createSchedule</title>


     <style>    

	#rowbelow{background-color:#FFFAF0;text-align:center;}
    #scroll{overflow: auto;width:300px;height:500px;}
    #scroll2{overflow: auto;width:300px;height:500px;}
   	#scroll3{overflow: auto;width:300px;height:500px;}
 
    </style>
    
</head>


<body>
	<!-- 고정(헤더) -->
	<div id="header">
		<%@ include file="/form/header.jsp"%>
	</div>
<br><br><br>

     
     
     <!-- map -->
    <div class="container">
		<div class="col-sm-8" style="width:100%">
			<%@ include file="maptest/maptest1.jsp" %>
		</div>	
			
	<!-- schedule -->		
	<div class="container">		
		<div class="col-sm-12" style="height:400px; width:100%; overflow-x:scroll; float:right; "><br><br>
			<form>
      		<input type="date" id="date" onchange="dateChange();" style="font-size:12px; float:right"; /><br>
      		<input id="input_submit" type="submit" value="add" onclick="input();" style="padding:5px 3px; float:right"/>
      		<input type="button" value="done" onclick="doneButton();" style="padding:5px 3px; float:right" />
   			</form><br><br> 
   			 <p style="text-align:center" id="temp"></p><br>
   			 <div><%@ include file="droptest.html" %></div>
	</div>
		 		
		</div>
	</div>
 
    <div style="width:100%; height:600px"></div>

 
	<!-- 하단 3컬럼 -->
	<div class="container">
		<div class="row" id="rowbelow"> 
		
			<!-- 컬럼1: hotel -->
			<div class="col" id="scroll">
			<br><br><h3>HOTEL</h3><br>
					 
			<table class="table">
  			<thead  id="results" data-bs-toggle="modal" data-bs-target="#Modal">
    		<tr>
      			<th colspan="2"><b>placename</b></th>
    		</tr>
  			</thead>
  			<tbody>
    		<tr>
		      <td><img src=" " width=90% style="top:20px; position:relative" ></td>
		    </tr>
			 </tbody>
			</table>
			
			</div>
		
			<!-- 컬럼2: place -->
			<div class="col" id="scroll2">
				<br><br><h3>PLACE</h3><br>
			
			<table class="table">
  			<thead  id="results_ta" data-bs-toggle="modal" data-bs-target="#Modal">
    		<tr>
      			<th colspan="2"><b>placename</b></th>
    		</tr>
  			</thead>
  			<tbody>
    		<tr>
		      <td><img src="" width=90% style="top:20px; position:relative" ></td>
		    </tr>
			 </tbody>
			</table>
				 
  			</div>
  			
  			<!-- 컬럼3: restaurant -->
			<div class="col" id="scroll3">
			<br><br><h3>RESTAURANT</h3><br>
			
			<table class="table">
  			<thead  id="results_rest" data-bs-toggle="modal" data-bs-target="#Modal">
    		<tr>
      			<th colspan="2"><b>placename</b></th>
    		</tr>
  			</thead>
  			<tbody>
    		<tr>
		      <td><img src="" width=90% style="top:20px; position:relative" ></td>
		    </tr>
			 </tbody>
			</table>
		
		</div>
			 



<!-- Modal start-->
<div class="modal fade" id="Modal" tabindex="-1" aria-labelledby="modalName" aria-hidden="true">
<div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="modalName"></h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
      		<div>
      		<br> 
      		<p id="modalimage"></p><br>
      		<p id="modalRating"></p><br>
      		<p id="modalAddress"></p><br>
      		<p id="modalPhone"></p><br>
      		<hr>
      		<a href="" id="modalUrl">go to web site</a>
      		<hr>
      		<p>review</p>
      		
      		</div>
      		
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary">Add</button>
        <button type="button" class="btn btn-third">Like</button>
      </div>
    </div>
  </div>
</div>
<!-- modal end -->
			
			<!-- modal javascript-->
			<script type="text/javascript">
			var myModal = document.getElementById('myModal')
			var myInput = document.getElementById('myInput')
			myModal.addEventListener('shown.bs.modal', function () {
  				myInput.focus()
					})
			</script>
			
			<!-- date javascript -->
			<script>
     		 var dateChange = () => {  
        	$("#temp").text($("#date").val()+"의 일정");};
     	   </script>
    
		 
		</div>
</div>

 
 
	
<br><br><br><br><br><br><br><br><br><br>




	<!-- 고정(푸터) -->
	<div id="footer">
		<%@ include file="/form/footer.jsp"%>
	</div>
</body>
</html>