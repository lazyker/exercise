<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div id="Contents">
    <!--검색영역-->
    <form id="frm" name="frm" method="post">
    <input type="hidden" id="searchType" name="searchType" value="<c:out value="${search.searchType}" />" />
    
    <div class="search">
        <div class="b_search">
            <div class="b_search2" style="width: 280px;">
                <input class="t_search" type="text" name="searchText" id="searchText" placeholder="제목, 내용" value='<c:out value="${search.searchText}" />' />
                <span class="search_icon pl5"><a href="#" id="search"></a></span>
                <span class="p_search"><a href="<c:url value="./notice" />">등록</a></span>
            </div>
        </div>
    </div>
    <div class="swrap">
        <table class="board_list" style="width:100%;">
            <colgroup>
            <col width="8%" />
            <col width="*" />
            <col width="8%" />
            <col width="5%" />
            <col width="10%" />
            </colgroup>
            <tbody>
                <tr>
                    <th>No</th>
                    <th>제목</th>
                    <th>등록자</th>
                    <th>첨부</th>
                    <th>등록일</th>
                </tr>
                <c:choose>
                    <c:when test="${!empty boardList}">
		                <c:forEach items="${boardList}" var="item">
			                <tr>
			                    <td><c:out value="${item.ROWNUM}" /></td>
			                    <td class="select" data-bod-id='${item.BOD_ID}' style="text-align: left; padding-left: 5px;}">
			                    	<a href="#javascript;"><c:out value="${item.TITLE}" /></a>
			                    </td>
			                    <td>
			                    	<c:out value="${item.CON_NM}" />
			                    </td>
			                    <td>
			                    	<c:if test="${item.ATT_CNT eq '1'}">
			                    		<i class="fa fa-file" aria-hidden="true"></i>
			                    	</c:if>
			                    </td>
			                    <td><c:out value="${item.REG_DATE}" /></td>
			                </tr>
		                </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <tr>
                        	<td colspan="4">목록이 존재하지 않습니다.</td>
                        </tr>
                    </c:otherwise>
                </c:choose>
            </tbody>
        </table>
        <c:if test="${!empty boardList}">
	        <jsp:include page="../common/paging.jsp" />
        </c:if>
        </div>
        </form>
</div>

<script>
	$(document).ready(init); 
	
	function init() {
	    $('#search').on('click', search); 
        $(document).on('click', '.select', detailNotice);
        
	    $('#searchText').on('keydown', function(key) {
	        if (key.keyCode == 13) {
	            search();
	        }
	    });
	}
	
	function goPage(pageNo) {
	    var url = '<c:url value="./noticeList" />';
	    var pageInput = $('<input type="hidden" name="pageNo" value="'+pageNo+'" />'); 
	    
	    $("#frm").append(pageInput);
	    $("#frm").attr('href', url).submit();
	}
	
	function search() {
	    var url = '<c:url value="./noticeList" />';
        $("#frm").attr('href', url).submit();
	}
	
	function detailNotice() {
		var bodId = $(this).data('bodId');
		var url = '<c:url value="./noticeDetail" />' + '?bodId=' + bodId;
       
		document.location.href = url;
	}
	
</script>