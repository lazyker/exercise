<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script src="/resources/js/vendor/jquery.battatech.excelexport.min.js" type="text/javascript"></script>

<div id="Contents">
    <form id="frm" name="frm" method="post">
    
    <div class="search">
        <div class="b_search">
            <div class="b_search2">
                <span class="p_search">
                	<a href="#this" id="exportExcel">엑셀</a>
                </span>
            </div>
        </div>
    </div>
    <div class="swrap">
        <table class="board_list" id="workReport" style="width:100%;">
            <colgroup>
            <col width="5%" />
            <col width="15%" />
            <col width="*%" />
            <col width="15%" />
            <col width="15%" />
            <col width="15%" />
            </colgroup>
            <tbody>
                <tr>
                    <th>No</th>
                    <th>고객사</th>
                    <th>포지션</th>
                    <th>후보자</th>
                    <th>일자</th>
                    <th>진행</th>
                </tr>
                <c:choose>
                    <c:when test="${!empty workReportList}">
		                <c:forEach items="${workReportList}" var="item">
			                <tr>
			                    <td style="text-align: center"><c:out value="${item.ROWNUM}" /></td>
			                    <td style="text-align: center"> <c:out value="${item.COM_NM}" /></a></td>
			                    <td style="text-align: center"><c:out value="${item.POS_NM}" /></td>
			                    <td style="text-align: center"><c:out value="${item.USR_NM}" /></td>
			                    <td style="text-align: center"><c:out value="${item.REG_DATE}" /></td>
			                    <td style="text-align: center"><c:out value="${item.STATE_NM}" /></td>
			                </tr>
		                </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <tr>
                        	<td colspan="6">목록이 존재하지 않습니다.</td>
                        </tr>
                    </c:otherwise>
                </c:choose>
            </tbody>
        </table>
        <c:if test="${!empty workReportList}">
	        <jsp:include page="../common/paging.jsp" />
        </c:if>
        </div>
        </form>
</div>

<script>
	$(document).ready(init); 
	
	function init() {
	    $("#exportExcel").on('click', function () {
	        $('#workReport').css('width' ,'60%');
	        $("#workReport tbody > tr").last().after('<tr><td style="height: 150px;" colspan="6"></td></tr>');
	        
	        var uri = $("#workReport").battatech_excelexport({
	            containerid: "workReport", 
	            datatype: 'table', 
	            returnUri: true
	        });
	
	        $(this).attr('download', '업무현황 리포트.xls').attr('href', uri);
	        
	        $('#workReport').css('width' ,'100%');
	        $("#workReport tbody > tr").last().remove();
	    });
	}
	
	function goPage(pageNo) {
	    var url = '<c:url value="./workReport" />';
	    var pageInput = $('<input type="hidden" name="pageNo" value="'+pageNo+'" />'); 
	    
	    $("#frm").append(pageInput);
	    $("#frm").attr('href', url).submit();
	}
	
</script>