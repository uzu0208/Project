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
</script>

<form action="login" method="get">
	<table>
		<tr>
			<th>아이디</th>
			<th><input type="text" name="userid" id="userid" oninput="checkMaxLengthInput(this, 20)"></th>
		</tr>
		<tr>
			<th>비밀번호</th>
			<th><input type="text" name="password" id="password" oninput="checkMaxLengthInput(this, 20)"></th>
		</tr>
		<tr>
			<th colspan="2">
				<input type="submit" value="로그인">
				<input type="reset" value="취소">
			</th>
		</tr>
	</table>

</form>



