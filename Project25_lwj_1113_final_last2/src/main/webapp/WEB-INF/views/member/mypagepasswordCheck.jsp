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
    <style type="text/css">
    	#backToMain:hover {
            border: 1px solid #007bff; /* Change the color as needed */
            border-radius: 10px;
        }
    </style>
</head>
<body>

<nav class="navbar navbar-light navbar-expand-lg bg-light">
	<div class="container">
                <div class="collapse navbar-collapse" id="navbarResponsive">
                <ul class="navbar-nav mr-auto">
        <li><a class="navbar-brand nav-link active">마이 페이지</a></li>
        <li><a class="navbar-brand nav-link active" id="backToMain" href="../main"  >뒤로</a></li>
                    </ul>
                    </div>
    </div>
</nav>

<form action="${pageContext.request.contextPath}/checkPassword/login" method="post" id="checkPasswordForm">
    <div class="row g-3 align-items-center position-absolute top-50 start-50 translate-middle" >
        <div class="col-auto">
            <label for="inputPassword" class="col-form-label" oninput="checkMaxLengthInput(this, 20)"><h4>비밀번호를 입력해주세요</h4></label>
        </div>
        <div class="col-auto input-group input-group-lg">
            <input type="password" id="inputPassword" class="form-control" aria-describedby="passwordHelpInline" name="password">
            <button type="button" class="btn btn-primary" id="checkPasswordBtn">확인</button>
        </div>
    </div>
</form>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
</body>
</html>
