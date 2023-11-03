<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%-- 네비게이션바 --%>
<nav class="navbar navbar-expand-lg navbar-light bg-light">
    <div class="container-fluid">
        <a class="navbar-brand">마이 페이지</a>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav">
                <li class="nav-item">
                    <a class="nav-link active" aria-current="page" href="${pageContext.request.contextPath}/mypageHome/login">회원 정보 수정</a>
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
