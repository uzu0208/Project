<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:choose>

	<c:when test="${pagedto.location.citykey=='강원'}">
		<jsp:include page="../map/Gangwon.jsp" flush="true" />
	</c:when>
	<c:when test="${pagedto.location.citykey=='경기'}">
		<jsp:include page="../map/Kyunggi.jsp" flush="true" />
	</c:when>
	<c:when test="${pagedto.location.citykey=='경상남도'}">
		<jsp:include page="../map/Kyungnam.jsp" flush="true" />
	</c:when>
	<c:when test="${pagedto.location.citykey=='경상북도'}">
		<jsp:include page="../map/Kyungbuk.jsp" flush="true" />
	</c:when>
	<c:when test="${pagedto.location.citykey=='광주'}">
		<jsp:include page="../map/Gwangju.jsp" flush="true" />
	</c:when>
	<c:when test="${pagedto.location.citykey=='대구'}">
		<jsp:include page="../map/Daegu.jsp" flush="true" />
	</c:when>
	<c:when test="${pagedto.location.citykey=='대전'}">
		<jsp:include page="../map/Daejeon.jsp" flush="true" />
	</c:when>
	<c:when test="${pagedto.location.citykey=='부산'}">
		<jsp:include page="../map/Busan.jsp" flush="true" />
	</c:when>
		<c:when test="${pagedto.location.citykey=='서울'}">
		<jsp:include page="../map/Seoul.jsp" flush="true" />
	</c:when>
		<c:when test="${pagedto.location.citykey=='세종'}">
		<jsp:include page="../map/Sejong.jsp" flush="true" />
	</c:when>
		<c:when test="${pagedto.location.citykey=='울산'}">
		<jsp:include page="../map/Ulsan.jsp" flush="true" />
	</c:when>
		<c:when test="${pagedto.location.citykey=='인천'}">
		<jsp:include page="../map/Incheon.jsp" flush="true" />
	</c:when>
		<c:when test="${pagedto.location.citykey=='전라남도'}">
		<jsp:include page="../map/Jeonnam.jsp" flush="true" />
	</c:when>
		<c:when test="${pagedto.location.citykey=='전라북도'}">
		<jsp:include page="../map/Jeonbuk.jsp" flush="true" />
	</c:when>
		<c:when test="${pagedto.location.citykey=='제주'}">
		<jsp:include page="../map/Jeju.jsp" flush="true" />
	</c:when>
		<c:when test="${pagedto.location.citykey=='충청남도'}">
		<jsp:include page="../map/Chungnam.jsp" flush="true" />
	</c:when>
		<c:when test="${pagedto.location.citykey=='충청북도'}">
		<jsp:include page="../map/Chungbuk.jsp" flush="true" />
	</c:when>
	
</c:choose>
 