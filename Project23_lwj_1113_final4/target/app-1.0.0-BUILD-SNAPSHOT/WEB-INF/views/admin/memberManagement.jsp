<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
    <title>회원 관리</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script type="text/javascript">
    
    $(document).ready(function(){
    		
    	$(".deleteReplyBtn").on("click",function(){
    		var no = $(this).attr("data-no");
    		console.log(no);
    		
    		 $.ajax({  
	               type:"get",
	               url:"../deleteComment",
	               data:{
	            	   rno:no
	               },  // 요청코드
	               dataType:'text',  //  응답받은 데이터 타입
	               success:function(data, status, xhr){
	            	   
	            	   console.log("삭제됨");
	            	   location.href=""; // 새로고침
	            	   
	               },// end success 
	               error:function(xhr, status, error){
	                    console.log("btn 삭제 error 발생");
	               }
	            }); // end inner ajax 
    	});

    	$("#selector").on("change",function(){
    		var val = $(this).val();
    		console.log(val);
    		if(val == 'writedate'){
    			$("#inputtip").text("YYYY-MM-DD HH:MI:SS 형식으로 쓸것");
    		}else if(val == 'fstvlStartDate' || val == 'fstvlEndDate' ){
    			$("#inputtip").text("YYYY-MM-DD 형식으로 쓸것");
    		}else { $("#inputtip").empty(); }
    	});
    	
    });// end jquery
    
    </script>
    <style>	#inputtip { display:inline; } </style>
</head>
<body>
    <jsp:include page="adminTop.jsp" flush="true"/>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
	<form action="../findByDropdown/admin"> 
		  <select class="custom-select m-2" name="option" id="selector" >
            <option value="rno">번호</option>
            <option value="rid">유저아이디</option>
            <option value="rname">유저이름</option>
            <option value="writedate">입력시간</option>
            <option value="comments">글내용</option>
            <option value="fstvlNm">축제명</option>
            <option value="opar">지역</option>
            <option value="fstvlStartDate">시작일자</option>
            <option value="fstvlEndDate">종료일자</option>
        </select>
        	<input type="text" name="contents"/><input type="submit" value="입력"/>  <p display: inline; id="inputtip"></p>
	</form>
	<table class="table">
		<tr>
			<th>번호</th>
			<th>유저아이디</th>
			<th>유저이름</th>
			<th>입력시간</th>
			<th>글내용</th>
			<th>축제명</th>
			<th>지역</th>
			<th>시작일자</th>
			<th>종료일자</th>
		</tr>
		<c:forEach items="${u_pagedto.list}" var="list">
			<tr>
				<td>${list.rno}</td>
				<td><a href="${pageContext.request.contextPath}/findUserReply/admin?rid=${list.rid}">${list.rid}</a></td>
				<td>${list.rname}</td>
				<td>${list.writedate}</td>
				<td>${list.comments}</td>
				<td>${list.fstvlNm}</td>
				<td>${list.opar}</td>
				<td>${(list.fstvlStartDate).substring(0,10)}</td>
				<td>${(list.fstvlEndDate).substring(0,10)}</td>
				<td><button class="btn btn-primary deleteReplyBtn"  data-no="${list.rno}">삭제</button></td>
			</tr>
		</c:forEach>

		<c:set var="curPage" value="${u_pagedto.c_curPage}"></c:set>
		<c:set var="perPage" value="${u_pagedto.c_perPage}"></c:set>
		<c:set var="totalCount" value="${u_pagedto.c_totalCount}"></c:set>
		<c:set var="pageNum" value="${totalCount/perPage}"></c:set>

		<c:if test="${totalCount%perPage!=0}">
			<c:set var="pageNum" value="${pageNum+1}" />
		</c:if>

		<tr>
			<td colspan="9"><c:forEach var="i" begin="1" end="${pageNum}">
					<c:if test="${i==curPage}">
						${i} 
					</c:if>
					<c:if test="${i!=curPage}">
						<c:if test="${ischanged==0}">
						<a href="${pageContext.request.contextPath}/findUserReply/admin?curPage=${i}" method="post">${i}</a>
						</c:if>
						<c:if test="${ischanged==1}">
						<a href="${pageContext.request.contextPath}/findUserReply/admin?curPage=${i}&rid=${u_pagedto.list[0].rid}" method="post">${i}</a>
						</c:if>
					</c:if>
				</c:forEach></td>
		</tr>
		<tr>
			<td colspan="9">
				<a href="${pageContext.request.contextPath}/findUserReply/admin">초기화</a>
			</td>
		</tr>

	</table>

</body>
</html>
