<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="css/main.css">
		
<style>
@import
	url('https://fonts.googleapis.com/css2?family=Gamja+Flower&display=swap');

td>#contentBox {
	border: 3px solid black;
	border-radius: 15px;
	width: 500px;
	height: 200px;
	padding: 20px;
	font-weight: bold;
}

#contentBox>#contentBox2 {
	color: gray;
	font-weight: bold;
}
 
</style>

 
</head>
<body>
<c:if test="${pagedto.location.citykey==null}">
<jsp:include page="map/nationWide.jsp" flush="true" />
</c:if>
<c:if test="${pagedto.location.citykey!=null}">
<jsp:include page="choosemap/choosemap.jsp" flush="true" />
</c:if>
	<table border="0" class="table table-striped">
		<thead>
			<tr>
				<th width="100px">deptno</th>
				<th width="100px">dname</th>
				<th width="100px">loc</th>
			</tr>
			<tr><td><br></td></tr>
		</thead>
		<tbody>
			<c:forEach var="list" items="${pagedto.list}">        
					<td colspan="3">
						<div id="contentBox">
							<div id="contentBox1"><a href="">${list.fstvlNm}</a></div> 
							<br>
							<div id="contentBox2"> ${list.opar}</div> 
							<div id="contentBox3"> ${list.phoneNumber}</div> 
							 
						</div><br>
					</td>
				</tr>
			</c:forEach>
		</tbody>

		<c:set var="curPage" value="${pagedto.curPage}"></c:set>
		<c:set var="perPage" value="${pagedto.perPage}"></c:set>
		<c:set var="totalCount" value="${pagedto.totalCount}"></c:set>
		<c:set var="pageNum" value="${totalCount/perPage}"></c:set>
		
		<c:set var="city" value="${pagedto.location.city}"></c:set>
		<c:set var="province" value="${pagedto.location.province}"></c:set>
		
		<c:if test="${totalCount%perPage!=0}">
			<c:set var="pageNum" value="${pageNum+1}" />
		</c:if>

		<tr>
			<td colspan="3">
				<c:forEach var="i" begin="1" end="${pageNum}">
					<c:if test="${i==curPage}">
						${i}
					</c:if>
					<c:if test="${i!=curPage}">
						<a href="main?curPage=${i}&city=${city}&province=${province}">${i}</a>
					</c:if>
				</c:forEach>
			</td>
		</tr>
	</table>
	
	<form action="search">
		<input type="submit" name="지역 찾기">
	</form>
	
	
</body>
</html>
