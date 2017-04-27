<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div id="wrap">
    <!--상단로고-->
    <form id="loginForm" name="loginForm" method="post">
	<div class="top_l">
    	<img src="/resources/images/login_logo.png" />
    </div>
    <div class="l_title">
    	<img src="/resources/images/login_t.png" />
    </div>
    <!--입력부분 시작-->
    <ul class="in_l">
    	<li class="lig_in">
        	<span class="in">user id</span>
            <input id="conId" name="conId" type="text" class="log"/>
            <div style="font-size : 10px; color: red;"><label for="conId" class="error"></label></div>
        </li>
        <li class="lig_in">
        	<span class="pw">password</span>
            <input id="password" name="password" type="password" class="log" value="123456" />
            <div style="font-size : 10px; color: red;"><label for="password" class="error"></label></div>
        </li>
        <li>
        <span class="l_ok" id="signIn"><a href="javascript:;">SIGN IN</a></span>
        </li>
        <li class="talign_c">
        <input id="rememberid" name="" type="checkbox" class="checkbox-style">
        <label for="rememberid">Remember id</label>
        </li>
    </ul>
	</form>
</div>

<script type="text/javascript">

	$(document).ready(init);
	
	function init() {
	    $('#conId').focus();
	    $('#signIn').on('click', loginCheck);
	    
	    var loginId = $.cookie('loginId');
	    if (loginId != undefined) {
	        $('#conId').val(loginId);
	        $('#rememberid').prop('checked', true);
	    }
	    
	    $('#password').on('keydown', function(key) {
	        if (key.keyCode == 13) {
	            loginCheck();
	        }
	    });
	}
	
	function loginCheck() {
	    $("#loginForm").validate({
	        rules : {
	            conId : {required: true}
	            ,password : {required: true}
	        },
	        messages : {
	            conId : {required: 'ID를 입력하세요.'}
	            ,password : {required: '패스워드를 입력하세요.'}
	        },
	        submitHandler : function(form) {
				$.ajax({
				    url: "loginCheck",
				    method : 'post',
				    data : {
				        conId : $('#conId').val(),
				        password : $('#password').val()
				    },
				    success : function(result) {
				        if (result) {
				            if($("#rememberid").prop('checked')) {
				                $.cookie('loginId', $("#conId").val());
				            } else {
				                $.removeCookie("loginId");
				            }
				            
				            window.location.href = '${pageContext.request.contextPath}/support/progress';
				        }
				        else {
				            toastr.options.positionClass = 'toast-bottom-full-width';
				            toastr.warning('아이디 또는 패스워드가 일치하지 않습니다.');
				        }
				    }
				});
	        }
	    });
	    
	    $("#loginForm").submit();
	}
	
</script>