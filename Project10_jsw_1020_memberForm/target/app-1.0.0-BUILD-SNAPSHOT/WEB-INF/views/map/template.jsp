<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js"
	integrity="sha384-wHAiFfRlMFy6i5SRaxvfOCifBUQy1xHdJ/yoi7FRNXMRBu5WHdZYu1hA6ZOblgut"
	crossorigin="anonymous"></script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/js/bootstrap.min.js"
	integrity="sha384-B0UglyR+jN6CkvvICOB2joaf5I4l3gm9GU6Hc1og6Ls7i6U/mkkaduKaBhlAXv9k"
	crossorigin="anonymous"></script>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css"
	integrity="sha384-GJzZqFGwb1QTTN6wy59ffF1BuGJpLSa9DkKMp0DgiMDm4iYMj70gZWKYbI706tWS"
	crossorigin="anonymous">

<script>

            $(document).ready(function(){
 

                // 툴팁을 설정합니다.
                $("g [id]").tooltip( );

                $("g [id]").on("mouseover",function(){
                    
                    let idValue = $(this).attr("id"); 

                    $("#"+idValue).attr("fill","#FF0000");
                   
                });

                $("g [id]").on("mouseout",function(){
                    
                    let idValue = $(this).attr("id");
                    console.dir(idValue);

                    $("#"+idValue).attr("fill","#FFFFFF");
                    
                });

                $("g [id]").on("click",function(){
                    
                    let city = $(this).attr("id");
                    console.log(city);
                    let province = $("g path:first-child").attr("title");
                    console.log(province);

                    location.href="main?city="+city+"&province="+province+"&citykey="+province;
                    
                });
                
                $("g [id]").css("cursor", "pointer");
            });
            
    </script>

</head>

<body>
    
    <div class="container">
        <form class="box">  
           <h1>What are you looking for?</h1> 
           <input type="text" placeholder="원하는 지역을 검색하세요.">
           <input type="submit" value="검색">
        </form>
        
        <form class="login">
            <input type="submit" value="로그인" onclick="">
        </form>

        <form class="join">
            <input type="submit" value="회원가입" onclick="">
        </form>

		<form class="backToMain" action="main">
			<input type="submit" value="뒤로">
		</form>

		<div class="map_svg_warp city">
        