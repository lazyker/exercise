<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<spring:eval expression="@requestUtil" var="requestUtil"/>

<div id="wrapper">
	<div class="logo"><a href="/support/progress">(주)코즈엘</a></div>
    <ul class="menu">
        <li ${requestUtil.servletPath eq '/company/companyList'
        		or requestUtil.servletPath eq '/company/companyDetail'
        		or requestUtil.servletPath eq '/company/company' ? 'class="ton"' : ''}>
            <a href="/company/companyList" title="고객사관리">고객사관리</a>
        	<ul class="sub">
				<li ${requestUtil.servletPath eq  '/company/companyList' ? 'class="ton"' : ''}>
					<a href="/company/companyList">고객사 리스트</a>
				</li>
				<li ${requestUtil.servletPath eq  '/company/company' 
						or requestUtil.servletPath eq '/company/companyDetail' ? 'class="ton"' : ''}>
					<a href="/company/company">고객사 등록</a>
				</li>
        	</ul>
        </li>
        <li ${requestUtil.servletPath eq '/position/positionList'
        		or requestUtil.servletPath eq '/position/positionDetail'
        		or requestUtil.servletPath eq '/position/position' ? 'class="ton"' : ''}>
            <a href="/position/positionList" title="포지션관리">포지션관리</a>
            <ul class="sub">
                <li ${requestUtil.servletPath eq  '/position/positionList' ? 'class="ton"' : ''}>
                	<a href="/position/positionList">포지션 리스트</a>
                	</li>
                <li ${requestUtil.servletPath eq  '/position/position'
                		or requestUtil.servletPath eq '/position/positionDetail' ? 'class="ton"' : ''}>
                	<a href="/position/position">포지션 등록</a>
                </li>
            </ul>
        </li>
        <li ${requestUtil.servletPath eq '/candidate/candidateList'
        		or requestUtil.servletPath eq '/candidate/candidateDetail'
        		or requestUtil.servletPath eq '/candidate/candidate' ? 'class="ton"' : ''}>
            <a href="/candidate/candidateList" title="후보자관리">후보자관리</a>
            <ul class="sub">
                <li ${requestUtil.servletPath eq  '/candidate/candidateList' ? 'class="ton"' : ''}>
                	<a href="/candidate/candidateList">후보자 리스트</a>
                </li>
                <li ${requestUtil.servletPath eq  '/candidate/candidate'
                		or requestUtil.servletPath eq '/candidate/candidateDetail' ? 'class="ton"' : ''}>
                	<a href="/candidate/candidate">후보자 등록</a>
                </li>
            </ul>
        </li>
        <li ${requestUtil.servletPath eq '/support/noticeList'  
        		or requestUtil.servletPath eq '/support/workDataList'
        		or requestUtil.servletPath eq '/support/schedule'
        		or requestUtil.servletPath eq '/support/markList'
        		or requestUtil.servletPath eq '/support/progress'
        		or requestUtil.servletPath eq '/support/kpi'
        		or requestUtil.servletPath eq '/support/workReport' 
        		or requestUtil.servletPath eq '/support/smsHistory' ? 'class="ton"' : ''}>
            <a href="/support/noticeList" title="통계/지원">통계/지원</a>
            <ul class="sub">
                <li ${requestUtil.servletPath eq  '/support/noticeList' ? 'class="ton"' : '' }>
                	<a href="/support/noticeList" title="공지사항">공지사항</a>
                </li>
                <li ${requestUtil.servletPath eq  '/support/workDataList' ? 'class="ton"' : ''}>
                	<a href="/support/workDataList" title="업무자료">업무자료</a>
                </li>
                <li ${requestUtil.servletPath eq  '/support/schedule' ? 'class="ton"' : ''}>
                	<a href="/support/schedule">일정 관리</a>
                </li>
                <li ${requestUtil.servletPath eq  '/support/markList' ? 'class="ton"' : ''}>
                	<a href="/support/markList">관심 DB</a>
                </li>
                <li ${requestUtil.servletPath eq  '/support/progress' ? 'class="ton"' : ''}>
                	<a href="/support/progress">진행 현황</a>
                </li>
                <li ${requestUtil.servletPath eq  '/support/kpi' ? 'class="ton"' : ''}>
                	<a href="/support/kpi">KPI 현황</a>
                </li>
                <li ${requestUtil.servletPath eq  '/support/workReport' ? 'class="ton"' : ''}>
                	<a href="/support/workReport">업무현황 리포트</a>
                </li>
                <li ${requestUtil.servletPath eq  '/support/smsHistory' ? 'class="ton"' : ''}>
                	<a href="/support/smsHistory">SMS 이력조회</a>
                </li>
            </ul>
        </li>
	<c:if test="${userInfo.ADMIN_YN eq 'Y'}">
        <li ${requestUtil.servletPath eq '/admin/consultantList' 
        		or requestUtil.servletPath eq '/admin/consultant'
        		or requestUtil.servletPath eq '/admin/loginStats'
        		or requestUtil.servletPath eq '/admin/codeList'
        		or requestUtil.servletPath eq '/admin/closedData' ? 'class="ton"' : ''}>
            <a href="/admin/consultantList" title="통계/지원">관리자</a>
            <ul class="sub">
                <li ${requestUtil.servletPath eq  '/admin/consultantList' ? 'class="ton"' : ''}>
                	<a href="/admin/consultantList">컨설턴트 리스트</a>
                </li>
                <li ${requestUtil.servletPath eq  '/admin/consultant' ? 'class="ton"' : ''}>
                	<a href="/admin/consultant">컨설턴트 등록</a>
                </li>
                <li ${requestUtil.servletPath eq  '/admin/loginStats' ? 'class="ton"' : ''}>
                	<a href="/admin/loginStats">관리통계</a>
                </li>
                <li ${requestUtil.servletPath eq  '/admin/codeList' ? 'class="ton"' : ''}>
                	<a href="/admin/codeList">업직종 등록</a>
                </li>
            </ul>
        </li>
	</c:if>
    </ul>
    <div class="g_h"><a href="/support/progress">홈으로</a></div>
</div>
<p class="clear"></p>

<script>
$(document).ready(init);

function init() {
	$("ul.menu li").hover(function(){
	    $("ul:not(:animated)",this).slideDown("fast");
		},
		function(){
		   $("ul",this).slideUp("fast");
		});
}

</script>