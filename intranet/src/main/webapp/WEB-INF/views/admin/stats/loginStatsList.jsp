<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div id="Contents">
    <form id="frm" name="frm" method="post">
    
    <div class="search">
        <div class="b_search">
            <div class="b_search3">
            	<span class="de_t2">컨설턴트</span>
            	<span>
            		<select name="conId" class="sel02" style="width:100px;" <c:if test="${!empty getCandidate.USR_ID}">disabled</c:if>>
                        <option value="">전체</option>
                        <c:forEach items="${consultantList}" var="consultant">
                            <option value="${consultant.CON_ID}" <c:if test="${search.conId eq consultant.CON_ID}">selected</c:if>>
                            	<c:out value="${consultant.CON_NM}" />
                            </option>
                        </c:forEach>
                    </select>
            	</span>
            	<span class="de_t2">기간</span>
            	<span>
            		<input id="startDate" name="startDate" type="text" class="in fl mr3" value='<c:out value="${search.startDate}" />' style="width:83px; float: none;" />
	                <span class="fl" style="float: none;">~</span>
	                <input id="endDate" name="endDate" type="text" class="in fl mr3" value='<c:out value="${search.endDate}" />' style="width:83px; float: none;" />
            	</span>
                <span class="p_search" id="search"><a href="javascript:;">검색</a></span>
            </div>
        </div>
    </div>
    <div class="swrap">
        <table class="board_list" style="width:100%;">
            <colgroup>
            <col width="5%" />
            <col width="15%" />
            <col width="*%" />
            <col width="30%" />
            <col width="20%" />
            </colgroup>
            <tbody>
                <tr>
                    <th>No</th>
                    <th>컨설턴트</th>
                    <th>접속 IP</th>
                    <th>접속일시</th>
                    <th>로그인 성공 여부</th>
                </tr>
                <c:choose>
                    <c:when test="${!empty loginStatsList}">
		                <c:forEach items="${loginStatsList}" var="item">
			                <tr>
			                    <td><c:out value="${item.ROWNUM}" /></td>
			                    <td> <c:out value="${item.CON_NM}" /></a></td>
			                    <td><c:out value="${item.IP}" /></td>
			                    <td><c:out value="${item.REG_DATE}" /></td>
			                    <td><c:out value="${item.PASS_YN}" /></td>
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
        <c:if test="${!empty loginStatsList}">
	        <jsp:include page="../../common/paging.jsp" />
        </c:if>
        </div>
        </form>
</div>

<script>
	$(document).ready(init); 
	
	function init() {
	    $("#startDate").datepicker();
        $("#endDate").datepicker();
	    $('#search').on('click', search);
	}
	
	function goPage(pageNo) {
	    var url = '<c:url value="./loginStats" />';
	    var pageInput = $('<input type="hidden" name="pageNo" value="'+pageNo+'" />'); 
	    
	    $("#frm").append(pageInput);
	    $("#frm").attr('href', url).submit();
	}
	
	function search() {
		var url = '<c:url value="./loginStats" />';
	    
        $("#frm").attr('href', url).submit();
	}
	
</script>