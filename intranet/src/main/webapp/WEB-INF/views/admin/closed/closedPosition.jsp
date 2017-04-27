<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div id="Contents">
    <form id="frm" name="frm" method="post">
    <input type="hidden" id="closedDataType" value='<c:out value="${base.closedDataType}" />' />
    
    <div class="search">
    	<ul class="tab2">
			<li class="tab01_on"><a href="./closedData?type=P">포지션</a></li>
			<li class="tab01"><a href="./closedData?type=C">후보자</a></li>
        </ul>
    </div>
    <div class="swrap">
        <table class="board_list" style="width:100%;">
            <colgroup>
            	<col width="8%" />
	            <col width="*" />
	            <col width="10%" />
	            <col width="20%" />
	            <col width="8%" />
	            <col width="5%" />
	            <col width="10%" />
	            <col width="10%" />
	            <col width="10%" />
	            <col width="10%" />
            </colgroup>
            <tbody>
                <tr>
                    <th>No</th>
                    <th>포지션</th>
                    <th>경력</th>
                    <th>회사명</th>
                    <th>방식</th>
                    <th>추천</th>
                    <th>컨설턴트</th>
                    <th>등록일</th>
                    <th>상태</th>
                    <th>공개여부</th>
                </tr>
                <c:choose>
                    <c:when test="${!empty positionList}">
		                <c:forEach items="${positionList}" var="item">
			                <tr>
			                    <td><c:out value="${item.ROWNUM}" /></td>
			                    <td class="select" data-pos-id='${item.POS_ID}'>
			                    	<a href="javascript:;"><c:out value="${item.POS_NM}" /></a>
			                    </td>
			                    <td><c:out value="${item.CAREER}" /></td>
			                    <td><c:out value="${item.COM_NM}" /></a></td>
			                    <td><c:out value="${item.RULE}" /></td>
			                    <td><c:out value="${item.REC_CNT}" /></td>
			                    <td><c:out value="${item.CON_NM}" /></td>
			                    <td><c:out value="${item.REG_DATE}" /></td>
			                    <td><c:out value="${item.POS_STATUS}" /></td>
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
                        	<td colspan="10">목록이 존재하지 않습니다.</td>
                        </tr>
                    </c:otherwise>
                </c:choose>
            </tbody>
        </table>
        <c:if test="${!empty positionList}">
	        <jsp:include page="../../common/paging.jsp" />
        </c:if>
        </div>
        </form>
</div>

<script>
	$(document).ready(init); 
	
	function init() {
	    $('.sel02').on('change', changePublicYn);
	    $(document).on('click', '.select', detailPosition);
	}
	
	function changePublicYn() {
	    var url = '<c:url value="./changePublicYn" />';
        var posId = $(this).parent().parent().find('.select').data('posId');
        var publicYnVal = $(this).val();
        
        $.ajax({
	        url :  url,
	        type : 'post',
	        data : {
	            		'posId' : posId,
	            		'publicYn' : publicYnVal,
	            		'closedDataType' : $('closedDataType').val()
	            	},
	        success : function(res) {
	            toastr.success('변경처리 되었습니다.');
	        }
	    });
	}
	
	function detailPosition() {
       var posId = $(this).data('posId');
       var url = '<c:url value="/position/position" />' + '?posId=' + posId;
       
       document.location.href = url;
	}
	
	function goPage(pageNo) {
	    var url = '<c:url value="./closedData" />';
	    var pageInput = $('<input type="hidden" name="pageNo" value="'+pageNo+'" />'); 
	    
	    $("#frm").append(pageInput);
	    $("#frm").attr('href', url).submit();
	}
	
</script>