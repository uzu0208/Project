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
		
		// 팝업 열기 + 맨처음 댓글보기
		$(".btn_open").on("click", function() {
			//scriptlet index를 사용해서 디수의 #pop_info_?를 만들고 적용한것 <-- EL은 foreach가 전부 실행 된 후에 출력되어서 호환되지 않는다.
		 	let index = $(this).attr("title"); // title이 index값이라 클릭한 레코드의 순서를 가져오기 위한것 (EL은 실행순서가 달라서 가져올 수 없다 scriptlet tag만 가능)
			
			let fstvlNm = $("#pop_info_"+index+" #lista").attr("value"); // id값에 index를 준 이유는 foreach는 실행순서가 제일 빨라서 중간에 숫자를 증가시키거나 할 수가 없다 == i++를 넣으면 결과값이 12345678910(한글자) <-- 이렇게 나옴 index값을 id(고유)에 줘서 나눠줘야만 구별 가능
			let opar = $("#pop_info_"+index+" #listb").attr("value");
			let fstvlStartDate = $("#pop_info_"+index+" #listc").attr("value");
			let fstvlEndDate = $("#pop_info_"+index+" #listd").attr("value");
			
			$.ajax({
	               type:"get",
	               url:"commentSelect",
	               data:{
	            	   fstvlNm:fstvlNm,
	            	   opar:opar,
	            	   fstvlStartDate:fstvlStartDate,
	            	   fstvlEndDate:fstvlEndDate,
	            	   c_curPage:0 // 초기에 현재페이지를 0으로 설정 --> 이후엔 아래의 ajax사용
	               },  // 요청코드
	               dataType:'json',  //  응답받은 데이터 타입
	               success:function(data, status, xhr){
	            	   
	            	   // 받아온 데이터(json)에서 원하는 변수 저장
	            	   var c_curPage = data['c_curPage'];
	            	   var c_perPage = data['c_perPage'];
	            	   var c_totalCount = data['c_totalCount'];
	            	   var c_PageNum = c_totalCount/c_perPage;
	            	   if(c_totalCount%c_perPage!=0){c_PageNum = parseInt(c_PageNum+1);}
	            	   
	            	   console.log("c_curPage = "+c_curPage);
	            	   console.log("c_perPage = "+c_perPage);
	            	   console.log("c_totalCount = "+c_totalCount);
	            	   console.log("c_PageNum = "+c_PageNum);
	            	   
	            	   $("#pop_info_"+index+" #commenttable").empty(); // table의 내용물 지우기
 
	 	   			   for(i=0;i<c_perPage;i++){
	            		   var tbody = data['list'][i]; // 얻어온 data (Rowbounds로 걸러낸 리스트들을 순서에 따라 또 걸러내는 작업) 
	            		   
	            		   let rname = (tbody['rname']);
	            		   let comments = (tbody['comments']);
	            		   let writedate = (tbody['writedate']);
	            		   let rno = (tbody['rno']);
	            		   
	            		   // prepend로 테이블의 제일 앞부분에 이름/내용/날짜 순으로 댓글이 작성됨 perpage만큼 반복 == 해당 페이지에 보여줄 리스트들
	            		   $("#pop_info_"+index+" #commenttable").prepend("<tr><td>"+rname+"</td><td>"+comments+"</td><td>"+writedate+"</td></tr><tr><td colspan='3'>");
	            	   }
	 	   			   for(i=0;i<c_PageNum;i++){ // append로 테이블의 뒷부분에 넣어짐 == 페이징부분 
	 	   				if(i!=c_curPage){$("#pop_info_"+index+" #commenttable").append("<a data-num='"+(parseInt(i)+1)+"' title='"+index+"' class='c_pagebutton' href='#pop_info_"+index+"'> "+parseInt(i+1))+"</a>";}
	            		   else{$("#pop_info_"+index+" #commenttable").append(" "+parseInt(i+1));}
	 	   			   }
	 	   					$("#pop_info_"+index+" #commenttable").append("</td></tr>");
	 	   			   		
	            	    
	               },// end success
	               error:function(xhr, status, error){
	                    console.log("error 발생");
	               }
	            });
			
			$("#pop_info_"+index).attr("style", "block"); // 팝업을 보이게 만들어줌 (실행)
			
		});
		
  

		// 팝업 닫기
		$(".btn_close").on("click", function() {
		 	let index = $(this).attr("title");
			$("#pop_info_"+index).attr("style", "display: none"); // 팝업을 안보이게 (종료)
		});
		
		// 페이지 클릭시 == 동적으로 생성한 태그는 이 방법으로만 접근 가능함 
		$(document).on("click",".c_pagebutton", function() { // document에서 "click","동적인 클래스" 를 선언해줘야 한다.
			  
			  var index = $(this).attr("title");
			  var i = $(this).attr("data-num");
			  console.log(i);
			  
				let fstvlNm = $("#pop_info_"+index+" #lista").attr("value");
				let opar = $("#pop_info_"+index+" #listb").attr("value");
				let fstvlStartDate = $("#pop_info_"+index+" #listc").attr("value");
				let fstvlEndDate = $("#pop_info_"+index+" #listd").attr("value");
			  
				$.ajax({
		               type:"get",
		               url:"commentSelect",
		               data:{
		            	   fstvlNm:fstvlNm,
		            	   opar:opar,
		            	   fstvlStartDate:fstvlStartDate,
		            	   fstvlEndDate:fstvlEndDate,
		            	   c_curPage:i // 이 i는 맨처음 시작시 실행한 팝업열기에서 가져온것 <-- 선언했을때 태그의 data-num에 저장 / 이후 지금 메서드에서 가져온 것
		               },  // 요청코드
		               dataType:'json',  //  응답받은 데이터 타입
		               success:function(data, status, xhr){
		            	   
		            	   var c_curPage = data['c_curPage'];
		            	   var c_perPage = data['c_perPage'];
		            	   var c_totalCount = data['c_totalCount'];
		            	   
		            	   console.log("c_curPage = "+c_curPage);
		            	   console.log("c_perPage = "+c_perPage);
		            	   console.log("c_totalCount = "+c_totalCount);
		            	   
		            	   var c_PageNum = c_totalCount/c_perPage;
		            	   if(c_totalCount%c_perPage!=0){c_PageNum = parseInt(c_PageNum+1);}
		            	   
		            	   console.log("c_PageNum = "+c_PageNum);
		            	   
		            	   $("#pop_info_"+index+" #commenttable").empty(); // 테이블 비우기
	 
		            	   for(i=0;i<c_perPage;i++){
		            		   var tbody = data['list'][i];
		            		  
		            		   if(tbody!=null){ // 만약 페이지가 5페이지인데 나올 갯수가 14개면 (perpage=3) 3번쨰 실행시에 데이터가 없어서 페이지가 안나온다 == 중간에 에러가 있으면 아래 코드가 실행되지 않음 그래서 조건처리한 것.
		            			   let rname = (tbody['rname']);
			            		   let comments = (tbody['comments']);
			            		   let writedate = (tbody['writedate']);
			            		   let rno = (tbody['rno']);
		            		   $("#pop_info_"+index+" #commenttable").prepend("<tr><td>"+rname+"</td><td>"+comments+"</td><td>"+writedate+"</td></tr>");
		            		   }
		            	   }
		            	   $("#pop_info_"+index+" #commenttable").append("<tr><td colspan='3'>");
		 	   			   for(i=1;i<c_PageNum+1;i++){
		 	   				if(i!=c_curPage){$("#pop_info_"+index+" #commenttable").append("<a data-num='"+i+"' title='"+index+"' class='c_pagebutton' href='#pop_info_"+index+"'> "+parseInt(i))+"</a>";}
		            		   else{$("#pop_info_"+index+" #commenttable").append(" "+parseInt(i));}
		 	   			   }
		 	   					$("#pop_info_"+index+" #commenttable").append("</td></tr>");
		 	   			   		
		            	    
		               },// end success
		               error:function(xhr, status, error){
		                    console.log("error 발생");
		               }
		            });
			  
			  $("#pop_info_"+index+" #commenttable").empty();
			  
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
 		<!-- 미리 index를 선언해준것 (쓸데가 많다) -->
		<%  int index = 0; %> 
		<tbody>
					<h2>${pagedto.location.citykey} ${pagedto.location.city}</h2>
					
			<c:forEach var="list" items="${pagedto.list}">
			<% index++;%> <!-- pagedto의 list(MapDTO)를 반복할때 증가할 수 있게 선언 -->
					<td colspan="3">
						<div id="contentBox">
							<div id="contentBox1"><a href="#pop_info_<%=index%>" title="<%=index%>" class="btn_open">${list.fstvlNm}</a></div>
	 					
	 					<!-- 팝업 태그 -->
						<div id="pop_info_<%=index%>" class="pop_wrap" style="display: none;" >
							<div class="pop_inner">
								<p class="dsc1">${list.fstvlNm}</p>
								<p class="dsc2">${list.fstvlCo}</p>
								<p class="dsc3">전화번호 : ${list.phoneNumber}</p>
								
								<input type="hidden" id="lista" name="fstvlNm" value="${list.fstvlNm}"/>
								<input type="hidden" id="listb" name="opar" value="${list.opar}"/>
								<input type="hidden" id="listc" name="fstvlStartDate" value="${list.fstvlStartDate}"/>
								<input type="hidden" id="listd" name="fstvlEndDate" value="${list.fstvlEndDate}"/>
								
								<!-- 홈페이지 url이 www로 시작할경우 http를 붙여줘서 제대로 하이퍼링크 이동하도록 -->
								<c:if test="${(list.homepageUrl).substring(0,4)=='http'}"><p class="dsc4">홈페이지 : <a id="clickdetail" href="${list.homepageUrl}" target="_blank">${list.homepageUrl}</a></p></c:if>
								<c:if test="${(list.homepageUrl).substring(0,4)!='http'}"><p class="dsc4">홈페이지 : <a id="clickdetail" href="https://${list.homepageUrl}" target="_blank">${list.homepageUrl}</a></p></c:if>
								
								<table id="commenttable" border=1>
								</table>
								
								
								<button type="button" title="<%=index%>" class="btn_close">닫기</button>
								
								<c:if test="${not empty sessionScope.login}">
								
								<!-- /commentAdd로 보낼 데이터들 (CommentDTO) -->			
								<form action="commentAdd" method="post">					
								<input type="hidden" id="list1" name="fstvlNm" value="${list.fstvlNm}"/>
								<input type="hidden" id="list2" name="opar" value="${list.opar}"/>
								<input type="hidden" id="list3" name="fstvlStartDate" value="${list.fstvlStartDate}"/>
								<input type="hidden" id="list4" name="fstvlEndDate" value="${list.fstvlEndDate}"/>
								<input type="hidden" name="rname" value="${sessionScope.login.username}"/>
								<input type="hidden" name="curPage" value="${pagedto.curPage}"/>
								<input type="hidden" name="city" value="${pagedto.location.city}"/>
								<input type="hidden" name="province" value="${pagedto.location.province}"/>
								<input type="hidden" name="citykey" value="${pagedto.location.province}"/>
								
								<!-- /commentAdd로 보내는 태그 -->	
								<input type="text" name="comments" /><!-- 글쓴 내용 -->	
								<input type="submit" title="<%=index%>" class="btn_submit" value="댓글작성" />
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

