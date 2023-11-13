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
    <!-- 로그인 시 버튼 변경 -->
    <c:choose>
        <c:when test="${empty sessionScope.login}">
         <li class="nav-item">
            
<!-- Button trigger modal -->
<button type="button" class="btn " data-bs-toggle="modal" data-bs-target="#exampleModal">
  로그인
</button>

		</li>
		 <li class="nav-item">
            <form class="join" action="memberUI">
                <input type="submit" value="회원가입" style="color:black"   class="btn " onclick="">
            </form>
         </li>
        </c:when>
        <c:otherwise>
        
        	<c:if test="${sessionScope.login.isAdmin==1}">
        		<form class="login" action="${pageContext.request.contextPath}/admin/admin">
                	<input type="submit" value="관리자 페이지" style="color:white" class="btn btn-danger" onclick="">
            	</form>
        	</c:if>
        	
        	<c:if test="${sessionScope.login.isAdmin!=1}">
        		<form class="login" action="mypage/login">
                	<input type="submit" value="마이페이지" style="color:black" class="btn " onclick="">
            	</form>
        	</c:if>

            <form class="join" action="logout/login">
                <input type="submit" value="로그아웃" style="color:black"  class="btn " onclick="">
            </form>
        </c:otherwise>
    </c:choose>

    <!-- Include Bootstrap JS (optional, for some components) -->
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>