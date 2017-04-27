<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div id="wrapper_p">
    <!--팝업타이틀 시작-->
    <div class="top">
        <span class="pop_st">고객사 검색</span>
        <span class="close"><a href=""><img src="/resources/images/p_close.png" title="닫기"/></a></span>
    </div>
    <!--팝업타이틀 끝-->

    <div class="b_search">
        <div class="b_search2">
            <input class="t_search" style="width:325px;" type="text" name="searchText" id="searchText" placeholder="회사명" value='<c:out value="${comNm}" />' />
            <span class="search_icon pl5"><a href="#" id="search"></a></span>
        </div>
    </div>

    <div id="popcontents">
        <table class="board_list" style="width:100%;">
            <colgroup>
            	<col width="15%" />
            	<col width="*%" />
            </colgroup>
            <tbody>
                <tr>
                	<th>No</th>
                    <th>회사명</th>
                </tr>
                <c:choose>
                    <c:when test="${!empty companyList}">
                    	<c:forEach var="item" items="${companyList}" varStatus="status">
	                    <tr>
	                    	<td><c:out value="${item.ROWNUM}" /></td>
		                    <td>
		                    	<div class="compSelect" 
		                    		data-com-id="${item.COM_ID}" 
		                    		data-com-nm="${item.COM_NM}"
		                    		data-industry1="${item.INDUSTRY1}"
		                    		data-industry2="${item.INDUSTRY2}"
		                    		data-summary="${item.SUMMARY}"
		                    		style="algin-text: center; cursor: pointer;">
		                    		<span><c:out value="${item.COM_NM}" /></span>
		                    	</div>
		                    </td>
	                    </tr>
                    	</c:forEach>
                    </c:when>
                    <c:otherwise>
	                    <tr>
		                    <td colspan="2">
		                        <div style="color:blue; margin-top: 5px;"><span>검색결과가 없습니다.</span></div>                   
		                    </td>
	                    </tr>
                    </c:otherwise>
                </c:choose>
              </tbody>
            </table>
            
			<c:if test="${!empty companyList}">
	        	<jsp:include page="../common/paging.jsp" />
			</c:if>
    </div>
</div>

<script type="text/javascript">
    $(document).ready(init);
    
    function init() {
        window.document.body.scroll = 'auto';
        
        $('#searchText').on('keydown', function(key) {
            if (key.keyCode == 13) {
                search();
            }
        });
        
        $('.search_icon').on('click', function() {
            search();
        });
        
        $('.close').on('click', function() {
            self.opener = self;
            window.close();
        });
        
        $('.close').on('click', function() {
            self.opener = self;
            window.close();
        });
        
        $('.compSelect').on('click', function() {
            var comId = $(this).data('comId');
            var comNm = $(this).data('comNm');
            var industry1 = $(this).data('industry1');
            var industry2 = $(this).data('industry2');
            var summary = $(this).data('summary');
            var parent = opener.positionForm;
            
            parent.comId.value = comId;
            parent.comNm.value = comNm;
			window.opener.document.getElementById('industry1').innerHTML = industry1;
			window.opener.document.getElementById('industry2').innerHTML = ' / ' + industry2;
            window.opener.document.getElementById('summary').innerHTML = summary;
            window.close();
        });
    }
    
    function search() {
        var url = '<c:url value="./companyPop" />';
        url += '?comNm=' + $('#searchText').val();
        
        window.location.href = encodeURI(url);
    }
    
	function goPage(pageNo) {
	    var url = '<c:url value="./companyPop" />';
	    url += '?pageNo=' + pageNo
	    
	    document.location.href = url;
	}
</script>
