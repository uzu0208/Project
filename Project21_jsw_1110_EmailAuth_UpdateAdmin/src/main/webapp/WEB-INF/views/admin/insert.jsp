<%@ page import="java.util.Date" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>축제 데이터 추가</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

    <script>
        jQuery.noConflict();

        jQuery(document).ready(function (){

            // 기본키 중복 체크
            jQuery("#duplicatedCheck").on("click", function (){
                // submit 비활성
                event.preventDefault();

                let fstvlNm = jQuery("#fstvlNm").val();
                let opar = jQuery("#opar").val();
                let fstvlStartDate = jQuery("#fstvlStartDate").val();
                let fstvlEndDate = jQuery("#fstvlEndDate").val();

                // 하나라도 입력되지 않으면 ajax 실행 X
                if (!fstvlNm || !opar || !fstvlStartDate || !fstvlEndDate){
                    alert("입력한 값을 다시 확인하세요.")
                }else {
                    // ajax 연동
                    jQuery.ajax({
                        type: "get",
                        url: "${pageContext.request.contextPath}/festivalDuplicatedCheck",
                        data: {
                            fstvlNm: fstvlNm,
                            opar: opar,
                            fstvlStartDate: fstvlStartDate,
                            fstvlEndDate: fstvlEndDate
                        },
                        dataType: "text",
                        success: function (data, status, xhr) {
                            jQuery("#result").text(data);
                        },
                        error: function (xhr, status, error) {
                            console.log(error);
                        }
                    });
                }
            });

            //   값 변경 시 중복 체크 초기화
            jQuery(".result-check").on("keyup", function () {
                jQuery("#result").text("");
            });
            jQuery(".result-checkDate").on("change", function (){
                jQuery("#result").text("");
            });

            // 축제명, 개최장소, 축제시작일자, 축제종료일자, 축제내용, 주관기관, 주최기관, 도로명주소 또는 지번주소, 제공기관코드는 반드시 입력
            // 또한 중복 체크 필수
            jQuery("#insertData").on("click", function () {
                let fstvlNm = jQuery("#fstvlNm").val();
                let opar = jQuery("#opar").val();
                let fstvlStartDate = jQuery("#fstvlStartDate").val();
                let fstvlEndDate = jQuery("#fstvlEndDate").val();
                let fstvlCo = jQuery("#fstvlCo").val();
                let mnnst = jQuery("#mnnst").val();
                let auspcInstt = jQuery("#auspcInstt").val();
                let rdnmadr = jQuery("#rdnmadr").val();
                let lnmadr = jQuery("#lnmadr").val();
                let insttCode = jQuery("#insttCode").val();

                if (!fstvlNm){
                    alert("축제명을 입력해주세요.");
                }else if (!opar){
                    alert("개최장소를 입력해주세요.");
                }else if (!fstvlStartDate){
                    alert("축제시작일자를 입력해주세요.");
                }else if (!fstvlEndDate){
                    alert("축제종료일자를 입력해주세요.");
                }else if (!fstvlCo){
                    alert("축제내용을 입력해주세요.");
                }else if (!mnnst){
                    alert("주관기관을 입력해주세요.");
                }else if (!auspcInstt){
                    alert("주최기관을 입력해주세요.");
                }else if (!rdnmadr && !lnmadr){
                    alert("소재지도로명주소 또는 소재지지번주소를 입력해주세요.");
                }else if (!insttCode){
                    alert("제공기관코드를 입력해주세요.");
                }else {
                    jQuery.ajax({
                        type: "get",
                        url: "${pageContext.request.contextPath}/festivalDuplicatedCheck",
                        data: {
                            fstvlNm: fstvlNm,
                            opar: opar,
                            fstvlStartDate: fstvlStartDate,
                            fstvlEndDate: fstvlEndDate
                        },
                        dataType: "text",
                        success: function (data, status, xhr) {
                            if (data == "중복 있음"){
                                alert("축제명, 개최장소, 축제시작일자, 축제종료일자가 모두 겹치는 데이터가 존재합니다.");
                            }else {
                                jQuery("#insertDataForm").submit();
                            }
                        },
                        error: function (xhr, status, error) {
                            console.log(error);
                        }
                    });
                }
            });

            jQuery("#goBack").on("click", function (){

                location.href = "${pageContext.request.contextPath}/admin/admin";
            });
        });
    </script>
</head>
<body>

<c:set var="now" value="<%= new Date() %>"/>

<nav class="navbar bg-body-tertiary px-3 mb-3">
    <a class="navbar-brand">축제 데이터 추가</a>
</nav>

<form action="${pageContext.request.contextPath}/insertData/admin" method="post" id="insertDataForm">
    <div class="m-3">
        <label for="fstvlNm" class="form-label"><strong>축제명</strong></label>
        <input class="form-control result-check" type="text" id="fstvlNm" name="fstvlNm">
    </div>
    <div class="m-3">
        <label for="opar" class="form-label"><strong>개최장소</strong></label>
        <input class="form-control result-check" type="text" id="opar" name="opar">
    </div>
    <div class="m-3">
        <label for="fstvlStartDate" class="form-label"><strong>축제시작일자</strong></label>
        <input class="form-control result-checkDate" type="date" id="fstvlStartDate" name="fstvlStartDate">
    </div>
    <div class="m-3">
        <label for="fstvlEndDate" class="form-label"><strong>축제종료일자</strong></label>
        <input class="form-control result-checkDate" type="date" id="fstvlEndDate" name="fstvlEndDate">
    </div>
    <button type="button" id="duplicatedCheck" class="btn btn-primary m-3">중복 체크</button>
    <span id="result" class="m-3"></span>
    <div class="m-3">
        <label for="fstvlCo" class="form-label"><strong>축제내용</strong></label>
        <input class="form-control" type="text" id="fstvlCo" name="fstvlCo">
    </div>
    <div class="m-3">
        <label for="mnnst" class="form-label"><strong>주관기관</strong></label>
        <input class="form-control" type="text" id="mnnst" name="mnnst">
    </div>
    <div class="m-3">
        <label for="auspcInstt" class="form-label"><strong>주최기관</strong></label>
        <input class="form-control" type="text" id="auspcInstt" name="auspcInstt">
    </div>
    <div class="m-3">
        <label for="suprtInstt" class="form-label"><strong>후원기관</strong></label>
        <input class="form-control" type="text" id="suprtInstt" name="suprtInstt">
    </div>
    <div class="m-3">
        <label for="phoneNumber" class="form-label"><strong>전화번호</strong></label>
        <input class="form-control" type="text" id="phoneNumber" name="phoneNumber">
    </div>
    <div class="m-3">
        <label for="homepageUrl" class="form-label"><strong>홈페이지주소</strong></label>
        <input class="form-control" type="text" id="homepageUrl" name="homepageUrl">
    </div>
    <div class="m-3">
        <label for="relateInfo" class="form-label"><strong>관련정보</strong></label>
        <input class="form-control" type="text" id="relateInfo" name="relateInfo">
    </div>
    <div class="m-3">
        <label for="rdnmadr" class="form-label"><strong>소재지도로명주소</strong></label>
        <input class="form-control" type="text" id="rdnmadr" name="rdnmadr">
    </div>
    <div class="m-3">
        <label for="lnmadr" class="form-label"><strong>소재지지번주소</strong></label>
        <input class="form-control" type="text" id="lnmadr" name="lnmadr">
    </div>
    <div class="m-3">
        <label for="latitude" class="form-label"><strong>위도</strong></label>
        <input class="form-control" type="number" id="latitude" name="latitude">
    </div>
    <div class="m-3">
        <label for="longitude" class="form-label"><strong>경도</strong></label>
        <input class="form-control" type="number" id="longitude" name="longitude">
    </div>
    <div class="m-3">
        <label for="referenceDate" class="form-label"><strong>데이터기준일자</strong></label>
        <input class="form-control" type="text" id="referenceDate" name="referenceDate" value="<fmt:formatDate value='${now}' pattern='yyyy-MM-dd'/>" readonly>
    </div>
    <div class="m-3">
        <label for="insttCode" class="form-label"><strong>제공기관코드</strong></label>
        <input class="form-control" type="text" id="insttCode" name="insttCode">
    </div>
    <button type="button" class="btn btn-primary m-3" id="insertData">추가</button>
    <button type="button" class="btn btn-secondary" id="goBack">뒤로가기</button>
</form>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
</body>
</html>
