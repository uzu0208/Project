<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- Bootstrap CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<style>
        /* Add your custom styles here if needed */
        body {
            background-color: #f8f9fa;
        }
        .container{
        	height: 100%;
        }
        .login-form {
            max-width: 400px;
            margin: 0 auto;
            margin-top: 25%;
            padding: 20px;
            background-color: #ffffff;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
    </style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
<script>
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
</script>

<div class="container">
 	
    <div class="row">
    
        <div class="col-md-12">
        
            <form action="login" method="get" onload="noBack()" class="login-form">
                <div class="form-group">
                    <label for="userid">아이디</label>
                    <input type="text" class="form-control" id="userid" name="userid" oninput="checkMaxLengthInput(this, 20)">
                </div>
                <div class="form-group">
                    <label for="password">비밀번호</label>
                    <input type="password" class="form-control" id="password" name="password" oninput="checkMaxLengthInput(this, 20)">
                </div>
                <div class="form-group text-center">
                    <input type="submit" class="btn btn-primary" value="로그인">
                    <input type="reset" class="btn btn-secondary" value="취소">
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Bootstrap JS (optional, for some components) -->
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.0.7/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.min.js"></script>

<!-- Your custom scripts go here -->

</body>
</html>



