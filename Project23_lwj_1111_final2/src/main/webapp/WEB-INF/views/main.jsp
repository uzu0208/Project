<%@page import="com.dto.MemberDTO"%>
<%@page import="com.dto.MapDTO"%>
<%@page import="com.dto.PageDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
  <head>
     <meta charset="UTF-8"/>
     <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
     <meta name="description" content="" />
     <meta name="author" content="" />
     <title>MainPage</title>
        <!-- Favicon-->
        <link rel="icon" type="image/x-icon" href="images/favicon.ico" />
        <!-- Google fonts-->
        <link href="https://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet" type="text/css" />
        <link href="https://fonts.googleapis.com/css?family=Roboto+Slab:400,100,300,700" rel="stylesheet" type="text/css" />
        <link href="https://fonts.googleapis.com/css2?family=Do+Hyeon&family=Noto+Sans+KR:wght@200&display=swap" rel="stylesheet">
      	<link href="https://fonts.googleapis.com/css2?family=Noto+Serif+KR:wght@700&display=swap" rel="stylesheet">
    
        <!-- Core theme CSS (includes Bootstrap)-->
        <link rel="stylesheet" href="css/main.css?3">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">

        <!-- Font Awesome icons (free version)-->
        <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
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
	            	   
	            	   
	            	   $("#pop_info_"+index+" #commenttable").empty(); // table의 내용물 지우기
 
	 	   			   for(i=0;i<c_perPage;i++){
	            		   var tbody = data['list'][i]; // 얻어온 data (Rowbounds로 걸러낸 리스트들을 순서에 따라 또 걸러내는 작업) 
	            		   let rname = (tbody['rname']);
	            		   let comments = (tbody['comments']);
	            		   let writedate = (tbody['writedate']);
	            		   let rno = (tbody['rno']);
	            		   let rid = (tbody['rid']);
	            		   // append로 테이블의 제일 앞부분에 이름/내용/날짜 순으로 댓글이 작성됨 perpage만큼 반복 == 해당 페이지에 보여줄 리스트들
	            		   $("#pop_info_"+index+" #commenttable").append("<tr><td>"+rname+"</td><td>"+comments+"</td><td>"+writedate+"</td><td><button id='deletebtn"+i+"' class='deletebtn' data-num='"+rid+"' data-no='"+rno+"'>삭제</button></td></tr>");
	            	   }
	 	   			 $("#pop_info_"+index+" #commenttable").append("<tr><td colspan='3'>");
	 	   			   for(i=0;i<c_PageNum;i++){ // append로 테이블의 뒷부분에 넣어짐 == 페이징부분 
	 	   				if(i!=c_curPage){$("#pop_info_"+index+" #commenttable").append("<a data-num='"+(parseInt(i)+1)+"' title='"+index+"' class='c_pagebutton' href='#pop_info_"+index+"'> "+parseInt(i+1))+"</a>";}
	            		   else{$("#pop_info_"+index+" #commenttable").append(" "+parseInt(i+1));}
	 	   			   }
	 	   					$("#pop_info_"+index+" #commenttable").append("</td></tr>");
	 	   			   		
	            	    
	               },// end success 
	               error:function(xhr, status, error){
	                    console.log("first commentSelect error 발생");
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
		            	   
		            	   var c_PageNum = c_totalCount/c_perPage;
		            	   if(c_totalCount%c_perPage!=0){c_PageNum = parseInt(c_PageNum+1);}
		            	   
		            	   $("#pop_info_"+index+" #commenttable").empty(); // 테이블 비우기
	 
		            	   for(i=0;i<c_perPage;i++){
		            		   var tbody = data['list'][i];
		            		  
		            		   if(tbody!=null){ // 만약 페이지가 5페이지인데 나올 갯수가 14개면 (perpage=3) 3번쨰 실행시에 데이터가 없어서 페이지가 안나온다 == 중간에 에러가 있으면 아래 코드가 실행되지 않음 그래서 조건처리한 것.
		            			   let rname = (tbody['rname']);
		            			   let rid = (tbody['rid']);
			            		   let comments = (tbody['comments']);
			            		   let writedate = (tbody['writedate']);
			            		   let rno = (tbody['rno']);
		            		   $("#pop_info_"+index+" #commenttable").append("<tr><td>"+rname+"</td><td>"+comments+"</td><td>"+writedate+"</td><td><button id='deletebtn"+i+"' class='deletebtn' data-no='"+rno+"' data-num='"+rid+"' >삭제</button></td></tr>");
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
		                    console.log("commentSelect page error 발생");
		               }
		            });
			  
			  $("#pop_info_"+index+" #commenttable").empty();
			  
		});
		
		// 삭제 버튼 생성시
		$(document).on("click",".deletebtn", function(){
			
			var btnid = $(this).attr("data-num");
			var btnno = $(this).attr("data-no");
			var btnname = $(this).attr("id");
			
			$.ajax({
	               type:"get",
	               url:"Idcheck/login",
	               data:{
	               },  // 요청코드
	               dataType:'text',  //  응답받은 데이터 타입
	               success:function(data, status, xhr){
	            	   
	            	   var arr = data.split("/");
	            	   var getId = arr[0];
	            	   var getIsAdmin = arr[1];
	            	   console.log(data);
	            	   console.log(getId);
	            	   console.log(getIsAdmin);
	            	   
	            	   if(getId == btnid || getIsAdmin == 1){
	            		console.log(getId);
	            		   
	            		    $.ajax({ // 아이디와 댓글정보의 아이디가 일치한다면 삭제 
	        	               type:"get",
	        	               url:"deleteComment",
	        	               data:{
	        	            	   rno:btnno
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
	            		   
	            	   }else alert("삭제할 수 없습니다");
	            	   
	               },// end success 
	               error:function(xhr, status, error){
	                    console.log("idcheck error 발생");
	               }
	            }); // end ajax
		}); // end deletebtn
		
		const urlParams = new URLSearchParams(window.location.search);
		const selectedCity = urlParams.get('citykey');
		const selectedSearchMode = urlParams.get('SearchMode');
		
		$("#selectSearch [value="+selectedCity+"]").prop('selected', true);
		$("#SearchMode [value="+selectedSearchMode+"]").prop('selected', true);
		
		// input태그의 최대 길이 설정
		function checkMaxLengthInput(element, maxLength){
			if(element.value.length > maxLength){
				element.value = element.value.substring(0, maxLength);
			}
		}

		// 뒤로 가기를 할 때 아이디와 비밀번호가 채워진 상태가 되지 않도록 막기
		$(window).bind("pageshow", (event) => {
			$("#userid").val("");
			$("#password").val("");
		});
		
	}); // end jquery
	
	
	</script>
	<style>
	@import
		url('https://fonts.googleapis.com/css2?family=Gamja+Flower&display=swap')
		;

	.map_wrap {position:relative;width:100%;height:350px;}
	.title {font-weight:bold;display:block;}
	.hAddr {position:absolute;left:10px;top:10px;border-radius: 2px;background:#fff;background:rgba(255,255,255,0.8);z-index:1;padding:5px;}
	#centerAddr {display:block;margin-top:2px;font-weight: normal;}
	.bAddr {padding:5px;text-overflow: ellipsis;overflow: hidden;white-space: nowrap;}
	
        /* Add hover effect to the button */
        .btn:hover {
            border: 1px solid #007bff; /* Change the color as needed */
            border-radius: 10px;
        }

	</style>

	</head>
	<body>
		
	        <nav class="navbar navbar-light navbar-expand-lg bg-light fixed-top"  id="mainNav">
            <div class="container">
                <div class="collapse navbar-collapse" id="navbarResponsive">
                <ul class="navbar-nav mr-auto">
                <a href="main"><img src="images/logo.png" width="70px" height="70px" ></a><span id="logo">NADURI</span>
                </ul>	
                  <ul class="navbar-nav ml-auto">
               		
                    <jsp:include page="common/menu.jsp"></jsp:include>
                
            </ul>
                </div>
            </div>
        </nav>
        
        <div class="blank_top"></div>


	<!-- Masthead-->
	<header class="masthead shadow-top-gray shadow-bottom-gray" overflow="hidden">
		<h1>WELCOME TO OUR WEBSITE</h1>
	</header>

	<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">로그인 화면</h5>
					<button type="button" class="close" data-bs-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<!-- 로그인 폼 -->
					<form action="login" method="get" onload="noBack()">
						<div class="form-group">
							<label for="userid" class="mr-sm-2">아이디</label> <input type="text"
								class="form-control mb-2 mr-sm-2" id="userid" name="userid"
								oninput="checkMaxLengthInput(this, 20)">
						</div>
						<div class="form-group">
							<label for="password" class="mr-sm-2">비밀번호</label> <input type="password"
								class="form-control mb-2 mr-sm-2" id="password" name="password"
								oninput="checkMaxLengthInput(this, 20)">
						</div>
				</div>
				<div class="modal-footer">
					<button type="submit" class="btn btn-primary">로그인</button>
				</div>
				</form>
			</div>
		</div>
	</div>


	<div class="itemcontainer">
	<h2>${pagedto.location.citykey}&nbsp;&nbsp;${pagedto.location.city}</h2>
	<c:set var="citykey" value="${pagedto.location.citykey}"></c:set>
	<c:if test="${citykey==null}">
	<jsp:include page="map/nationWide.jsp" flush="true" />
	</c:if>
	<c:if test="${citykey!=null}">
	<jsp:include page="choosemap/choosemap.jsp" flush="true" />
	</c:if>


	    
	    <!-- Bootstrap core JS-->
	    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
	    <!-- Core theme JS-->
	    
	    <!-- * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *-->
	    <!-- * *                               SB Forms JS                               * *-->
	    <!-- * * Activate your form at https://startbootstrap.com/solution/contact-forms * *-->
	    <!-- * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *-->
	    <script src="https://cdn.startbootstrap.com/sb-forms-latest.js"></script>
	    
	  <div class="col-lg-4 col-md-12" id="mainTableContainer">		
		<table border="0" class="table fade-in" id="maintable" >

		<thead>
					<tr>
						<td>
							<form action="toCity" class=form-inline"">
								<select id="selectSearch" name="citykey"
									class="form-select form-select-lg"
									aria-label=".form-select-lg example">
									<option selected disabled hidden>지역 선택</option>
									<option id="강원" value="강원">강원도</option>
									<option value="경기">경기도</option>
									<option value="경상남도">경상남도</option>
									<option value="경상북도">경상북도</option>
									<option value="광주">광주</option>
									<option value="대구">대구</option>
									<option value="대전">대전</option>
									<option value="부산">부산</option>
									<option value="서울">서울</option>
									<option value="세종">세종</option>
									<option value="울산">울산</option>
									<option value="인천">인천</option>
									<option value="전라남도">전라남도</option>
									<option value="전라북도">전라북도</option>
									<option value="제주">제주도</option>
									<option value="충청남도">충청남도</option>
									<option value="충청북도">충청북도</option>
								</select>  
						</td>
						<td><select id="SearchMode" name="SearchMode"
							class="form-select form-select-lg"
							aria-label=".form-select-lg example">
								<option value=null >최신</option>
								<option value="past">종료됨</option>
						</select></td>
						<td><input type="submit" value="검색" class="btn btn-danger btn-lg" /> 
				</td>
				</form>
						</tr>
		</thead>
 		<!-- 미리 index를 선언해준것 (쓸데가 많다) -->
		<%  int index = 0; %> 
		<tbody>
			
					
			<c:forEach var="list" items="${pagedto.list}">
			<% index++;%> <!-- pagedto의 list(MapDTO)를 반복할때 증가할 수 있게 선언 -->
					<td colspan="3">
						<div id="contentBox">
							<div id="contentBox1"><a href="#pop_info_<%=index%>" title="<%=index%>" data-latitude="${list.latitude}" data-longitude="${list.longitude}" class="btn_open">${list.fstvlNm}</a></div>
	 					
	 					<!-- 팝업 태그 -->
						<div id="pop_info_<%=index%>" class="pop_wrap" style="display: none;" >
							<div class="pop_inner">
								<p class="dsc1">${list.fstvlNm}</p>
								<p class="dsc2">${list.fstvlCo}</p>
								
								
								<input type="hidden" id="lista" name="fstvlNm" value="${list.fstvlNm}"/>
								<input type="hidden" id="listb" name="opar" value="${list.opar}"/>
								<input type="hidden" id="listc" name="fstvlStartDate" value="${list.fstvlStartDate}"/>
								<input type="hidden" id="listd" name="fstvlEndDate" value="${list.fstvlEndDate}"/>
								
		 						<div class="map_wrap" title="<%=index%>">
									<div id="map<%=index%>" style="width:100%;height:100%;position:relative;overflow:hidden;"></div>
									<div class="hAddr">
										<span class="title">지도중심기준 행정동 주소정보</span>
										<span id="centerAddr<%=index%>"></span>
									</div>
								</div>		
								
								<p class="dsc3">전화번호 : ${list.phoneNumber}</p>		 						
		 						<!-- 홈페이지 url이 www로 시작할경우 http를 붙여줘서 제대로 하이퍼링크 이동하도록 -->
								<c:if test="${(list.homepageUrl).substring(0,4)=='http'}"><p class="dsc4">홈페이지 : <a id="clickdetail" href="${list.homepageUrl}" target="_blank">${list.homepageUrl}</a></p></c:if>
								<c:if test="${(list.homepageUrl).substring(0,4)!='http'}"><p class="dsc4">홈페이지 : <a id="clickdetail" href="https://${list.homepageUrl}" target="_blank">${list.homepageUrl}</a></p></c:if>
		 						
								<table id="commenttable" border=1>
								</table>

								
								
								<c:if test="${not empty sessionScope.login}">
								
								<!-- /commentAdd로 보낼 데이터들 (CommentDTO) -->			
								<form action="commentAdd" method="post">					
								<input type="hidden" id="list1" name="fstvlNm" value="${list.fstvlNm}"/>
								<input type="hidden" id="list2" name="opar" value="${list.opar}"/>
								<input type="hidden" id="list3" name="fstvlStartDate" value="${list.fstvlStartDate}"/>
								<input type="hidden" id="list4" name="fstvlEndDate" value="${list.fstvlEndDate}"/>
								<input type="hidden" name="rname" value="${sessionScope.login.username}"/>
								<input type="hidden" name="rid" value="${sessionScope.login.userid}"/>
								<input type="hidden" name="curPage" value="${pagedto.curPage}"/>
								<input type="hidden" name="city" value="${pagedto.location.city}"/>
								<input type="hidden" name="province" value="${pagedto.location.province}"/>
								<input type="hidden" name="citykey" value="${pagedto.location.province}"/>
								
								<!-- /commentAdd로 보내는 태그 -->	
								<input type="text" name="comments" /><!-- 글쓴 내용 -->	
								<input type="submit" title="<%=index%>" class="btn_submit" value="댓글작성" />
								</form>
								</c:if>
								
								<button type="button" title="<%=index%>" class="btn btn_close btn-outline-dark translate-middle">닫기</button>
							</div>
						</div>
						<br>
							<div id="contentBox2"> ${(list.fstvlStartDate).substring(0,10)}~${(list.fstvlEndDate).substring(0,10)} </div>
							<c:choose>
								<c:when test="${list.rdnmadr!=null}"><div id="contentBox3"> ${list.rdnmadr}</div> </c:when>
								<c:otherwise><div id="contentBox3"> ${list.lnmadr}</div></c:otherwise>
							</c:choose> 
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

						<nav aria-label="Page navigation example">
							<ul class="pagination justify-content-center"">
							
								<c:if test="${curPage>1}">
								<li class="page-item"><a class="page-link" href="main?curPage=${curPage-1}&city=${city}&province=${province}&citykey=${province}&SearchMode=${pagedto.location.SearchMode}" id="Previous" aria-label="Previous"> 
								<span aria-hidden="true">&laquo;</span></a></li>
								</c:if>
								
								<c:forEach var="i" begin="1" end="${pageNum}">
										<c:if test="${i==curPage}">
											<li class="page-item active" aria-current="page"><a
												class="page-link" href="#">${i}</a></li>
										</c:if>
										<c:if test="${i!=curPage}">
											<li class="page-item"><a class="page-link"
												href="main?curPage=${i}&city=${city}&province=${province}&citykey=${province}&SearchMode=${pagedto.location.SearchMode}">${i}</a></li>
										</c:if>
							 
									<c:forEach var="y" begin="1" end="${pageNum/10}">
										<c:if test="${i==(10*y)}">
										</ul>
											</td>
											</tr>
											<tr>
											<td colspan="3">
											<ul class="pagination justify-content-center"">
										</c:if>
									</c:forEach>
								</c:forEach>
								
								<c:if test="${curPage<pageNum-1}">
								<li class="page-item"><a class="page-link" href="main?curPage=${curPage+1}&city=${city}&province=${province}&citykey=${province}&SearchMode=${pagedto.location.SearchMode}" id="Next" aria-label="Next"> 
								<span aria-hidden="true">&raquo;</span></a></li>
								</c:if>
								
							</ul>
					</td>
				</tr>
		
	</table>
  </div>
  
  </div> <!-- table, 지도 전체를 감싸는 div -->

	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
</body>

 
	    
  <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=e94021873edcb2b72eb1481490f42d78&libraries=services"></script>
  <script>
  $(document).ready(function() {
 
  var startButtons = document.querySelectorAll('.btn_open');  
	
  startButtons.forEach(function(button) {
      button.addEventListener('click', function() {
    	  
    	  var index = this.getAttribute('title');
    	  latitude = this.getAttribute('data-latitude');
    	  longitude = this.getAttribute('data-longitude');
    	  console.log('index = '+index);
    	  console.log('latitude = '+latitude);
    	  console.log('longitude = '+longitude);
    	  
    	  var mapContainer = document.getElementById('map'+index), // 지도를 표시할 div
		  mapOption = {
			  center: new kakao.maps.LatLng(latitude, longitude), // 지도의 중심좌표 // 이부분에 list의 위도 / 경도 값을 삽입했음
			  level: 1 // 지도의 확대 레벨
		  };
  // 지도를 생성합니다
  var map = new kakao.maps.Map(mapContainer, mapOption);

  
  // 주소-좌표 변환 객체를 생성합니다
  var geocoder = new kakao.maps.services.Geocoder();

  var marker = new kakao.maps.Marker(), // 클릭한 위치를 표시할 마커입니다
		  infowindow = new kakao.maps.InfoWindow({zindex:1}); // 클릭한 위치에 대한 주소를 표시할 인포윈도우입니다
	
		  var markerPosition = new kakao.maps.LatLng(latitude, longitude);
          var marker = new kakao.maps.Marker({ position: markerPosition });
    
  // 현재 지도 중심좌표로 주소를 검색해서 지도 좌측 상단에 표시합니다
  searchAddrFromCoords(map.getCenter(), displayCenterInfo);
  
  // 지도를 클릭했을 때 클릭 위치 좌표에 대한 주소정보를 표시하도록 이벤트를 등록합니다
  kakao.maps.event.addListener(map, 'click', function(mouseEvent) {
	  searchDetailAddrFromCoords(mouseEvent.latLng, function(result, status) {
		  if (status === kakao.maps.services.Status.OK) {
			  var detailAddr = !!result[0].road_address ? '<div>도로명주소 : ' + result[0].road_address.address_name + '</div>' : '';
			  detailAddr += '<div>지번 주소 : ' + result[0].address.address_name + '</div>';

			  var content = '<div class="bAddr">' +
					  '<span class="title">법정동 주소정보</span>' +
					  detailAddr +
					  '</div>';

			  // 마커를 클릭한 위치에 표시합니다
			  marker.setPosition(mouseEvent.latLng);
			  marker.setMap(map);

			  // 인포윈도우에 클릭한 위치에 대한 법정동 상세 주소정보를 표시합니다
			  infowindow.setContent(content);
			  infowindow.open(map, marker);
		  }
	  });
  });
  
  marker.setMap(map);
  
  // 중심 좌표나 확대 수준이 변경됐을 때 지도 중심 좌표에 대한 주소 정보를 표시하도록 이벤트를 등록합니다
  kakao.maps.event.addListener(map, 'idle', function() {
	  searchAddrFromCoords(map.getCenter(), displayCenterInfo);
  });

  function searchAddrFromCoords(coords, callback) {
	  // 좌표로 행정동 주소 정보를 요청합니다
	  geocoder.coord2RegionCode(coords.getLng(), coords.getLat(), callback);
  }

  function searchDetailAddrFromCoords(coords, callback) {
	  // 좌표로 법정동 상세 주소 정보를 요청합니다
	  geocoder.coord2Address(coords.getLng(), coords.getLat(), callback);
  }
  
  // 지도 좌측상단에 지도 중심좌표에 대한 주소정보를 표출하는 함수입니다
  function displayCenterInfo(result, status) {
	  if (status === kakao.maps.services.Status.OK) {
		  var infoDiv = document.querySelector('#centerAddr'+index);  
		  for(var i = 0; i < result.length; i++) {
			  // 행정동의 region_type 값은 'H' 이므로
			  if (result[i].region_type === 'H') {
				  infoDiv.innerHTML = result[i].address_name;
				  break;
			  }
		  }
	  }
  }
    	  
      });
      
  });
  });
		 
  
	 
  </script>
</html>

