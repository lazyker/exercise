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
            <span class="d_search"><a href="<c:url value="./position" />">신규</a></span>
            <span class="d_search"><a href="javascript:;" id="copyPosition">복사</a></span>
            <c:if test="${userInfo.CON_ID eq getPosition.CON_ID || userInfo.CON_ID eq getPosition.S_CON_ID || userInfo.ADMIN_YN eq 'Y'}">
	            <span class="d_search"><a href="javascript:;" id="modPosition">수정</a></span>
            </c:if>
			<c:if test="${userInfo.ADMIN_YN eq 'Y'}">
				<span class="d_search"><a href="javascript:;" id="delPosition">삭제</a></span>
			</c:if>
            <span class="d_search"><a href="<c:url value="javascript:history.back(-1);" />">목록</a></span>
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
                    <th>포지션코드</th>
                    <td id="posIdClean"><c:out value="${getPosition.POS_ID}" /></td>
                    <th>등록일</th>
                    <td id="regDateClean"><c:out value="${getPosition.REG_DATE}" /></td>	  	
                </tr>
                <tr>	
                    <th class="re">포지션</th>
                    <td><c:out value="${getPosition.POS_NM}" /></td>
                    <th class="re">회사명</th>
                    <td><c:out value="${getPosition.COM_NM}" /></td>
                </tr>
                <tr>
                    <th class="re">업무방식</th>
                    <td>
                    	<c:if test="${getPosition.RULE eq 'A'}">단독</c:if>
                    	<c:if test="${getPosition.RULE eq 'B'}">협업</c:if>
                    	<c:if test="${getPosition.RULE eq 'C'}">양수도</c:if>
                    	<c:if test="${getPosition.RULE eq 'D'}">공동</c:if>
                    	<c:if test="${getPosition.RULE eq 'E'}">기타</c:if>
                    </td>
                    <th class="re">홈페이지 공개</th>
                    <td><c:out value="${getPosition.H_PUBLIC_YN_NM}" /></td>
                </tr>
                <tr>
                    <th class="re">컨설턴트[주|부]</th>
                    <td>
                    	<c:out value="${getPosition.CON_NM}" /> ㅣ <c:out value="${getPosition.S_CON_NM}" /> 
                    </td>
                    <th>진행상태</th>
                    <td><c:out value="${getPosition.POS_STATUS_NM}" /></td>
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
                    		<span id="industry2"><c:if test="${!empty getPosition.INDUSTRY2}"> / </c:if><c:out value="${getPosition.INDUSTRY2}" /></span>
                    	</div>
                    </td>
                    <th class="re">직무</th>
                    <td>
                    	<c:out value="${getPosition.JOB1_NM}" /> / <c:out value="${getPosition.JOB2_NM}" />
                    </td>
                </tr>
                <tr>
                    <th>학력</th>
                    <td>
                    	<c:if test="${getPosition.EDU eq '1'}">박사</c:if>
                    	<c:if test="${getPosition.EDU eq '2'}">석사</c:if>
                    	<c:if test="${getPosition.EDU eq '3'}">학사</c:if>
                    	<c:if test="${getPosition.EDU eq '4'}">전문학사</c:if>
                    	<c:if test="${getPosition.EDU eq '5'}">무관</c:if>
                    </td>
                    <th>직급</th>
                    <td>
                    	<c:if test="${getPosition.FROM_RANK eq 'A'}">임원</c:if>
                    	<c:if test="${getPosition.FROM_RANK eq 'B'}">부장</c:if>
                    	<c:if test="${getPosition.FROM_RANK eq 'C'}">차장</c:if>
                    	<c:if test="${getPosition.FROM_RANK eq 'D'}">과장</c:if>
                    	<c:if test="${getPosition.FROM_RANK eq 'E'}">대리</c:if>
                    	<c:if test="${getPosition.FROM_RANK eq 'F'}">주임</c:if>
                    	<c:if test="${getPosition.FROM_RANK eq 'G'}">사원</c:if>
                    	~
                    	<c:if test="${getPosition.TO_RANK eq 'A'}">임원</c:if>
                    	<c:if test="${getPosition.TO_RANK eq 'B'}">부장</c:if>
                    	<c:if test="${getPosition.TO_RANK eq 'C'}">차장</c:if>
                    	<c:if test="${getPosition.TO_RANK eq 'D'}">과장</c:if>
                    	<c:if test="${getPosition.TO_RANK eq 'E'}">대리</c:if>
                    	<c:if test="${getPosition.TO_RANK eq 'F'}">주임</c:if>
                    	<c:if test="${getPosition.TO_RANK eq 'G'}">사원</c:if>
                    </td>
                </tr>
                <tr>
                    <th class="re">경력</th>
                    <td><c:out value="${getPosition.CAREER}" /></td>
                    <th>외국어</th>
                    <td><c:out value="${getPosition.LANG}" /></td>
                </tr>
                <tr>
                    <th class="re">근무지</th>
                    <td><c:out value="${getPosition.PLACE}" /></td>
                    <th class="re">인트라넷 공개</th>
                    <td><c:out value="${getPosition.PUBLIC_YN_NM}" /></td>
                </tr>
                <tr>
					<th>업무내용</th>
                   	<td colspan="3"><c:out escapeXml="false" value="${fn:replace(getPosition.TASK, cn, '<br/>')}" /></td>
                </tr>
                <tr>
					<th>자격요건</th>
					<td colspan="3"><c:out escapeXml="false" value="${fn:replace(getPosition.POS_CONDITION, cn, '<br/>')}" /></td>
                </tr>
                <tr>
                    <th>타켓연령</th>
                    <td>
                    	<c:out value="${getPosition.FROM_TARGET}" />년
                        ~
                        <c:out value="${getPosition.TO_TARGET}" />년
                    </td>
                    <th>선호기업</th>
                    <td><c:out value="${getPosition.T_COMPANY}" /></td>
                </tr>
                <tr>
                    <th>성별</th>
                    <td><c:out value="${getPosition.GENDER_NM}" /></td>
                    <th>자격증</th>
                    <td><c:out value="${getPosition.LICENSE}" /></td>
                </tr>
                <tr>
                	<th>처우</th>
                    <td>기본급 : <c:out value="${getPosition.BASE}" /></td>
                    <td colspan="2">성과급 : <c:out value="${getPosition.BONUS}" /></td>
                </tr>
                <tr>
                    <th>기타정보</th>
                    <td colspan="3"><c:out value="${getPosition.ETC}" /></td>
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
            <col width="*%" />
            <col width="10%" />
            <col width="7%" />
            <col width="28%" />
            <col width="6%" />
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
	    $('#modPosition').on('click', modPosition);
	    $('#delPosition').on('click', delPosition);
	    $('#copyPosition').on('click', copyPosition);
	    $('#print').on('click', PrintElem);
	    
	    $('#candidateAddPop').on('click', candidateAddPop);
	    $('#delPresent').on('click', delPresent);
	    $('input[name="statusDate"]').datepicker();
	    $(document).on('click','a[name="statusDateImg"]',openDate);
	    $(document).on('click','.t_p',addStatus);
	    $(document).on('click','.delState',delStatus);
	}
	
	function modPosition() {
	    var posId = $('#posId').val();
		var url = '<c:url value="./position" />' + '?posId=' + posId;
	       
		document.location.href = url;
	}
	
	function delPosition() {
	    if (confirm('정말 삭제 하시겠습니까?')) {
			var url = '<c:url value="./delPosition" />';
			var form = document.positionForm;
			form.action = url;
			form.submit();
	    }
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
	
	//복사 버튼 이벤트
	function copyPosition() {
		toastr.success('복사가 완료 되었습니다.');
		
		window.setTimeout(function() {
		    var url = '<c:url value="./copyPosition" />';
			var form = document.positionForm;
			form.action = url;
			form.submit();
        }, 300);
		
	}
	
	function PrintElem() {
// 	    var $elem = $('#Contents'); 
	    $('.board_h, .s_title, .commentBody, #preTable').printThis({
	        debug: false,
	        importCSS: true,
	        loadCSS : ['${pageContext.request.contextPath}/resources/css/jquery-ui.min.css',
	                   '${pageContext.request.contextPath}/resources/css/common.css',
	                   '${pageContext.request.contextPath}/resources/css/layout.css']
	    });
// 	Popup($($elem).html());
	}
	function Popup(data) {
		var mywindow = window.open('', 'my div', 'height=400,width=600');
		mywindow.document.write('<html><head><title>my div</title>');
		mywindow.document.write('</head><body >');
		mywindow.document.write(data);
		mywindow.document.write('</body></html>');
		mywindow.document.close(); // IE >= 10에 필요
		mywindow.focus(); // necessary for IE >= 10
		mywindow.print();
		mywindow.close();
		return true;
	}
	
//     function getNumber(){
// 		var obj = this;
//          var num01;
//          var num02;
//          num01 = obj.value;
//          num01 == 0 ? '' : num01;
//          num02 = num01.replace(/\D/g,"");
//          num01 = setComma(num02);
//          obj.value =  num01;

//     }
	
//     function setComma(x){
//         return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
//     }
</script>