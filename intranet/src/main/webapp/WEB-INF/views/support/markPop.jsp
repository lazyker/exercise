<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div id="wrapper_p">
    <!--팝업타이틀 시작-->
    <div class="top">
        <span class="pop_st">후보자 검색</span>
        <span class="close"><a href=""><img src="/resources/images/p_close.png" title="닫기"/></a></span>
    </div>
    <!--팝업타이틀 끝-->

    <div class="b_search">
        <div class="b_search2">
            <input class="t_search" style="width:325px;" type="text" name="searchText" id="searchText" placeholder="후보자" value='<c:out value="${usrNm}" />' />
            <span class="search_icon pl5"><a href="#" id="search"></a></span>
        </div>
    </div>

    <div id="popcontents">
        <table class="board_list" style="width:100%;">
            <colgroup>
            	<col width="10%" />
            	<col width="20%" />
            	<col width="30%" />
            	<col width="*%" />
            </colgroup>
            <tbody>
                <tr>
                	<th>No</th>
                    <th>후보자</th>
                    <th>최종학교</th>
                    <th>전공</th>
                </tr>
                <c:choose>
                    <c:when test="${!empty candidateList}">
                    	<c:forEach var="item" items="${candidateList}" varStatus="status">
	                    <tr class="select"
	                    			data-usr-id="${item.USR_ID}" 
		                    		data-usr-nm="${item.USR_NM}"
		                    		data-usr-school="${item.USR_SCHOOL}"
		                    		data-usr-major="${item.USR_MAJOR}"
		                    		data-mobile="${item.MOBILE}"
		                    		style="algin-text: center; cursor: pointer;">
	                    	<td><c:out value="${item.ROWNUM}" /></td>
		                    <td><c:out value="${item.USR_INFO}" /></td>
		                    <td><c:out value="${item.USR_SCHOOL}" /></td>
		                    <td><c:out value="${item.USR_MAJOR}" /></td>
	                    </tr>
                    	</c:forEach>
                    </c:when>
                    <c:otherwise>
	                    <tr>
		                    <td colspan="5">
		                        <div style="color:blue; margin-top: 5px;"><span>검색결과가 없습니다.</span></div>                   
		                    </td>
	                    </tr>
                    </c:otherwise>
                </c:choose>
              </tbody>
            </table>
            
            <c:if test="${!empty candidateList}">
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
        
        $('.select').on('click', function() {
            var param = {
                    usrId : $(this).data('usrId'),
                    usrNm : $(this).data('usrNm'),
                    usrSchool : $(this).data('usrSchool'),
                    usrMajor : $(this).data('usrMajor'),
                    mobile : $(this).data('mobile')
			};
            
            opener.setMark(param);
            window.close();
        });
    }
    
    function search() {
        var url = '<c:url value="./markPop" />';
        url += '?usrNm=' + $('#searchText').val();
        
        window.location.href = encodeURI(url);
    }
    
	function goPage(pageNo) {
	    var url = '<c:url value="./markPop" />';
	    url += '?pageNo=' + pageNo
	    
	    document.location.href = url;
	}
</script>
