<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.mvc.dto.UserDto" %>
<%@ page import="com.mvc.dto.MessageDto" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="./companion/js/room.js"></script>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic&display=swap" rel="stylesheet">

<%
	UserDto login_id = (UserDto)session.getAttribute("dto");
	List<MessageDto> list = (List<MessageDto>)request.getAttribute("detailList");
	MessageDto con_id = list.get(list.size()-1);
%>

<style type="text/css">
	#check-promise {
	width:70%;
	height:auto;
	margin-left: 15%;
	margin-top: 8%;
	border-radius:10px;
	background-color:rgb(238, 222, 224);
	display:none;
	position: absolute;
	z-index:1;
}
.connect-pic {
	width:40px;
	height:40px;
	float:left;
	margin-top:15%;
	margin-left:20%;
}
.alert-button {
	width:45px;
	height:20px;
	font-size:10px;
	border-radius:10px;
	background-color:white;
	border:none;
}
#goMyPromise:hover {
	cursor:pointer;
}
#openPromise{
	cursor:pointer;
}
.check-ul {
list-style:none; 
padding-left:0px; 
margin-bottom:3px;
border-radius:10px;
}
.check-li-title{
text-align:center; margin:2%;
}
.check-title-span{
letter-spacing:3px; font-size:24px; font-weight:bold; font-family: 'Nanum Gothic', sans-serif;
}
.check-imgdiv{
width:100%; height:auto; background-color:rgb(238, 222, 224); border-radius:10px;
}
.check-imgdiv2{
height:100%; width:10%; padding-top:2%
}
.check-infodiv{
width:80%; height:auto; margin-left:13%;
}
.check-infoname{
font-size:15px; letter-spacing:2px; font-weight:bold;
}
.check-infoloc{
margin-left:15px; font-size:12px;
}
.check-infolocData{
margin-left:2px; font-size:12px;
}
.check-infodate{
margin-left:15px; font-size:12px;
}
.check-infodateData{
margin-left:2px; font-size:12px;
}
.check-commentdiv{
width:80%; height:auto; margin-left:13%; font-size:13px; letter-spacing:2px;
}
.check-buttondiv{
width:80%; height:auto; margin-left:13%;
}
.check-li-goMy{
text-align:right; margin-top:10px; margin-bottom:10px;
}
#goMyPromise{
color:rgb(83, 67, 226); margin-right:20px; font-size:13px;
}
.messenger-table {
	width: 700px;
	height: 600px;
	margin: 0 auto;
	background-color: rgb(245, 240, 240);
	border-radius: 10px;
	opacity: 0.9;
	box-shadow: blur;
	overflow: auto;
	position: relative;
}

.message {
	width: 97%;
	height: auto;
	overflow: hidden;
	float: left;
}

.reportTab {
	width: 100%;
	padding: 0px;
}

tr {
	height: 30px;
}

#pic {
	width: 50px;
	height: 50px;
}

.reportIcon {
	margin-left: 10px;
	width: 20px;
	height: 20px;
}

<!--
-->
#picture {
	width: 10%;
	height: 100%;
	float: left;
}

#messageBody {
	width: 90%;
	float: right;
	height: auto;
}

<!--
-->
.nav-tab {
	font-size: 20px;
	text-decoration: none;
	color: black;
}

<!--
-->
.inputForm {
	width: 700px;
	margin: 0 auto;
	margin-bottom: 150px;
	height: 75px;
	background-color: rgb(241, 244, 245);
	border-radius: 10px;
	opacity: 0.8;
	padding: 10px;
}

<!--
-->
.messenger-nav {
	width: 700px;
	height: 80px;
	margin: 0 auto;
	margin-top: 100px;
	padding: 10px;
	opacity: 0.8;
}

textarea::placeholder {
	letter-spacing: 1.5px;
	font-size: 90%;
}

<!--
-->
.promise-table {
	position: absolute;
	width: 70%;
	height: 60%;
	background-color: rgb(250, 218, 223);
	margin-left: 15%;
	margin-top: 10%;
	border-radius: 10px;
	display: none;
}

#close-button {
	width: 15px;
	height: 15px;
	margin-left: 95%;
}

.promise-tr {
	height: 5%;
}

.promise-td {
	padding-left: 30px;
	font-family: 'Nanum Gothic', sans-serif;
}

.input {
	resize: none;
	border: 1px solid;
	border-radius: 10px;
}

#close-button:hover {
	cursor: pointer;
}

#button:hover {
	cursor: pointer;
}

.reportIcon:hover {
	cursor: pointer;
}

#promiseTab:hover {
	cursor: pointer;
}

.firstTd {
	text-align: center; padding: 15px;
}
.spanSender {
	font-size: 20px;
}
.spanTime {
	font-size: 12px; margin-left: 10px;
}
.secondTd {
	padding: 5px; padding-bottom: 15px;
}
#refresh:hover{
	cursor:pointer;
}
</style>
<script type="text/javascript">
$(document).ready(function() {
	setInterval(function() {
		var con_id = document.getElementById("con_id").innerText;
		var idx = 0;
		$("#tbody").html("");
		$.ajax({
			url:"message.do?command=refresh&con_id="+con_id,
			dataType:"json",
			success:function(data) {
				var json = data;
				$.each(json, function(idx) {
					$("#tbody").append(
							"<tr> <td rowspan='2' class='firstTd'> <img id='pic' alt='profile' src='./img/user/" + json[idx].user_img + ".png'></td>" +
							"<td colspan='2'> <span id='sender' class='fw-bold spanSender'>" + json[idx].user_name + "</span>" +
							"<span id='m_time' class='spanTime'>" + json[idx].time + "</span>" +
							"<img class='reportIcon' alt='report' src='./img/companion/report2.png' onclick='reportUser();'>" +
							"</td></tr>" +
							"<tr><td colspan='3' class='secondTd'><div id='getMessage' class='message'>" + json[idx].message + "</div>" +
							"</td></tr>"
					);
					idx = (idx+1)==json.length? 0 : (idx+1);
				});
				$(".messenger-table").scrollTop($("#tbody")[0].scrollHeight);
			}
		});
	}, 15000);
});


$(function() {
	$("#inputMessage").on("keydown",function(event) {
		if (event.keyCode == 13) {
			if (!event.shiftKey) {
				event.preventDefault();
				messageFunction();
			}
		}
	});
});

function openPromiseTab() {
	$(".promise-table").css("display","none");
	$("#promiseList").html("");
	$.ajax({
		url:"message.do?command=getPromise",
		dataType:"json",
		success:function(data){
			var list = data;
			
			$.each(list, function(key, value) {
				$("#promiseList").append(
						"<div class='check-imgdiv'>" +
						"<div class='check-imgdiv2'>" +
						"<img class='connect-pic' alt='user' src='./img/user/" + value[4] + ".png'>" +
						"</div>" +
						"<div class='check-infodiv'>" +
						"<span id='ask-id' style='display:none;'>" + value[0] + "</span>" +
						"<span id='ask-name' class='check-infoname'>"+value[5]+"</span>" +
						"<span class='check-infoloc'>??????: </span><span id='ask-loc' class='check-infolocData'>"+value[1]+"</span>" +
						"<span class='check-infodate'>??????: </span><span id='ask-time' class='check-infodateData'>"+value[2]+"</span>" +
						"</div>" +
						"<div id='ask_comment' class='check-commentdiv'>"+value[3]+"</div>" +
						"<div class='check-buttondiv'>" +
						"<button class='alert-button' onclick='permitPromise(this);'>??????</button>" +
						"<button class='alert-button' onclick='denyPromise(this);'>??????</button>" +
						"</div>" +
						"</div>"
				);
			});
		}
	});
	$("#check-promise").css("display", "block");
}

function denyPromise(obj) {
	var id = $(obj).parent().siblings(".check-infodiv").children("#ask-id").text();
	console.log(id);
	var loc = $(obj).parent().siblings(".check-infodiv").children("#ask-loc").text();
	if (confirm("????????? ?????????????????????????")) {
		$.ajax({
			url:"message.do?command=choicePromise",
			type:"post",
			data:{
				"con_id":id,
				"loc":loc,
				"permit":"N"
			},
			success:function(msg){
				$(obj).parent().parent(".check-imgdiv").css("display","none");
				alert("????????? ?????????????????????.");
				denyMessage(id);
			}
		});
	}
}

function denyMessage(id) {
	var chat_serial = document.getElementById("chat_serial").innerText;
	$.ajax({
		url:"message.do?command=denyMessage",
		type:"post",
		data:{
			"con_id":id,
			"chat_serial":chat_serial
		},
		success:function(msg) {
			if (msg == "??????") {
				console.log(msg);
			}
		}
	})
}

function permitPromise(obj) {
	var id = $(obj).parent().siblings(".check-infodiv").children("#ask-id").text();
	var loc = $(obj).parent().siblings(".check-infodiv").children("#ask-loc").text();
	var time = $(obj).parent().siblings(".check-infodiv").children("#ask-time").text();
	var chat_serial = document.getElementById("chat_serial").innerText;
	var comment = id + "????????? ?????? : " + $(obj).parent().siblings(".check-commentdiv").text();
	var login_id = $("#login_id").text();
	var user_name = document.getElementById("user_name").innerText;
	var user_img = document.getElementById("user_img").innerText;
	
	if (confirm(id+"?????? ??????????????????????")) {
		$.ajax({
			url:"message.do?command=choicePromise",
			type:"post",
			data:{
				"con_id":id,
				"loc":loc,
				"permit":"Y",
				"comment":comment,
				"chat_serial":chat_serial
			},
			success:function(msg){
				alert("????????? ?????????????????????. ????????????????????? ????????? ??????????????????.");
				$(obj).parent().parent(".check-imgdiv").css("display","none");
				
				if (id == $("#con_id").text()) {
					$("#tbody").append(
							"<tr> <td rowspan='2' class='firstTd'> <img id='pic' alt='profile' src='./img/user/" + user_img + ".png'></td>" +
							"<td colspan='2'> <span id='sender' class='fw-bold spanSender'>" + user_name + "</span>" +
							"<span id='m_time' class='spanTime'>" + time + "</span>" +
							"<img class='reportIcon' alt='report' src='./img/companion/report2.png' onclick='reportUser();'>" +
							"</td></tr>" +
							"<tr><td colspan='3' class='secondTd'><div id='getMessage' class='message' style='color:blue;'>" + comment + "</div>" +
							"</td></tr>"
					);
				}
			}
		});
	}
}


function messageFunction() {
	var message = document.getElementById("inputMessage").value;
	var login_id = document.getElementById("login_id").innerText;
	var user_name = document.getElementById("user_name").innerText;
	var con_id = document.getElementById("con_id").innerText;
	var chat_serial = document.getElementById("chat_serial").innerText;
	var user_img = document.getElementById("user_img").innerText;
	
	var today = new Date();
	var year = today.getFullYear();
	var month = ('0' + (today.getMonth() + 1)).slice(-2);
	var day = ('0' + today.getDate()).slice(-2);
	var dateString = year + '/' + month  + '/' + day;
	
	if (message.trim() == "" || message == null) {
		alert("???????????? ??????????????????");
		$("#inputMessage").focus();
		return;
	}
	if (message.length > 200) {
		alert("???????????? ?????? ?????? ?????????????????????.\n 200??? ???????????? ??????????????????");
		$("#inputMessage").focus();
		return;
	}
	
	$.ajax({
		url:"message.do?command=sendMessage&message="+message+"&con_id="+con_id+"&chat_serial="+chat_serial,
		success: function(){
			console.log(????????????);
		}
	});
	
	$("#tbody").append(
			"<tr> <td rowspan='2' class='firstTd'> <img id='pic' alt='profile' src='./img/user/" + user_img + ".png'></td>" +
			"<td colspan='2'> <span id='sender' class='fw-bold spanSender'>" + user_name + "</span>" +
			"<span id='m_time' class='spanTime'>" + dateString + "</span>" +
			"<img class='reportIcon' alt='report' src='./img/companion/report2.png' onclick='reportUser();'>" +
			"</td></tr>" +
			"<tr><td colspan='3' class='secondTd'><div id='getMessage' class='message'>" + message + "</div>" +
			"</td></tr>"
	);
	document.getElementById("inputMessage").value = "";
	
	// ????????? ??????
	$(".messenger-table").scrollTop($("#tbody")[0].scrollHeight);
}

function refreshMassage() {
	var con_id = document.getElementById("con_id").innerText;
	var idx = 0;
	$("#tbody").html("");
	$.ajax({
		url:"message.do?command=refresh&con_id="+con_id,
		dataType:"json",
		success:function(data) {
			var json = data;
			$.each(json, function(idx) {
				$("#tbody").append(
						"<tr> <td rowspan='2' class='firstTd'> <img id='pic' alt='profile' src='./img/user/" + json[idx].user_img + ".png'></td>" +
						"<td colspan='2'> <span id='sender' class='fw-bold spanSender'>" + json[idx].user_name + "</span>" +
						"<span id='m_time' class='spanTime'>" + json[idx].time + "</span>" +
						"<img class='reportIcon' alt='report' src='./img/companion/report2.png' onclick='reportUser();'>" +
						"</td></tr>" +
						"<tr><td colspan='3' class='secondTd'><div id='getMessage' class='message'>" + json[idx].message + "</div>" +
						"</td></tr>"
				);
				idx = (idx+1)==json.length? 0 : (idx+1);
			});
			$(".messenger-table").scrollTop($("#tbody")[0].scrollHeight);
		}
	});
}

function transPromise() {
	//????????? ??????
	if ($(".input:eq(1)").val() == null || $(".input:eq(1)").val().trim() == "") {
		alert("???????????? ????????? ????????? ??????????????????.");
		$(".input:eq(1)").focus();
		return;
	}
	//?????? ????????? ??????
	if ($(".input:eq(2)").val().length < 13 || $(".input:eq(2)").val().length > 15) {
		alert("????????? ????????? ????????? ??????????????????. ex) 2021/10/29/16??? ");
		$(".input:eq(2)").focus();
		return;
	}
	if ($(".input:eq(2)").val() == null || $(".input:eq(2)").val().trim() == "") {
		alert("????????? ???????????? ??????????????????.");
		$(".input:eq(2)").focus();
		return;
	}
	
	var temp = $(".input:eq(2)").val().split('/');
	var today = new Date();
	var year = today.getFullYear();
	var month = today.getMonth() + 1;
	var date = today.getDate();
	var time = "";
	
	for (var i = 0; i < 4; i++) {
		if (temp[0] < year) {
			alert("?????? ?????? ????????? ????????? ?????? ??? ?????????! ");
			$(".input:eq(2)").focus();
			return;
		} else if (temp[1] > 12 || temp[1] < 1) {
			alert("?????? ?????? ?????????????????????. ?????? ??????????????????.");
			$(".input:eq(2)").focus();
			return;
		} else if (temp[0] == year && temp[1] < month) {
			alert("?????? ?????? ????????? ????????? ?????? ??? ?????????!");
			$(".input:eq(2)").focus();
			return;
		} else if (temp[2] < 1 || temp[2] > 31) {
			alert("????????? ?????? ?????????????????????. ?????? ??????????????????.");
			$(".input:eq(2)").focus();
			return;
		} else if (temp[1] == month && temp[2] < date) {
			alert("?????? ?????? ????????? ????????? ?????? ??? ?????????!");
			$(".input:eq(2)").focus();
			return;
		} else if (temp[3].length > 4) {
			alert("????????? ?????? ?????????????????????. ?????? ??????????????????.");
			$(".input:eq(2)").focus();
			return;
		}
	}
	for (var i = 0; i < temp[3].length; i++) {
		console.log(temp[3][i]);
		if (!isNaN(temp[3][i])){
            time += temp[3][i];
        }
	}
	if (time < 0 || time > 24) {
		alert("????????? ?????? ?????????????????????. ?????? ??????????????????.");
		$(".input:eq(2)").focus();
		return;
	}
	
	if ($(".input:eq(3)").val() == null || $(".input:eq(3)").val().trim() == "") {
		alert("????????? ??? ??? ??????????????????!");
		$(".input:eq(3)").focus();
		return;
	}
	
	var con_id = $("#con_id").text();
	var loc = $(".input:eq(1)").val().trim();
	var date = $(".input:eq(2)").val().trim();
	var comment = $(".input:eq(3)").val();
	
	if (confirm("?????? ????????? ??????????????????????")) {
		$.ajax({
			url:"message.do?command=promise",
			type:"post",
			data:{
				"con_id":con_id,
				"loc":loc,
				"date":date,
				"comment":comment
			},
			success:function(msg) {
				alert("?????? ????????? " + msg + " ????????????.");
				$(".promise-table").css("display", "none");
				$(".input:eq(1)").val("");
				$(".input:eq(2)").val("");
				$(".input:eq(3)").val("");
			}
		});
	} else {
		alert("??????");
		$(".input:eq(3)").focus();
	}
}

function openPromise() {
	$("#check-promise").css("display", "none");
	$(".promise-table").css("display", "block");
}

function closeButton(obj) {
	$(obj).parent("div").css("display","none");
}

function reportUser() {
	if (confirm("???????????? ?????? ???????????? ?????????????????????????\n?????? ??? ???????????? ????????? ????????????.")) {
		var con_id = document.getElementById("con_id").innerText;
		//????????? ajax??? ????????? ?????? ????????? ????????? ????????? ???????????????.
		$.ajax({
			url:"message.do?command=reportUser&con_id=" + con_id,
			success:function(msg) {
				location.href="message.do?command=message";
			}
		});
	}
}
</script>


<body>
	<div id="header">
		<%@ include file="/form/header.jsp"%>
	</div>
	<hr>
	<div class="container">
		<div class="messenger-nav">
			<table style="width: 100%;" class="text-center">
				<colgroup>
					<col width="33%">
					<col width="33%">
					<col width="33%">
				</colgroup>
				<tr style="height: 70px;">
					<td><a id="promiseTab" class="nav-tab fw-bold" onclick="openPromise();">????????????</a></td>
					<td><a class="nav-tab fw-bold" onclick="openPromiseTab()">?????? ????????????</a></td>
					<td><a id="refresh" class="nav-tab fw-bold" onclick="refreshMassage();">????????????</a></td>
				</tr>
			</table>
		</div>
		<div class="messenger-table">
			<div id="check-promise">
				<img id="close-button" alt="close" src="./img/companion/close.png" onclick="closeButton(this);">
				<ul class="check-ul">	
	    			<li class="check-li-title">
	    				<span class="check-title-span">????????? ??? ??????</span>
	    			</li>
					<li id="promiseList">
	    			</li>
	    			<li class="check-li-goMy">
	    				<!-- ?????????????????? ?????? -->
	    				<a id="goMyPromise" href="<%=request.getContextPath()%>/mypage.do?command=myCompanion">?????? ?????? ??????????????????></a>
	    			</li>
	    		</ul>
			</div>
			<div class="promise-table">
				<img id="close-button" alt="close" src="./img/companion/close.png" onclick="closeButton(this);">
				<div style="width: 100%; height: 90%">
					<table style="width: 100%; height: 100%;">
						<colgroup>
							<col width="24%">
							<col width="76%">
						</colgroup>
						<tbody id="promiseBody">
							<tr>
								<td colspan="2" style="font-size:20px; font-family: 'Nanum Gothic', sans-serif;" class="text-center"><b style="padding:10px;">?????? ?????????</b></td>
							</tr>
							<tr class="promise-tr">
								<td class="promise-td text-center"><b>???????</b></td>
								<td><textarea class="input" rows="1" readonly
										style="letter-spacing:3px; width:90%;"><%=login_id.getUser_id()%></textarea></td>
							</tr>
							<tr class="promise-tr">
								<td class="promise-td text-center"><b>??????????</b></td>
								<td><textarea class="input" rows="1"
										name="location" placeholder="???????????? ????????? ??????????????????." style="letter-spacing:3px; width:90%;"></textarea></td>
							</tr>
							<tr class="promise-tr">
								<td class="promise-td text-center"><b>???????</b></td>
								<td><textarea class="input" rows="1" name="date"
										placeholder="???/???/???/??? ??????(ex: 2021/05/21/16???)" style="letter-spacing:3px; width:90%;"></textarea></td>
							</tr>
							<tr class="promise-tr">
								<td class="promise-td text-center"><b>??????????</b></td>
								<td><textarea class="input" rows="5"
										name="comment" placeholder="???????????? ????????? ????????? ??????????????? ???????????????!" style="letter-spacing:3px; width:90%;"></textarea></td>
							</tr>
							<tr style="height:1%;">
								<td colspan="2" class="text-center">
									<button id="submitButton" onclick="transPromise();" class="btn-primary" style="border-radius:15px;">?????????</button>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
			<table style="width: 100%;">
				<colgroup>
					<col width="12%">
					<col width="78%">
					<col width="10%">
				</colgroup>
				<thead>
					<tr style="display:none">
						<td>
							<span id="user_name"><%=login_id.getName() %></span>
							<span id="user_img"><%=login_id.getUser_img() %></span>
							<span id="con_id"><%=con_id.getSen_id()%></span>
							<span id="chat_serial"><%=con_id.getChat_serial()%></span>
							<span id="login_id"><%=login_id.getUser_id()%></span>
						</td>
					</tr>
					<!-- ?????? ????????? -->
					<tr style="margin-top: 10px;">
						<td rowspan="2" style="text-align: center; padding: 15px;"><img id="pic" alt="bell" src="./img/companion/admin.png"></td>
						<td colspan="2"><span class="fw-bold" style="font-size: 20px;">????????? ??????</span></td>
					</tr>
					<tr>
						<td colspan="3" style="padding: 5px; padding-bottom: 15px;">
							<div class="message">
								??????????????? ????????? ???????????????! Manner Maketh Man!
								<br>
								?????? ??? ??????????????? ?????????????????? ????????????.
								<a href="#" style="color: red; text-decoration: none; font-size: 10px;">&nbsp;???????????? ????????????</a>
							</div>
						</td>
					</tr>
				</thead>
				<tbody id="tbody">
<%	
				for (int i = 0; i < list.size()-1; i++) {
%>
					<tr>
						<td rowspan="2" style="text-align: center; padding: 15px;"><img id="pic" alt="profile" src="./img/user/<%=list.get(i).getSender_img() %>.png"></td>
						<td colspan="2"><span id="sender"class="fw-bold" style="font-size: 20px;"><%=list.get(i).getUser_name() %></span>
							<span id="m_time" style="font-size: 12px; margin-left: 10px;"><%=list.get(i).getM_time()%></span>
							<img class="reportIcon" alt="report" src="./img/companion/report2.png" onclick="reportUser();">
						</td>
					</tr>
					<tr>
						<td colspan="3" style="padding: 5px; padding-bottom: 15px;">
							<div id="getMessage" class="message"><%=list.get(i).getMessage()%></div>
						</td>
					</tr>
<%
				}
%>
				</tbody>
			</table>
		</div>
		<div class="inputForm">
			<div style="width: 70%; float: left; margin-left: 30px;">
				<textarea id="inputMessage" class="input" style="height: 50px; width: 100%;" rows="2"
					cols="56" placeholder="&nbsp;&nbsp;???????????? ???????????????"></textarea>
			</div>
			<div style="width: 20%; float: right; margin-right: 15px;">
				<button id="sendMessage" class="btn-primary" onclick="messageFunction();"
					style="width: 90%; height: 50px; border-radius: 5px; opacity: 3;">??????</button>
			</div>
		</div>
	</div>
	<div id="footer">
		<%@ include file="/form/footer.jsp"%>
	</div>
</body>
</html>