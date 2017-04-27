<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div id="Contents">
    <form id="frm" name="frm" method="post">
    <input type="hidden" id="searchType" name="searchType" value="<c:out value="${search.searchType}" />" />
    
    <div class="search">
        <div class="b_search">
            <div class="b_search2" style="width: 280px;">
                <span class="p_search" id="delMark"><a href="javascript:;">해제</a></span>
                <span class="p_search" id="popMark"><a href="javascript:;">등록</a></span>
            </div>
        </div>
    </div>
    <div class="swrap">
        <table class="board_list" style="width:100%;">
            <colgroup>
            <col width="5%" />
            <col width="5%" />
            <col width="12%" />
            <col width="15%" />
            <col width="15%" />
            <col width="*" />
            <col width="17%" />
            </colgroup>
            <tbody>
                <tr>
                	<th>선택</th>
                    <th>No</th>
                    <th>후보자</th>
                    <th>최종학교</th>
                    <th>전공</th>
                    <th>경력회사</th>
                    <th>직무</th>
                </tr>
                <c:choose>
                    <c:when test="${!empty markList}">
		                <c:forEach items="${markList}" var="item">
			                <tr>
			                	<td><input type="checkbox" name="chk" value='<c:out value="${item.MARK_ID}" />'/></td>
			                    <td><c:out value="${item.ROWNUM}" /></td>
			                    <td class="select" 
			                    	data-mark-id='${item.MARK_ID}' 
			                    	data-con-id='${item.CON_ID}'
			                    	data-usr-id='${item.USR_ID}'>
			                    	<a href="javascript:;"><c:out value="${item.USR_INFO}" /></a>
			                    </td>
			                    <td><c:out value="${item.USR_SCHOOL}" /></td>
			                    <td><c:out value="${item.USR_MAJOR}" /></td>
			                    <td><c:out value="${item.C_NAME}" /></td>
			                    <td><c:out value="${item.JOB1_NM}" /><c:if test="${!empty item.JOB2_NM }"> / <c:out value="${item.JOB2_NM }" /></c:if></td>
			                </tr>
		                </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <tr>
                        	<td colspan="7">목록이 존재하지 않습니다.</td>
                        </tr>
                    </c:otherwise>
                </c:choose>
            </tbody>
        </table>
        <c:if test="${!empty markList}">
	        <jsp:include page="../common/paging.jsp" />
        </c:if>
        </div>
        </form>
</div>

<script>
	$(document).ready(init); 
	
	function init() {
	    $('#delMark').on('click', delMark);
	    $('#popMark').on('click', popMark);
	    $(document).on('click', '.select', detailCandidate);
	}
	
	function goPage(pageNo) {
	    var url = '<c:url value="./markList" />';
	    var pageInput = $('<input type="hidden" name="pageNo" value="'+pageNo+'" />'); 
	    
	    $("#frm").append(pageInput);
	    $("#frm").attr('href', url).submit();
	}
	
	function popMark() {
	    var url = '<c:url value="./markPop" />';
		var popWidth = 500, popHeight = 450;
		var mtWidth = document.body.clientWidth;
		var mtHeight = document.body.clientHeight;
		var scX = window.screenLeft;
		var scY = window.screenTop;
		var popX = scX + (mtWidth - popWidth) / 2 - 50;
		var popY = scY + (mtHeight - popHeight) / 2 - 50;
		
		window.open(encodeURI(url), "markPop", "width=" + popWidth + ", height=" + popHeight + ", left=" + popX + ", top=" + popY, 
		        "scrollbars=yes, toolbar=no menubar=no, location=no");
	}
	
	/* 관심 등록 */
	function setMark(param) {
	    var url = '<c:url value="./setMark" />';
	    
	    $.ajax({
	        url :  url,
	        type : 'post',
	        data : param,
	        success : function(res) {
	            var result = res.result;
	            
	            if (result === 'success') {
	                toastr.success('관심DB에 등록 되었습니다.');
	                
	                window.setTimeout(function() {
			            document.location.href = '<c:url value="./markList" />';
		            }, 500);
	            } else {
	                toastr.warning('이미 관심DB에 등록된<br/> 후보자 입니다.');
	            }
	            
	        }
	    });
	}
	
	/* 관심 해제 */
	function delMark() {
	    var url = '<c:url value="/support/delMark" />';
	    var $chk = $('input:checkbox[name="chk"]:checked');
	    
	    if ($chk.length == 0) {
	        toastr.warning('선택된 후보자가 없습니다.');
	        return false;
	    } 
	    else {
	        var checkArr = [];
	        $chk.each(function() {
	            checkArr.push(this.value);
	        })
	    }
	    
	    $.ajax({
	        url :  url,
	        type : 'post',
	        data : { 'markIdArr' : checkArr },
	        success : function(res) {
	            var result = res.result;
	            
	            if (result === 'success') {
	                toastr.info('관심DB에서 해제 되었습니다.');
	                
	                window.setTimeout(function() {
			            document.location.href = '<c:url value="./markList" />';
		            }, 500);
	            }
	        }
	    });
	}
	
	/* 후보자 상세화면 이동 */
	function detailCandidate() {
       var authType = '${userInfo.AUTH_USER_TYPE}';
       var conId = $(this).data('conId');
       var currentConId = '${userInfo.CON_ID}';
       
       if (authType === '3' && conId != currentConId) {
           toastr.info('이력서를 조회할 권한이<br/>없습니다.');
       } else {
	       var usrId = $(this).data('usrId');
	       var url = '<c:url value="/candidate/candidateDetail" />' + '?usrId=' + usrId;
	       
	       document.location.href = url;
       }
	}
	
</script>