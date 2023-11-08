<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
<script>
	// input태그의 최대 길이 설정
	function checkMaxLengthInput(element, maxLength){
		if(element.value.length > maxLength){
			element.value = element.value.substring(0, maxLength);
		}
	}

	// 뒤로 가기를 할 때 아이디와 비밀번호가 채워진 상태가 되지 않도록 막기
	$(window).bind("pageshow", (event) => {
		$("#userid").val("");
		$("#password").val("");
	});
</script>

<form action="login" method="get" onload="noBack()">
	<table>
		<tr>
			<th>아이디</th>
			<th><input type="text" name="userid" id="userid" oninput="checkMaxLengthInput(this, 20)"></th>
		</tr>
		<tr>
			<th>비밀번호</th>
			<th><input type="password" name="password" id="password" oninput="checkMaxLengthInput(this, 20)"></th>
		</tr>
		<tr>
			<th colspan="2">
				<input type="submit" value="로그인">
				<input type="reset" value="취소">
			</th>
		</tr>
	</table>


</form>



