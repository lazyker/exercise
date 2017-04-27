<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div id="Contents">
    <!--검색영역-->
    <form id="positionForm" name="positionForm" method="post">
    <input type="hidden" id="searchType" name="searchType" value="<c:out value="${search.searchType}" />" />
    
    <div class="search">
        <div class="b_search">
            <div class="b_search2">
                <input class="t_search" type="text" name="searchText" id="searchText" placeholder="포지션, 회사명, 컨설턴트" value='<c:out value="${search.searchText}" />' />
                <span class="search_icon pl5"><a href="#" id="search"></a></span>
                <span class="d_search"><a href="#" id="searchBtn">상세검색</a></span>
                <span class="p_search"><a href="<c:url value="./position" />">등록</a></span>
            </div>
        </div>
        <!--상세검색시작-->
        <div class="de_search" id="searchDetailsDiv" style="display:none;">
	        <div style=" float:left; overflow:hidden; width:900px;"> 
				<ul class="de_s01">
					<li>
	                    <span class="de_t">업종</span>
	                    <select id="industry1" name="industry1" class="sel02" style="width:100px;" >
	                        <option value="">선택</option>
	                        <c:forEach items="${codeMap.codeList1}" var="parentCode">
	                            <option value="${parentCode.CD_ID}" 
	                                <c:if test="${search.industry1 eq parentCode.CD_ID}">selected</c:if>>
	                                <c:out value="${parentCode.CD_NM}" />
	                            </option>
	                        </c:forEach>
	                    </select>
	                    <select id="industry2" name="industry2" class="sel02" style="width:100px;" >
	                        <option value="">선택</option>
	                        <c:forEach items="${codeChildList1}" var="childCode">
		                       <option value="${childCode.CD_ID}" 
		                               <c:if test="${search.industry2 eq childCode.CD_ID}">selected</c:if>>
		                               <c:out value="${childCode.CD_NM}" />
		                           </option>
	                        </c:forEach>
	                    </select>
					</li>
	                <li>
	                    <span class="de_t">포지션</span>
	                    <input name="posNm" type="text" class="in" value='<c:out value="${search.posNm}" />' style="width:200px;" />
	                </li>
					<li>
	                    <span class="de_t">컨설턴트</span>
	                    <input name="conNm" type="text" class="in" value='<c:out value="${search.conNm}" />' style="width:200px;" />
	                </li>
	            </ul>
	            <ul class="de_s01">
	                <li>
	                    <span class="de_t">직무</span>
	                    <select id="job1" name="job1" class="sel02" style="width:100px;" >
	                        <option value="">선택</option>
	                        <c:forEach items="${codeMap.codeList2}" var="parentCode">
	                            <option value="${parentCode.CD_ID}" 
	                                <c:if test="${search.job1 eq parentCode.CD_ID}">selected</c:if>>
	                                <c:out value="${parentCode.CD_NM}" />
	                            </option>
	                        </c:forEach>
	                    </select>
	                    <select id="job2" name="job2" class="sel02" style="width:100px;" >
	                        <option value="">선택</option>
	                        <c:forEach items="${codeChildList2}" var="childCode">
		                       <option value="${childCode.CD_ID}" 
		                               <c:if test="${search.job2 eq childCode.CD_ID}">selected</c:if>>
		                               <c:out value="${childCode.CD_NM}" />
		                           </option>
	                        </c:forEach>
	                    </select>
					</li>
					<li>
	                    <span class="de_t">회사명</span>
	                    <input name="comNm" type="text" class="in" value='<c:out value="${search.comNm}" />' style="width:200px;" />
	                </li>
	                <li>
	                    <span class="de_t">진행상태</span>
	                    <select name="posStatus" class="sel02" style="width:160px;" >
	                        <option value="">전체</option>
	                        <option value="A" <c:if test="${search.posStatus eq 'A'}">selected</c:if>>진행</option>
	                        <option value="B" <c:if test="${search.posStatus eq 'B'}">selected</c:if>>성공</option>
	                        <option value="C" <c:if test="${search.posStatus eq 'C'}">selected</c:if>>마감</option>
	                        <option value="D" <c:if test="${search.posStatus eq 'D'}">selected</c:if>>보류</option>
	                   </select>
	                </li>
	            </ul>
	            <ul class="de_s01">
	                <li>
	                    <span class="de_t">등록일</span>
	                    <input id="startDate" name="startDate" type="text" class="in fl mr3" value='<c:out value="${search.startDate}" />' style="width:80px;" />
	                    <span class="fl mr5 ml5">~</span>
	                    <input id="endDate" name="endDate" type="text" class="in fl mr3" value='<c:out value="${search.endDate}" />' style="width:80px;" />
	                </li>
	                <li>
	                    <span class="de_t">업무방식</span>
	                    <select name=rule class="sel02" style="width:205px;" >
	                        <option value="">전체</option>
	                        <option value="A" <c:if test="${search.rule eq 'A'}">selected</c:if>>단독</option>
	                        <option value="B" <c:if test="${search.rule eq 'B'}">selected</c:if>>협업</option>
	                        <option value="C" <c:if test="${search.rule eq 'C'}">selected</c:if>>양수도</option>
	                        <option value="D" <c:if test="${search.rule eq 'D'}">selected</c:if>>공통</option>
	                        <option value="E" <c:if test="${search.rule eq 'D'}">selected</c:if>>기타</option>
	                    </select>
	                </li>
	            </ul>
	            <ul class="de_s01">
	            	<li>
						<span class="de_t">모집내용</span>
						<input name="contents" type="text" class="in" value='<c:out value="${search.contents}" />' style="width:695px;" />
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
	            <col width="8%" />
	            <col width="*" />
	            <col width="10%" />
	            <col width="15%" />
	            <col width="5%" />
	            <col width="5%" />
	            <col width="8%" />
	            <col width="8%" />
	            <col width="5%" />
            </colgroup>
            <tbody>
                <tr>
                    <th>No</th>
                    <th>포지션</th>
                    <th>경력</th>
                    <th>회사명</th>
                    <th>방식</th>
                    <th>컨택</th>
                    <th>컨설턴트</th>
                    <th>등록일</th>
                    <th>상태</th>
                </tr>
                <c:choose>
                    <c:when test="${!empty positionList}">
		                <c:forEach items="${positionList}" var="item">
			                <tr>
			                    <td><c:out value="${item.ROWNUM}" /></td>
			                    <td class="select left" data-pos-id='${item.POS_ID}'>
			                    	<a href="javascript:;"><c:out value="${item.POS_NM}" /></a>
			                    </td>
			                    <td><c:out value="${item.CAREER}" /></td>
			                    <td class="select2" data-com-id='${item.COM_ID}'>
			                    	<a href="javascript:;"><c:out value="${item.COM_NM}" /></a>
			                    </td>
			                    <td><c:out value="${item.RULE}" /></td>
			                    <td><c:out value="${item.REC_CNT}" /></td>
			                    <td><c:out value="${item.CON_NM}" /></td>
			                    <td><c:out value="${item.REG_DATE}" /></td>
			                    <td><c:out value="${item.POS_STATUS}" /></td>
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
        <c:if test="${!empty positionList}">
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
	    $('#industry1').on('change', getIndustry);
	    $('#job1').on('change', getJob);
	    $("#startDate").datepicker();
        $("#endDate").datepicker();
        $(document).on('click', '.select', detailPosition);
        $(document).on('click', '.select2', detailCompany);
        
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
	    var url = '<c:url value="./positionList" />';
	    var pageInput = $('<input type="hidden" name="pageNo" value="'+pageNo+'" />'); 
	    
	    $("#positionForm").append(pageInput);
	    $("#positionForm").attr('href', url).submit();
	}
	
	function search() {
	    var url = '<c:url value="./positionList" />';
	    
		//상세검색 초기화
		$('.sel02').each(function() {
		    this.value = '';
		});
		$('.in').each(function() {
		    this.value = '';
		});
		
		$('#searchType').val('');
        $("#positionForm").attr('href', url).submit();
	}
	
	function searchBtn() {
        if ($('#searchDetailsDiv').css('display') == 'none') {
            $('#searchDetailsDiv').show();
        } else {
            $('#searchDetailsDiv').hide();
        }
	}
	
   function searchDetails() {
       var url = '<c:url value="./positionList" />';
       $('#searchType').val("detail");
       $('#searchText').val(""); //기본검색 초기화
       $("#positionForm").attr('href', url).submit();
   }
   
   function detailPosition() {
       var posId = $(this).data('posId');
       var url = '<c:url value="./positionDetail" />' + '?posId=' + posId;
       
       document.location.href = url;
   }
   
   function detailCompany() {
       var comId = $(this).data('comId');
       var url = '<c:url value="/company/company" />' + '?comId=' + comId;
       
       document.location.href = url;
   }
	
   function getIndustry() {
        var url = '<c:url value="/admin/childList" />';
        var parentId = $(this).val(); 
        $('#industry2').empty();
        
        $.ajax({
            url :  url,
            data : {'parentId' : parentId},
            success : function(res) {
                var str = '<option value="">선택</option>';
                $.each(res, function(i, item) {
                    str += '<option value="'+item.CD_ID+'">' +item.CD_NM+ '</option>'; 
                    
                });
                $('#industry2').append(str);
            }
        })
    }
   
   function getJob() {
       var url = '<c:url value="/admin/childList" />';
       var parentId = $(this).val(); 
       $('#job2').empty();
       
       $.ajax({
           url :  url,
           data : {'parentId' : parentId},
           success : function(res) {
               var str = '<option value="">선택</option>';
               $.each(res, function(i, item) {
                   str += '<option value="'+item.CD_ID+'">' +item.CD_NM+ '</option>'; 
                   
               });
               $('#job2').append(str);
           }
       })
   }
</script>