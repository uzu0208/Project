<%@page import="com.dto.MapDTO"%>
<%@page import="com.dto.PageDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="css/main.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>

<script type="text/javascript">

	$(document).ready(function() {
		
		$(".btn_open").on("click", function() {
			//scriptlet index를 사용해서 10개의 #pop_info_?를 만들고 적용한것 <-- EL은 foreach가 전부 실행 된 후에 출력되어서 호환되지 않는다.
		 	let index = $(this).attr("title");
			$("#pop_info_"+index).attr("style", "block");
			
			console.log(a);
			
		});

		// 팝업 닫기
		$(".btn_close").on("click", function() {
		 	let index = $(this).attr("title");
			$("#pop_info_"+index).attr("style", "display: none");
		});
		
		$(".btn_submit").on("click", function() {
			
		});

	});
</script>
<style>
@import
	url('https://fonts.googleapis.com/css2?family=Gamja+Flower&display=swap')
	;

td>#contentBox {
	border: 3px solid black;
	border-radius: 15px;
	width: 500px;
	height: 200px;
	padding: 20px;
	font-weight: bold;
}
/* 이하는 전부 팝업 css */
.wrap {
	padding: 10px;
}

.btn_open {
	font-weight: bold;
	color: gray;
}

.pop_wrap {
	position: fixed;
	top: 0;
	left: 0;
	right: 0;
	bottom: 0;
	background: rgba(0, 0, 0, .5);
	font-size: 0;
	text-align: center;
}

.pop_wrap:after {
	display: inline-block;
	height: 100%;
	vertical-align: middle;
	content: '';
}

.pop_wrap .pop_inner {
	display: inline-block;
	background: #fff;
	padding: 100px 40px 40px 40px;
	width: 500px;
	height: 400px;
	vertical-align: middle;
	font-size: 15px;
}
 .pop_inner>.dsc{
 	vertical-align: middle;
 }

</style>

</head>
<body>

<c:set var="citykey" value="${pagedto.location.citykey}"></c:set>
<c:if test="${citykey==null}">
<jsp:include page="map/nationWide.jsp" flush="true" />
</c:if>
<c:if test="${citykey!=null}">
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
		<%  int index = 0; %>
		<tbody>
					<h2>${pagedto.location.citykey} ${pagedto.location.city}</h2>
					
			<c:forEach var="list" items="${pagedto.list}">
			<% index++;%>
					<td colspan="3">
						<div id="contentBox">
						 
							<div id="contentBox1"><a href="#pop_info_<%=index%>" title="<%=index%>" class="btn_open">${list.fstvlNm}</a></div>
	 					
						<div id="pop_info_<%=index%>" class="pop_wrap" style="display: none;" >
							<div class="pop_inner">
								<p class="dsc1">${list.fstvlNm}</p>
								<p class="dsc2">${list.fstvlCo}</p>
								<p class="dsc3">전화번호 : ${list.phoneNumber}</p>
								<!-- 홈페이지 url이 www로 시작할경우 http를 붙여줘서 제대로 하이퍼링크 이동하도록 -->
								<c:if test="${(list.homepageUrl).substring(0,4)=='http'}"><p class="dsc4">홈페이지 : <a id="clickdetail" href="${list.homepageUrl}" target="_blank">${list.homepageUrl}</a></p></c:if>
								<c:if test="${(list.homepageUrl).substring(0,4)!='http'}"><p class="dsc4">홈페이지 : <a id="clickdetail" href="https://${list.homepageUrl}" target="_blank">${list.homepageUrl}</a></p></c:if>
								
								<button type="button" title="<%=index%>" class="btn_close">닫기</button>
								<c:if test="${not empty sessionScope.login}">
								<form action="comment">
								<input type="text" name="commentcontent" />
								<input type="submit" title="<%=index%>" w class="btn_submit" value="댓글작성" />
								</form>
								</c:if>
							</div>
						</div>
						<br>
							<div id="contentBox2"> ${(list.fstvlStartDate).substring(0,10)}~${(list.fstvlEndDate).substring(0,10)} </div> 
							<div id="contentBox3"> ${list.opar}</div> 
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
						<a href="main?curPage=${i}&city=${city}&province=${province}&citykey=${province}">${i}</a>
					</c:if>
				</c:forEach>
			</td>
		</tr>
	</table>
	
	
	
</body>
</html>
