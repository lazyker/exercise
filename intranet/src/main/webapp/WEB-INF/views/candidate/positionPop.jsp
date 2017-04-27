<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div id="wrapper_p">
    <!--팝업타이틀 시작-->
    <div class="top">
        <span class="pop_st">포지션 검색</span>
        <span class="close"><a href=""><img src="/resources/images/p_close.png" title="닫기"/></a></span>
    </div>
    <!--팝업타이틀 끝-->

    <div class="b_search">
        <div class="b_search2">
            <input class="t_search" style="width:325px;" type="text" name="searchText" id="searchText" placeholder="포지션" value='<c:out value="${comNm}" />' />
            <span class="search_icon pl5"><a href="#" id="search"></a></span>
        </div>
    </div>

    <div id="popcontents">
        <table class="board_list" style="width:100%;">
            <colgroup>
            	<col width="10%" />
            	<col width="30%" />
            	<col width="*%" />
            	<col width="15%" />
            </colgroup>
            <tbody>
                <tr>
                	<th>No</th>
                    <th>회사명</th>
                    <th>포지션</th>
                    <th>등록일</th>
                </tr>
                <c:choose>
                    <c:when test="${!empty positionList}">
                    	<c:forEach var="item" items="${positionList}" varStatus="status">
	                    <tr>
	                    	<td><c:out value="${item.ROWNUM}" /></td>
	                    	<td><c:out value="${item.COM_NM}" /></td>
	                    	<td>
	                    		<div class="select" 
		                    		data-com-id="${item.COM_ID}" 
		                    		data-com-nm="${item.COM_NM}"
		                    		data-pos-id="${item.POS_ID}"
		                    		data-pos-nm="${item.POS_NM}"
		                    		style="algin-text: center; cursor: pointer;">
		                    		<span><c:out value="${item.POS_NM}" /></span>
		                    	</div>
	                    	</td>
	                    	<td><c:out value="${item.REG_DATE}" /></td>
	                    </tr>
                    	</c:forEach>
                    </c:when>
                    <c:otherwise>
	                    <tr>
		                    <td colspan="4">
		                        <div style="color:blue; margin-top: 5px;"><span>검색결과가 없습니다.</span></div>                   
		                    </td>
	                    </tr>
                    </c:otherwise>
                </c:choose>
              </tbody>
            </table>
            
            <c:if test="${!empty positionList}">
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
        
        $('.select').on('click', function() {
            var param = {
               posId : $(this).data('posId'),
               comId : $(this).data('comId'),
               comNm : $(this).data('comNm'),
               posNm : $(this).data('posNm')
            };

            opener.addPostionPresent(param);
            window.close();
        });
    }
    
    function search() {
        var url = '<c:url value="./positionAddPop" />';
        url += '?posNm=' + $('#searchText').val();
        
        window.location.href = encodeURI(url);
    }
    
	function goPage(pageNo) {
	    var url = '<c:url value="./positionAddPop" />';
	    url += '?pageNo=' + pageNo
	    
	    document.location.href = url;
	}
</script>
