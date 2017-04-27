<%@ page language="java" contentType="text/html; charSet=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

	<div class="paging mt25" >
	    <ul>
            <li><a href="javascript:goPage(${paging.firstPageNo});">&#60&#60;</a></li>  
	        <li><a href="javascript:goPage(${paging.prevPageNo});">&#60;</a></li>
            <c:forEach var="i" begin="${paging.startPageNo}" end="${paging.endPageNo}" step="1">
                <c:choose>
                    <c:when test="${i eq paging.pageNo}">
                        <li><a href='javascript:goPage(${i});' class='p_on'>${i}</a></li>
                    </c:when>
                    <c:otherwise>
                        <li><a href="javascript:goPage(${i});">${i}</a></li>
                    </c:otherwise>
                </c:choose>
            </c:forEach>
	        <li><a href="javascript:goPage(${paging.nextPageNo});">&#62;</a></li>
	        <li class='last'><a href="javascript:goPage(${paging.finalPageNo});">&#62&#62;</a></li>              
	    </ul>
	</div>