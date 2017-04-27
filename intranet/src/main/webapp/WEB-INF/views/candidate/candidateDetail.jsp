<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<% pageContext.setAttribute("cn", "\n"); %>

<div id="Contents">
    <form id="candidateForm" name="candidateForm" method="post">
        <input type="hidden" id="usrId" name="usrId" value='<c:out value="${getCandidate.USR_ID}" />' />
        <input type="hidden" id="conId" name="conId" value='<c:out value="${getCandidate.CON_ID}" />' />
        <c:set var="markId" value="${getMarkId}" />
        <input type="hidden" id="markId" name="markId" value='${markId}' />
        <input type="hidden" id="currentUser" name="currentUser" value='<c:out value="${userInfo.CON_ID}" />' />
        
    <div class="swrap">
        <div class="search2">
			<c:if test="${markId ne null}">
				<span class="d_search"><a href="javascript:;" id="delMark">관심해제</a></span>
			</c:if>
				<span class="d_search"><a href="javascript:;" id="setMark">관심등록</a></span>
            <span class="d_search"><a href="<c:url value="./candidate" />">신규</a></span>
            <c:if test="${userInfo.CON_ID eq getCandidate.CON_ID || userInfo.ADMIN_YN eq 'Y'}">
	            <span class="d_search"><a href="javascript:;" id="modCandidate">수정</a></span>
            </c:if>
			<c:if test="${userInfo.ADMIN_YN eq 'Y'}">
				<span class="d_search"><a href="javascript:;" id="delCandidate">삭제</a></span>
			</c:if>
            <span class="d_search"><a href="<c:url value="javascript:location.replace(document.referrer);" />">목록</a></span>
            <span class="p_search"><a href="javascript:;" id="print">인쇄</a></span>
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
                    <th>후보자코드</th>
                    <td id="usrIdClean"><c:out value="${getCandidate.USR_ID}" /></td>
                    <th>등록일</th>
                    <td id="regDateClean"><c:out value="${getCandidate.REG_DATE}" /></td>	  	
                </tr>
                <tr>	
                    <th class="re">성명</th>
                    <td>
                    	<c:out value="${getCandidate.USR_NM}" />
                    	<c:if test="${!empty getCandidate.USR_ID}">
		                    <span class="t_search"><a href="#" id="smsPop">SMS</a></span>
	                    </c:if>
                    </td>
                    <th class="re">업종</th>
                    <td><c:out value="${getCandidate.INDUSTRY1_NM}" /> / <c:out value="${getCandidate.INDUSTRY2_NM}" /> </td>
                </tr>
                <tr>
                    <th>출생년도</th>
                    <td>
                    	<c:out value="${getCandidate.YEAR}" />년 /
                    	<c:if test="${getCandidate.GENDER eq 'M'}">남</c:if>
                    	<c:if test="${getCandidate.GENDER eq 'W'}">여</c:if>
                    </td>
                    <th class="re">직무</th>
                    <td><c:out value="${getCandidate.JOB1_NM}" /> / <c:out value="${getCandidate.JOB2_NM}" /> </td>
                </tr>
                <tr>
                    <th>주소</th>
                    <td><c:out value="${getCandidate.ADDRESS}" /></td>
                    <th>인트라넷 공개</th>
                    <td>
                    	<c:if test="${getCandidate.PUBLIC_YN eq '1'}">공개</c:if>
                    	<c:if test="${getCandidate.PUBLIC_YN eq '0'}">바공개</c:if>
                    </td>
                </tr>
                <tr>
                    <th>외국어</th>
                    <td><c:out value="${getCandidate.LANG}" /></td>
                    <th>자격증</th>
                    <td><c:out value="${getCandidate.LICENSE}" /></td>
                </tr>
                <tr>
                    <th>현재(최종)연봉</th>
                    <td><c:out value="${getCandidate.BASE}" /> 만원</td>
                    <th>희망연봉</th>
                    <td><c:out value="${getCandidate.BONUS}" /> 만원</td>
                </tr>
                <tr>
                	<th>학력사항</th>
                	<td colspan="3">
                		<table class="board_h" style="width:100%; margin:0; ">
            				<colgroup>
					            <col width="25%" />
					            <col width="25%" />
					            <col width="25%" />
					            <col width="25%" />
            				</colgroup>
            				<tbody>
            					<tr>
            						<th style="text-align: center;">학력</th>
            						<th style="text-align: center;">학교</th>
            						<th style="text-align: center;">전공</th>
            						<th style="text-align: center;">졸업구분</th>
            					</tr>
          						<c:forEach var="item" items="${getUsrAcademicList}" begin="0" end="3" varStatus="status">
          							<c:if test="${item.USR_LEVEL ne '' || item.USR_SCHOOL ne '' || item.USR_MAJOR  ne '' || item.USR_TYPE ne ''}">
		            					<tr>
		            						<td style="text-align: center;">
						                        <c:if test="${item.USR_LEVEL eq '1'}">박사</c:if>
					                            <c:if test="${item.USR_LEVEL eq '2'}">석사</c:if>
					                            <c:if test="${item.USR_LEVEL eq '3'}">학사</c:if>
					                            <c:if test="${item.USR_LEVEL eq '4'}">전문학사</c:if>
					                            <c:if test="${item.USR_LEVEL eq '5'}">무관</c:if>
		            						</td>
		            						<td style="text-align: center;"><c:out value="${item.USR_SCHOOL}" /></td>
		            						<td style="text-align: center;"><c:out value="${item.USR_MAJOR}" /></td>
		            						<td style="text-align: center;">
						                        <c:if test="${item.USR_TYPE eq '1'}">졸업</c:if>
					                            <c:if test="${item.USR_TYPE eq '2'}">졸업예정</c:if>
					                            <c:if test="${item.USR_TYPE eq '3'}">수료</c:if>
					                            <c:if test="${item.USR_TYPE eq '4'}">편입</c:if>
					                            <c:if test="${item.USR_TYPE eq '5'}">중퇴</c:if>
					                            <c:if test="${item.USR_TYPE eq '6'}">재학중</c:if>
					                            <c:if test="${item.USR_TYPE eq '7'}">기타</c:if>
		            						</td>
		            					</tr>
          							</c:if>
           						</c:forEach>
           						<c:if test="${fn:length(getUsrAcademicList) == 0}">
  									<tr>
  										<td colspan="4" style="text-align: center;">등록된 학력사항이 없습니다.</td>
  									</tr>
          						</c:if>
            				</tbody>
            			</table>
                	</td>
                </tr>
                <tr>
                    <th class="re">경력회사(최근순)</th>
                    <td colspan="3"><c:out value="${getCandidate.C_NAME}" /></td>
                </tr>
                <tr>
					<th>경력요약</th>
                   	<td colspan="3"><c:out value="${fn:replace(getCandidate.SUMMARY, cn, '<br/>')}" escapeXml="false" /></td>
                </tr>
                <tr>
                	<th>상세경력</th>
					<td colspan="3"><c:out value="${fn:replace(getCandidate.DETAIL, cn, '<br/>')}" escapeXml="false" /></td>
                </tr>
                <tr>
                    <th class="re">출처</th>
                    <td>
                        <c:if test="${getCandidate.SOURCES eq 'A'}">잡코리아</c:if>
                        <c:if test="${getCandidate.SOURCES eq 'B'}">인크루트</c:if>
                        <c:if test="${getCandidate.SOURCES eq 'C'}">스카우트</c:if>
                        <c:if test="${getCandidate.SOURCES eq 'D'}">사람인</c:if>
                        <c:if test="${getCandidate.SOURCES eq 'E'}">기타 잡포탈</c:if>
                        <c:if test="${getCandidate.SOURCES eq 'F'}">명부</c:if>
                        <c:if test="${getCandidate.SOURCES eq 'G'}">지인소개</c:if>
                        <c:if test="${getCandidate.SOURCES eq 'H'}">개인DB</c:if>
                        <c:if test="${getCandidate.SOURCES eq 'I'}">직접지원</c:if>
                        <c:if test="${getCandidate.SOURCES eq 'J'}">기타</c:if>
                        <c:if test="${getCandidate.SOURCES eq 'K'}">Old DB</c:if>
                        <c:if test="${getCandidate.SOURCES eq '*********'}">*********</c:if>
                    </td>
                    <th>등록자</th>
                    <td><c:out value="${getCandidate.CON_NM}" /></td>
                </tr>
                <tr>
                    <th class="re">연락처</th>
                    <td>
                    	(HP) <c:out value="${getCandidate.MOBILE}" />
						&nbsp; ☎  <c:out value="${getCandidate.PHONE}" />
                    </td>
                    <th class="re">E-mail</th>
                    <td><c:out value="${getCandidate.EMAIL}" /></td>
                </tr>
                <tr>
                    <th>국문이력서1</th>
                    <td>
                    	<div class="filebox">
                            <c:choose>
                                <c:when test="${empty fileMap.originalFileNm_1}">
                                    <a href="javascript:;" class="upload-name">파일선택</a>
                                </c:when>
                                <c:otherwise>
                                	<input type="hidden" name="attId_1" value='<c:out value="${fileMap.attId_1}"></c:out>' />
                                    <a href="javascript:;" data-att-id='<c:out value="${fileMap.attId_1}" />' class="upload-name" style="width: 90%">
                                    	<c:out value="${fileMap.originalFileNm_1}" /> (<c:out value="${fileMap.fileSize_1}" />kb)
                                    </a>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </td>
                    <th>영문이력서1</th>
                    <td>
	                    <div class="filebox">
                            <c:choose>
                                <c:when test="${empty fileMap.originalFileNm_2}">
                                    <a href="javascript:;" class="upload-name">파일선택</a>
                                </c:when>
                                <c:otherwise>
                                	<input type="hidden" name="attId_2" value='<c:out value="${fileMap.attId_2}"></c:out>' />
                                    <a href="javascript:;" data-att-id='<c:out value="${fileMap.attId_2}" />' class="upload-name" style="width: 90%">
                                    	<c:out value="${fileMap.originalFileNm_2}" /> (<c:out value="${fileMap.fileSize_2}" />kb)
                                    </a>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </td>
                </tr>
                <tr>
                    <th>국문이력서2</th>
                    <td>
                    	<div class="filebox">
                            <c:choose>
                                <c:when test="${empty fileMap.originalFileNm_3}">
                                    <a href="javascript:;" class="upload-name">파일선택</a>
                                </c:when>
                                <c:otherwise>
                                	<input type="hidden" name="attId_3" value='<c:out value="${fileMap.attId_3}"></c:out>' />
                                    <a href="javascript:;" data-att-id='<c:out value="${fileMap.attId_3}" />' class="upload-name" style="width: 90%">
                                    	<c:out value="${fileMap.originalFileNm_3}" /> (<c:out value="${fileMap.fileSize_3}" />kb)
                                    </a>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </td>
                    <th>영문이력서2</th>
                    <td>
	                    <div class="filebox">
                            <c:choose>
                                <c:when test="${empty fileMap.originalFileNm_4}">
                                    <a href="javascript:;" class="upload-name">파일선택</a>
                                </c:when>
                                <c:otherwise>
                                	<input type="hidden" name="attId_4" value='<c:out value="${fileMap.attId_4}"></c:out>' />
                                    <a href="javascript:;" data-att-id='<c:out value="${fileMap.attId_4}" />' class="upload-name" style="width: 90%">
                                    	<c:out value="${fileMap.originalFileNm_4}" /> (<c:out value="${fileMap.fileSize_4}" />kb)
                                    </a>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </td>
                </tr>
                <tr>
                    <th>추천서</th>
                    <td>
                    	<div class="filebox">
                            <c:choose>
                                <c:when test="${empty fileMap.originalFileNm_5}">
                                    <a href="javascript:;" class="upload-name">파일선택</a>
                                </c:when>
                                <c:otherwise>
                                	<input type="hidden" name="attId_5" value='<c:out value="${fileMap.attId_5}"></c:out>' />
                                    <a href="javascript:;" data-att-id='<c:out value="${fileMap.attId_5}" />' class="upload-name" style="width: 90%">
                                    	<c:out value="${fileMap.originalFileNm_5}" /> (<c:out value="${fileMap.fileSize_5}" />kb)
                                    </a>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </td>
                    <th>기타</th>
                    <td>
	                    <div class="filebox">
                            <c:choose>
                                <c:when test="${empty fileMap.originalFileNm_6}">
                                    <a href="javascript:;" class="upload-name">파일선택</a>
                                </c:when>
                                <c:otherwise>
                                	<input type="hidden" name="attId_6" value='<c:out value="${fileMap.attId_6}"></c:out>' />
                                    <a href="javascript:;" data-att-id='<c:out value="${fileMap.attId_6}" />' class="upload-name" style="width: 90%">
                                    	<c:out value="${fileMap.originalFileNm_6}" /> (<c:out value="${fileMap.fileSize_6}" />kb)
                                    </a>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </td>
                </tr>
            </tbody>
        </table>
        
        <c:if test="${!empty getCandidate.USR_ID}">
			<jsp:include page="/WEB-INF/views/common/comment.jsp" />        
        </c:if>
        
        <c:if test="${!empty getCandidate.USR_ID}">
        <p class="s_title">진행현황</p>
        <p style="float:right; margin-top:15px;">
            <span class="d_search"><a href="javascript:;" id="delPresent">삭제</a></span>
            <span class="p_search"><a href="javascript:;" id="positionAddPop">등록</a></span>
        </p>
        
        <table id="preTable" class="board_list" style="width:100%;">
            <colgroup>
            <col width="4%" />
            <col width="4%" />
            <col width="15%" />
            <col width="25%" />
            <col width="10%" />
            <col width="7%" />
            <col width="28%" />
            <col width="6%" />
            </colgroup>
            <tbody>
                <tr>
                	<th>선택</th>
                    <th>No</th>
                    <th>회사명</th>
                    <th>포지션</th>
                    <th>포지션등록일</th>
                    <th>등록자</th>
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
	                    <td><c:out value="${item.COM_NM}" /></td>
	                    <td><c:out value="${item.POS_NM}" /></td>
	                    <td><c:out value="${item.REG_DATE}" /></td>
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
	                    	<c:if test="${item.CON_ID eq userInfo.CON_ID || getCandidate.CON_ID eq userInfo.CON_ID || userInfo.ADMIN_YN eq 'Y'}">
	                    		<span class="t_p"><a href="javascript:;">추가</a></span>
	                    	</c:if>
	                    </td>
	                </tr>
                </c:forEach>
                <c:if test="${empty progressList}">
                	<tr>
                		<td colspan="8">진행현황 목록이 없습니다.</td>
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
	    $('#modCandidate').on('click', modCandidate);
	    $('#delCandidate').on('click', delCandidate);
	    $('#print').on('click', PrintElem);
	    $(document).on('click', '#setMark', setMark);
	    $(document).on('click', '#delMark', delMark);
	    $('.upload-name').on('click', downloadFile);
	    $('#smsPop').on('click', smsPop);
	    
	    $('#positionAddPop').on('click', positionAddPop);
	    $('#delPresent').on('click', delPresent);
	    $('input[name="statusDate"]').datepicker();
	    $(document).on('click','a[name="statusDateImg"]',openDate);
	    $(document).on('click','.t_p',addStatus);
	    $(document).on('click','.delState',delStatus);
	}
	
	function modCandidate() {
	    var usrId = $('#usrId').val();
		var url = '<c:url value="./candidate" />' + '?usrId=' + usrId;
	       
		document.location.href = url;
	}
	
	function delCandidate() {
	    if (confirm('정말 삭제 하시겠습니까?')) {
			var url = '<c:url value="./delCandidate" />';
			var form = document.candidateForm;
			form.action = url;
			form.submit();
	    }
	}
	
	/* SMS 팝업창 */
	function smsPop() {
	    var url = '<c:url value="./smsPop" />';
	    url += '?toTarget=${getCandidate.MOBILE}';
	    
	    popupCenter(encodeURI(url), "smsPop", 540, 450);
	}
	
	function positionAddPop() {
	    var url = '<c:url value="./positionAddPop" />';
	    
	    popupCenter(url, "positionAddPop", 500, 450);
	}
	
	function downloadFile() {
	    var attId = $(this).data('attId');
	    var authUserType = '${userInfo.AUTH_USER_TYPE}';
	    var currentUserId = '${userInfo.CON_ID}';
	    var conId = $('#conId').val();
	    
	    if (authUserType === '1' || conId === currentUserId) {
		    if (attId != undefined) {
			    var url = '<c:url value="/downloadFile" />';
			    url += '?attId=' + attId;
			    
			    $(location).attr('href', url);
		    }
	    } else {
	        toastr.info('다운로드 권한이 없습니다.');    
	    }
	}
	
	/** 진행현황 등록 **/
	function addPostionPresent(param) {
	    var url = '<c:url value="./addPositionPresent" />';
	    var data = {
	      usrId : $('#usrId').val(),
	      posId : param.posId,
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
	            str += '<td><input type="checkbox" name="chk" value="' + result.REC_ID + '" /></td>';
	            str += '<td>' + (Number(indexTxt)+1) + '</td>';
	            str += '<td>' + result.COM_NM + '</td>';
	            str += '<td>' + result.POS_NM + '</td>';
	            str += '<td>' + result.REG_DATE + '</td>';
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
	    var url = '<c:url value="./delPosRecPresent" />';
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
			                var str = '<tr><td colspan="8">진행현황 목록이 없습니다.</td></tr>';
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
	    var url = '<c:url value="./addPosProStatus" />';
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
	    var url = '<c:url value="./delPosProStatus" />';
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

	//관심등록
	function setMark() {
	    var url = '<c:url value="/support/setMark" />';
	    
	    $.ajax({
	        url :  url,
	        type : 'post',
	        data : { 'usrId' : $('#usrId').val() },
	        success : function(res) {
	            var result = res.result;
	            
	            if (result === 'success') {
	                toastr.success('관심DB에 등록 되었습니다.');  
	                $('.search2').prepend('<span class="d_search"><a href="javascript:;" id="delMark">관심해제</a></span>');
	                $('#markId').val(res.markId);
	            } else {
	                toastr.warning('이미 관심DB에 등록된 후보자 입니다.');
	            }
	        }
	    });
	}
	
	//관심 해제
	function delMark() {
	    var url = '<c:url value="/support/delMark" />';
	    
	    $.ajax({
	        url :  url,
	        type : 'post',
	        data : { 
	            		'usrId' : $('#usrId').val(),
	            		'markId' : $('#markId').val()
	            	 },
	        success : function(res) {
	            var result = res.result;
	            
	            if (result === 'success') {
	                toastr.error('관심DB에서 해제 되었습니다.');
	                $('#delMark').remove();
	            }
	        }
	    });
	}
	
	function PrintElem() {
	    $('.board_h:first, .s_title, .commentBody, #preTable').printThis({
	        debug: false,
	        importCSS: true,
	        loadCSS : ['${pageContext.request.contextPath}/resources/css/jquery-ui.min.css',
	                   '${pageContext.request.contextPath}/resources/css/common.css',
	                   '${pageContext.request.contextPath}/resources/css/layout.css']
	    });
	}
</script>