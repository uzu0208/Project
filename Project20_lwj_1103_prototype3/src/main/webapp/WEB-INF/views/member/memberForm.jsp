<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
<script>
    $(document).ready(function () {

        // 비번일치 여부 확인
        $("#password2").on("keyup", function () {
            var password = $("#password").val();
            var password2 = $("#password2").val();
            var mesg = "비번 일치";
            if (password != password2) {
                mesg = "비번 불일치"
            }

            $("#idcheck").text(mesg);
        });

        // id 중복체크
        $("#idDupulicatedcheck").on("click", function () {
            // submit 비활성
            event.preventDefault();
            // ajax 연동
            $.ajax({
                type: "get",
                url: "${pageContext.request.contextPath}/MemberIdCheck",
                data: {
                    userid: $("#userid").val()
                },  // 요청코드
                dataType: 'text',  //  응답받은 데이터 타입
                success: function (data, status, xhr) {
                    console.log(data);
                    $("#result").text(data);
                },
                error: function (xhr, status, error) {
                    console.log("erro 발생");
                }
            });
        });

        // id입력 변화 시 중복체크 초기화
        $("#userid").on("keyup", function () {
            $("#result").text("");
        });

        //email 선택 시 채우기
        $("select[name=emailSite]").on("change", function () {
            $("#email2").val($(this).val());
        });

        // 모든 회원 정보가 입력된 후 submit 되도록 체크
        $("#join").on("click", function () {
            let userid = $("#userid").val();
            let password = $("#password").val();
            let password2 = $("#password2").val();
            let username = $("#username").val();
            let post = $("#sample4_postcode").val();
            let addr1 = $("#sample4_roadAddress").val();
            let addr2 = $("#sample4_jibunAddress").val();
            let phone1 = $("#phone1").val();
            let phone2 = $("#phone2").val();
            let phone3 = $("#phone3").val();
            let email1 = $("#email1").val();
            let email2 = $("#email2").val();

            if (!userid) {
                alert("아이디를 입력해주세요.");
            } else if (!password || !password2) {
                alert("비밀번호를 입력해주세요.");
            } else if (password != password2) {
                alert("비밀번호가 맞는지 확인하세요.");
            } else if (!username) {
                alert("이름을 입력하세요.");
            } else if (!post) {
                alert("우편번호를 입력하세요.");
            } else if (!addr1 && !addr2) {
                alert("주소를 입력하세요.");
            } else if (!phone1 || !phone2 || !phone3) {
                alert("휴대전화번호를 입력하세요.");
            } else if (!email1 || !email2) {
                alert("이메일을 입력하세요.");
            } else {
                $.ajax({
                    type: "get",
                    url: "${pageContext.request.contextPath}/MemberIdCheck",
                    data: {
                        userid: userid
                    },  // 요청코드
                    dataType: 'text',  //  응답받은 데이터 타입
                    success: function (data, status, xhr) {
                        if (data == "아이디 중복"){
                            alert("아이디 중복을 확인하세요.");
                        }else {
                            $("#memberForm").submit();
                        }
                    },
                    error: function (xhr, status, error) {
                        console.log("error 발생");
                    }
                });
            }
        });
    });

    // input태그의 최대 길이 설정
    function checkMaxLengthInput(element, maxLength) {
        if (element.value.length > maxLength) {
            element.value = element.value.substring(0, maxLength);
        }
    }
</script>

<div class="card col-6 text-bg-light">
    <div class="card-body">
        <div class="col-md-5">
            <form class="php-email-form aos-init aos-animate m-2" action="MemberAdd" method="post" id="memberForm">
                <div class="row">
                    <div class="form-group col-auto">
                        <label for="userid" class="form-label"><strong>아이디</strong></label><br>
                        <input type="text" class="form-control" name="userid" id="userid"
                               oninput="checkMaxLengthInput(this, 20)">
                        <small class="form-text text-muted">최대 20자</small>
                        <button class="btn btn-primary" id="idDupulicatedcheck">중복확인</button>
                        <span id="result"></span>
                    </div>
                </div>
                <div class="row">
                    <div class="form-group col-auto my-2">
                        <label for="password" class="form-label"><strong>비밀번호</strong></label><br>
                        <input type="password" name="password" id="password" oninput="checkMaxLengthInput(this, 20)">
                        <small class="form-text text-muted">최대 20자</small>
                    </div>
                </div>
                <div class="row">
                    <div class="form-group col-auto my-2">
                        <label for="password2" class="form-label"><strong>비밀번호 확인</strong></label><br>
                        <input type="password" name="password2" id="password2" oninput="checkMaxLengthInput(this, 20)">
                        <span id="idcheck"></span>
                    </div>
                </div>
                <div class="row">
                    <div class="form-group col-auto">
                        <label for="username" class="form-label"><strong>이름</strong></label><br>
                        <input type="text" name="username" oninput="checkMaxLengthInput(this, 20)" id="username">
                    </div>
                </div>
                <div class="row">
                    <div class="form-group my-2">
                        <label for="sample4_postcode"><strong>주소</strong></label>
                        <div class="row">
                            <div class="col-4">
                                <input type="text" class="form-control" name="post" id="sample4_postcode" placeholder="우편번호" oninput="checkMaxLengthInput(this, 5)">
                            </div>
                            <div class="col-10">
                                <button class="btn btn-outline-secondary" type="button" onclick="sample4_execDaumPostcode()">우편번호 찾기</button>
                            </div>
                        </div>
                        <input type="text" class="form-control" name="addr1" id="sample4_roadAddress" placeholder="도로명주소" oninput="checkMaxLengthInput(this, 40)">
                        <input type="text" class="form-control" name="addr2" id="sample4_jibunAddress" placeholder="지번주소" oninput="checkMaxLengthInput(this, 40)">
                        <small id="guide" class="form-text text-muted"></small>
                    </div>
                </div>
                <div class="row">
                    <div class="form-group my-2">
                        <label for="phone1"><strong>전화번호</strong></label>
                        <div class="input-group mb-3">
                            <select class="custom-select" name="phone1" oninput="checkMaxLengthInput(this, 3)" id="phone1">
                                <option value="010">010</option>
                                <option value="011">011</option>
                            </select>
                            <div class="input-group-prepend">
                                <span class="input-group-text">-</span>
                            </div>
                            <div class="col-3">
                                <input type="text" class="form-control" name="phone2" oninput="checkMaxLengthInput(this, 4)"
                                       id="phone2">
                            </div>
                            <div class="input-group-prepend">
                                <span class="input-group-text">-</span>
                            </div>
                            <div class="col-3">
                                <input type="text" class="form-control col-md-2" name="phone3"
                                       oninput="checkMaxLengthInput(this, 4)" id="phone3">
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="form-group my-2">
                        <label for="email1"><strong>이메일</strong></label>
                        <div class="input-group mb-3">
                            <div class="col-5">
                                <input type="text" class="form-control" name="email1"
                                       oninput="checkMaxLengthInput(this, 20)" id="email1">
                            </div>
                            <div class="input-group-prepend">
                                <span class="input-group-text">@</span>
                            </div>
                            <div class="col-5">
                                <input type="text" class="form-control" name="email2" placeholder="직접입력"
                                       oninput="checkMaxLengthInput(this, 20)" id="email2">
                            </div>

                            <select class="custom-select" name="emailSite">
                                <option value="daum.net">daum.net</option>
                                <option value="google.com">google.com</option>
                                <option value="naver.com">naver.com</option>
                            </select>

                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="form-group my-2">
                        <button type="button" class="btn btn-primary" id="join">회원가입</button>
                        <button type="reset" class="btn btn-secondary">취소</button>
                    </div>

                </div>
            </form>
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