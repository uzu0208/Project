<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
 <form class="box">
        <h1>What are you looking for?</h1>
        <input type="text" placeholder="원하는 지역을 검색하세요.">
        <input type="submit" value="검색">
    </form>
    <!-- 로그인 시 버튼 변경 -->
    <c:choose>
		<c:when test="${empty sessionScope.login}">
			<form class="login" action="loginUI">
				<input type="submit" value="로그인" onclick="">
			</form>

			<form class="join" action="memberUI">
				<input type="submit" value="회원가입" onclick="">
			</form>

			<form class="backToMain" action="main">
				<input type="submit" value="뒤로">
			</form>
		</c:when>
		<c:otherwise>
			<form class="login" action="">
				<input type="submit" value="mypage" onclick="">
			</form>

			<form class="join" action="logout/login">
				<input type="submit" value="로그아웃" onclick="">
			</form>

			<form class="backToMain" action="main">
				<input type="submit" value="뒤로">
			</form>
		</c:otherwise>
	</c:choose>
</body>
</html>