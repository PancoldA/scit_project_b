<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>LOGIN</title>

<!-- 구글 로그인 -->
<link href="https://fonts.googleapis.com/css?family=Roboto" rel="stylesheet" type="text/css">
<script src="https://apis.google.com/js/api:client.js"></script>
<script src="resources/js/jquery-3.4.1.min.js"></script>
<script >
console.log($('#logininter').val());
//이메일 정규표현식 통과시 true 반환
function email_check(email) {
  var regex = /([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/;
  return (email != '' && email != 'undefined' && regex.test(email));
}

/* 로그인 */
$('#loginbtn').click(function () {
if ($.trim($('#inputEmail').val()) == '') {
	Swal.fire({
		  type: 'warning',
		  text: '이메일 입력이 되지 않았습니다.'
	})
    $('#inputEmail').focus();
    return;
} else if ($.trim($('#inputPassword').val()) == '') {
	Swal.fire({
  type: 'warning',
  text: '패스워드 입력이 되지 않았습니다.'
})
    $('#inputPassword').focus();
    return;
} else if (Erchk == 0) {
	Swal.fire({
  type: 'warning',
  text: '이메일을 정확히 입력해주세요.'
})
    $('#inputEmail').focus();
    return;
} else {
$.ajax({
    url: "${pageContext.request.contextPath}/login_chk",
    type: "POST",
    data: {
        "user_email": $('#inputEmail').val(),
        "user_password": $('#inputPassword').val(),
    },
    success: function (data) {
        if (data == '1') {
        	Swal.fire({
        	  type: 'success',
      		  text: '로그인 되었습니다.',
      		showConfirmButton: false
        	});
     	var timer = setInterval(function() { 
        		$('.close').trigger('click');	
        		 location.reload(); 
        		 clearInterval(timer);
   			}, 500); 
        } else if (data == '2') {
            Swal.fire({
          	type: 'error',
        	text: '이메일 혹은 비밀번호를 다시 확인해주세요.',
          	});
            $('#inputEmail').focus();
        } else if (data == '3') {
        	 Swal.fire({
             	type: 'error',
           		text: '이미 접속중인 계정입니다.',
             	});
            $('.close').trigger('click');
            location.reload();
        } else if (data == "google"
            || data == "naver"
            || data == "kakao") 
        	{
            var snstype = data;  
            Swal.fire({
             	type: 'error',                    	
           		html:"회원님은 " + snstype + " 소셜 계정으로 가입된 회원입니다. <br> 해당 플랫폼 계정으로 로그인 해주세요."
             	});      
            $('#inputEmail').focus();
        }
    },
    error: function () {
    	 Swal.fire({
          	type: 'error',
        		text: '서버 에러',
          	});
    }
});
    }
});
/* 구글 로그인  */
var googleUser = {};
var startApp = function () {
    gapi.load('auth2', function () {
        // Retrieve the singleton for the GoogleAuth library and set up the client.
        auth2 = gapi.auth2.init({
            client_id: '1085160836725-98c6ensgeom0vh7f60mv4bgm79o6ap3r.apps.googleusercontent.com',
            cookiepolicy: 'single_host_origin',

            // Request scopes in addition to 'profile' and 'email'
            //scope: 'additional_scope'
        });
        attachSignin(document.getElementById('customBtn'));
    });
};

function attachSignin(element) {
    auth2.attachClickHandler(element, {},
        function (googleUser) {
        var id_token = googleUser.getAuthResponse().id_token; //id 토큰 획득 (id토큰에 사용자 정보가 모여있다 아이디번호,닉네임,이메일,프로필사진)
    $.ajax({
        url: "${pageContext.request.contextPath}/google",
        type: "post",
        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
        data: {
            "idtoken": id_token
        },
        success: function (data) {
            if (data == '1') {
                $('.close').trigger('click');
                location.reload();
            } else if (data == '2') {
            	 Swal.fire({
                   	type: 'error',                    	
                 		title:"로그인 실패 ",
                 		html:"해당 이메일은  다른 소셜플랫폼 <br>혹은 일반회원 계정으로 가입되어 있습니다."
                   	});     
            } else if (data == '3') {
            	Swal.fire({
                	  type: 'success',
              		  text: '소셜회원 자동가입이 완료되었습니다.',
              		showConfirmButton: false,
              		  timer: 1500,
                	 });
                $('.close').trigger('click');
                location.reload();
            }
        },
      error: function () {
      	 Swal.fire({
             	type: 'error',
           		text: '서버 에러',
             	});
      }
  });

}, function (error) {

});
}

    startApp();


	
</script>
</head>
<body>
<div id="wrapper">
	<form>
    <h3>로그인</h3>
    <br> <label for="inputEmail">Email address</label>
    <input type="email" name="user_email" id="inputEmail" placeholder="이메일주소" required autofocus>
    <label for="inputPassword">Password</label>
    <input type="password" name="user_password" id="inputPassword" placeholder="비밀번호" required> <br>
    <input type="button" id="loginbtn" value="로그인">
</form>
</div>
<!-- 소셜 로그인 패널 -->
<div id="sns_nav">
    <div id="gSignInWrapper">
        <div id="customBtn">
            <span id="cbicon" class="icon"></span>
            <span id="cblogin" class="customGPlusSignIn ml-3">Google</span>
        </div>
    </div>
</div>

	
</body>
</html>