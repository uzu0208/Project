<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>관리자 페이지</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script>
        // EL 표현식과 jQuery 표현식 충돌 방지
        jQuery.noConflict();

        jQuery(document).ready(function (){

            jQuery("#insert").on("click", function (){
                location.href = "${pageContext.request.contextPath}/insertForm/admin";
            });

            // 삭제 버튼 클릭 시 확인창이 뜬 후에 삭제
            jQuery(".deleteData").on("click", function (){

                let fstvlNm = jQuery(this).attr("data-fstvlNm");
                let opar = jQuery(this).attr("data-opar");
                let fstvlStartDate = jQuery(this).attr("data-fstvlStartDate");
                let fstvlEndDate = jQuery(this).attr("data-fstvlEndDate");
                let curPage = jQuery(this).attr("data-curPage");
                let city = jQuery(this).attr("data-city");
                let province = jQuery(this).attr("data-province");

                if (confirm("이 데이터를 삭제하시겠습니까? 축제명:" + fstvlNm)){
                    location.href = "${pageContext.request.contextPath}/deleteData/admin?fstvlNm=" + fstvlNm
                        + "&opar=" + opar + "&fstvlStartDate=" + fstvlStartDate + "&fstvlEndDate=" + fstvlEndDate
                        + "&curPage=" + curPage + "&city=" + city + "&province=" + province;
                }
            });

            jQuery("#searchProvince").ready( () => slectedCity()).on("change", () => slectedCity());

            // 도와 시를 검색한다.
            jQuery("#searchProvinceAndCityBtn").on("click", function (){

                jQuery("#search").submit();

            });

            // // 광역자치단체 값 선택 시 기초자치단체 값이 나오게 한다.
            function slectedCity() {
                let province = jQuery("#searchProvince").val();
                let gyeonggiCity = ["수원시", "용인시", "고양시", "성남시", "화성시", "부천시", "남양주시", "안산시", "평택시",
                    "안양시", "시흥시", "파주시", "김포시", "의정부시", "광주시", "하남시", "광명시", "군포시",
                    "양주시", "오산시", "이천시", "안성시", "구리시", "의왕시", "포천시", "여주시", "동두천시", "과천시",
                    "양평군", "가평군", "연천군"]
                let gangwonCity = ["춘천시", "원주시", "강릉시", "동해시", "태백시", "속초시", "삼척시", "홍천군", "횡성군", "영월군",
                    "평창군", "정선군", "철원군", "화천군", "양구군", "인제군", "고성군", "양양군"];
                let chungbukCity = ["청주시", "충주시", "제천시", "보은군", "옥천군", "영동군", "증평군", "진천군", "괴산군", "음성군", "단양군"];
                let chungnamCity = ["천안시", "공주시", "보령시", "아산시", "서산시", "논산시", "계룡시", "당진시", "금산군", "부여군", "서천군",
                    "청양군", "홍성군", "예산군", "태안군"];
                let jeonbukCity = ["전주시", "익산시", "군산시", "정읍시", "남원시", "김제시", "무주군", "완주군", "부안군", "고창군", "임실군",
                    "순창군", "진안군", "장수군"];
                let jeonnamCity = ["목포시", "여수시", "순천시", "나주시", "광양시", "담양군", "곡성군", "구례군", "고흥군", "보성군",
                    "화순군", "장흥군", "강진군", "해남군", "영암군", "무안군", "함평군", "영광군", "장성군", "완도군",
                    "진도군", "신안군"];
                let gyeongbukCity = ["포항시", "경주시", "김천시", "안동시", "구미시", "영주시", "영천시", "상주시", "문경시", "경산시",
                    "의성군", "청송군", "영양군", "영덕군", "청도군", "고령군", "성주군", "칠곡군", "예천군", "봉화군",
                    "울진군", "울릉군"];
                let gyeongnamCity = ["창원시", "김해시", "양산시", "진주시", "거제시", "통영시", "사천시", "밀양시", "함안군", "거창군",
                    "창녕군", "고성군", "하동군", "합천군", "남해군", "함양군", "산청군", "의령군"];


                let city;

                if (province == "경기도") {
                    city = gyeonggiCity;
                }else if (province == "강원특별자치도") {
                    city = gangwonCity;
                }else if (province == "충청북도") {
                    city = chungbukCity;
                }else if (province == "충청남도") {
                    city = chungnamCity;
                }else if (province == "전라북도") {
                    city = jeonbukCity;
                }else if (province == "전라남도") {
                    city = jeonnamCity;
                }else if (province == "경상북도") {
                    city = gyeongbukCity;
                }else if (province == "경상남도") {
                    city = gyeongnamCity;
                }else {
                    city = [];
                }

                jQuery("#searchCity").empty().append("<option></option>");

                for (let i = 0; i < city.length; i++){
                    let isSelect = "";
                    let locationCity = '<c:out value="${pagedto.location.city}"/>';

                    if (locationCity == city[i]){
                        isSelect = "selected='selected'";
                    }
                    jQuery("#searchCity").append("<option value=" + city[i] + " " + isSelect + ">" + city[i] + "</option>");
                }
            }
        });
    </script>
</head>
<style>
    table{
        table-layout: fixed;
    }

    td{
        overflow: hidden;
        text-overflow: ellipsis;
        white-space: nowrap;
    }
</style>
<body>

<c:set var="curPage" value="${pagedto.curPage}"/>
<c:set var="perPage" value="${pagedto.perPage}"/>
<c:set var="totalCount" value="${pagedto.totalCount}"/>
<c:set var="pageNum" value="${totalCount/perPage}"/>

<c:set var="city" value="${pagedto.location.city}"/>
<c:set var="province" value="${pagedto.location.province}"/>
<c:set var="searchFstvlNm" value="${pagedto.location.searchFstvlNm}"/>

<%--페이징 처리 (10페이지만 보여주고 이전과 다음을 구현)--%>
<c:set var="startPage" value="${(((curPage - 1) / perPage) - (((curPage - 1) / perPage) % 1)) * perPage + 1}"/>
<c:set var="endPage" value="${startPage + (perPage - 1)}"/>

<%-- 문자열 데이터를 숫자 데이터로 변환--%>
<fmt:parseNumber value="${startPage}" var="startPage"/>
<fmt:parseNumber value="${endPage}" var="endPage"/>

<c:if test="${totalCount % perPage != 0}">
    <c:set var="pageNum" value="${pageNum + 1}" />
</c:if>

<c:if test="${endPage > pageNum}">
    <c:set var="endPage" value="${pageNum}"/>
</c:if>

<jsp:include page="adminTop.jsp" flush="true"/>
<button type="button" class="btn btn-primary m-2" id="insert">데이터 추가</button>

<form action="${pageContext.request.contextPath}/admin/admin" method="get" id="search">
    <label for="searchProvince" class="form-label m-2">광역자치단체</label>
    <select class="custom-select m-2" name="province" id="searchProvince">
        <option></option>
        <option value="서울특별시" ${province == '서울특별시' ? 'selected="selected"' : ''}>서울특별시</option>
        <option value="인천광역시" ${province == '인천광역시' ? 'selected="selected"' : ''}>인천광역시</option>
        <option value="대전광역시" ${province == '대전광역시' ? 'selected="selected"' : ''}>대전광역시</option>
        <option value="대구광역시" ${province == '대구광역시' ? 'selected="selected"' : ''}>대구광역시</option>
        <option value="울산광역시" ${province == '울산광역시' ? 'selected="selected"' : ''}>울산광역시</option>
        <option value="부산광역시" ${province == '부산광역시' ? 'selected="selected"' : ''}>부산광역시</option>
        <option value="광주광역시" ${province == '광주광역시' ? 'selected="selected"' : ''}>광주광역시</option>
        <option value="세종특별자치시" ${province == '세종특별자치시' ? 'selected="selected"' : ''}>세종특별자치시</option>
        <option value="경기도" ${province == '경기도' ? 'selected="selected"' : ''}>경기도</option>
        <option value="강원특별자치도" ${province == '강원특별자치도' ? 'selected="selected"' : ''}>강원특별자치도</option>
        <option value="충청북도" ${province == '충청북도' ? 'selected="selected"' : ''}>충청북도</option>
        <option value="충청남도" ${province == '충청남도' ? 'selected="selected"' : ''}>충청남도</option>
        <option value="전라북도" ${province == '전라북도' ? 'selected="selected"' : ''}>전라북도</option>
        <option value="전라남도" ${province == '전라남도' ? 'selected="selected"' : ''}>전라남도</option>
        <option value="경상북도" ${province == '경상북도' ? 'selected="selected"' : ''}>경상북도</option>
        <option value="경상남도" ${province == '경상남도' ? 'selected="selected"' : ''}>경상남도</option>
    </select>
    <label for="searchCity" class="form-label m-2">기초자치단체</label>
    <select class="custom-select m-2" name="city" id="searchCity">
        <option></option>
    </select>
    <div class="mb-2 row">
        <label for="searchFstvlNm" class="form-label col-sm-1 m-2">축제명</label>
        <div class="col-sm-2">
            <input type="text" name="searchFstvlNm" class="form-control m-2" id="searchFstvlNm" value="${pagedto.location.searchFstvlNm}">
        </div>
    </div>
    <button class="btn btn-primary mx-2" id="searchProvinceAndCityBtn">검색</button>
</form>



<table class="table table-striped table-hover">
    <thead>
    <tr>
        <th>축제명</th>
        <th>개최장소</th>
        <th>축제시작일자</th>
        <th>축제종료일자</th>
        <th>데이터기준일자</th>
        <th>데이터 삭제</th>
    </tr>
    </thead>
    <tbody>
    <%--@elvariable id="pagedto" type="com.dto.PageDTO"--%>
    <c:forEach var="list" items="${pagedto.list}">
        <fmt:parseDate value="${list.fstvlStartDate}" pattern="yyyy-MM-dd" var="fstvlStartDate"/>
        <fmt:parseDate value="${list.fstvlEndDate}" pattern="yyyy-MM-dd" var="fstvlEndDate"/>
        <fmt:parseDate value="${list.referenceDate}" pattern="yyyy-MM-dd" var="referenceDate"/>

        <fmt:formatDate value="${fstvlStartDate}" pattern="yyyy-MM-dd" var="fstvlStartDate"/>
        <fmt:formatDate value="${fstvlEndDate}" pattern="yyyy-MM-dd" var="fstvlEndDate"/>
        <tr>
            <td title="${list.fstvlNm}">
                <a href="${pageContext.request.contextPath}/retrieveForm/admin?fstvlNm=${list.fstvlNm}&opar=${list.opar}&fstvlStartDate=${fstvlStartDate}&fstvlEndDate=${fstvlEndDate}&curPage=${curPage}&city=${city}&province=${province}&searchFstvlNm=${searchFstvlNm}">${list.fstvlNm}</a>
                    <%--
                        a태그 href 속성 값 (줄바꿈 시 오류 발생)
                        ${pageContext.request.contextPath}/retrieveForm/login?
                        fstvlNm=${list.fstvlNm}
                        &opar=${list.opar}
                        &fstvlStartDate=${fstvlStartDate}
                        &fstvlEndDate=${fstvlEndDate}
                        &curPage=${curPage}
                        &city=${city}
                        &province=${province}
                        &searchFstvlNm=${searchFstvlNm}
                    --%>
            </td>
            <td title="${list.opar}">${list.opar}</td>
            <td>${fstvlStartDate}</td>
            <td>${fstvlEndDate}</td>
            <td><fmt:formatDate value="${referenceDate}" pattern="yyyy-MM-dd"/></td>
                <%-- 삭제 버튼 --%>
            <td><button type="button" class="btn btn-danger deleteData" data-fstvlNm="${list.fstvlNm}" data-opar="${list.opar}"
                        data-fstvlStartDate="${fstvlStartDate}" data-fstvlEndDate="${fstvlEndDate}" data-curPage="${curPage}" data-city="${city}"
                        data-province="${province}" data-searchFstvlNm="${searchFstvlNm}">
                삭제
            </button>
            </td>
        </tr>
    </c:forEach>
    </tbody>
</table>

<nav aria-label="Page navigation example">
    <ul class="pagination">
        <c:choose>
            <c:when test="${startPage != 1}">
                <li class="page-item">
                    <a class="page-link" aria-label="Previous"
                       href="${pageContext.request.contextPath}/admin/admin?curPage=${startPage - perPage}&city=${city}&province=${province}&searchFstvlNm=${searchFstvlNm}">
                        이전
                    </a>
                </li>
            </c:when>
            <c:otherwise>
                <li class="page-item">
                    <span class="page-link text-muted">이전</span>
                </li>
            </c:otherwise>
        </c:choose>

        <c:forEach var="i" begin="${startPage}" end="${endPage}">
            <c:if test="${i == curPage}">
                <li class="page-item active" aria-current="page">
                    <span class="page-link">${i}</span>
                </li>
            </c:if>
            <c:if test="${i != curPage}">
                <li class="page-item">
                    <a class="page-link" href="${pageContext.request.contextPath}/admin/admin?curPage=${i}&city=${city}&province=${province}&searchFstvlNm=${searchFstvlNm}">
                            ${i}
                    </a>
                </li>
            </c:if>
        </c:forEach>

        <c:choose>
            <c:when test="${endPage != pageNum}">
                <li class="page-item">
                    <a class="page-link" aria-label="Previous"
                       href="${pageContext.request.contextPath}/admin/admin?curPage=${startPage + perPage}&city=${city}&province=${province}&searchFstvlNm=${searchFstvlNm}">
                        다음
                    </a>
                </li>
            </c:when>
            <c:otherwise>
                <li class="page-item">
                    <span class="page-link text-muted">다음</span>
                </li>
            </c:otherwise>
        </c:choose>
    </ul>
</nav>
<p>&nbsp;&nbsp;전체 <fmt:formatNumber maxFractionDigits="0" value="${pageNum}"/>페이지가 검색되었습니다.</p>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>

</body>
</html>
