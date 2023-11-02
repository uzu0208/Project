<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script>
        jQuery.noConflict();

        // 뒤로 가기를 할 때 비밀번호가 채워진 상태가 되지 않도록 막기
        jQuery(window).bind("pageshow", (event) => {
            jQuery("#inputPassword").val("");
        });

        jQuery(document).ready(function (){

            jQuery("#checkPasswordBtn").on("click", function (){

                let password = jQuery("#inputPassword").val();

                if (!password){
                    alert("비밀번호를 입력해주세요.");
                }else {
                    jQuery("#checkPasswordForm").submit();
                }
            });
        });
    </script>
</head>
<body>
    <jsp:include page="mypageTop.jsp" flush="true"/>

    <div class="container mx-3 rounded-5 my-3" style="background-color: #d0ebfa" >
        <div class="row mx-lg-1">
            <div class="col-3 my-5">
                <span><strong>아이디</strong></span>
            </div>
            <div class="col-4 my-5">
                <span>${sessionScope.login.userid}</span>
            </div>
        </div>
        <div class="row mx-lg-1">
            <div class="col-3 my-5">
                <span><strong>비밀번호 수정</strong></span>
            </div>
            <div class="col-4 my-5">
                <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#staticBackdrop">비밀번호 수정</button>
            </div>
        </div>
    </div>

    <div class="modal fade" id="staticBackdrop" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="staticBackdropLabel">비밀번호 확인</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
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
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
                    <button type="button" class="btn btn-primary" id="checkPasswordBtn">확인</button>
                </div>
            </div>
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
</body>
</html>
