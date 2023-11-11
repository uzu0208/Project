<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>비밀 번호 변경</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script>
        jQuery.noConflict();

        // input태그의 최대 길이 설정
        function checkMaxLengthInput(element, maxLength){
            if(element.value.length > maxLength){
                element.value = element.value.substring(0, maxLength);
            }
        }

        jQuery(document).ready(function (){

            // 뒤로 가기를 할 때 비밀번호가 채워진 상태가 되지 않도록 막기
            jQuery(window).bind("pageshow", (event) => {
                jQuery("#inputPassword").val("");
                jQuery("#inputPasswordCheck").val("");
                if (event.persist){
                    window.history.forward();
                }
            });

            // 비밀번호 수정 버튼 클릭 시 비밀번호 입력한 것과 비밀번호 확인 input이 같은 지 확인하고 비밀번호가 기존과 같은 지 확인하고 비밀번호 수정
            jQuery("#memberPasswordUpdateBtn").on("click", function (){

                let password = jQuery("#inputPassword").val();
                let passwordCheck = jQuery("#inputPasswordCheck").val();

                if (!password || !passwordCheck){
                    alert("비밀번호를 입력하세요.");
                }else if (password != passwordCheck){
                    alert("비밀번호가 맞지 않습니다. 비밀번호를 다시 확인하세요.")
                }else {
                    jQuery("#memberPasswordUpdateForm").submit();
                }
            });

        });
    </script>
</head>
<body>
    <jsp:include page="mypageTop.jsp" flush="true"/>

    <div class="container mx-3 my-5 rounded-3" style="background-color: #d0ebfa">
        <form action="${pageContext.request.contextPath}/memberUpdatePassword/login" method="post" class="my-3" id="memberPasswordUpdateForm">
            <div class="row">
                <div class="col-4">
                    <div class="mb-3">
                        <label for="inputPassword" class="form-label"><strong>바꿀 비밀번호 입력</strong></label>
                        <input type="password" class="form-control" id="inputPassword" name="password" oninput="checkMaxLengthInput(this, 20)" aria-describedby="passwordHelp">
                        <div id="passwordHelp" class="form-text">비밀번호는 최대 20자입니다.</div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-4">
                    <div class="mb-3">
                        <label for="inputPasswordCheck" class="form-label"><strong>비밀번호 확인</strong></label>
                        <input type="password" class="form-control" id="inputPasswordCheck" oninput="checkMaxLengthInput(this, 20)">
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-2">
                    <div class="mb-3">
                        <button type="button" class="btn btn-primary" id="memberPasswordUpdateBtn">비밀번호 수정</button>
                    </div>
                </div>
            </div>
            <input type="hidden" value="${sessionScope.login.userid}" name="userid">
        </form>
    </div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
</body>
</html>
