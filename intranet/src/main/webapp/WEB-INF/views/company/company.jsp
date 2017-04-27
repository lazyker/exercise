<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div id="Contents">
    <form id="companyForm" name="companyForm" method="post">
        <input type="hidden" id="comId" name="comId" value='<c:out value="${getCompany.COM_ID}" />' />
        
    <div class="swrap">
        <div class="search2">
        	<c:choose>
        		<c:when test="${empty getCompany.COM_ID}">
        			<span class="d_search"><a href="#" id="addCompany">등록</a></span>
        			<span class="d_search"><a href="/company/companyList">목록</a></span>
        		</c:when>
        		<c:otherwise>
		            <span class="d_search"><a href="<c:url value="./company" />">신규</a></span>
		            <c:if test="${userInfo.CON_ID eq getCompany.USR_ID || userInfo.CON_ID eq getCompany.CON_ID || userInfo.ADMIN_YN eq 'Y'}">
			            <span class="d_search"><a href="javascript:;" id="modCompany">저장</a></span>
		            </c:if>
		            <span class="d_search"><a href="javascript:history.back(-1);">취소</a></span>
        		</c:otherwise>
        	</c:choose>
        </div>
        <!--데이타테이블시작-->
        <table class="board_h" style="width:100%;">
            <colgroup>
            <col width="16%" />
            <col width="34%" />
            <col width="16%" />
            <col width="*" />
            </colgroup>
            <tbody>
                <tr>
                    <th>회사코드</th>
                    <td id="comIdClean"><c:out value="${getCompany.COM_ID}" /></td>
                    <th>등록일</th>
                    <td id="regDateClean"><c:out value="${getCompany.REG_DATE}" /></td>	  	
                </tr>
                <tr>	
                    <th class="re">회사명</th>
                    <td>
	                    <input id="comNm" name="comNm" type="text" class="in2" value="<c:out value="${getCompany.COM_NM}" />" style="width:150px;" />
	                    <span class="t_search"><a href="#" id="overlapPop">중복검사</a></span>
	                    <div style="margin-top: 4px;"><label for="comNm" class="error"></label></div>
                    </td>
                    <th class="re">구분</th>
                    <td>
                        <select name="section" class="sel02" style="width:250px;" >
                           <option value="">선택</option>
                           <option value="A" <c:if test="${getCompany.SECTION eq 'A'}">selected</c:if>>고객사</option>
                           <option value="B" <c:if test="${getCompany.SECTION eq 'B'}">selected</c:if>>마케팅</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <th class="re">기업형태</th>
                    <td>
                        <select name="comType" class="sel02" style="width:250px;" >
                            <option value="">선택</option>
                            <option value="A" <c:if test="${getCompany.COM_TYPE eq 'A'}">selected</c:if>>대기업</option>
                            <option value="B" <c:if test="${getCompany.COM_TYPE eq 'B'}">selected</c:if>>중견기업</option>
                            <option value="C" <c:if test="${getCompany.COM_TYPE eq 'C'}">selected</c:if>>중소기업</option>
                            <option value="D" <c:if test="${getCompany.COM_TYPE eq 'D'}">selected</c:if>>외국기업</option>
                            <option value="E" <c:if test="${getCompany.COM_TYPE eq 'E'}">selected</c:if>>거래소</option>
                            <option value="F" <c:if test="${getCompany.COM_TYPE eq 'F'}">selected</c:if>>코스닥</option>
                            <option value="G" <c:if test="${getCompany.COM_TYPE eq 'G'}">selected</c:if>>기타</option>
                        </select></td>
                    <th>매출|인원</th>
                    <td>
                    	<input name="sales" type="text" class="in2" value="<c:out value="${getCompany.SALES}" />" style="width:150px;" /> | 
                    	<input name="people" type="text" class="in2" value="<c:out value="${getCompany.PEOPLE}" />" style="width:150px;" />
                    </td>
                    
                </tr>
                <tr>
                    <th class="re">업종</th>
                    <td>
                        <select id="industry1" name="industry1" class="sel02" style="width:170px;" >
                            <option value="">선택</option>
                            <c:forEach items="${codeList}" var="parentCode">
                                <option value="${parentCode.CD_ID}" <c:if test="${getCompany.INDUSTRY1 eq parentCode.CD_ID}">selected</c:if>><c:out value="${parentCode.CD_NM}" /></option>
                            </c:forEach>
                        </select>
                        <select id="industry2" name="industry2" class="sel02" style="width:170px;" >
                        <option value="">선택</option>
                            <c:forEach items="${childCodeList}" var="childCode">
                                <option value="${childCode.CD_ID}" <c:if test="${getCompany.INDUSTRY2 eq childCode.CD_ID}">selected</c:if>><c:out value="${childCode.CD_NM}" /></option>
                            </c:forEach>
                        </select>
                        <div style="margin-top: 4px;"><label for="industry1" class="error"></label></div>
                    </td>
                    <th>인트라넷 공개</th>
                    <td>
	                    <select name="publicYn" class="sel02" style="width:250px;" >
	                       <option value="Y" <c:if test="${getCompany.PUBLIC_YN eq 'Y'}">selected</c:if>>공개</option>
	                       <option value="N" disabled <c:if test="${getCompany.PUBLIC_YN eq 'N'}">selected</c:if>>비공개</option>
	                    </select>
                    </td>
                </tr>
                <tr>
                    <th style="background: url('../resources/images/ne.png') no-repeat 10px 85px; color:#ffffff; font-weight:600; background-color:#a1a1c4; border-top:1px solid #999999; border-bottom:1px solid #dadada; font-size:13px;">
                    	회사개요
                    </th>
                    <td colspan="3">
                        <textarea name="summary" cols="" rows="8" placeholder="[회사개요]" style="width:98%;"><c:out value="${getCompany.SUMMARY}" /></textarea>
                    </td>
                </tr>
                <tr>
                    <th>주소</th>
                    <td colspan="3">
                        <input name="address" type="text" class="in2" value="<c:out value="${getCompany.ADDRESS}" />" style="width:99%" />
                    </td>
                </tr>
                <tr>
                    <th>처우수준</th>
                    <td colspan="3">
                        <input name="standard" type="text" class="in2" value="<c:out value="${getCompany.STANDARD}" />" style="width:99%" />
                    </td>
                </tr>
                <tr>
                    <th>URL</th>
                    <td>
                        <input name="url" type="text" class="in2" value="<c:out value="${getCompany.URL}" />" style="width:200px;" />
                    </td>
                    <th>등록경로</th>
                    <td>
                        <select name="source" class="sel02" style="width:250px;" >
                            <option value="">선택</option>
                            <option value="1" <c:if test="${getCompany.SOURCE eq '1'}">selected</c:if>>TM</option>
                            <option value="2" <c:if test="${getCompany.SOURCE eq '2'}">selected</c:if>>EM</option>
                            <option value="3" <c:if test="${getCompany.SOURCE eq '3'}">selected</c:if>>방문</option>
                            <option value="4" <c:if test="${getCompany.SOURCE eq '4'}">selected</c:if>>지인소개</option>
                            <option value="5" <c:if test="${getCompany.SOURCE eq '5'}">selected</c:if>>인바운드</option>
                            <option value="6" <c:if test="${getCompany.SOURCE eq '6'}">selected</c:if>>기타</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <th>수수료율</th>
                    <td>
                        <input name="commission" type="text" class="in2" value="<c:out value="${getCompany.COMMISSION}" />" style="width:200px;" />
                    </td>
                    <th>개런티</th>
                    <td>
                        <select name="guarantee" class="sel02" style="width:250px;" >
                            <option value="">선택</option>
                            <option value="0" <c:if test="${getCompany.GUARANTEE eq '0'}">selected</c:if>>0개월</option>
                            <option value="1" <c:if test="${getCompany.GUARANTEE eq '1'}">selected</c:if>>1개월</option>
                            <option value="2" <c:if test="${getCompany.GUARANTEE eq '2'}">selected</c:if>>2개월</option>
                            <option value="3" <c:if test="${getCompany.GUARANTEE eq '3'}">selected</c:if>>3개월</option>
                            <option value="4" <c:if test="${getCompany.GUARANTEE eq '4'}">selected</c:if>>4개월</option>
                            <option value="5" <c:if test="${getCompany.GUARANTEE eq '5'}">selected</c:if>>5개월</option>
                            <option value="6" <c:if test="${getCompany.GUARANTEE eq '6'}">selected</c:if>>6개월</option>
                            <option value="7" <c:if test="${getCompany.GUARANTEE eq '7'}">selected</c:if>>7개월</option>
                            <option value="8" <c:if test="${getCompany.GUARANTEE eq '8'}">selected</c:if>>8개월</option>
                            <option value="9" <c:if test="${getCompany.GUARANTEE eq '9'}">selected</c:if>>9개월</option>
                            <option value="10" <c:if test="${getCompany.GUARANTEE eq '10'}">selected</c:if>>10개월</option>
                            <option value="11" <c:if test="${getCompany.GUARANTEE eq '11'}">selected</c:if>>11개월</option>
                            <option value="12" <c:if test="${getCompany.GUARANTEE eq '12'}">selected</c:if>>12개월</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <th>등록자</th>
                    <td>
                        <c:out value="${getCompany.USR_NM}" />
                        <input type="hidden" name="usrNm" value="${getCompany.USR_NM}" />
                    </td>
                    <th class="re">컨설턴트</th>
                    <td>
                        <select name="conId" class="sel02" style="width:250px;" >
                            <option value="">선택</option>
                            <c:forEach items="${consultantList}" var="consultant">
                                <option value="${consultant.CON_ID}" <c:if test="${getCompany.CON_ID eq consultant.CON_ID}">selected</c:if>><c:out value="${consultant.CON_NM}" /></option>
                            </c:forEach>
                        </select>
                    </td>
                </tr>
            </tbody>
        </table>
        
        <table class="board_list" style="width:100%;">
            <colgroup>
            <col width="12%" />
            <col width="22%" />
            <col width="15%" />
            <col width="15%" />
            <col width="20%" />
            <col width="*" />
            </colgroup>
            <tbody>
                <tr>
                    <th>
                    	<img src="../resources/images/ne.png" alt="" />&nbsp;담당자
                    </th>
                    <th>부서|직위</th>
                    <th>
                    	<img src="../resources/images/ne.png" alt="" />&nbsp;연락처1
                    </th>
                    <th>연락처2</th>
                    <th>
                    	<img src="../resources/images/ne.png" alt="" />&nbsp;E-mail
                    </th>
                    <th>비고</th>
                </tr>
                <c:choose>
                	<c:when test="${empty getPersonList}">
                		<c:forEach begin="0" end="2" varStatus="status">
			                <tr>
			                    <td>
			                    	<input name="list[${status.index}].personNm" type="text" class="in" value="" style="width:100px;" />
			                    </td>
			                    <td>
			                        <input name="list[${status.index}].deptNm" type="text" class="in" style="width:140px;"  />
			                        <input name="list[${status.index}].posNm" type="text" class="in" style="width:60px;"  />
			                    </td>
			                    <td><input name="list[${status.index}].phone1" type="text" class="in" style="width:130px;"  /></td>
			                    <td><input name="list[${status.index}].phone2" type="text" class="in" style="width:130px;" /></td>
			                    <td><input name="list[${status.index}].email" type="text" class="in" style="width:180px;" /></td>
			                    <td><input name="list[${status.index}].etc" type="text" class="in" style="width:180px;" /></td>
			                </tr>
                		</c:forEach>
                	</c:when>
                	<c:otherwise>
                		<c:forEach var="item" items="${getPersonList}" begin="0" end="2" varStatus="status">
			                <tr>
			                    <td>
			                    	<input name="list[${status.index}].personId" type="hidden" class="in" value="${item.PERSON_ID}" style="width:100px;" />
			                    	<input name="list[${status.index}].personNm" type="text" class="in" value="${item.PERSON_NM}" style="width:100px;" />
			                    </td>
			                    <td>
			                        <input name="list[${status.index}].deptNm" type="text" class="in" value="${item.DEPT_NM}" style="width:140px;"  />
			                        <input name="list[${status.index}].posNm" type="text" class="in" value="${item.POS_NM}" style="width:60px;"  />
			                    </td>
			                    <td><input name="list[${status.index}].phone1" type="text" class="in" value="${item.PHONE1}" style="width:130px;"  /></td>
			                    <td><input name="list[${status.index}].phone2" type="text" class="in" value="${item.PHONE2}" style="width:130px;" /></td>
			                    <td><input name="list[${status.index}].email" type="text" class="in" value="${item.EMAIL}" style="width:180px;" /></td>
			                    <td><input name="list[${status.index}].etc" type="text" class="in" value="${item.ETC}" style="width:180px;" /></td>
			                </tr>
                		</c:forEach>
                	</c:otherwise>
                </c:choose>
              </tbody>
            </table>
            
            <c:if test="${!empty getCompany.COM_ID}">
	        	<jsp:include page="/WEB-INF/views/common/comment.jsp" />        
            </c:if>
        </div>
        </form>
        
</div>

<script type="text/javascript">
	$(document).ready(init);
	
	function init() {
	    $('#addCompany').on('click', addCompany);
	    $('#industry1').on('change', getIndustry);
	    $('#overlapPop').on('click', overlapPop);
	    $('#comNm').on('keydown', this, enterEvent);
	    $('#modCompany').on('click', addCompany);
	}
	
	function addCompany() {
	    var state = $('#comId').val() == '' ? 'new' : 'mod';
	    
	    $("#companyForm").validate({
	        onfocusout: true,
	        rules : {
	            comNm : {required : true}
	            ,section : {required : true}
	            ,comType : {required : true}
	            ,industry1 : {required : true}
	            ,summary : {required : true}
	            ,conId : {required : true}
	            ,'list[0].personNm' : {required : true}
	            ,'list[0].phone1' : {required : true}
	            ,'list[0].email' : {required : true}
	        },
	        messages : {
	            comNm  : {required : '회사명을 입력하세요.'}
	            ,section : {required : '구분을 선택하세요.'}
	            ,comType : {required : '기업형태를 선택하세요.'}
	            ,industry1 : {required : '업종을 선택하세요.'}
	            ,summary : {required : '회사개요를 입력하세요.'}
	            ,conId : {required : '컨설턴트를 선택하세요.'}
	            ,'list[0].personNm' : {required : '담당자를 입력하세요.'}
	            ,'list[0].phone1' : {required : '연락처를 입력하세요.'}
	            ,'list[0].email' : {required : 'email을 입력하세요.'}
	        },
	        submitHandler : function(form) {
	            callAjaxSubmit(form);
	        }
	    });
	    
	    $("#companyForm").submit();
	}
	
	function callAjaxSubmit(form) {
	    var url = ($('#comId').val() == '') ? '<c:url value="./setCompany" />' : '<c:url value="./modCompany" />';

		$(form).ajaxSubmit({
		    url : url,
		    type : 'post',
		    success : function(res) {
		        if (res.result === 'success') {
            		toastr.success('저장 되었습니다.');

            		window.setTimeout(function() {
			            document.location.href = '<c:url value="./companyList" />';
		            }, 300);
		        }
		    }
		});
	}
	
	function getIndustry() {
	    var url = '<c:url value="/admin/childList" />';
	    var parentId = $(this).val(); 
	    $('#industry2').empty();
	    
	    $.ajax({
	        url :  url,
	        data : {'parentId' : parentId},
	        success : function(res) {
	            var str = "";
	            str += '<option value="">선택</option>'; 
	            $.each(res, function(i, item) {
	                str += '<option value="'+item.CD_ID+'">' +item.CD_NM+ '</option>'; 
	                
	            });
	            $('#industry2').append(str);
	        }
	    });
	}
	
	/* 중복검사 팝업창 */
	function overlapPop() {
        var url = '<c:url value="./companyOverlapPop" />';
        url += '?comNm=' + $('#comNm').val();
        
        popupCenter(encodeURI(url), "positionAddPop", 500, 450);
	}
	
	function enterEvent(key) {
        if (key.keyCode == 13) {
            overlapPop();
        }
    }
</script>