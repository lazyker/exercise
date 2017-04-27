<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="utf-8">
    <meta http-equiv="x-ua-compatible" content="ie=edge">
    <title><tiles:getAsString name="title"/></title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link type="text/css" rel="stylesheet" href="/resources/css/jquery-ui.min.css" />
    <link type="text/css" rel="stylesheet" href="/resources/css/common.css" />
    <link type="text/css" rel="stylesheet" href="/resources/css/toastr.min.css" />
    <link type="text/css" rel="stylesheet" href="/resources/css/login.css" />
    
    <script src="/resources/js/vendor/jquery-1.12.3.min.js" type="text/javascript"></script>
    <script src="/resources/js/vendor/jquery.validate.js" type="text/javascript"></script>
    <script src="/resources/js/vendor/toastr.min.js" type="text/javascript"></script>
    <script src="/resources/js/vendor/jquery.cookie.js" type="text/javascript"></script>
	<script src="/resources/js/vendor/cozel.js" type="text/javascript"></script>
</head>
<body style="overflow-x:hidden">
    <tiles:insertAttribute name="content" flush="true"/>
</body>
</html>