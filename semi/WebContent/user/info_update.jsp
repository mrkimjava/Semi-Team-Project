<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<style type="text/css">
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
	.user_list{
		display:flex;
		margin-left: 200px;
		margin-bottom: 20px;
	}
	.sidebar {
	  width: 15%;
	  float: left;
	  height: 50%;
	}
	form{
		margin-left: 160px;
	}
	input{
	border : 0;
	border-bottom: 2px solid lightgrey;
	}
	
	h3 {
		padding: 0;
		margin: 0;
	}
	body {
		margin: 0;
		padding: 0;
	}
#id{
	border:0;
	border-bottom: 2px solid;
}

.btn {
	padding : 5px 10px;
	width:130px;
	background-color: white;
}
.btn:hover{
	background-color: grey;
}

.num{
	border-bottom: 1px solid;
	color : red;
}
span, .noti{
	font-size: 5pt;
}
</style>
<script type="text/javascript">
	function passwdChk(){
		var pw = document.getElementsByName("rPasswd")[0]; //db에 저장된 현재비밀번호
		var pw1 = document.getElementsByName("passwd")[0]; //입력한 현재 비밀번호
		
		if(pw1.value.trim()==""|| pw1.value==null){
			alert("현재비밀번호를 입력해 주세요");
		}else if(pw.value.trim() != pw1.value.trim()){
			document.getElementById("pw_equal").innerHTML = "<b><font color='red'>"+"비밀번호가 다릅니다."+"</font></b>";
		}else if(pw.value.trim() == pw1.value.trim()){
			document.getElementById("pw_equal").innerHTML = "";
		}
		
	}
	
	function beforeSubmit(){
		var pw1 = document.getElementsByName("pw_change")[0];
		var pw2 = document.getElementsByName("pw_check")[0];
		var name = document.getElementsByName("name")[0];
		var nickname = document.getElementsByName("nickname")[0];
		var addr = document.getElementById("extraAddress");
		var email = document.getElementsByName("email")[0];

		var pattern1 = /[0-9]/;
        var pattern2 = /[a-zA-Z]/;
        var pattern3 = /[~!@\#$%<>^&*]/; 
		
		if(pw1.value.trim()==""|| pw1.value==null){
			alert("수정할 비밀번호를 입력해 주세요");
			pw1.focus();
            return false;
		}else if(pw2.value.trim()==""|| pw2.value==null){
			alert("비밀번호 확인을 입력해 주세요");
			pw2.focus();
            return false;
		}else if(!pattern1.test(pw1.value.trim())||!pattern2.test(pw1.value.trim())||!pattern3.test(pw1.value.trim())||pw1.value.trim().length<4||pw1.value.trim().length>17){
            alert("영문+숫자+특수기호 5-16자리로 구성하여야 합니다.");
            pw1.focus();
            return false;         
		}else if(name.value.trim()==""|| name.value==null){
			alert("이름을 입력해 주세요");
			name.focus();
            return false;
		}else if(nickname.value.trim()==""|| nickname.value==null){
			alert("닉네임을 입력해 주세요");
			nickname.focus();
            return false;
		}else if(addr.value.trim()==""|| addr.value==null){
			alert("주소를 입력해 주세요");
			addr.focus();
            return false;
		}else if(email.value.trim()==""|| email.value==null){
			alert("메일을 입력해 주세요");
			email.focus();
            return false;
		}else if(pw1.value.trim() != pw2.value.trim()){
			document.getElementById("pw_msg").innerHTML = "<b><font color='red'>"+"비밀번호가 다릅니다."+"</font></b>";
			pw1.focus();
			return false;
		}else if(pw1.value.trim() == pw2.value.trim()){
			document.getElementById("pw_msg").innerHTML = "비밀번호가같습니다.";
			return true; //모든값 확인 후 리턴
		}

	}
	
	
</script>
<script type="text/javascript">
	function popup(){
		window.open("user/unregister_1.jsp","_blank","width=300px, height=150px");
		
	}
</script>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script>
    <!-- 주소 API-->
    function execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var roadAddr = data.roadAddress; // 도로명 주소 변수
                var extraRoadAddr = ''; // 참고 항목 변수

                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraRoadAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                   extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraRoadAddr !== ''){
                    extraRoadAddr = ' (' + extraRoadAddr + ')';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('postcode').value = data.zonecode;
                document.getElementById("roadAddress").value = roadAddr;
                document.getElementById("jibunAddress").value = data.jibunAddress;
         
                document.getElementById("engAddress").value = data.addressEnglish;
                       
                // 참고항목 문자열이 있을 경우 해당 필드에 넣는다.
                if(roadAddr !== ''){
                    document.getElementById("extraAddress").value = extraRoadAddr;
                } else {
                    document.getElementById("extraAddress").value = '';
                }

                var guideTextBox = document.getElementById("guide");
                // 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
                if(data.autoRoadAddress) {
                    var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
                    guideTextBox.innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';
                    guideTextBox.style.display = 'block';

                } else if(data.autoJibunAddress) {
                    var expJibunAddr = data.autoJibunAddress;
                    guideTextBox.innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';
                    guideTextBox.style.display = 'block';
                } else {
                    guideTextBox.innerHTML = '';
                    guideTextBox.style.display = 'none';
                }
            }
        }).open();
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
	<div id="right" class="flex_container">
	
		<!-- 정보수정 -->
		<div class="user_list">
			<form action="mypage.do" method="post" onsubmit="return beforeSubmit();">
				<input type="hidden" name="command" value="updateUser">
				<h3 style="text-align:center">회원정보수정</h3>
				<table>
					<col width=150px><col width=300px>
					<tr>
						<td class="col1">아이디</td>
						<td class="col2"><input type="text" name="user_id" value="${dto.user_id }" readonly="readonly"></td>
					</tr>

					<tr>
						<td class="col1">현재비밀번호</td>
						<td class="col2">
							<input type="hidden" id="rPasswd" name="rPasswd" value="${dto.passwd }">
							<input type="password" id="passwd" name="passwd" maxlength="16" >
							<span id="pw_equal"></span>
						</td>
					</tr>
					<tr>
						<td class="col1">비밀번호 수정</td>
						<td class="col2">
							<input type="password" id="pw_change" name="pw_change" maxlength="16" onclick="passwdChk();">
							<p class="noti">비밀번호는<span class="num">문자,숫자,특수문자조합으로 5자리-16자리</span> 입력이 가능합니다.</p>
						</td>	
					</tr>
					<tr>
						<td class="col1">비밀번호 확인</td>
						<td class="col2">
							<input type="password" id="pw_chek" name="pw_check" maxlength="16">
							<span id="pw_msg"></span>
						</td>	
					</tr>
					<tr>
						<td class="col1">이름</td>
						<td class="col2"><input type="text" name="name" value="${dto.name }" onclick="passwdChk();"></td>
					</tr>
					<tr>
						<td class="col1">닉네임</td>
						<td class="col2"><input type="text" name="nickname" value="${dto.nickname }"></td>
					</tr>
					<tr>
						<td class="col1">이메일</td>
						<td class="col2">
							<input type="text" name="email" value="<%=dto.getEmail().split("@")[0] %>"> @ 
							<select name="dot">
								<option value="naver.com">naver.com</option>
								<option value="daum.net">daum.net</option>
								<option value="google.com">google.com</option>
							</select>
						</td>
					</tr>
					<tr>
						<td class="col1">국적</td>
						<td class="col2">
							<select name="nation">
								<option value="kr">한국</option>
								<option value="us">미국</option> 
								<option value="ch">중국</option>
								<option value="jp">일본</option>
								<option value="sp">스페인</option>
							</select>
						</td>
					</tr>
					
					<!-- 주소 API -->
					<tr>
						<td class="col1">주소</td>
						<td class="col2">
							<input type="text" id="postcode" name="postcode" placeholder="우편번호">
							<input type="button" class="btn" style="border: 2px solid grey" onclick="execDaumPostcode()" value="우편번호 찾기"><br>
							<input type="text" id="roadAddress" name="roadAddress" placeholder="도로명주소" size="60" ><br>
							<input type="hidden" id="jibunAddress" placeholder="지번주소"  size="60">
							<span id="guide" style="color:#999;display:none"></span>
							<input type="text" id="detailAddress" name="detailAddress" placeholder="상세주소"  size="60"><br>
							<input type="hidden" id="extraAddress" placeholder="참고항목"  size="60">
							<input type="hidden" id="engAddress" placeholder="영문주소"  size="60" ><br>
						</td>
					</tr>
					<tr>
						<td class="col1">성별</td>
						<td class="col2">
							<select name="gender">
								<option value="M">남자</option>
								<option value="F">여자</option>
							</select>
						</td>
					</tr>
					<tr>
						<td class="col1">나이</td>
						<td class="col2">
							<input type="number" name="age" value="${dto.age }">
						</td>
					</tr>
					<tr>
						<td class="col1">핸드폰번호</td>
						<td class="col2"><input type="text" name="phone" value=${dto.phone } ></td>
					</tr>
				</table>
				<br><br>
				<div style="text-align: center;">
					<input type="submit" class="btn" style="border: 2px solid grey" value="회원정보수정">
					<input type="button" class="btn" style="border: 2px solid grey" value="취소" onclick="location.href='index.jsp'">
				</div>
			</form>
		</div>
	</div>

	<!-- 고정(푸터) -->
	<div id="footer">
		<%@ include file="/form/footer.jsp"%>
	</div>
</body>
</html>