<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%-- 네비게이션바 --%>

<style>
/* Add hover effect to the button */
a:hover {
	border: 1px solid #007bff; /* Change the color as needed */
	border-radius: 10px;
}
</style>


<nav class="navbar navbar-expand-lg navbar-light bg-light">
    <div class="container-fluid">
        <span class="navbar-brand">관리자 페이지</span>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav">
                <li class="nav-item">
                    <a class="nav-link active" aria-current="page" href="${pageContext.request.contextPath}/mypageHome/login">마이 페이지</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link active" aria-current="page" href="${pageContext.request.contextPath}/admin/admin">축제 데이터 수정</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/findUserReply/admin">회원 관리</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link active" href="../main"  >메인</a>
                </li>
            </ul>
        </div>
    </div>
</nav>
