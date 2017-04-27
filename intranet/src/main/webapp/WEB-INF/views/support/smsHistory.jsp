<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<div id="Contents">
    <form id="frm" name="frm" method="post">
    
    <div class="search">
        <div class="b_search">
            <div class="b_search2">
	            <span>
            		<select name="year" class="sel02" style="width:100px;" <c:if test="${!empty getCandidate.USR_ID}">disabled</c:if>>
                        <c:forEach items="${yearList}" var="value">
                            <option value="${value.YEAR}" <c:if test="${search.year eq value.YEAR}">selected</c:if>>
                            	<c:out value="${value.YEAR}년" />
                            </option>
                        </c:forEach>
                    </select>
	            </span>
	            <span>
            		<select name="month" class="sel02" style="width:100px;" <c:if test="${!empty getCandidate.USR_ID}">disabled</c:if>>
                        <option value="01" <c:if test="${search.month eq '01'}">selected</c:if>>1월</option>
                        <option value="02" <c:if test="${search.month eq '02'}">selected</c:if>>2월</option>
                        <option value="03" <c:if test="${search.month eq '03'}">selected</c:if>>3월</option>
                        <option value="04" <c:if test="${search.month eq '04'}">selected</c:if>>4월</option>
                        <option value="05" <c:if test="${search.month eq '05'}">selected</c:if>>5월</option>
                        <option value="06" <c:if test="${search.month eq '06'}">selected</c:if>>6월</option>
                        <option value="07" <c:if test="${search.month eq '07'}">selected</c:if>>7월</option>
                        <option value="08" <c:if test="${search.month eq '08'}">selected</c:if>>8월</option>
                        <option value="09" <c:if test="${search.month eq '09'}">selected</c:if>>9월</option>
                        <option value="10" <c:if test="${search.month eq '10'}">selected</c:if>>10월</option>
                        <option value="11" <c:if test="${search.month eq '11'}">selected</c:if>>11월</option>
                        <option value="12" <c:if test="${search.month eq '12'}">selected</c:if>>12월</option>
                    </select>
	            </span>
                <span class="p_search" id="search"><a href="javascript:;">검색</a></span>
            </div>
        </div>
    </div>
    <div class="swrap">
        <table class="board_list" style="width:100%;">
            <colgroup>
            <col width="5%" />
            <col width="10%" />
            <col width="10%" />
            <col width="10%" />
            <col width="10%" />
            </colgroup>
            <tbody>
                <tr>
                	<th>No</th>
                    <th>컨설턴트 아이디</th>
                    <th>발송번호</th>
                    <th>발송날짜</th>
                    <th>결과</th>
                </tr>
                <c:choose>
                    <c:when test="${!empty smsHistory}">
                    	<c:set value="${fn:length(smsHistory)}" var="count" />
		                <c:forEach items="${smsHistory}" var="item" varStatus="status">
		                	<c:set var="rownum" value="${count-status.count+1}" />
			                <tr>
			                	<td style="text-align: center"><c:out value="${rownum}" /></td>
			                    <td style="text-align: center"><c:out value="${item.TRAN_ETC1}" /></td>
			                    <td style="text-align: center"> <c:out value="${item.TRAN_PHONE}" /></td>
			                    <td style="text-align: center"><c:out value="${item.CK_DATE}" /></td>
			                    <td style="text-align: center"><c:out value="${item.TRAN_RSLT}" /></td>
			                </tr>
		                </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <tr>
                        	<td colspan="5">목록이 존재하지 않습니다.</td>
                        </tr>
                    </c:otherwise>
                </c:choose>
            </tbody>
        </table>
        </div>
        </form>
</div>

<script>
	$(document).ready(init); 
	
	function init() {
	    $("#search").on('click', function () {
	        var url = '<c:url value="./smsHistory" />';
	        $("#frm").attr('href', url).submit();
	    });
	}
	
</script>