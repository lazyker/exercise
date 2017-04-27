<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<div id="Contents">
    <form:form commandName="consultantVo" id="frm" action="/save" method="post">
		<form:input path="userName" />
		
		<div>
	    	<form:errors path="userName" />
		</div>    
    
    </form:form>
    
    <button type="button" id="save">전송</button>
</div>

<script>
$(document).ready(function() {
	$("#save").on("click", function () {
        $("#frm").submit();
    });
});
	

</script>