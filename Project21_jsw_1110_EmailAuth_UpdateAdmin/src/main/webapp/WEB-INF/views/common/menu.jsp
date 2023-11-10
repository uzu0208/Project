<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
  <style>
    @import url('https://fonts.googleapis.com/css2?family=Gamja+Flower&display=swap');
  </style>
</head>
        

        
<body>
  <form class="picture">
                    <h1>Multicampus</h1>
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
				<input type="submit" value="main">
			</form>
		</c:when>
		<c:otherwise>
			<form class="login" action="mypage/login">
				<input type="submit" value="mypage" onclick="">
			</form>

			<form class="join" action="logout/login">
				<input type="submit" value="로그아웃" onclick="">
			</form>

			<form class="backToMain" action="main">
				<input type="submit" value="main">
			</form>
		</c:otherwise>
	</c:choose>
	
	 
                <form class="box">
                    <h1>Welcome To Our Homepage!</h1>
                </form>

                <form class="choice">
                    <h4>원하는 지역을 선택하세요.</h4>
                </form>
</body>
</html>