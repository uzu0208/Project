<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>마이페이지 비밀번호 확인</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script>
        jQuery.noConflict();

        jQuery(document).ready(function (){

            // input태그의 최대 길이 설정
            function checkMaxLengthInput(element, maxLength) {
                if (element.value.length > maxLength) {
                    element.value = element.value.substring(0, maxLength);
                }
            }

            // 뒤로 가기를 할 때 비밀번호가 채워진 상태가 되지 않도록 막기
            jQuery(window).bind("pageshow", (event) => {
                jQuery("#inputPassword").val("");
            });

            // 확인 버튼 클릭 시 비밀번호 확인
            jQuery("#checkPasswordBtn").on("click", function (){

                let password = jQuery("#inputPassword").val();

                if (!password){
                    alert("비밀번호를 입력하세요.");
                }else {
                    jQuery("#checkPasswordForm").submit();
                }
            });
        });
    </script>
</head>
<body>

<nav class="navbar navbar-expand-lg navbar-light bg-light">
    <div class="container-fluid">
        <a class="navbar-brand">마이 페이지</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
                    <a class="nav-link active" href="../main"  >main으로</a>
        </div>
    </div>
</nav>

<form action="${pageContext.request.contextPath}/checkPassword/login" method="post" id="checkPasswordForm">
    <div class="row g-3 align-items-center m-5">
        <div class="col-auto">
            <label for="inputPassword" class="col-form-label" oninput="checkMaxLengthInput(this, 20)"><strong>비밀번호</strong></label>
        </div>
        <div class="col-auto">
            <input type="password" id="inputPassword" class="form-control" aria-describedby="passwordHelpInline" name="password">
        </div>
        <div class="col-auto">
            <span id="passwordHelpInline" class="form-text">
                비밀번호를 입력해주세요.
            </span>
        </div>
        <div class="col-auto">
            <button type="button" class="btn btn-primary" id="checkPasswordBtn">확인</button>
        </div>
    </div>
</form>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
</body>
</html>
