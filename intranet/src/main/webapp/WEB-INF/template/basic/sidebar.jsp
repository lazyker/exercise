<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<spring:eval expression="@requestUtil" var="requestUtil"/>

<div id="inb">
	<div class="name_m">
        <div class="fl" style="width:130px;">
            <span class="name"><em>${userInfo.CON_NM}</em> 로그인</span><br />
            <span class="n_time">${userInfo.loginTime}</span>
        </div>
        <div class="out" title="로그아웃"><a href="/logout">로그아웃</a></div>
    </div>
    <c:choose>
        <c:when test="${requestUtil.menuPath eq 'company'}">
            <ul class="s_m">
	            <li ${requestUtil.servletPath eq '/company/companyList' ? 'class="list_s_on"' : 'class="list_s"'}>
	                <a href="/company/companyList">고객사 리스트</a>
	            </li>
	            <li ${requestUtil.servletPath eq '/company/company' 
	            		or requestUtil.servletPath eq '/company/companyDetail' ? 'class="en_s_on"' : 'class="en_s"'}>
                    <a href="/company/company">고객사 등록</a>
                </li>
            </ul>
        </c:when>
        <c:when test="${requestUtil.menuPath eq 'position'}">
	        <ul class="s_m">
		        <li ${requestUtil.servletPath eq '/position/positionList' ? 'class="list_s_on"' : 'class="list_s"'}>
		        	<a href="/position/positionList">포지션 리스트</a>
		        </li>
		        <li ${requestUtil.servletPath eq '/position/position'
		        		or requestUtil.servletPath eq '/position/positionDetail' ? 'class="en_s_on"' : 'class="en_s"'}>
		        	<a href="/position/position">포지션 등록</a>
		        </li>
		    </ul>
        </c:when>
        <c:when test="${requestUtil.menuPath eq 'candidate'}">
            <ul class="s_m">
            	<li ${requestUtil.servletPath eq  '/candidate/candidateList' ? 'class="list_s_on"' : 'class="list_s"'}>
            		<a href="/candidate/candidateList">후보자 리스트</a>
            	</li>
            	<li ${requestUtil.servletPath eq  '/candidate/candidate'
            			or requestUtil.servletPath eq '/candidate/candidateDetail' ? 'class="en_s_on"' : 'class="en_s"'}>
            		<a href="/candidate/candidate">후보자 등록</a>
            	</li>
            </ul>
        </c:when>
        <c:when test="${requestUtil.menuPath eq 'support'}">
            <ul class="s_m">
            	<li ${requestUtil.servletPath eq  '/support/noticeList' ? 'class="list_s_on"' : 'class="list_s"'}>
                	<a href="/support/noticeList">공지사항</a>
                </li>
                <li ${requestUtil.servletPath eq  '/support/workDataList' ? 'class="list_s_on"' : 'class="list_s"'}>
                	<a href="/support/workDataList">업무자료</a>
                </li>
                <li ${requestUtil.servletPath eq  '/support/schedule' ? 'class="list_s_on"' : 'class="list_s"'}>
                	<a href="/support/schedule">일정 관리</a>
                </li>
                <li ${requestUtil.servletPath eq  '/support/markList' ? 'class="list_s_on"' : 'class="list_s"'}>
                	<a href="/support/markList">관심 DB</a>
                </li>
                <li ${requestUtil.servletPath eq  '/support/progress' ? 'class="list_s_on"' : 'class="list_s"'}>
                	<a href="/support/progress">진행 현황</a>
                </li>
                <li ${requestUtil.servletPath eq  '/support/kpi' ? 'class="list_s_on"' : 'class="list_s"'}>
                	<a href="/support/kpi">KPI 현황</a>
                </li>
                <li ${requestUtil.servletPath eq  '/support/workReport' ? 'class="list_s_on"' : 'class="list_s"'}>
                	<a href="/support/workReport">업무현황 리포트</a>
                </li>
                <li ${requestUtil.servletPath eq  '/support/smsHistory' ? 'class="list_s_on"' : 'class="list_s"'}>
                	<a href="/support/smsHistory">SMS 이력조회</a>
                </li>
            </ul>
        </c:when>
        <c:when test="${requestUtil.menuPath eq 'admin'}">
		   <ul class="s_m">
		        <li ${requestUtil.servletPath eq '/admin/consultantList' ? 'class="list_s_on"' : 'class="list_s"'}>
                    <a href="/admin/consultantList">컨설턴트 리스트</a>
		        </li>
		        <li ${requestUtil.servletPath eq '/admin/consultant' ? 'class="en_s_on"' : 'class="en_s"'}>
                    <a href="/admin/consultant">컨설턴트 등록</a>
		        </li>
		        <li ${requestUtil.servletPath eq '/admin/loginStats' ? 'class="stats_on"' : 'class="stats"'}>
                    <a href="/admin/loginStats">관리통계</a>
                </li>
		        <li ${requestUtil.servletPath eq '/admin/codeList' ? 'class="rec_s_on"' : 'class="rec_s"'}>
                    <a href="/admin/codeList">업직종 등록</a>
                </li>
<%-- 		        <li ${requestUtil.servletPath eq '/admin/closedData' ? 'class="rec_s_on"' : 'class="rec_s"'}> --%>
<!--                     <a href="/admin/closedData">비공개 등록자료</a> -->
<!--                 </li> -->
		    </ul>
        </c:when>
    </c:choose>
</div>
<p class="clear"></p>
