<%--@elvariable id="mapdto" type="com.dto.MapDTO"--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>축제 데이터 수정</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script>
        jQuery.noConflict();

        jQuery(document).ready(function (){

            // 축제내용, 주관기관, 주최기관, 도로명주소 또는 지번주소, 제공기관코드는 반드시 입력
            jQuery("#updateData").on("click", function () {
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
                    jQuery("#updateDateForm").submit();
                }
            });

            jQuery("#goBack").on("click", function (){

                location.href = "${pageContext.request.contextPath}/admin/admin/?curPage=${curPage}&city=${city}&province=${province}&fstvlNm=${fstvlNm}";
            });
        });
    </script>
</head>
<body>
    <nav class="navbar bg-body-tertiary px-3 mb-3">
        <a class="navbar-brand">축제 데이터 수정</a>
    </nav>

    <%-- 축제시작일자, 축제종료일자,데이터기준일자 날짜 형식 변환 --%>
    <fmt:parseDate value="${mapdto.fstvlStartDate}" pattern="yyyy-MM-dd" var="fstvlStartDate"/>
    <fmt:parseDate value="${mapdto.fstvlEndDate}" pattern="yyyy-MM-dd" var="fstvlEndDate"/>
    <fmt:parseDate value="${mapdto.referenceDate}" pattern="yyyy-MM-dd" var="referenceDate"/>

    <fmt:formatDate value="${fstvlStartDate}" pattern="yyyy-MM-dd" var="fstvlStartDate"/>
    <fmt:formatDate value="${fstvlEndDate}" pattern="yyyy-MM-dd" var="fstvlEndDate"/>
    <fmt:formatDate value="${referenceDate}" pattern="yyyy-MM-dd" var="referenceDate"/>

    <form action="${pageContext.request.contextPath}/updateData/admin" method="post" id="updateDateForm">
        <div class="m-3">
            <label for="fstvlNm" class="form-label"><strong>축제명</strong></label>
            <input class="form-control" type="text" id="fstvlNm" value="${mapdto.fstvlNm}" name="fstvlNm" readonly>
        </div>
        <div class="m-3">
            <label for="opar" class="form-label"><strong>개최장소</strong></label>
            <input class="form-control" type="text" id="opar" value="${mapdto.opar}" name="opar" readonly>
        </div>
        <div class="m-3">
            <label for="fstvlStartDate" class="form-label"><strong>축제시작일자</strong></label>
            <input class="form-control" type="text" id="fstvlStartDate" value="${fstvlStartDate}" name="fstvlStartDate" readonly>
        </div>
        <div class="m-3">
            <label for="fstvlEndDate" class="form-label"><strong>축제종료일자</strong></label>
            <input class="form-control" type="text" id="fstvlEndDate" value="${fstvlEndDate}" name="fstvlEndDate" readonly>
        </div>
        <div class="m-3">
            <label for="fstvlCo" class="form-label"><strong>축제내용</strong></label>
            <input class="form-control" type="text" id="fstvlCo" name="fstvlCo" value="${mapdto.fstvlCo}">
        </div>
        <div class="m-3">
            <label for="mnnst" class="form-label"><strong>주관기관</strong></label>
            <input class="form-control" type="text" id="mnnst" name="mnnst" value="${mapdto.mnnst}">
        </div>
        <div class="m-3">
            <label for="auspcInstt" class="form-label"><strong>주최기관</strong></label>
            <input class="form-control" type="text" id="auspcInstt" name="auspcInstt" value="${mapdto.auspcInstt}">
        </div>
        <div class="m-3">
            <label for="suprtInstt" class="form-label"><strong>후원기관</strong></label>
            <input class="form-control" type="text" id="suprtInstt" name="suprtInstt" value="${mapdto.suprtInstt}">
        </div>
        <div class="m-3">
            <label for="phoneNumber" class="form-label"><strong>전화번호</strong></label>
            <input class="form-control" type="text" id="phoneNumber" name="phoneNumber" value="${mapdto.phoneNumber}">
        </div>
        <div class="m-3">
            <label for="homepageUrl" class="form-label"><strong>홈페이지주소</strong></label>
            <input class="form-control" type="text" id="homepageUrl" name="homepageUrl" value="${mapdto.homepageUrl}">
        </div>
        <div class="m-3">
            <label for="relateInfo" class="form-label"><strong>관련정보</strong></label>
            <input class="form-control" type="text" id="relateInfo" name="relateInfo" value="${mapdto.relateInfo}">
        </div>
        <div class="m-3">
            <label for="rdnmadr" class="form-label"><strong>소재지도로명주소</strong></label>
            <input class="form-control" type="text" id="rdnmadr" name="rdnmadr" value="${mapdto.rdnmadr}">
        </div>
        <div class="m-3">
            <label for="lnmadr" class="form-label"><strong>소재지지번주소</strong></label>
            <input class="form-control" type="text" id="lnmadr" name="lnmadr" value="${mapdto.lnmadr}">
        </div>
        <div class="m-3">
            <label for="latitude" class="form-label"><strong>위도</strong></label>
            <input class="form-control" type="text" id="latitude" name="latitude" value="${mapdto.latitude}">
        </div>
        <div class="m-3">
            <label for="longitude" class="form-label"><strong>경도</strong></label>
            <input class="form-control" type="text" id="longitude" name="longitude" value="${mapdto.longitude}">
        </div>
        <div class="m-3">
            <label for="referenceDate" class="form-label"><strong>데이터기준일자</strong></label>
            <input class="form-control" type="text" id="referenceDate" name="referenceDate" value="${referenceDate}" readonly>
        </div>
        <div class="m-3">
            <label for="insttCode" class="form-label"><strong>제공기관코드</strong></label>
            <input class="form-control" type="text" id="insttCode" name="insttCode" value="${mapdto.insttCode}">
        </div>
        <button type="button" class="btn btn-primary m-3" id="updateData">변경</button>
        <button type="button" class="btn btn-secondary" id="goBack">뒤로가기</button>

        <input type="hidden" name="curPage" value="${curPage}">
        <input type="hidden" name="city" value="${city}">
        <input type="hidden" name="province" value="${province}">
        <input type="hidden" name="searchFstvlNm" value="${searchFstvlNm}">
    </form>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
</body>
</html>
