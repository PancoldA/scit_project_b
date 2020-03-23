<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="resources/js/jquery-3.4.1.min.js"></script>
<script src="resources/js/sweetalert2.all.min.js"></script>
<script>
$(document).ready(function (e) {
//최초의 숨김 요소들
$("#authsubmit").hide();
$("#authcheck").hide();
$("#emchange").hide();
$("#nmchange").hide();
$("#loading-bar1").hide();
$("#setIntervaling-bar2").hide();

var Erchk = 0; //이메일 정규식
var pwch = 0;	 // 비밀번호 정규식
var namech = 0;	 //이름 정규식
var authch = 0;	 // 인증키 인증여부

$('#emchange').click(function () {
	if(emailch==true){
		Swal.fire({
			  text: "입력하신 이메일을 변경하시겠습니까?",
			  type: 'question',
			  showCancelButton: true,
			  confirmButtonColor: '#3085d6',
			  cancelButtonColor: '#d33',
			  cancelButtonText: '취소',
			  confirmButtonText: '확인'
			}).then((result) => {
			  if (result.value) {
				  authch = 0;
				  emailch = false;
				  $('#inputAuthNum').attr("readonly", false);
				  $('#inputAuthNum').val('');
				  $('#inputEmail').attr("readonly", false);
				  $('#inputEmail').val('');
				  $("#EmailCheck").empty();
		          $('#emcheck').show();
		          $("#authsubmit").hide();
		          $("#authcheck").hide();
		          $("#emchange").hide();
		          $("#EmailAuth").show();
		          $("#EmailAuth").attr("style","font-size:small;");
		          $('#EmailAuth').html("이메일 중복체크를 먼저 해주세요.");
		          
			  }
			})
	}
})

$('#nmchange').click(function () {
	if(namechk==true){
		Swal.fire({
			  text: "입력하신 닉네임을 변경하시겠습니까?",
			  type: 'question',
			  showCancelButton: true,
			  confirmButtonColor: '#3085d6',
			  cancelButtonColor: '#d33',
			  cancelButtonText: '취소',
			  confirmButtonText: '확인'
			}).then((result) => {
			  if (result.value) {
				  namechk = false;		
				  $('#inputName').val('');
				  $('#inputName').attr("readonly", false);
				  $('#nameCheck').empty();
		          $('#nmcheck').show();
		          $("#nmchange").hide();
			  }
			})
	}
})


// 이메일 실시간 입력감지
$("#inputEmail").on("propertychange change click keyup input paste", function () {
	if(emailch==false){	
    var email = $(this).val();
    // if value is empty then exit
    if (email == '' || email == 'undefined' || email == null){
    	$("#inputEmail").attr("style","border-color:none;");
    	$("#EmailCheck").empty();
        return;
    }
    if (!email_check(email)) {
         $("#EmailCheck").html("이메일을 정확히 입력해주세요. ");
         $("#inputEmail").attr("style","border-color: red; box-shadow: none; -webkit-box-shadow: none;");
        $("#EmailCheck").attr("style","color:red;font-size:small;");
        $(this).focus();
        Erchk = 0;
        return false;
    } else
    	$("#inputEmail").attr("style","border-color:none;");
        $("#EmailCheck").html("올바른 이메일 양식입니다.");
    $("#EmailCheck").attr("style","color:green;font-size:small;");
    Erchk = 1;}
	else{}
});


// 비밀번호 실시간 입력감지
$("#inputPassword").on("propertychange change click keyup input paste", function () {
    var pw = $(this).val();
    if (pw == '' || pw == 'undefined' || pw == null){
        return;
    }
    if (!pw_chk(pw)) {
        pwch = 0;
        return false;
    } else
        pwch = 1;
});

//이름 실시간 입력감지
$("#inputName").on("propertychange change click keyup input paste", function () {
	if(namechk==false){	
    var name = $(this).val();
    if (name == '' || name == 'undefined' || name == null){
    	$("#inputName").attr("style","border-color:none;");
    	$("#nameCheck").empty();
        return;
    }
    if (!name_chk(name)) {
    	 $("#inputName").attr("style","border-color: red; box-shadow: none; -webkit-box-shadow: none;");
    	$("#nameCheck").attr("style","color:red;font-size:small;");
    	$("#nameCheck").html("닉네임은 특수문자를 제외 2~10 글자로 입력해주세요.");
        namech = 0;
        return false;
    } else
    	$("#inputName").attr("style","border-color:none;");
    	$("#nameCheck").attr("style","color:green;font-size:small;");
    	$("#nameCheck").html("올바른 닉네임 양식입니다. ");
        namech = 1;
	}else{}
});

//이메일 정규표현식 통과시 true 반환
function email_check(email) {
    var regex = /([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/;
    return (email != '' && email != 'undefined' && regex.test(email));
}

// 비밀번호 정규표현식 통과시 true 반환
function pw_chk(pw) {
    var passRule = /^.*(?=^.{8,12}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&+=]).*$/;
    return (pw != '' && pw != 'undefined' && passRule.test(pw));
}

// 닉네임 정규표현식 통과시 true 반환
function name_chk(name) {
    var nameRule = /^[0-9a-zA-Z가-힣]{2,10}$/;
    return (name != '' && name != 'undefined' && nameRule.test(name));
}

var emailch = false; // 이메일 체크
var namechk = false; // 닉네임 체크
//유효성검사
$('#signUp').click(function () {
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
}
//패스워드 2번 입력 확인
else if ($('#inputPassword').val() != $('#inputPasswordchk').val()) {
	Swal.fire({
		  type: 'warning',
		  text: '패스워드가 다릅니다.'
		})
    $('#inputPasswordchk').focus();
    return;
} else if (pwch == 0) {
	Swal.fire({
  type: 'warning',
  text: '비밀번호를 문자,숫자,특수문자 포함 8~12자리 이내로 입력해주세요.'
})
   $('#inputPassword').focus();
    return;
}
else if (namechk == false) {
	Swal.fire({
		  type: 'warning',
		  text: '닉네임 중복체크를 해주세요.'
		})
    $('#inputName').focus();
    return;
}

//이메일 , 인증번호 중복확인
else if (emailch == false) {
	Swal.fire({
  type: 'warning',
  text: '이메일 중복체크를 해주세요.'
})
    return;
} else if (authch == false) {
	Swal.fire({
  type: 'warning',
  text: '이메일 인증코드 체크를 해주세요.'
})
    return;
} else {
$.ajax({
    url: "signup_go",
    type: "post",
    data: {
        "user_email": $('#inputEmail').val(),
        "user_password": $('#inputPassword').val(),
        "user_name": $('#inputName').val()
    },
    success: function (data) {
        if (data == '1') {            
        	Swal.fire({
          	type: 'success',
        		  html: '가입이 완료 되었습니다! <br> 로그인 해주세요.',
        		showConfirmButton: false,
        		timer: 1500
          	});
        		$(".loginmodal-body").load("login");
       		 }
    },
    error: function () {
    	Swal.fire({
    		  type: 'warning',
    		  text: '서버에러'
    		})
    }
   });
  }
});

/* 이메일 중복 확인  */
$('#emcheck').click(function () {
  if (!Erchk == 0) { //이메일 정규식 통과 검사
  $.ajax({
     url: "emailchk",
     type: "GET",
     data: {
         "user_email": $('#inputEmail').val()
     },
    success: function (data) {
        if (data == 0 && $.trim($('#inputEmail').val()) != '') {
            emailch = true;
            $('#EmailCheck').empty();
            $("#EmailCheck").attr("style","color:green;font-size:small;");
            $('#EmailCheck').html("사용가능한 이메일입니다.");
            $('#EmailAuth').empty();
            $("#authsubmit").show();
            $('#emcheck').hide();
        	$('#inputEmail').attr("readonly", true);
    		$("#emchange").show();

        } else {
            $('#EmailCheck').empty();
            $("#inputEmail").attr("style","border-color: red; box-shadow: none; -webkit-box-shadow: none;");
            $("#EmailCheck").attr("style","color:red;font-size:small;");
            $('#EmailCheck').html("이미 가입된 이메일입니다.");
        }
    },
   error: function () {
   	Swal.fire({
 		  type: 'warning',
 		  text: '서버에러'
 		})
   }
    }); //ajax 이벤트 끝
} else {
    $('#EmailCheck').empty();
    $("#EmailCheck").attr("style","color:red;font-size:small;");
    $('#EmailCheck').html("이메일을 올바르게 입력하고 확인버튼을 눌러주세요.");
}
}); // click 이벤트 끝



/* 닉네임 중복 확인  */
$('#nmcheck').click(function () {
  if (!namech == 0) { //닉네임 정규식 통과 검사
  $.ajax({
     url: "namechk",
     type: "GET",
     data: {
         "user_name": $('#inputName').val()
     },
    success: function (data) {
        if (data == 0 && $.trim($('#inputName').val()) != '') {
        	namechk = true;
            $('#inputName').attr("readonly", true);
            $('#nameCheck').empty();            
            $("#nameCheck").attr("style","color:green;font-size:small;");
            $('#nameCheck').html("사용가능한 닉네임입니다.");
            $('#nmcheck').hide();
            $('#nmchange').show();

        } else {
            $('#nameCheck').empty();
            $("#inputName").attr("style","border-color: red; box-shadow: none; -webkit-box-shadow: none;");
            $("#nameCheck").attr("style","color:red;font-size:small;");
            $('#nameCheck').html("이미 사용중인 닉네임입니다.");
        }
    },
   error: function () {
   	Swal.fire({
 		  type: 'warning',
 		  text: '서버에러'
 		})
   }
    }); //ajax 이벤트 끝
} else {
    $('#nameCheck').empty();
    $("#nameCheck").attr("style","color:red;font-size:small;");
    $('#nameCheck').html("닉네임을 올바르게 입력하고 확인버튼을 눌러주세요.");
}
}); // click 이벤트 끝


/* 이메일 인증번호 발송 */
$('#authsubmit').click(function () {
Swal.fire({
	  title: '인증코드',
	  text: "현재 입력된 메일로 인증코드를 발송 하시겠습니까?",
	  type: 'question',
	  showCancelButton: true,
	  confirmButtonColor: '#3085d6',
	  cancelButtonColor: '#d33',
	  cancelButtonText: '취소',
	  confirmButtonText: '발송'
	}).then((result) => {
if (result.value) {
$.ajax({
   url: "auth_submit",
   type: "post",
   data: {
       "user_email": $('#inputEmail').val()
   },
   beforeSend: function () {
       $("#loading-bar1").show();
   },
  success: function (data) {
      $("#loading-bar1").hide();
      if (data == '1') {
      	  Swal.fire({
              	type: 'success',
            		text: '입력하신 이메일로 인증번호가 발송되었습니다.',
              	});
          $("#EmailAuthdiv").show();
          $("#authcheck").show();
      }
  },
  error: function () {
		Swal.fire({
  		  type: 'warning',
  		  text: '서버에러'
			})
		}
	});
}
})
});	


/* 이메일 인증번호 확인 */
$('#authcheck').click(function () {
$.ajax({
    url: "${pageContext.request.contextPath}/auth_check",
    type: "post",
    data: {
        "auth_key": $('#inputAuthNum').val()
    },
    success: function (data) {
        if (data == '1') {
            $('#inputAuthNum').attr("readonly", true);
            Swal.fire({
              	type: 'success',
            		text: '인증번호가 확인되었습니다.',
              	});
            $("#authsubmit").hide();
            $("#authcheck").hide();
            $("#EmailAuth").attr("style","color:green;font-size:small;");
            $('#EmailAuth').html("인증번호가 확인되었습니다.");
            authch = 1;
        } else if (data == '2') {
        	Swal.fire({
              	type: 'error',
            		text: '인증번호가 틀렸습니다.',
              	});
        	$("#EmailAuth").attr("style","color:red;font-size:small;");
            $('#EmailAuth').html("인증번호가 틀렸습니다.");
        }
    },
    error: function () {
    	Swal.fire({
     		  type: 'warning',
     		  text: '서버에러'
     		})
    }
    }); //ajax 이벤트 끝
}); // click 이벤트 끝
});
</script>
</head>
<body>
<div id="wrapper">
	<form id="signupform" action="signup_go">
	<h3>회원가입</h3>
    <h6>이메일</h6>
    <label for="inputEmail">Email address</label>
    <input type="email" name="user_email" id="inputEmail" placeholder="이메일주소" required autofocus>
    <input type="button" id="emcheck" value="중복체크 후 사용">

    <input type="button" id="emchange" value="이메일 변경">
    <p id="EmailCheck" style="font-size:small"></p>

    <div id="loading-bar1">
         <b style="font-size:small">잠시만 기다려주십시오... </b>
    </div>

    <div id="EmailAuthdiv">
        <br>
        <h6>이메일 인증</h6>
        <label for="inputAuthNum">이메일 인증번호</label>
        <input type="text" name="auth_key" id="inputAuthNum" placeholder="이메일로 발송된 인증번호를 입력해주세요." required>
        <p id="EmailAuth" style="font-size:small">이메일 중복체크를 먼저 해주세요.</p>
        <input type="button" id="authsubmit" value="이메일 인증번호 발송" >
        <input type="button" id="authcheck" value="이메일 인증번호 확인">
        <br>
    </div>
    
    <h6 class="mt-3">닉네임</h6>
    <label for="inputName">Name</label>
    <input type="text" name="user_name" id="inputName" placeholder="닉네임" required>
    <input type="button" id="nmcheck" value="중복체크 후 사용" >
     <input type="button" id="nmchange" value="닉네임 변경" >
    <p id="nameCheck" class="mt-2" style="font-size:small"></p>
    <br>
    <h6>비밀번호</h6>
    <label for="inputPassword" >Password</label>
    <input type="password" name="user_password" id="inputPassword" placeholder="비밀번호" required>
    <input type="password" name="user_passwordchk" id="inputPasswordchk" placeholder="비밀번호 확인" required>      
    <p id="pwchk" style="font-size:small">비밀번호는 문자,숫자,특수문자 포함 8~12자리 이내로 입력해주세요.</p>
    <br>
    <input type="button" id="signUp" value="가입">
	</form>

</div>

</body>
</html>