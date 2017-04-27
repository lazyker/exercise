<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%-- <%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %> --%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>

<spring:eval expression="@config" var="config"/>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="utf-8">
    <meta http-equiv="x-ua-compatible" content="ie=edge">
    <title><tiles:getAsString name="title"/></title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
<!--     <sec:csrfMetaTags/> -->
    <tiles:insertTemplate template="/WEB-INF/template/basic/css.jsp" flush="true"/>
    <tiles:insertTemplate template="/WEB-INF/template/basic/js.jsp" flush="true"/>
</head>
<body style="overflow-x:hidden">
    <tiles:insertAttribute name="header" flush="true"/>
    <tiles:insertAttribute name="sidebar" flush="true"/>
	<tiles:insertAttribute name="content" flush="true"/>
</body>
</html>
