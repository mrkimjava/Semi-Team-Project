<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="./companion/js/message.js"></script>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Nanum+Pen+Script&display=swap" rel="stylesheet">

<style type="text/css">
.trash:hover {
	cursor:pointer;
}

table {
	width:100%;
}

#bell, #promise {
	width:25px;
	height:25px;
}
.trash {
	width:15px;
	height:15px;
}
.listpic {
	width: 45px;
	height: 45px;
}
.messenger-table {
	width:600px;
	margin:50px auto;
}
tr {
	height:40px;
}
.message {
	text-decoration:none;
	color:black;
	font-weight:lighter;
	font-family: 'Nanum Gothic', sans-serif;
}

.iconTd{
	padding:25px;
}

.alert-message{
	z-index:1;
	width:75%; 
	height:auto; 
	background-color:rgb(250, 218, 223); 
	position:absolute; 
	margin-left:19%;
	margin-top:8%;
	display:none;
	border-radius:10px;
	padding-bottom:5px;

}

.alert-button {
	width:45px;
	height:20px;
	font-size:10px;
	border-radius:10px;
	background-color:white;
	border:none;
}
#close-button, #close-button-promise {
	width:15px;
	height:15px;
	margin-left:95%;
}
#close-button:hover{
	cursor:pointer;
}
#bell:hover{
	cursor:pointer;
}
#promise:hover{
	cursor:pointer;
}
#deleteTab:hover {
	cursor:pointer;
}
#messageTab:hover {
	cursor:pointer;
}
li {
	margin-bottom:10px;
}

.firstDiv {
	width:100%; height:auto; background-color:rgb(250, 218, 223); border-radius:10px;
}
.secondDiv {
	height:100%; width:20%; padding-top:2%;
}
.thirdDiv {
	width:80%; height:auto; margin-left:17%;
}
.ask_nameSpan {
	font-size:15px; letter-spacing:2px; font-weight:bold;
}
.ask_timeSpan {
	margin-left:20px; font-size:12px;
}
.fourthDiv {
	width:80%; height:auto; margin-left:17%; font-size:13px; letter-spacing:2px;
	font-family: 'Nanum Gothic', sans-serif;
}
.fifthDiv {
	width:80%; height:auto; margin-left:17%;
}
.connect-pic {
	width:40px;
	height:40px;
	float:left;
	margin-top:15%;
	margin-left:25%;
}
.title-asking {
	letter-spacing:3px; font-size:x-large; font-family: 'Nanum Gothic', sans-serif; font-weight:bold;
}

.promiseWithUs{
	z-index:1;
	width:75%; 
	height:auto; 
	background-color:rgb(184, 210, 240); 
	position:absolute; 
	margin-left:6%;
	margin-top:8%;
	display:none;
	border-radius:10px;
	padding-bottom:15px;

}

.firstProDiv {
	width:100%; height:auto; background-color:rgb(184, 210, 240); border-radius:10px;
}

.connect-prom-pic {
	width:35px;
	height:35px;
	float:left;
	margin-top:9%;
	margin-left:25%;
}

.ask_locSpan {
	margin-left:20px; font-size:12px;
}

.ask_nameSpanPro {
	font-size:18px; letter-spacing:2px; font-weight:bold;
}

.fourthDivPro {
	width:80%; height:auto; margin-left:17%; font-size:20px; letter-spacing:2px;
	font-family: 'Nanum Pen Script', cursive;
}
.deletePromise {
	width:15px;
	height:15px;
}
.ask_deleteSpan {
	margin-left:20px;
}
.deletePromise:hover{
	cursor:pointer;
}
#close-button-promise:hover{
	cursor:pointer;
}

</style>
<script type="text/javascript">
function deleteMessage(obj) {
	var con_id = $(obj).siblings("span").text();
	
	if (confirm("상대방과 연결을 끊으시겠습니까?")) {
		alert("삭제된 대화는 삭제된 메세지에서 확인할 수 있습니다.\n삭제된 지 15일 이후 모든 메세지는 삭제됩니다.");
		
		$.ajax({
			url:"message.do?command=deleteMessage&con_id="+con_id,
			success: function() {
				$(obj).parents("."+con_id).css({"display":"none"});
				$(obj).parents("."+con_id).siblings("."+con_id).css({"display":"none"});
			}
		});
	} 
}

$(function() {
	$("#close-button").click(function() {
		$(".alert-message").css("display","none");
	});
	
	$("#close-button-promise").click(function() {
		$(".promiseWithUs").css("display","none");
	});
	
	
	$("#bell").click(function() {
		$(".promiseWithUs").css("display","none");
		$(".alert-message").css("display","block");
		$("#liTitle").html("");
		$.ajax({
			url: "message.do?command=askConnect",
			dataType: "json",
			success: function(msg) {
				var json = msg;
				
				$.each(json, function(key, value) {
					$("#liTitle").append(
							"<li'> <div class='firstDiv'> <div class='secondDiv'>" + 
							"<div class='userImg' style='display:none;'>" + value[3] + "</div>" +
							"<div class='userName' style='display:none;'>" + value[4] + "</div>" +
							"<div class='userId' style='display:none;'>" + value[0] + "</div>" +
							"<img class='connect-pic' alt='user' src='./img/user/" + value[3] + ".png'>" +
							"</div> <div class='thirdDiv'> <span id='ask_name' class='ask_nameSpan'><b>" + value[4] + "</b></span>" + 
							"<span id='ask_time' class='ask_timeSpan'>" + value[2] + "</span> </div>" +
							"<div id='ask_comment' class='fourthDiv'>" + value[1] + "</div> <div class='fifthDiv'>" + 
							"<button class='alert-button' onclick='askPermit(this);'>수락</button> <button class='alert-button' onclick='askDenied(this);'>거절</button>" +
							"</div></div></li>"
					);
				});
			}
		});
	});
	
	//약속 확인버튼
	$("#promise").click(function() {
		$(".alert-message").css("display","none");
		$(".promiseWithUs").css("display","block");
		$("#promiseTitle").html("");
		$.ajax({
			url: "message.do?command=promiseWithUs",
			dataType: "json",
			success: function(msg) {
				var json = msg;
				$.each(json, function(key, value) {
					var temp = value[2].split("/");
					var time = temp[3];
					var date = "";
					for (var i = 0; i < temp.length - 1; i++) {
						if (i != 2) {
							date += temp[i] + "/";
						} else {
							date += temp[i];
						}
					}
					$("#promiseTitle").append(
							"<li style='margin-bottom:0px;'> <div class='firstProDiv'> <div class='secondDiv'>" + 
							"<div class='userImg' style='display:none;'>" + value[4] + "</div>" +
							"<div class='userName' style='display:none;'>" + value[5] + "</div>" +
							"<div class='userId' style='display:none;'>" + value[0] + "</div>" +
							"<img class='connect-prom-pic' alt='user' src='./img/user/" + value[4] + ".png'>" +
							"</div>" + 
							"<div class='thirdDiv'>" + 
							"<span id='ask_name' class='ask_nameSpanPro'><b>" + value[5] + "</b></span>" + 
							"<span id='ask_loc' class='ask_locSpan'>" + value[1] + "</span>" +
							"<span id='ask_time' class='ask_timeSpan'>" + date + "</span>" + 
							"<span id='ask-delete' class='ask_deleteSpan'><img class='deletePromise' src='./img/companion/promiseCancel.png' alt='deletePromise' onclick='cancelPromise(this);'></span>" +
							"</div>" +
							"<div id='ask_comment' class='fourthDivPro'>" + "<b style='font-size:20px;'>" + time +
							"</b>&nbsp;&nbsp;" + value[3] + "</div>" + 
							"</div></li>"
					);
				});
			}
		});
	});
});

//보내야하는 데이터 연결된 상대방 아이디, 위치정보로 해당 약속 찾아서 삭제하자
function cancelPromise(obj) {
	var con_id = $(obj).parent().parent().siblings(".secondDiv").children(".userId").text();
	var loc = $(obj).parent().siblings("#ask_loc").text();
	
	if (confirm("약속을 취소하시면 패널티가 1회 부여됩니다. 약속을 취소하시겠습니까?")) {
		$.ajax({
			url:"message.do?command=cancelPromise",
			type:"post",
			data:{
				"loc":loc
			},
			success:function(msg){
				alert(con_id + "님과의 약속을 취소하셨습니다. 패널티가 1회 부여됩니다.");
				$(obj).parent().parent().parent().css({"display":"none"});
			},
			error:function(msg) {
				console.log(msg);
			}
		});
	}
}

function deleteMessageTab() {
	$("#tbody").html("");
	$.ajax({
		url:"message.do?command=deleteMessageTab",
		dataType: "json",
		success: function(msg) {
			var json = msg;
			$.each(json, function(key, value) {
				console.log(value[0]);
				$("#tbody").append(
						"<tr class='"+value[0]+"' style='padding:10px;'>" +
						"<td rowspan='2' style='text-align:center;'><img class='listpic' alt='profile' src='./img/user/" + value[2] + ".png'></td>" +
						"<td colspan='3' class='fw-bold'>"+value[3]+"</td>" +
						"</tr>" +
						"<tr class='"+value[0]+"' style='padding:10px;'>" +
						"<td><a class='message'>"+value[1]+"</a></td>" +
						"<td style='padding-left:105px;' colspan='3'>" +
						"<span class='sen-id' style='display:none;'>"+value[0]+"</span>" +
						"<img class='trash' alt='trash' src='./img/companion/trash.png' onclick='completeDelete(this);'>" +
						"</td>" +
						"</tr>"
				);
			});
		}
	});
}

function completeDelete(obj) {
	var con_id = $(obj).siblings("span").text();
	
	if (confirm("상대방과의 메세지를 완전히 삭제하시겠습니까?")) {
		$.ajax({
			url:"message.do?command=completeDelete",
			type:"post",
			data: {
				"con_id":con_id
			},
			success:function(msg) {
				var cls = "."+con_id;
				if (msg == "성공") {
					alert("메세지를 성공적으로 삭제했습니다");
					$(cls).css({"display":"none"});
				} else {
					alert("fail");
				}
			}
		});
	}
}


function messageTab() {
	$("#tbody").html("");
	$.ajax({
		url:"message.do?command=currentMessageTab",
		dataType: "json",
		success: function(msg) {
			var json = msg;
			$.each(json, function(key, value) {
				$("#tbody").append(
						"<tr class='"+value[0]+"' style='padding:10px;'>" +
						"<td rowspan='2' style='text-align:center;'><img class='listpic' alt='profile' src='./img/user/" + value[2] + ".png'></td>" +
						"<td colspan='3' class='fw-bold'>"+value[3]+"</td>" +
						"</tr>" +
						"<tr class='"+value[0]+"' style='padding:10px;'>" +
						"<td><a href='message.do?command=detailMessage&sen_id="+value[0]+"' class='message'>"+value[1]+"</a></td>" +
						"<td style='padding-left:105px;' colspan='2'>" +
						"<span class='sen-id' style='display:none;'>"+value[0]+"</span>" +
						"<img class='trash' alt='trash' src='./img/companion/trash.png' onclick='deleteMessage(this);'>" +
						"</td>" +
						"</tr>"
				);
			});
		}
	});
}

function askPermit(obj) {
	var message = $(obj).parent(".fifthDiv").siblings(".fourthDiv").text();
	var userImg = $(obj).parent(".fifthDiv").siblings(".secondDiv").children(".userImg").text();
	var userName = $(obj).parent(".fifthDiv").siblings(".secondDiv").children(".userName").text();
	var id = $(obj).parent(".fifthDiv").siblings(".secondDiv").children(".userId").text();
	
	$.ajax({
		url:"message.do?command=askPermit&id="+id+"&message="+message,
		success: function(msg) {
			alert(userName+"님과 연결되었습니다. 행복한 추억을 만들어보세요!");
			$(obj).parent(".fifthDiv").parent(".firstDiv").css({"display":"none"});
			$("#tbody").append(
					"<tr class='"+id+"' style='padding:10px;'>" +
					"<td rowspan='2' style='text-align:center;'><img class='listpic' alt='profile' src='./img/user/" + userImg + ".png'></td>" +
					"<td colspan='3' class='fw-bold'>"+userName+"</td>" +
					"</tr>" +
					"<tr class='"+id+"' style='padding:10px;'>" +
					"<td><a href='message.do?command=detailMessage&sen_id="+id+"' class='message'>"+message+"</a></td>" +
					"<td style='padding-left:105px;' colspan='2'>" +
					"<span class='sen-id' style='display:none;'>"+id+"</span>" +
					"<img class='trash' alt='trash' src='./img/companion/trash.png' onclick='deleteMessage(this);'>" +
					"</td>" +
					"</tr>"
			);
		}
	});
}

function askDenied(obj) {
	var id = $(obj).parent(".fifthDiv").siblings(".secondDiv").children(".userId").text();
	
	$.ajax({
		url:"message.do?command=askDenied&id="+id,
		success:function(msg) {
			alert(id+"님의 동행요청을 거절하셨습니다");
			$(obj).parent(".fifthDiv").parent(".firstDiv").css({"display":"none"});
		}
	});
}
</script>

<body>
	<!-- request객체에 담겨서 넘어옴. request 객체 : connectList -->
	<div id="header">
		<%@ include file="/form/header.jsp"%>
	</div>
	<hr>
	<div class="container-fluid">
	    <div class="messenger-table">
	    	<div style="position:relative;">
	    	<div class="alert-message">
	    		<img id="close-button" alt="close" src="./img/companion/close.png">
	    		<ul style="list-style:none; padding-left:0px; margin-bottom:3px; border-radius:10px;">	
	    			<li style="text-align:center; margin:2%;">
	    				<span class="title-asking">우리 함께해요!</span>
	    			</li>
	    			<li id="liTitle">
	    			</li>
	    		</ul>
	    	</div>
	    	<div class="promiseWithUs">
	    		<img id="close-button-promise" alt="close" src="./img/companion/close.png">
	    		<ul style="list-style:none; padding-left:0px; margin-bottom:3px; border-radius:10px;">	
	    			<li style="text-align:center; margin:2%;">
	    				<span class="title-asking">깐부와의 약속</span>
	    			</li>
	    			<li id="promiseTitle">
	    			</li>
	    		</ul>
	    	</div>
		        <table>
		        	<colgroup>
		        		<col width="10%">
		        		<col width="70%">
		        		<col width="10%">
		        		<col width="10%">
		        	</colgroup>
		        	<thead>
		        		<tr>
		        			<td style="padding:25px;">
		        				<a class="navbar-brand" id="messageTab"style="color:black; margin:auto;" onclick="messageTab();">메세지</a>
		        			</td>
		        			<td style="padding:25px;">
		        				<a class="navbar-brand" id="deleteTab" style="color:black;" onclick="deleteMessageTab();">삭제된 메세지</a>
		        			</td>
		        			<td style="padding:25px; padding-left:25px;">
		        				<img id="promise" alt="promise" src="./img/companion/promise.png">
		        			</td>
		        			<td style="padding:25px;">
		        				<img id="bell" alt="bell" src="./img/companion/idea.png">
		        			</td>
		        		</tr>
		        	</thead>
		        	<tbody id="tbody">
		        		<!-- tr태그 2개 하나에 한 셋트 -->
		        		<c:forEach var="list" items="${conList}">
		        		<tr class="${list.sen_id}" style="padding:10px;">
		        			<td rowspan="2" style="text-align:center;">
		        				<img class="listpic" alt="profile" src="./img/user/${list.sender_img}.png">
		        			</td>
		        			<td colspan="3" class="fw-bold">${list.user_name}</td>
		        		</tr>
		        		<tr class="${list.sen_id}" style="padding:10px;">
		        			<td>
		        				<a href="message.do?command=detailMessage&sen_id=${list.sen_id}" class="message">${list.message}</a>
		        			</td>
		        			<td style="padding-left:105px;" colspan="2">
		        				<span class="sen-id" style="display:none;">${list.sen_id}</span>
		        				<img class="trash" alt="trash" src="./img/companion/trash.png" onclick="deleteMessage(this);">
		        			</td>
		        		</tr>
		        		</c:forEach>
		        	</tbody>
		        </table>
	        </div>
	    </div>
	</div>
	<div id="footer">
		<%@ include file="/form/footer.jsp"%>
	</div>
</body>
</html>