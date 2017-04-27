<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div id="Contents">
    <!--검색영역-->
    <form id="frm" name="frm" method="post">
    <input type="hidden" id="searchType" name="searchType" value="<c:out value="${search.searchType}" />" />
    
    <div class="search">
        <div class="b_search">
            <div class="b_search2" style="width: 300px;">
                <input class="t_search" type="text" name="searchText" id="searchText" placeholder="포지션, 회사명, 컨설턴트" value='<c:out value="${search.searchText}" />' />
                <span class="search_icon pl5"><a href="#" id="search"></a></span>
                <span class="d_search"><a href="#" id="searchBtn">상세검색</a></span>
            </div>
        </div>
        <!--상세검색시작-->
        <div class="de_search" id="searchDetailsDiv" style="display:none;">
	        <div style=" float:left; overflow:hidden; width:900px;"> 
				<ul class="de_s01">
					<li>
	                    <span class="de_t">회사명</span>
	                    <input name="comNm" type="text" class="in" value='<c:out value="${search.comNm}" />' style="width:200px;" />
					</li>
	                <li>
	                    <span class="de_t">후보자</span>
	                    <input name="usrNm" type="text" class="in" value='<c:out value="${search.usrNm}" />' style="width:200px;" />
	                </li>
					<li>
	                    <span class="de_t">추천자</span>
	                    <input name="recNm" type="text" class="in" value='<c:out value="${search.recNm}" />' style="width:200px;" />
	                </li>
	                <li>
	                    <span class="de_t">등록일</span>
	                    <input id="startDate" name="startDate" type="text" class="in fl mr3" value='<c:out value="${search.startDate}" />' style="width:83px;" />
	                    <span class="fl mr5 ml5">~</span>
	                    <input id="endDate" name="endDate" type="text" class="in fl mr3" value='<c:out value="${search.endDate}" />' style="width:83px;" />
	                </li>
	            </ul>
	            <ul class="de_s01">
	            	<li>
	                    <span class="de_t">포지션</span>
	                    <input name="posNm" type="text" class="in" value='<c:out value="${search.posNm}" />' style="width:200px;" />
	                </li>
					<li>
	                    <span class="de_t">컨설턴트</span>
	                    <input name="conNm" type="text" class="in" value='<c:out value="${search.conNm}" />' style="width:200px;" />
	                </li>
	                <li>
	                    <span class="de_t">진행단계</span>
	                    <select name="state" class="sel02" style="width:210px;" >
	                    <c:if test="${userInfo.ADMIN_YN eq 'Y'}">
	                        <option value="">전체</option>
						</c:if>
                    		<option value="A" <c:if test="${search.state eq 'A'}">selected</c:if>>추천</option>
                    	<c:if test="${userInfo.ADMIN_YN eq 'Y'}">
                    		<option value="B" <c:if test="${search.state eq 'B'}">selected</c:if>>1차면접</option>
                    		<option value="C" <c:if test="${search.state eq 'C'}">selected</c:if>>2차면접</option>
                    		<option value="D" <c:if test="${search.state eq 'D'}">selected</c:if>>3차면접</option>
                    		<option value="E" <c:if test="${search.state eq 'E'}">selected</c:if>>실기</option>
                    		<option value="F" <c:if test="${search.state eq 'F'}">selected</c:if>>인적성</option>
                    		<option value="G" <c:if test="${search.state eq 'G'}">selected</c:if>>입사확정</option>
                    		<option value="H" <c:if test="${search.state eq 'H'}">selected</c:if>>입사</option>
                    		<option value="I" <c:if test="${search.state eq 'I'}">selected</c:if>>빌링</option>
                    		<option value="J" <c:if test="${search.state eq 'J'}">selected</c:if>>탈락</option>
                    		<option value="K" <c:if test="${search.state eq 'K'}">selected</c:if>>보류</option>
                    		<option value="L" <c:if test="${search.state eq 'L'}">selected</c:if>>미검토</option>
                    		<option value="M" <c:if test="${search.state eq 'M'}">selected</c:if>>협상결렬</option>
                    		<option value="N" <c:if test="${search.state eq 'N'}">selected</c:if>>본인포기</option>
                    		<option value="O" <c:if test="${search.state eq 'O'}">selected</c:if>>입금</option>
                    		<option value="P" <c:if test="${search.state eq 'P'}">selected</c:if>>빌링취소</option>
                    		<option value="Q" <c:if test="${search.state eq 'Q'}">selected</c:if>>리플접수</option>
                    		<option value="R"<c:if test="${search.state eq 'R'}">selected</c:if>>리플</option>
                    		<option value="S" <c:if test="${search.state eq 'S'}">selected</c:if>>정산</option>
                    		<option value="T" <c:if test="${search.state eq 'T'}">selected</c:if>>call</option>
                    		<option value="U" <c:if test="${search.state eq 'U'}">selected</c:if>>이메일</option>
                    		<option value="V" <c:if test="${search.state eq 'V'}">selected</c:if>>프리뷰</option>
                    		<option value="W" <c:if test="${search.state eq 'W'}">selected</c:if>>기타</option>
                    	</c:if>
	                   </select>
	                </li>
	                <li>
	                    <span class="de_t">진행일</span>
	                    <input id="proStartDate" name="proStartDate" type="text" class="in fl mr3" value='<c:out value="${search.proStartDate}" />' style="width:83px;" />
	                    <span class="fl mr5 ml5">~</span>
	                    <input id="proEndDate" name="proEndDate" type="text" class="in fl mr3" value='<c:out value="${search.proEndDate}" />' style="width:83px;" />
	                </li>
	            </ul>
            </div>
            <span id="searchDetails" class="b_det_s mr10"><a href="#">검색</a></span>
	        <div>
	        </div>
        </div>
        <!--상세검색끝-->                                     
    </div>
    <div class="swrap">
        <table class="board_list" style="width:100%;">
            <colgroup>
	            <col width="7%" />
	            <col width="20%" />
	            <col width="*%" />
	            <col width="10%" />
	            <col width="7%" />
	            <col width="7%" />
	            <col width="10%" />
	            <col width="10%" />
	            <col width="10%" />
            </colgroup>
            <tbody>
                <tr>
                    <th>No</th>
                    <th>회사명</th>
                    <th>포지션</th>
                    <th>후보자</th>
                    <th>컨설턴트</th>
                    <th>추천자</th>
                    <th>진행단계</th>
                    <th>등록일</th>
                    <th>진행일</th>
                </tr>
                <c:choose>
                    <c:when test="${!empty progressList}">
		                <c:forEach items="${progressList}" var="item">
			                <tr>
			                    <td><c:out value="${item.ROWNUM}" /></td>
			                    <td><c:out value="${item.COM_NM}" /></td>
			                    <td><c:out value="${item.POS_NM}" /></td>
			                    <td class="select" data-usr-id='${item.USR_ID}'>
			                    	<a href="javascript:;"><c:out value="${item.USR_INFO}" /></a>
			                    </td>
			                    <td><c:out value="${item.CON_NM}" /></td>
			                    <td><c:out value="${item.REC_NM}" /></td>
			                    <td><c:out value="${item.STATE_NM}" /></td>
			                    <td><c:out value="${item.REG_DATE}" /></td>
			                    <td><c:out value="${item.PROGRESS_DATE}" /></td>
			                </tr>
		                </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <tr>
                        	<td colspan="9">목록이 존재하지 않습니다.</td>
                        </tr>
                    </c:otherwise>
                </c:choose>
            </tbody>
        </table>
        <c:if test="${!empty progressList}">
	        <jsp:include page="../common/paging.jsp" />
        </c:if>
        </div>
        </form>
</div>

<script>
	$(document).ready(init); 
	
	function init() {
	    $('#search').on('click', search); 
	    $('#searchBtn').on('click', searchBtn);
	    $('#searchDetails').on('click', searchDetails);
	    $("#startDate").datepicker();
        $("#endDate").datepicker();
        $("#proStartDate").datepicker();
        $("#proEndDate").datepicker();
        
        $(document).on('click', '.select', detailCandidate);
//         $(document).on('click', '.select2', detailCompany);
        
        //상세검색 초기화
        if ($("#searchType").val() != '') {
            $('#searchDetailsDiv').show();
        }
	    
	    $('#searchText').on('keydown', function(key) {
	        if (key.keyCode == 13) {
	            search();
	        }
	    });
	}
	
	function goPage(pageNo) {
	    var url = '<c:url value="./progress" />';
	    var pageInput = $('<input type="hidden" name="pageNo" value="'+pageNo+'" />'); 
	    
	    $("#frm").append(pageInput);
	    $("#frm").attr('href', url).submit();
	}
	
	function search() {
	    var url = '<c:url value="./progress" />';
	    
		//상세검색 초기화
		$('.sel02').each(function() {
		    this.value = '';
		});
		$('.in').each(function() {
		    this.value = '';
		});
		
		$('#searchType').val('');
        $("#frm").attr('href', url).submit();
	}
	
	function searchBtn() {
        if ($('#searchDetailsDiv').css('display') == 'none') {
            $('#searchDetailsDiv').show();
        } else {
            $('#searchDetailsDiv').hide();
        }
	}
	
   function searchDetails() {
       var url = '<c:url value="./progress" />';
       $('#searchType').val("detail");
       $('#searchText').val(""); //기본검색 초기화
       $("#frm").attr('href', url).submit();
   }

   /* 후보자 상세 */
   function detailCandidate() {
       var usrId = $(this).data('usrId');
       var url = '<c:url value="/candidate/candidate" />' + '?usrId=' + usrId;	       
	       
       document.location.href = url;
   }
   
//    function detailPosition() {
//        var posId = $(this).data('posId');
//        var url = '<c:url value="./position" />' + '?posId=' + posId;
       
//        document.location.href = url;
//    }
   
//    function detailCompany() {
//        var comId = $(this).data('comId');
//        var url = '<c:url value="/company/company" />' + '?comId=' + comId;
       
//        document.location.href = url;
//    }
	
</script>