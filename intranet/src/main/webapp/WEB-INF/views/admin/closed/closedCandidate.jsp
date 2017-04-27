<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div id="Contents">
    <form id="frm" name="frm" method="post">
    
    <div class="search">
    	<ul class="tab2">
			<li class="tab01"><a href="./closedData?type=P">포지션</a></li>
			<li class="tab01_on"><a href="./closedData?type=C">후보자</a></li>
        </ul>
    </div>
    <div class="swrap">
        <table class="board_list" style="width:100%;">
            <colgroup>
            	<col width="8%" />
	            <col width="15%" />
	            <col width="20%" />
	            <col width="15%" />
	            <col width="*%" />
	            <col width="12%" />
	            <col width="10%" />
	            <col width="10%" />
            </colgroup>
            <tbody>
                <tr>
                    <th>No</th>
                    <th>후보자</th>
                    <th>최종학교</th>
                    <th>전공</th>
                    <th>경력회사</th>
                    <th>직무</th>
                    <th>컨설턴트</th>
                    <th>공개여부</th>
                </tr>
                <c:choose>
                    <c:when test="${!empty candidateList}">
		                <c:forEach items="${candidateList}" var="item">
			                <tr>
			                    <td><c:out value="${item.ROWNUM}" /></td>
			                    <td class="select" data-usr-id='${item.USR_ID}' data-con-id='${item.CON_ID}'>
			                    	<a href="javascript:;"><c:out value="${item.USR_INFO}" /></a>
			                    </td>
			                    <td><c:out value="${item.USR_SCHOOL}" /></td>
			                    <td><c:out value="${item.USR_MAJOR}" /></td>
			                    <td><c:out value="${item.C_NAME}" /></td>
			                    <td>
			                    	<c:out value="${item.JOB1_NM}" /><c:if test="${!empty item.JOB2_NM }"> / <c:out value="${item.JOB2_NM }" /></c:if>
			                    </td>
			                    <td><c:out value="${item.CON_NM}" /></td>
			                    <td>
			                    	<select class="sel02"  style="width: 80px;">
			                    		<option value="N">비공개</option>
			                    		<option value="Y">공개</option>
			                    	</select>
			                    </td>
			                </tr>
		                </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <tr>
                        	<td colspan="8">목록이 존재하지 않습니다.</td>
                        </tr>
                    </c:otherwise>
                </c:choose>
            </tbody>
        </table>
        <c:if test="${!empty candidateList}">
	        <jsp:include page="../../common/paging.jsp" />
        </c:if>
        </div>
        </form>
</div>

<script>
	$(document).ready(init); 
	
	function init() {
	    $('.sel02').on('change', changePublicYn);
	    $(document).on('click', '.select', detailCandidate);
	}
	
	function changePublicYn() {
	    var url = '<c:url value="./changePublicYn" />';
        var usrId = $(this).parent().parent().find('.select').data('usrId');
        var publicYnVal = $(this).val();
        var publicYnText = publicYnVal === 'Y' ? '공개' : '비공개'; 
        
        $.ajax({
	        url :  url,
	        type : 'post',
	        data : {
	            		'usrId' : usrId,
	            		'publicYn' : publicYnVal,
	            		'closedDataType' : $('closedDataType').val()
	            	},
	        success : function(res) {
	            toastr.success(publicYnText + '로 변경처리 되었습니다.');
	        }
	    });
	}
	
	function detailCandidate() {
       var usrId = $(this).data('usrId');
       var url = '<c:url value="/candidate/candidate" />' + '?usrId=' + usrId;
       
       document.location.href = url;
	}
	
	function goPage(pageNo) {
	    var url = '<c:url value="./closedData" />';
	    var pageInput = $('<input type="hidden" name="pageNo" value="'+pageNo+'" />'); 
	    
	    $("#frm").append(pageInput);
	    $("#frm").attr('href', url).submit();
	}
	
</script>