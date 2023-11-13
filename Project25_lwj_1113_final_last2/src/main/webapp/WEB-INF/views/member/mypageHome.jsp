<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
            jQuery("#inputPassword2").val("");
        });

        // input태그의 최대 길이 설정
        function checkMaxLengthInput(element, maxLength){
            if(element.value.length > maxLength){
                element.value = element.value.substring(0, maxLength);
            }
        }

        jQuery(document).ready(function (){

            jQuery("#checkPasswordBtn").on("click", function (){

                let password = jQuery("#inputPassword").val();

                if (!password){
                    alert("비밀번호를 입력해주세요.");
                }else {
                    jQuery("#checkPasswordForm").submit();
                }
            });

            // 이메일 사이트를 선택 시 input 상자도 변경
            jQuery("#emailSite").on("change", function (){

                let emailSite = jQuery("#emailSite").val();

                jQuery("#email2").val(emailSite);
            });

            // 회원 정보 수정 버튼 클릭 시 입력한 값 확인 후 submit
            jQuery("#updateMemberInfoBtn").on("click", function (){

                let username = jQuery("#inputUsername").val();
                let post = jQuery("#sample4_postcode").val();
                let addr1 = jQuery("#sample4_roadAddress").val();
                let addr2 = jQuery("#sample4_jibunAddress").val();
                let email1 = jQuery("#email1").val();
                let email2 = jQuery("#email2").val();

                if (!username){
                    alert("이름을 입력하세요.");
                }else if (!post || post.length != 5){
                    alert("우편번호를 입력하세요.");
                }else if (!addr1){
                    alert("도로명주소를 입력하세요.");
                }else if (!addr2){
                    alert("지번주소를 입력하세요.");
                }else if (!email1 || !email2){
                    alert("이메일을 입력하세요.");
                }else {
                    jQuery("#updateMemberInfoForm").submit();
                }
            });

            // 회원 탈퇴의 모달창에서의 비밀번호 확인 버튼 클릭
            jQuery("#checkPasswordBtn2").on("click", function (){

                let password = jQuery("#inputPassword2").val();

                if (!password){

                    alert("비밀번호를 입력해주세요.");
                }else {
                    if (confirm("계정을 정말로 삭제하시겠습니까? 삭제하려면 확인을 눌러주세요.")){
                        jQuery("#checkPasswordForm2").submit();
                    }
                }
            });
        });
    </script>
</head>
<body>
    <jsp:include page="mypageTop.jsp" flush="true"/>

    <%-- select태그에서 사용하기 위한 변수--%>
    <c:set var="isSelected" value="selected='selected'"/>

    <div class="container-fluid rounded-5" style="background-color: #d0ebfa; padding-left:120px; padding-right:120px; padding-top:40px; padding-bottom:20px; margin-top: 5%; margin-left: 15%; margin-right: 15%; width: 70%;" >
        <div class="row ">
            <div class="col-2 py-4">
                <span><strong>아이디</strong></span>
            </div>
            <div class="col-4 py-4">
                <span>${sessionScope.login.userid}</span>
            </div>
        </div>
        <div class="row  ">
            <div class="col-2 py-4">
                <span><strong>비밀번호 수정</strong></span>
            </div>
            <div class="col-4 py-4">
                <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#staticBackdrop">비밀번호 수정</button>
            </div>
        </div>
        <form action="${pageContext.request.contextPath}/updateMemberInfo/login" method="get" id="updateMemberInfoForm">
            <div class="row  ">
                <div class="col-2 py-4">
                    <label for="inputUsername" class="form-label"><strong>이름</strong></label>
                </div>
                <div class="col-4 py-4">
                    <input type="text" class="form-control" value="${sessionScope.login.username}" id="inputUsername" name="username" oninput="checkMaxLengthInput(this, 20)">
                </div>
            </div>

            <div class="row  ">
                <div class="col-2 py-4">
                    <label for="sample4_postcode" class="form-label"><strong>주소</strong></label>
                </div>
                <div class="col-2 py-4">
                    <input type="text" class="form-control" name="post" id="sample4_postcode" placeholder="우편번호" oninput="checkMaxLengthInput(this, 5)"
                           value="${sessionScope.login.post}">
                </div>
                <div class="col-3 py-4">
                    <button type="button" class="btn btn-warning" onclick="sample4_execDaumPostcode()">우편번호 찾기</button>
                </div>
            </div>
            <div class="row px-lg-1">
                <div class="col-2 py-4">

                </div>
                <div class="col-5 py-1">
                    <input type="text" class="form-control" name="addr1" id="sample4_roadAddress" placeholder="도로명주소"
                           oninput="checkMaxLengthInput(this, 40)" value="${sessionScope.login.addr1}">
                </div>
                <div class="col-5 py-1">
                    <input type="text" class="form-control" name="addr2" id="sample4_jibunAddress" placeholder="지번주소"
                           oninput="checkMaxLengthInput(this, 40)" value="${sessionScope.login.addr2}">
                </div>
                <div class="col-2 py-1">
                    <small id="guide" class="form-text text-muted"></small>
                </div>
            </div>
            <div class="row py-lg-1">
                <div class="col-2 py-4">
                    <label for="email1" class="form-label"><strong>이메일</strong></label>
                </div>
                <div class="col-10 py-4">
                    <div class="input-group mb-3">
                        <div class="col-4">
                            <input type="text" class="form-control" name="email1"
                                   oninput="checkMaxLengthInput(this, 20)" id="email1" value="${sessionScope.login.email1}" disabled>
                        </div>
                        <div class="input-group-prepend">
                            <span class="input-group-text">@</span>
                        </div>
                        <div class="col-3">
                            <input type="text" class="form-control" name="email2" placeholder="직접입력"
                                   oninput="checkMaxLengthInput(this, 20)" id="email2" value="${sessionScope.login.email2}" disabled>
                        </div>
                </div>
            </div>
            <div class="row py-lg-1">
				<div class="col col-sm-8">
                    <button type="button" class="btn btn-danger" data-bs-toggle="modal" data-bs-target="#checkPasswordToDelete">회원 탈퇴</button>
                </div>
				<div class="col col-sm-2">
					<button type="button" class="btn btn-primary"
						id="updateMemberInfoBtn">회원 정보 수정</button>
				</div>
				<div class="col col-sm-2">
					<button type="button" class="btn btn-secondary"
						id="cancelUpdateMemberInfoBtn">수정 취소</button>
				</div>
			</div>
            <input type="hidden" value="${sessionScope.login.userid}" name="userid">
            <input type="hidden" value="${sessionScope.login.phone1}" name="phone1">
            <input type="hidden" value="${sessionScope.login.phone2}" name="phone2">
            <input type="hidden" value="${sessionScope.login.phone3}" name="phone3">
        </form>
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

    <div class="modal fade" id="checkPasswordToDelete" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="checkPasswordToDeleteLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="checkPasswordToDeleteLabel">비밀번호 확인</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form action="${pageContext.request.contextPath}/checkPasswordToDelete/login" method="post" id="checkPasswordForm2">
                        <p class="text-danger">계정을 정말로 삭제하시겠습니까?</p>
                        <p class="text-danger text-decoration-underline">계정을 삭제하려면 비밀번호를 입력하세요.</p>
                        <div class="row g-3 align-items-center m-5">
                            <div class="col-auto">
                                <label for="inputPassword" class="col-form-label" oninput="checkMaxLengthInput(this, 20)"><strong>비밀번호</strong></label>
                            </div>
                            <div class="col-auto">
                                <input type="password" id="inputPassword2" class="form-control" aria-describedby="passwordHelpInline2" name="password">
                            </div>
                            <div class="col-auto">
                                <span id="passwordHelpInline2" class="form-text">
                                    비밀번호를 입력해주세요.
                                </span>
                            </div>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
                    <button type="button" class="btn btn-danger" id="checkPasswordBtn2">계정 삭제</button>
                </div>
            </div>
        </div>
    </div>

    <script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
    <script>
        //본 예제에서는 도로명 주소 표기 방식에 대한 법령에 따라, 내려오는 데이터를 조합하여 올바른 주소를 구성하는 방법을 설명합니다.
        function sample4_execDaumPostcode() {
            new daum.Postcode({
                oncomplete: function (data) {
                    // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                    // 도로명 주소의 노출 규칙에 따라 주소를 조합한다.
                    // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                    var fullRoadAddr = data.roadAddress; // 도로명 주소 변수
                    var extraRoadAddr = ''; // 도로명 조합형 주소 변수

                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
                        extraRoadAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if (data.buildingName !== '' && data.apartment === 'Y') {
                        extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 도로명, 지번 조합형 주소가 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if (extraRoadAddr !== '') {
                        extraRoadAddr = ' (' + extraRoadAddr + ')';
                    }
                    // 도로명, 지번 주소의 유무에 따라 해당 조합형 주소를 추가한다.
                    if (fullRoadAddr !== '') {
                        fullRoadAddr += extraRoadAddr;
                    }

                    // 우편번호와 주소 정보를 해당 필드에 넣는다.
                    document.getElementById('sample4_postcode').value = data.zonecode; //5자리 새우편번호 사용
                    document.getElementById('sample4_roadAddress').value = fullRoadAddr;
                    document.getElementById('sample4_jibunAddress').value = data.jibunAddress;

                    // 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
                    if (data.autoRoadAddress) {
                        //예상되는 도로명 주소에 조합형 주소를 추가한다.
                        var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
                        document.getElementById('guide').innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';

                    } else if (data.autoJibunAddress) {
                        var expJibunAddr = data.autoJibunAddress;
                        document.getElementById('guide').innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';

                    } else {
                        document.getElementById('guide').innerHTML = '';
                    }
                }
            }).open();
        }
    </script>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
</body>
</html>
