<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<% pageContext.setAttribute("cn", "\n"); %>

<div id="Contents">
    <form id="positionForm" name="positionForm" method="post">
        <input type="hidden" id="posId" name="posId" value='<c:out value="${getPosition.POS_ID}" />' />
        <input type="hidden" id="currentUser" name="currentUser" value='<c:out value="${userInfo.CON_ID}" />' />
        
    <div class="swrap">
        <div class="search2">
        	<c:choose>
        		<c:when test="${empty getPosition.POS_ID}">
        			<span class="d_search"><a href="javascript:;" id="setPosition">등록</a></span>
        			<span class="d_search"><a href="<c:url value="javascript:history.back(-1);" />">목록</a></span>
        		</c:when>
        		<c:otherwise>
		            <span class="d_search"><a href="<c:url value="./position" />">신규</a></span>
		            <c:if test="${userInfo.CON_ID eq getPosition.CON_ID || userInfo.CON_ID eq getPosition.S_CON_ID || userInfo.ADMIN_YN eq 'Y'}">
			            <span class="d_search"><a href="javascript:;" id="modPosition">저장</a></span>
		            </c:if>
		            <span class="d_search"><a href="<c:url value="javascript:history.back(-1);" />">목록</a></span>
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
                    <th>포지션코드</th>
                    <td id="posIdClean"><c:out value="${getPosition.POS_ID}" /></td>
                    <th>등록일</th>
                    <td id="regDateClean"><c:out value="${getPosition.REG_DATE}" /></td>	  	
                </tr>
                <tr>	
                    <th class="re">포지션</th>
                    <td>
	                    <input id="posNm" name="posNm" type="text" class="in2" value="<c:out value="${getPosition.POS_NM}" />" style="width:80%;" placeholder="최대 50자 입력 가능" />
                    </td>
                    <th class="re">회사명</th>
                    <td>
	                    <input id="comNm" name="comNm" type="text" class="in2" value="<c:out value="${getPosition.COM_NM}" />" style="width:150px;" />
	                    <input type="hidden" name="comId" value="<c:out value="${getPosition.COM_ID}" />" />
	                    <c:if test="${empty getPosition.POS_ID}">
		                    <span class="t_search"><a href="javascript:;" id="companyPop">검색</a></span>
	                    </c:if>
	                    <div style="margin-top: 4px;"><label for="comNm" class="error"></label></div>
                    </td>
                </tr>
                <tr>
                    <th class="re">업무방식</th>
                    <td>
                        <select name="rule" class="sel02" style="width:250px;" >
                            <option value="A" <c:if test="${getPosition.RULE eq 'A'}">selected</c:if>>단독</option>
                            <option value="B" <c:if test="${getPosition.RULE eq 'B'}">selected</c:if> selected>협업</option>
                            <option value="C" <c:if test="${getPosition.RULE eq 'C'}">selected</c:if>>양수도</option>
                            <option value="D" <c:if test="${getPosition.RULE eq 'D'}">selected</c:if>>공동</option>
                            <option value="E" <c:if test="${getPosition.RULE eq 'E'}">selected</c:if>>기타</option>
                        </select>
                    </td>
                    <th class="re">홈페이지 공개</th>
                    <td>
                    	<select id="hPublicYn" name="hPublicYn" class="sel02" style="width:250px;" >
                            <option value="Y" <c:if test="${getPosition.H_PUBLIC_YN eq 'Y'}">selected</c:if>>공개</option>
                            <option value="N" <c:if test="${getPosition.H_PUBLIC_YN eq 'N'}">selected</c:if>>비공개</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <th class="re">컨설턴트[주|부]</th>
                    <td>
                        <select name="conId" class="sel02" style="width:125px;" <c:if test="${!empty getPosition.POS_ID}"><c:if test="${userInfo.ADMIN_YN eq 'Y'}"><disabled</c:if></c:if> >
                            <option value="">선택</option>
                            <c:forEach items="${consultantList}" var="consultant">
                                <option value="${consultant.CON_ID}" <c:if test="${getPosition.CON_ID eq consultant.CON_ID}">selected</c:if>><c:out value="${consultant.CON_NM}" /></option>
                            </c:forEach>
                        </select>
                        <select name="sConId" class="sel02" style="width:125px;" >
                            <option value="">선택</option>
                            <c:forEach items="${consultantList}" var="consultant">
                                <option value="${consultant.CON_ID}" <c:if test="${getPosition.S_CON_ID eq consultant.CON_ID}">selected</c:if>><c:out value="${consultant.CON_NM}" /></option>
                            </c:forEach>
                        </select>
                        <div style="margin-top: 4px;"><label for="conId" class="error"></label></div>
                    </td>
                    <th>진행상태</th>
                    <td>
                    	<select name="posStatus" class="sel02" style="width:125px;" >
                            <option value="A" <c:if test="${getPosition.POS_STATUS eq 'A'}">selected</c:if>>진행</option>
                            <option value="B" <c:if test="${getPosition.POS_STATUS eq 'B'}">selected</c:if>>성공</option>
                            <option value="C" <c:if test="${getPosition.POS_STATUS eq 'C'}">selected</c:if>>마감</option>
                            <option value="D" <c:if test="${getPosition.POS_STATUS eq 'D'}">selected</c:if>>보류</option>
                        </select>
<!--                         <select name="conId" class="sel02" style="width:125px;" > -->
<!--                             <option value="">선택</option> -->
<%--                             <c:forEach items="${consultantList}" var="consultant"> --%>
<%--                                 <option value="${consultant.CON_ID}" <c:if test="${getPosition.CON_ID eq consultant.CON_ID}">selected</c:if>><c:out value="${consultant.CON_NM}" /></option> --%>
<%--                             </c:forEach> --%>
<!--                         </select> -->
                    </td>
                </tr>
                <tr>
                    <th>회사개요</th>
                    <td colspan="3">
                    	<div id="summary"><c:out escapeXml="false" value="${fn:replace(getPosition.SUMMARY, cn, '<br/>')}" /></div>
                    </td>
                </tr>
                <tr>
                    <th>업종</th>
                    <td>
                    	<div>
                    		<span id="industry1"><c:out value="${getPosition.INDUSTRY1}" /></span>
                    		<span id="industry2"><c:if test="${!empty getPosition.INDUSTRY2}"> / </c:if> <c:out value="${getPosition.INDUSTRY2}" /></span>
                    	</div>
                    </td>
                    <th class="re">직무</th>
                    <td>
	                    <select id="job1" name="job1" class="sel02" style="width:120px;" >
                            <option value="">선택</option>
                            <c:forEach items="${jobCodeList}" var="parentCode">
                                <option value="${parentCode.CD_ID}" 
                                	<c:if test="${getPosition.JOB1 eq parentCode.CD_ID}">selected</c:if>>
                                	<c:out value="${parentCode.CD_NM}" />
                                </option>
                            </c:forEach>
                        </select>
                        <select id="job2" name="job2" class="sel02" style="width:120px;" >
                        <option value="">선택</option>
                            <c:forEach items="${childCodeList}" var="childCode">
                                <option value="${childCode.CD_ID}" 
                                	<c:if test="${getPosition.JOB2 eq childCode.CD_ID}">selected</c:if>>
                                	<c:out value="${childCode.CD_NM}" />
                                </option>
                            </c:forEach>
                        </select>
                        <div style="margin-top: 4px;"><label for="job1" class="error"></label></div>
                    </td>
                </tr>
                <tr>
                    <th>학력</th>
                    <td>
                        <select id="edu" name="edu" class="sel02" style="width:170px;" >
                            <option value="">선택</option>
                            <option value="1" <c:if test="${getPosition.EDU eq '1'}">selected</c:if>>박사</option>
                            <option value="2" <c:if test="${getPosition.EDU eq '2'}">selected</c:if>>석사</option>
                            <option value="3" <c:if test="${getPosition.EDU eq '3'}">selected</c:if>>학사</option>
                            <option value="4" <c:if test="${getPosition.EDU eq '4'}">selected</c:if>>전문학사</option>
                            <option value="5" <c:if test="${getPosition.EDU eq '5'}">selected</c:if>>무관</option>
                        </select>
                    </td>
                    <th>직급</th>
                    <td>
	                    <select name="fromRank" class="sel02" style="width:110px;" >
	                       <option value="">선택</option>
	                       <option value="A" <c:if test="${getPosition.FROM_RANK eq 'A'}">selected</c:if>>임원</option>
	                       <option value="B" <c:if test="${getPosition.FROM_RANK eq 'B'}">selected</c:if>>부장</option>
	                       <option value="C" <c:if test="${getPosition.FROM_RANK eq 'C'}">selected</c:if>>차장</option>
	                       <option value="D" <c:if test="${getPosition.FROM_RANK eq 'D'}">selected</c:if>>과장</option>
	                       <option value="E" <c:if test="${getPosition.FROM_RANK eq 'E'}">selected</c:if>>대리</option>
	                       <option value="F" <c:if test="${getPosition.FROM_RANK eq 'F'}">selected</c:if>>주임</option>
	                       <option value="G" <c:if test="${getPosition.FROM_RANK eq 'G'}">selected</c:if>>사원</option>
	                    </select>
	                    ~
	                    <select name="toRank" class="sel02" style="width:110px;" >
	                       <option value="">선택</option>
	                       <option value="A" <c:if test="${getPosition.TO_RANK eq 'A'}">selected</c:if>>임원</option>
	                       <option value="B" <c:if test="${getPosition.TO_RANK eq 'B'}">selected</c:if>>부장</option>
	                       <option value="C" <c:if test="${getPosition.TO_RANK eq 'C'}">selected</c:if>>차장</option>
	                       <option value="D" <c:if test="${getPosition.TO_RANK eq 'D'}">selected</c:if>>과장</option>
	                       <option value="E" <c:if test="${getPosition.TO_RANK eq 'E'}">selected</c:if>>대리</option>
	                       <option value="F" <c:if test="${getPosition.TO_RANK eq 'F'}">selected</c:if>>주임</option>
	                       <option value="G" <c:if test="${getPosition.TO_RANK eq 'G'}">selected</c:if>>사원</option>
	                    </select>
                    </td>
                </tr>
                <tr>
                    <th class="re">경력</th>
                    <td>
                        <input name="career" type="text" class="in2" value="<c:out value="${getPosition.CAREER}" />" style="width:150px" maxlength="30" />
                        <div style="margin-top: 4px;"><label for="career" class="error"></label></div>
                    </td>
                    <th>외국어</th>
                    <td>
                        <input name="lang" type="text" class="in2" value="<c:out value="${getPosition.LANG}" />" style="width:80%" />
                    </td>
                </tr>
                <tr>
                    <th class="re">근무지</th>
                    <td>
                        <input name="place" type="text" class="in2" value="<c:out value="${getPosition.PLACE}" />" style="width:80%;" />
                    </td>
                    <th class="re">인트라넷 공개</th>
                    <td>
                        <select name="publicYn" class="sel02" style="width:250px;" >
                            <option value="Y" <c:if test="${getPosition.PUBLIC_YN eq 'Y'}">selected</c:if>>공개</option>
                            <option value="N" disabled <c:if test="${getPosition.PUBLIC_YN eq 'N'}">selected</c:if>>비공개</option>
                        </select>
                    </td>
                </tr>
                <tr>
					<th>업무내용</th>
                   	<td colspan="3">
                   		<textarea name="task" cols="" rows="10" placeholder="[업무내용]" style="width:98%;"><c:out value="${getPosition.TASK}" /></textarea>
					</td>
                </tr>
                <tr>
					<th>자격요건</th>
					<td colspan="3">
						<textarea name="posCondition" cols="" rows="10" placeholder="[자격요건]" style="width:98%;"><c:out value="${getPosition.POS_CONDITION}" /></textarea>
					</td>
                </tr>
                <tr>
                    <th>타켓연령</th>
                    <td>
                    	<select id="fromTarget" name="fromTarget" class="sel02" style="width:125px;" >
                            <option value="">전체</option>
                        </select>
                        ~
                    	<select id="toTarget" name="toTarget" class="sel02" style="width:125px;" >
                            <option value="">전체</option>
                        </select>
                    </td>
                    <th>선호기업</th>
                    <td>
                        <input name="tCompany" type="text" class="in2" value="<c:out value="${getPosition.T_COMPANY}" />" style="width:200px;" />
                    </td>
                </tr>
                <tr>
                    <th>성별</th>
                    <td>
                        <label><input type="checkbox" name="gender" value="M" <c:if test="${getPosition.GENDER eq 'M'}">checked</c:if> /> 남</label>
                        <label><input type="checkbox" name="gender" value="W" <c:if test="${getPosition.GENDER eq 'W'}">checked</c:if> /> 여</label>
                    </td>
                    <th>자격증</th>
                    <td>
                    	<input name="license" type="text" class="in2" value="<c:out value="${getPosition.LICENSE}" />" style="width:200px;" />
                    </td>
                </tr>
                <tr>
                	<th>처우</th>
                    <td>
						기본급 : <input name="base" type="text" class="in2" value="<c:out value="${getPosition.BASE}" />" style="width:200px;" />
                    </td>
                    <td colspan="2">
						성과급 : <input name="bonus" type="text" class="in2" value="<c:out value="${getPosition.BONUS}" />" style="width:200px;" />
                    </td>
                </tr>
                <tr>
                    <th>기타정보</th>
                    <td colspan="3">
                        <input name="etc" type="text" class="in2" value="<c:out value="${getPosition.ETC}" />" style="width:99%" />
                    </td>
                </tr>
            </tbody>
        </table>
        
        <c:if test="${!empty getPosition.COM_ID}">
			<jsp:include page="/WEB-INF/views/common/comment.jsp" />        
        </c:if>
         
		<c:if test="${!empty getPosition.COM_ID}">
        <p class="s_title">진행현황</p>
        <p style="float:right; margin-top:15px;">
            <span class="d_search"><a href="javascript:;" id="delPresent">삭제</a></span>
            <span class="p_search"><a href="javascript:;" id="candidateAddPop">등록</a></span>
        </p>
        
		<table id="preTable" class="board_list" style="width:100%;">
            <colgroup>
            <col width="4%" />
            <col width="4%" />
            <col width="10%" />
            <col width="15%" />
            <col width="15%" />
            <col width="10%" />
            <col width="10%" />
            <col width="23%" />
            <col width="*" />
            </colgroup>
            <tbody>
                <tr>
                	<th>선택</th>
                    <th>No</th>
                    <th>후보자</th>
                    <th>최종학교</th>
                    <th>전공</th>
                    <th>연락처(HP)</th>
                    <th>추천자</th>
                    <th>상태</th>
                    <th>비고</th>
                </tr>
                <c:forEach var="item" items="${progressList}" >
	                <tr>
	                	<td>
	                		<input type="checkbox" name="chk" value="<c:out value="${item.REC_ID}" />" />
	                		<input type="hidden" id="recConId" value="<c:out value="${item.CON_ID}" />" />
	                	</td>
	                    <td><c:out value="${item.ROWNUM}" /></td>
	                    <td><c:out value="${item.USR_INFO}" /></td>
	                    <td><c:out value="${item.USR_SCHOOL}" /></td>
	                    <td><c:out value="${item.USR_MAJOR}" /></td>
	                    <td><c:out value="${item.MOBILE}" /></td>
	                    <td><c:out value="${item.CON_NM}" /></td>
	                    <td>
	                    	<div style="margin-bottom:10px;" class="state">
		                    	<select class="sel02" style="width:80px;" >
		                    		<option value="">선택</option>
		                    		<option value="A">추천</option>
		                    		<option value="B">1차면접</option>
		                    		<option value="C">2차면접</option>
		                    		<option value="D">3차면접</option>
		                    		<option value="E">실기</option>
		                    		<option value="F">인적성</option>
		                    		<option value="G">입사확정</option>
		                    		<option value="H">입사</option>
		                    		<option value="I">빌링</option>
		                    		<option value="J">탈락</option>
		                    		<option value="K">보류</option>
		                    		<option value="L">미검토</option>
		                    		<option value="M">협상결렬</option>
		                    		<option value="N">본인포기</option>
		                    		<option value="O">입금</option>
		                    		<option value="P">빌링취소</option>
		                    		<option value="Q">리플접수</option>
		                    		<option value="R">리플</option>
		                    		<option value="S">정산</option>
		                    		<option value="T">call</option>
		                    		<option value="U">이메일</option>
		                    		<option value="V">프리뷰</option>
		                    		<option value="W">기타</option>
		                    	</select>
	                    		<input name="statusDate" type="text" class="in" style="width:70px;" />
	                    		<a href="javascript:;" name="statusDateImg"><img src="/resources/images/b_cal.png" style="vertical-align: middle;"/></a>
	                    	</div>
	                    	<c:forEach var="chlidstate" items="${item.posProStatusList}">
		                    	<div class="divState">
		                    		<span class="spanStateDate"><c:out value="${chlidstate.STATE_NM}" /></span> 
		                    		<span style="color: #999999; margin-left: 10px;"><c:out value="${chlidstate.STATE_DATE}" /></span>
		                    		<c:if test="${chlidstate.CON_ID eq userInfo.CON_ID || userInfo.ADMIN_YN eq 'Y'}">
			                    		<span class="delState" id="<c:out value="${chlidstate.STA_ID}" />">x</span>
		                    		</c:if>
		                    	</div>
	                    	</c:forEach> 
	                    </td>
	                    <td>
	                    	<c:if test="${item.CON_ID eq userInfo.CON_ID || getPosition.CON_ID eq userInfo.CON_ID || userInfo.ADMIN_YN eq 'Y'}">
		                    	<span class="t_p"><a href="javascript:;">추가</a></span>
	                    	</c:if>
	                    </td>
	                </tr>
                </c:forEach>
                <c:if test="${empty progressList}">
                	<tr>
                		<td colspan="9">진행현황 목록이 없습니다.</td>
                	</tr>
                </c:if>
			</tbody>
		</table>
		</c:if>
	</div>
	</form>
</div>

<script type="text/javascript">

	$(document).ready(init);
	
	function init() {
	    $('#setPosition').on('click', setPosition);
	    $('#companyPop').on('click', companyPop);
	    $('#modPosition').on('click', setPosition);
	    
	    $('#job1').on('change', getJob);
	    $('#candidateAddPop').on('click', candidateAddPop);
	    $('#delPresent').on('click', delPresent);
	    $('input[name="statusDate"]').datepicker();
	    $(document).on('click','a[name="statusDateImg"]',openDate);
	    $(document).on('click','.t_p',addStatus);
	    $(document).on('click','.delState',delStatus);
	    $('#comNm').on('keyup', this, enterEvent);
	    
// 	    $('input[name=base]').on('keyup change', getNumber);
// 	    $('input[name=bonus]').on('keyup change', getNumber);
	    
	    for (var i = new Date().getFullYear(); i > 1939; i--)
	    {
	        $('#fromTarget').append($('<option />').val(i).html(i + '년'));
	        $('#toTarget').append($('<option />').val(i).html(i + '년'));
	    }
        $('#fromTarget').val('${getPosition.FROM_TARGET}')
        $('#toTarget').val('${getPosition.TO_TARGET}')
	}
	
	function setPosition() {
	    $("#positionForm").validate({
	        onfocusout: true,
	        rules : {
	            posNm : {required : true}
	    		,comNm : {required : true}
	            ,job1 : {required : true}
	            ,conId : {required : true}
	            ,career : {required : true}
	            ,place : {required : true}
	        },
	        messages : {
	            posNm  : {required : '포지션을 입력하세요.'}
	        	,comNm  : {required : '회사명을 입력하세요.'}
	            ,job1 : {required : '직무를 선택하세요.'}
	            ,conId : {required : '컨설턴트를 선택하세요.'}
	            ,career : {required : '경력을 입력하세요.'}
	            ,place : {required : '근무지를 입력하세요.'}
	        },
	        submitHandler : function(form) {
	            callAjaxSubmit(form);
	        }
	    });
	    
	    $("#positionForm").submit();
	}
	
	function callAjaxSubmit(form) {
	    var url = ($('#posId').val() == '') ? '<c:url value="./setPosition" />' : '<c:url value="./modPosition" />';

		$(form).ajaxSubmit({
		    url : url,
		    type : 'post',
		    beforeSubmit : function(formData, jqForm, options) {
		    },
		    success : function(res) {
		        if (res.result === 'success') {
            		toastr.success('저장 되었습니다.');

            		window.setTimeout(function() {
			            document.location.href = '<c:url value="./positionList" />';
		            }, 300);
		        }
		    }
		});
	}
	
	function getJob() {
	    var url = '<c:url value="/admin/childList" />';
	    var parentId = $(this).val(); 
	    $('#job2').empty();
	    
	    $.ajax({
	        url :  url,
	        data : {'parentId' : parentId},
	        success : function(res) {
	            var str = "";
	            str += '<option value="">선택</option>'; 
	            $.each(res, function(i, item) {
	                str += '<option value="'+item.CD_ID+'">' +item.CD_NM+ '</option>'; 
	                
	            });
	            $('#job2').append(str);
	        }
	    });
	}
	
	function companyPop() {
	    var url = '<c:url value="./companyPop" />';
	    url += '?comNm=' + $('#comNm').val();
	    
	    popupCenter(encodeURI(url), "companyPop", 500, 450);
	}
	
	/** 진행현황 후보자 등록 팝업 **/
	function candidateAddPop() {
	    var url = '<c:url value="./candidateAddPop" />';
	    
	    popupCenter(url, "candidateAddPop", 500, 450);
	}
	
	/** 진행현황 등록 **/
	function addCandidatePresent(param) {
	    var url = '<c:url value="./addCandidatePresent" />';
	    var data = {
	      posId : $('#posId').val(),
	      usrId : param.usrId,
	      conId : $('#currentUser').val()
	    };
	    var $preTableTd = $('#preTable tbody').find('td');
	    var tdCnt = $preTableTd.length;
	    var indexTxt = $preTableTd.eq(1).text()
		if (tdCnt === 1) { //첫등록
		    $preTableTd.parent().remove();
		    indexTxt = 0;
		};

	    $.ajax({
	        url :  url,
	        type : 'post',
	        data : data,
	        success : function(res) {
	            var result = res.result;
	            var str = '';
	            str += '<tr>';
	            str += '<td><input type="checkbox" name="chk" value="' + result.REC_ID + '" />'
	            str += '<input type="hidden" id="recConId" value="' + result.CON_ID + '" />';
	            str += '</td>';
	            str += '<td>' + (Number(indexTxt)+1) + '</td>';
	            str += '<td>' + result.USR_INFO + '</td>';
	            str += '<td>' + result.USR_SCHOOL + '</td>';
	            str += '<td>' + result.USR_MAJOR + '</td>';
	            str += '<td>' + result.MOBILE + '</td>';
	            str += '<td>' + result.CON_NM + '</td>';
	            str += '<td>';
	            str += '<div style="margin-bottom:10px;" class="state">'; 
	            str += '<select class="sel02" style="width:80px;" >';
	            str += '<option>선택</option>';
	            str += '<option value="A">추천</option><option value="B">1차면접</option><option value="C">2차면접</option><option value="D">3차면접</option>' +
            			'<option value="E">실기</option><option value="F">인적성</option><option value="G">입사확정</option><option value="H">입사</option>' +
            			'<option value="I">빌링</option><option value="J">탈락</option><option value="K">보류</option><option value="L">미검토</option>' +
            			'<option value="M">협상결렬</option><option value="N">본인포기</option><option value="O">입금</option><option value="P">빌링취소</option>' +
            			'<option value="Q">리플접수</option><option value="R">리플</option><option value="S">정산</option><option value="T">call</option>' +
            			'<option value="U">이메일</option><option value="V">프리뷰</option><option value="W">기타</option>';
	            str += '</select>';
	            str += ' <input name="statusDate" type="text" class="in" style="width:70px;" /> ';
	            str += '<a href="javascript:;" name="statusDateImg"><img src="/resources/images/b_cal.png" style=" vertical-align: middle;"/></a>';
	            str +='</div>';
	            str +='</td>';
	            str += '<td>';
	            str += '<span class="t_p"><a href="javascript:;">추가</a></span> ';
	            str += '</td>';
	            str += '</tr>';
	            
				$('#preTable tbody').find('tr').first().after(str);
				
				$(document).scrollTop($(document).height());
				$('input[name="statusDate"]').removeClass('hasDatepicker').datepicker();
	        }
	    });
	}
	
	/** 진행현황 삭제 **/
	function delPresent() {
	    var url = '<c:url value="./delUsrRecPresent" />';
	    var $chk = $('input:checkbox[name="chk"]:checked');
	    var result = '';
	    
	    if (!$chk.is(':checked')) {
	        toastr.warning('<div class="font14">삭제할 진행현황을 체크해 주세요.</div>');
	        return;
	    }
	    else {
	        if ($chk.parent().parent().find('.divState').length != 0) {
	            toastr.warning('<div class="font14">진행상태값이 존재하여 삭제가<br/>불가능 합니다.</div>');
	            return;
	        }
	        
	        $chk.each(function() {
	            var recConId = $(this).next().val();
	            if (recConId !=  '${userInfo.CON_ID}' && '${userInfo.ADMIN_YN}' === 'N') {
	                result += 'N';
	            } else {
	                result += 'Y';
	            }
	        });
	        
	        if (result.indexOf('N') === -1) 
	        {
		        if (confirm('정말 삭제 하시겠습니까?')) {
			        var arrayChk = [];
			        
			        $chk.each(function() {
			            arrayChk.push(this.value);
			            $(this).parent().parent().remove();
			        	
			            var $preTableTr = $('#preTable tbody').find('tr');
			            if ($preTableTr.length === 1) {
			                var str = '<tr><td colspan="9">진행현황 목록이 없습니다.</td></tr>';
			                $preTableTr.after(str)
			            }
			        });
			        var data = {'arrayChk' : arrayChk}
			        
			        $.ajax({
		    	        url :  url,
		    	        type : 'post',
		    	        data : data,
		    	        traditional: true,
		    	        success : function(res) {
		    	            if (res.result === 'success')  
		    	                toastr.success('삭제 되었습니다.');
		    	        }
		    	    });
		        }
	        } 
	        else 
	        {
	            toastr.warning('<div class="font14">본인이 등록한 진행현황만 삭제</br>가능 합니다.</div>');
	        }
	        
	    }
	}
	
	/** 진행상태 등록 **/
	function addStatus() {
	    var url = '<c:url value="./addUsrProStatus" />';
	    var $stateTd = $(this).parent().parent();
	    var recId = $stateTd.find(':checkbox').val();
	    var $selected = $stateTd.find('select option:selected');
	    var stateVal = $selected.val();
	    var stateNm = $selected.text();
	    var stateDate = $stateTd.find('.hasDatepicker').val();
	    
	    if (stateVal == '' || stateDate == '') {
	        toastr.warning('상태값을 입력하셔야 합니다.');
	        return;
	    }
	    
	    var data = {
			'recId' : recId,
			'state' : stateVal,
			'stateNm' : stateNm,
			'stateDate' : stateDate,
			'conId' : $('#currentUser').val()
	    };

	    $.ajax({
	        url :  url,
	        type : 'post',
	        data : data,
	        success : function(res) {
	            var result = res.result;
	            
	            if (result === 'success') {
		            var str = '';
		            str += '<div class="divState">';
		            str += '<span class="spanStateDate">' + stateNm + '</span>&nbsp;';
		            str += '<span style="color: #999999; margin-left: 10px;">' + stateDate + '</span>';
		            str += '<span class="delState" id="' + res.staId + '">x</span>';
		            str += '</div>';
		            
		            $stateTd.find('.state').after(str);
	            }
	        }
	    });
	}
	
	/** 진행상태 삭제 **/
	function delStatus() {
	    var url = '<c:url value="./delUsrProStatus" />';
	    var $sta = $(this);
	    
	    if (confirm('정말 삭제 하시겠습니까?')) {
		    $.ajax({
		        url :  url,
		        type : 'post',
		        data : {'staId' : $sta.attr('id')},
		        success : function(res) {
		            var result = res.result;
		            
		            if (result === 'success') {
		                $sta.parent().remove();
		            }
		        }
		    });
	    }
	}
	
	//달력 포커스
	function openDate() {
	    $(this).parent().find('input[name="statusDate"]').focus();
	};
	
	function enterEvent(key) {
        if (key.keyCode == 13) {
            companyPop();
        }
    }
	
</script>