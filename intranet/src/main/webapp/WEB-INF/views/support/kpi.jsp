<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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
        <table class="board_list" id="kpiList" style="width:100%;">
            <colgroup>
            <col width="10%" />
            <col width="10%" />
            <col width="10%" />
            <col width="10%" />
            <col width="10%" />
            <col width="10%" />
            <col width="10%" />
            <col width="10%" />
            <col width="10%" />
            <col width="10%" />
            </colgroup>
            <tbody>
                <tr>
                    <th>구분</th>
                    <th>추천</th>
                    <th>1차면접</th>
                    <th>2차면접</th>
                    <th>3차면접</th>
                    <th>입사확정</th>
                    <th>입사</th>
                    <th>고객사</th>
                    <th>신규포지션</th>
                    <th>DB입력</th>
                </tr>
                <c:choose>
                    <c:when test="${!empty kpiList}">
		                <c:forEach items="${kpiList}" var="item">
			                <tr>
			                    <td style="text-align: center"><c:out value="${item.CON_NM}" /></td>
			                    <td style="text-align: center"> <c:out value="${item.STA_CNT_A}" /></td>
			                    <td style="text-align: center"><c:out value="${item.STA_CNT_B}" /></td>
			                    <td style="text-align: center"><c:out value="${item.STA_CNT_C}" /></td>
			                    <td style="text-align: center"><c:out value="${item.STA_CNT_D}" /></td>
			                    <td style="text-align: center"><c:out value="${item.STA_CNT_G}" /></td>
			                    <td style="text-align: center"><c:out value="${item.STA_CNT_H}" /></td>
			                    <td style="text-align: center"><c:out value="${item.COM_CNT}" /></td>
			                    <td style="text-align: center"><c:out value="${item.POS_CNT}" /></td>
			                    <td style="text-align: center"><c:out value="${item.USR_CNT}" /></td>
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
        </div>
        </form>
</div>

<script>
	$(document).ready(init); 
	
	function init() {
	    $("#search").on('click', function () {
	        var url = '<c:url value="./kpi" />';
	        $("#frm").attr('href', url).submit();
	    });
	    
	    $('tr').last().find('td').css({'background-color':'#FFE4E1', 'font-weight':'bold'});
	}
	
</script>