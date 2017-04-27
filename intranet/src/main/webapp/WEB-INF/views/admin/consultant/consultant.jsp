<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div id="Contents">
    <form id="consultantForm" name="consultantForm" method="post" enctype="multipart/form-data">
        <input type="hidden" id="conId" name="conId" value='<c:out value="${consultant.CON_ID}"></c:out>' />
    
	<div class="swrap">
        <div class="search2">
            <c:choose>
                <c:when test="${empty consultant.CON_ID}">
                    <span class="d_search"><a href="#" id="addConsultant">등록</a></span>
                </c:when>
                <c:otherwise>
                    <span class="d_search"><a href="#" id="delConsultant">삭제</a></span>
                    <span class="d_search"><a href="#" id="modConsultant">수정</a></span>
                </c:otherwise>
            </c:choose>
            <span class="d_search"><a href="/admin/consultantList">목록</a></span>
        </div>
    	<!--데이타테이블시작-->
        <table class="board_h" style="width:100%;">
            <colgroup>
            <col width="18%" />
            <col width="37%" />
            <col width="18%" />
            <col width="*" />
            </colgroup>
            <tbody>
                <tr>
                    <th class="re">성명</th>
                    <td><input id="conNm" name="conNm" type="text" class="in2" value='<c:out value="${consultant.CON_NM}" />' /></td>
                    <th class="re">E-mail</th>
                    <td>
                    	<input id="email" name="email" type="text" class="in2" value='<c:out value="${consultant.EMAIL}" />'  <c:if test="${!empty consultant.EMAIL}">disabled</c:if> />
                    </td>
                </tr>
                <tr>
                    <th class="re">패스워드</th>
                    <td><input id="password" name="password" type="password" class="in2" value='' /></td>
                    <th class="re">패스워드 확인</th>
                    <td><input id="rePassword" name="rePassword" type="password" class="in2" value='' /></td>
                </tr>
                <tr>
                    <th class="re">직급</th>
                    <td>
                    	<input id="rank" name="rank" type="text" class="in2" value='<c:out value="${consultant.RANK}" />' />
<!--                         <select id="rank" name="rank" class="sel02"> -->
<!--                             <option value="">선택</option> -->
<%--                             <option <c:if test="${consultant.RANK eq '임원'}">selected</c:if>>임원</option> --%>
<%--                             <option <c:if test="${consultant.RANK eq '부장'}">selected</c:if>>부장</option> --%>
<%--                             <option <c:if test="${consultant.RANK eq '차장'}">selected</c:if>>차장</option> --%>
<%--                             <option <c:if test="${consultant.RANK eq '과장'}">selected</c:if>>과장</option> --%>
<%--                             <option <c:if test="${consultant.RANK eq '대리'}">selected</c:if>>대리</option> --%>
<%--                             <option <c:if test="${consultant.RANK eq '주임'}">selected</c:if>>주임</option> --%>
<%--                             <option <c:if test="${consultant.RANK eq '사원'}">selected</c:if>>사원</option> --%>
<!--                         </select> -->
                    </td>
                    <th class="re">정렬순서</th>
                    <td><input id="conOrder" name="conOrder" type="text" class="in2" maxlength="5" value='<c:out value="${consultant.CON_ORDER}" />'></td>
                </tr>
                <tr>
                    <th>전문분야</th>
                    <td colspan="3">
                        <textarea name="field" cols="" rows="4" style="width:97%;"><c:out value="${consultant.FIELD}" /></textarea>
                    </td>
                </tr>
                <tr>
                    <th>전화번호</th>
                    <td  colspan="3"><input type="text" id="phone" name="phone" class="in2" placeholder="02-423-4806" value='<c:out value="${consultant.PHONE}" />' /></td>
                </tr>
                <tr>
                    <th class="re">휴대폰</th>
                    <td  colspan="3"><input type="text" id="mobile" name="mobile" class="in2" placeholder="010-3423-4806" value='<c:out value="${consultant.MOBILE}" />' /></td>
                </tr>
                <tr>
                    <th>학력경력</th>
                    <td colspan="3">
                        <textarea name="edu" cols="" rows="4" style="width:97%;"><c:out value="${consultant.EDU}" /></textarea>
                    </td>
                </tr>
                <tr>
                    <th rowspan="6">권한설정</th>
                    <td colspan="3">
                        <label><input type="checkbox" name="adminYn" value="Y" <c:if test="${consultant.ADMIN_YN eq 'Y'}">checked</c:if>> 관리자 지정</label>
                    </td>
                </tr>
                <tr>
                    <td colspan="3">
                        <label><input type="radio" name="authPublic" value="1" <c:if test="${consultant.AUTH_PUBLIC eq '1'}">checked</c:if>> 등록자료의 인트라넷 공개</label>
                        <label><input type="radio" name="authPublic" value="0" disabled <c:if test="${consultant.AUTH_PUBLIC eq '0'}">checked</c:if>> 등록자료의 인트라넷 비공개</label>
                        <span>※ 등록자료 : 포지션, 후보자</span>
                    </td>
                </tr>
                <tr>
                    <td rowspan="4" style="background-color: #a4eaea; text-align: center;
                        vertical-align: middle;">타인이 등록한 데이터의 권한</td>
                    <td colspan="2">
                        <label><input type="radio" name="authCompany" value="1" <c:if test="${consultant.AUTH_COMPANY eq '1'}">checked</c:if>> 고객사 리스트/내용 조회</label>
                        <label><input type="radio" name="authCompany" value="0" disabled <c:if test="${consultant.AUTH_COMPANY eq '0'}">checked</c:if>> 고객사 리스트/내용 조회 불가</label>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <label><input type="radio" name="authPosition" value="1" <c:if test="${consultant.AUTH_POSITION eq '1'}">checked</c:if>> 포지션 리스트/내용 조회</label>
                        <label><input type="radio" name="authPosition" value="0" disabled <c:if test="${consultant.AUTH_POSITION eq '0'}">checked</c:if>> 포지션 리스트/내용 조회 불가</label>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <label><input type="radio" name="authUser" value="1" <c:if test="${consultant.AUTH_USER eq '1'}">checked</c:if>> 후보자 리스트 조회</label>
                        <label><input type="radio" name="authUser" value="0" disabled <c:if test="${consultant.AUTH_USER eq '0'}">checked</c:if>> 후보자 리스트 조회 불가</label>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                                상위의 후보자 리스트 조회/권한이 부여된 상태에서 아래 항목의 선택이 가능함
                        <div><label><input type="radio" name="authUserType" value="1" <c:if test="${consultant.AUTH_USER_TYPE eq '1'}">checked</c:if>> 후보자 전체 이력서 조회</label></div>
                        <div><label><input type="radio" name="authUserType" value="2" <c:if test="${consultant.AUTH_USER_TYPE eq '2'}">checked</c:if>> 후보자 연락처를 제외한 이력서 조회</label></div>
                        <div><label><input type="radio" name="authUserType" value="3" disabled <c:if test="${consultant.AUTH_USER_TYPE eq '3'}">checked</c:if>> 후보자 이력서 조회 불가</label></div>
                    </td>
                </tr>
                <tr>
                    <th>사진</th>
                    <td colspan="3">
                        <div class="filebox">
                            <c:choose>
                                <c:when test="${empty consultant.ORIGINAL_FILE_NM}">
                                    <a href="#this" class="upload-name">파일선택</a>
                                </c:when>
                                <c:otherwise>
                                    <input type="hidden" name="attId" id="attId" value='<c:out value="${consultant.ATT_ID}"></c:out>' />
                                    <input type="hidden" name="orgId" id="orgId" value='<c:out value="${consultant.CON_ID}"></c:out>' />
                                    <a href="#this" id="downloadFile" class="upload-name">${consultant.ORIGINAL_FILE_NM} (${consultant.FILE_SIZE}kb)</a>
                                </c:otherwise>
                            </c:choose>

							<label for="file">파일첨부</label> 
							<input type="file" id="file" name="file" class="upload-hidden" accept="image/*">
							
							<c:if test="${!empty consultant.ORIGINAL_FILE_NM}">
								<span class="d_btn"><a href="#this" id="delFile">삭제</a></span>
							</c:if> 
                        </div>
                        <p style="color: red; margin-top: 3px;">※ 가로 : 110 * 세로 : 145 최적화</p>
                    </td>
                </tr>
            </tbody>
		</table>
        </div>
	</form>
</div>

<script>
	$(document).ready(init); 
	    
	function init() {
	    $('#addConsultant').on('click', addConsultant);
	    $('#modConsultant').on('click', addConsultant);
	    $('#delConsultant').on('click', delConsultant);
	    $('#downloadFile').on('click', downloadFile);
	    $('#file').on('change', setFile);
	    $(document).on('click', '#delFile', delFile);
	    
	    $('input[name="adminYn"]').on('click', function() {
	        if ($(this).is(':checked')) {
	            $('input[name="authPublic"]').prop('disabled', true);
	            $('input[name="authCompany"]').prop('disabled', true);
	            $('input[name="authPosition"]').prop('disabled', true);
	            $('input[name="authUser"]').prop('disabled', true);
	            $('input[name="authUserType"]').prop('disabled', true);
	        } else {
	            $('input[name="authPublic"]:even').prop('disabled', false);
	            $('input[name="authPublic"]:odd').prop('disabled', true);
	            $('input[name="authCompany"]:even').prop('disabled', false);
	            $('input[name="authCompany"]:odd').prop('disabled', true);
	            $('input[name="authPosition"]:even').prop('disabled', false);
	            $('input[name="authPosition"]odd').prop('disabled', true);
	            $('input[name="authUser"]:even').prop('disabled', false);
	            $('input[name="authUser"]:odd').prop('disabled', true);
	            $('input[name="authUserType"]:eq(0)').prop('disabled', false);
	            $('input[name="authUserType"]:eq(1)').prop('disabled', false);
	            $('input[name="authUserType"]:eq(2)').prop('disabled', true);
	        }
	    });
	}
	
	function addConsultant(event) {
	    var state = $('#conId').val() == '' ? 'new' : 'mod';
	    
	    $("#consultantForm").validate({
	        rules : {
	            conNm : {required: true}
	            ,email : {
	                required: true, 
	                email: true, 
	                minlength: 2,
	                remote: {
	                    url : '<c:url value="./emailCheck" />',
	                    type : 'post',
	                    data : {
	                        email : function() {
	                            return $('#email').val();
	                        },
	                        state : function() {
	                            return state;
	                        }
	                    }
	                }
	             }
	            ,password : {minlength: 6, pwd : true}
	            ,rePassword : {equalTo: '#password', rePwd : true}
	            ,mobile : {required: true, minlength: 10, mobilePhone: true}
	            ,rank : {required: true}
	            ,conOrder : {required : true, maxlength: 5, digits: true}
	        },
	        messages : {
	            conNm : {required: '성명을 입력하세요.'}
	            ,email : {required: '메일을 입력하세요.', email: '메일규칙에 어긋납니다.', minlength: '최소 {0}글자이상이어야 합니다.', remote: '중복된 E-mail 입니다.'}
	            ,password : {minlength: '패스워드는 최소 {0}글자 이상이어야 합니다.'}
	            ,rePassword : {equalTo: '패스워드 항목과 일치하지 않습니다.'}
	            ,mobile : {required: '휴대폰번호를 입력해주세요.', minlength: $.validator.format("휴대폰은 최소 {0} 글자 이상 입력하세요.")}
	            ,rank : {required: '직급을 입력하세요.'}
	            ,conOrder : {required: '정렬 순서를 입력하세요.', digits : '숫자만 입력 가능합니다.'}
	        },
	        submitHandler : function(form) {
	            callAjaxSubmit(form);
	        }
	    });
	    
	    $.validator.addMethod(
	            'mobilePhone', function(value, element) {
	                return (value.substring(0,1) == 0) ? true : false;
	            }, '휴대폰 번호는 0으로 시작하여야 합니다.'
	    );
	    $.validator.addMethod(
	            'pwd', function(value, element) {
	                return ((state === 'new' && value > 6) || state === 'mod') ? true : false;
	            }, '패스워드를 입력하세요.'
	    );
	    $.validator.addMethod(
	            'rePwd', function(value, element) {
	                return ((state === 'new' && value > 6) || state === 'mod') ? true : false;
	            }, '패스워드 확인을 입력하세요.'
	    );
	    
	    $("#consultantForm").submit();
	    
	}
	
	/* 저장 */
	function callAjaxSubmit(form) {
	    var url = ($('#conId').val() == '') ? '<c:url value="./addConsultant" />' : '<c:url value="./modConsultant" />';
	    
	    $(form).ajaxSubmit({
		    url : url,
		    type : 'post',
		    success : function(res) {
		        if (res.result === 'success') {
            		toastr.success('저장 되었습니다.');

            		window.setTimeout(function() {
			            document.location.href = '<c:url value="./consultantList" />';
		            }, 300);
		        }
		    }
		});
	}
	
	function setFile() {
	    if(window.FileReader){  // modern browser
	        var filename = $(this)[0].files[0].name;
	      } 
	      else {  // old IE
	        var filename = $(this).val().split('/').pop().split('\\').pop();  // 파일명만 추출
	      }
	    
	    // 추출한 파일명 삽입
	    $(this).siblings('.upload-name').text(filename);
	    if ($(this).parent().find('.d_btn').length === 0)  {
		    $(this).after('<span class="d_btn"><a href="#this" id="delFile">삭제</a></span>');
	    }
	}
	
	function delConsultant() {
	    if (confirm("삭제 처리 하시겠습니까?")) {
		    var url = '<c:url value="./delConsultant" />';
		    $("#consultantForm").attr('action', url).submit();
	    }
	}
	
	function delFile() {
		var agent = navigator.userAgent.toLowerCase();
	    
	    //IE 일때와 타브라우저일때 
		if ( (navigator.appName == 'Netscape' && navigator.userAgent.search('Trident') != -1) || (agent.indexOf("msie") != -1) ) {
			$("#file").replaceWith( $("#file").clone(true) );	
		} else {
		    $("#file").val('');
		}
	    $('.upload-name').text('파일선택').off('click', downloadFile);
	    $('#attId').val('');
	    $('.d_btn').remove();
	}
	
	function downloadFile() {
	    var attId = $('#attId').val();
	    var url = '<c:url value="/downloadFile" />';
	    url += '?attId=' + attId;
	    
	    $(location).attr('href', url);
	}
	
	function setRadioCl(e) {
	    var srcEl = getSrc(e);
	    var ra = srcEl.form[srcEl.name];
	    for (var i =0; i < ra.length; i++) {
	    	if (ra[i].checked) ra[i].onpropertychange = function(e){getSrc(e).click()}
	    	else ra[i].onclick = function(){return false};
	    }
	}
	
	function getSrc(e) {
	    return e ? e.target || e.srcElement : event.srcElement;
	}
	
</script>