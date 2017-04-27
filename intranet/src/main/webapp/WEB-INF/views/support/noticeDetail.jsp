<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div id="Contents">
    <form id="frm" name="frm" method="post" enctype="multipart/form-data">
        <input type="hidden" id="bodId" name="bodId" value='<c:out value="${getNotice.BOD_ID}" />' />
        <input type="hidden" name="bodType" value='1' placeholder="공지사항" />
        
    <div class="swrap">
        <div class="search2">
        	<c:choose>
        		<c:when test="${empty getNotice.BOD_ID}">
        			<span class="d_search"><a href="javascript:;" id="setNotice">등록</a></span>
        			<span class="d_search"><a href="<c:url value="./noticeList" />">목록</a></span>
        		</c:when>
        		<c:otherwise>
        			<c:if test="${userInfo.CON_ID eq getNotice.CON_ID || userInfo.ADMIN_YN eq 'Y'}">
			            <span class="d_search"><a href="#" id="modNotice">수정</a></span>
        			</c:if>
		            <span class="d_search"><a href="<c:url value="./noticeList" />">목록</a></span>
        		</c:otherwise>
        	</c:choose>
        </div>
        <!--데이타테이블시작-->
        <table class="board_h" style="width:100%;">
            <colgroup>
            <col width="18%" />
            <col width="*" />
            </colgroup>
            <tbody>
                <tr>
                    <th>제목</th>
                    <td><c:out value="${getNotice.TITLE}" /></td>
                </tr>
                <tr>	
                    <th>내용</th>
                    <td><c:out value="${getNotice.CONTENTS}" escapeXml="false" /></td>
                </tr>
                <tr>	
                    <th>첨부파일</th>
                    <td>
                    	<div class="filebox">
                            <c:choose>
                                <c:when test="${empty getNotice.ORIGINAL_FILE_NM}">
                                    <a href="#this" class="upload-name">파일선택</a>
                                </c:when>
                                <c:otherwise>
                                    <input type="hidden" name="attId" id="attId" value='<c:out value="${getNotice.ATT_ID}"></c:out>' />
                                    <input type="hidden" name="orgId" id="orgId" value='<c:out value="${getNotice.CON_ID}"></c:out>' />
                                    <a href="#this" id="downloadFile" class="upload-name" style="width: 80%">${getNotice.ORIGINAL_FILE_NM} (${getNotice.FILE_SIZE}kb)</a>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </td>
                </tr>
            </tbody>
        </table>
	</div>
	</form>
</div>

<script type="text/javascript">

	$(document).ready(init);
	
	function init() {
	    $('#modNotice').on('click', modNotice);
	    $('#downloadFile').on('click', downloadFile);
	}
	
	function modNotice() {
		var bodId = $('#bodId').val();
		var url = '<c:url value="./notice" />' + '?bodId=' + bodId;
	       
		document.location.href = url;
	}
	
	function downloadFile() {
	    var attId = $('#attId').val();
	    var url = '<c:url value="/downloadFile" />';
	    url += '?attId=' + attId;
	    
	    $(location).attr('href', url);
	}
	
</script>