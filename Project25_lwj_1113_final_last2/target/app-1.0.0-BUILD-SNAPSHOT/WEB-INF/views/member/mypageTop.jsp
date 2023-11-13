<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%-- 네비게이션바 --%>

	<style>
 /* Add hover effect to the button */
        #backToMain:hover {
            border: 1px solid #007bff; /* Change the color as needed */
            border-radius: 10px;
        }

	</style>
<nav class="navbar navbar-expand-lg navbar-light bg-light">
       <div class="container">
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav mr-auto">
            	<li class="nav-item"><a class="navbar-brand nav-link active">회원 정보 수정</a></li>
                 <li class="nav-item">
                        <a class="navbar-brand nav-link active" id="backToMain" href="../main"  >뒤로</a>
                    </li>
                <c:if test="${sessionScope.login.isAdmin == '1'}">
                    <li class="nav-item">
                        <a class="nav-link rounded-5" href="${pageContext.request.contextPath}/admin/admin" style="background-color:#e76464">관리자 페이지</a>
                    </li>
                </c:if>
            </ul>
        </div>
        </div>
</nav>

 