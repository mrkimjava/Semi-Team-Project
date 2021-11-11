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
	
.flex_container{
display: flex;
  align-items: center; /* 수직 정렬 */
  flex-direction: row; /* default: row */
  justify-content: center; /* flex direction에 대해서 정렬방식 선택 */
  margin-top: 20px;
  margin-bottom: 20px;
}	

input{
	border: 0;
	border-bottom: 2px solid lightgrey;
	width : 250px;
}

.btn {
	padding : 5px 10px;
	width:130px;
}
.btn:hover{
	background-color: grey;
}
p{
	font-size: 5pt;
}
span{
	font-size: 8pt;
}
</style>
<script type="text/javascript">
	function idChk(){
		var doc = document.getElementsByName("user_id")[0];
		if(doc.value.trim()==""|| doc.value==null){
			alert("아이디를 입력해 주세요");
		}else{
			var target = "loginController.do?command=idchk&id="+doc.value.trim();
			open(target,"","width=300,height=200"); //팝업창을 거쳐 원하는 내용을 띄어줌
		}
	}
	function id_title(){
		document.getElementsByName("user_id")[0].title ="n";
	}
	function idChkConfirm(){
		var chk = document.getElementsByName("user_id")[0].title;
		if(chk=="n"){
			alert("아이디 중복체크를 해주세요");
			document.getElementsByName("user_id")[0].focus();
		}
	}
	

	function beforeSubmit(){
		var pw1 = document.getElementsByName("passwd")[0];
		var pw2 = document.getElementsByName("pw_check")[0];
		var name = document.getElementsByName("name")[0];
		var nickname = document.getElementsByName("nickname")[0];
		var addr = document.getElementById("extraAddress");
		var email = document.getElementsByName("email")[0];

		var pattern1 = /[0-9]/;
        var pattern2 = /[a-zA-Z]/;
        var pattern3 = /[~!@\#$%<>^&*]/; 
		
		if(pw1.value.trim()==""|| pw1.value==null){
			alert("비밀번호를 입력해 주세요");
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

<title>회원가입</title>
</head>
<body>
	<!-- 고정(헤더) -->
	<div id="header">
		<%@ include file="/form/header.jsp"%>
	</div>
	

	<br>
	<div style="text-align: center;"><h2>회원가입</h2></div>
	<br>

	<!-- 메인 -->
	<div id="right" class="flex_container">
	
		<!-- 정보수정 -->
		<div class="user_list">
			<form action="loginController.do" method="post" onsubmit="return beforeSubmit()">
				<input type="hidden" name="command" value="regist">
				<table>
					<tr class="tr">
						<td>아이디</td>
						<td>
							<input type="text" name="user_id" maxlength="16" title="n" required="required" onclick="id_title();">
							<input type="button" class="btn" value="중복확인" style="border: 2px solid grey;" onclick="idChk();">
						</td>
					</tr>

					<tr class="tr">
						<td >비밀번호</td>
						<td>
							<input type="password" name="passwd" onclick="idChkConfirm();" maxlength="16" >
							<p>비밀번호는<span class="num">문자,숫자,특수문자조합으로 4자리이상</span> 입력이 가능합니다.</p>
						</td>
					</tr>
					<tr class="tr">
						<td >비밀번호 확인</td>
						<td>
							<input type="password" name="pw_check" maxlength="16">
							<span id="pw_msg"></span>
						</td>	
					</tr>
					<tr class="tr">
						<td >이름</td>
						<td><input type="text" name="name" onclick="passwdChk();"></td>
					</tr>
					<tr class="tr">
						<td >닉네임</td>
						<td><input type="text" name="nickname"></td>
					</tr>
					<tr class="tr">
						<td >이메일</td>
						<td>
							<input type="text" name="email"> @ 
							<select name="dot">
								<option value="naver.com">naver.com</option>
								<option value="daum.net">daum.net</option>
								<option value="google.com">google.com</option>
							</select>
						</td>
					</tr>
					<tr class="tr">
						<td >국적</td>
						<td>
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
					<tr class="tr">
						<td >주소</td>
						<td>
							<input type="text" id="postcode" name="postcode" placeholder="우편번호">
							<input type="button" class="btn" style="border: 2px solid grey;" onclick="execDaumPostcode()" value="우편번호 찾기"><br>
							<input type="text" id="roadAddress" name="roadAddress" placeholder="도로명주소" size="60" ><br>
							<input type="hidden" id="jibunAddress" placeholder="지번주소"  size="60">
							<span id="guide" style="color:#999;display:none"></span>
							<input type="text" id="detailAddress" name="detailAddress" placeholder="상세주소"  size="60"><br>
							<input type="hidden" id="extraAddress" placeholder="참고항목"  size="60">
							<input type="hidden" id="engAddress" placeholder="영문주소"  size="60" ><br>
						</td>
					</tr>
					<tr class="tr">
						<td >성별</td>
						<td>
							<select name="gender">
								<option value="M">남자</option>
								<option value="F">여자</option>
							</select>
						</td>
					</tr>
					<tr class="tr">
						<td >나이</td>
						<td>
							<input type="number" name="age">
						</td>
					</tr>
					<tr class="tr">
						<td >핸드폰번호</td>
						<td><input type="text" name="phone" onclick="allChk();"></td>
					</tr>
				</table>
				<br><br>
				<div style="text-align: center;">
					<input type="submit" class="btn" style="border: 2px solid grey;" value="회원가입">
					<input type="button" class="btn" style="border: 2px solid grey;" value="취소" onclick="location.href='index.jsp'">
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