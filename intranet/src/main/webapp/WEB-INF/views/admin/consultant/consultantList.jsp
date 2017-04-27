<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<div id="Contents">
    <div class="swrap">
        <div class="search2">
            <span class="p_search"><a href="#" id="addConsultant">등록</a></span>
        </div>
        
        <table class="board_h" style="width:100%;">
            <colgroup>
            <col width="18%" />
            <col width="15%" />
            <col width="18%" />
            <col width="15%" />
            <col width="*" />
            </colgroup>
            <tbody>
                <c:choose>
                    <c:when test="${!empty consultantList}">
				        <c:forEach items="${consultantList}" var="item">
		                <tr data-con-id="${item.CON_ID}">
		                    <td rowspan="3" style="vertical-align:top; text-align:center; border-bottom:1px solid #8989b1;">
		                        <c:choose>
		                            <c:when test="${!empty item.STORED_FILE_NM}">
				                        <img src='<c:out value="/images/${item.STORED_FILE_NM}/${item.FILE_TYPE}" />' width="110" height="145" />
		                            </c:when>
		                            <c:otherwise>
		                                <img src='/resources/images/no_img.jpg' width="110" height="145" />
		                            </c:otherwise>
		                        </c:choose>
		                    </td>
		                    <th>컨설턴트</th>
		                    <td class="tdHover" style="vertical-align: middle;">
		                        <c:out value="${item.CON_NM}" /> (<c:out value="${item.RANK}" />)
		                    </td>
		                    <th>연락처</th>
		                    <td style="vertical-align: middle;">
		                        <c:out value="${item.PHONE}" /> / <c:out value="${item.MOBILE}" />
		                    </td>
		                </tr>
		                <tr>
		                    <th>학력경력</th>
		                    <td colspan="3" style="vertical-align: middle;">
								<c:out value="${item.EDU}" escapeXml="false" />
		                    </td>
		                </tr>
		                <tr>
		                    <th style="border-bottom:1px solid #8989b1;">전문분야</th>
		                    <td colspan="3" style="border-bottom:1px solid #8989b1; vertical-align: middle;">
								<c:out value="${item.FIELD}" escapeXml="false" />
		                    </td>
		                </tr>
				        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <tr>
                            <td style="text-align: center">컨설턴트 목록이 없습니다.</td>
                        </tr>
                    </c:otherwise>
                </c:choose>
            </tbody>
        </table>
    </div>
</div>

<script>
	$(document).ready(init); 
	
	function init() {
	    $('#addConsultant').on('click', addConsultant);
	    $('.tdHover').on('click', modConsultant);
	}
	
	function addConsultant() {
	    var url = '<c:url value="./consultant" />';
	    $(location).attr('href', url);
	}
	
	function modConsultant() {
	    var conId = $(this).parent().data('conId');
	    var url = '<c:url value="./consultant" />?conId=' + conId ;
	    $(location).attr('href', url);
	}
</script>