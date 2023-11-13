<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
<title>회원가입</title>
    <style>
        #logo{
            font-family: 'Do Hyeon', sans-serif;
            font-weight: bold;
            font-size: 25px;
            color: #6c757d;
            line-height: 3;
        }
    </style>
</head>
<body>

    <div class="row">
        <div class="col-5 fs-3 text-bg-light">
            <a href="${pageContext.request.contextPath}/main" class="text-decoration-none"><img src="images/logo.png" width="70px" height="70px"><span id="logo">NADURI</span></a>
        </div>
        <div class="text-bg-light col">
            <h1>회원등록 화면입니다</h1>
        </div>
    </div>

<jsp:include page="member/memberForm.jsp" flush="true" />
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
</body>
</html>