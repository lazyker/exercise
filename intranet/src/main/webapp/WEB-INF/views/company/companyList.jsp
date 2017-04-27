<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div id="Contents">
    <!--검색영역-->
    <form id="companyForm" name="companyForm" method="post">
    <input type="hidden" id="searchType" name="searchType" value="<c:out value="${search.searchType}" />" />
    
    <div class="search">
        <div class="b_search">
            <div class="b_search2">
                <input class="t_search" type="text" name="searchText" id="searchText" placeholder="회사명 or 컨설턴트" value='<c:out value="${search.searchText}" />' />
                <span class="search_icon pl5"><a href="#" id="search"></a></span>
                <span class="d_search"><a href="#" id="searchBtn">상세검색</a></span>
                <span class="p_search"><a href="<c:url value="./company" />">등록</a></span>
            </div>
        </div>
        <!--상세검색시작-->
        <div class="de_search" id="searchDetailsDiv" style="display:none;">
            <ul class="de_s01">
                <li>
                    <span class="de_t">업종</span>
                    <select id="industry1" name="industry1" class="sel02" style="width:150px;" >
                        <option value="">선택</option>
                        <c:forEach items="${codeList}" var="parentCode">
                            <option value="${parentCode.CD_ID}" 
                                <c:if test="${search.industry1 eq parentCode.CD_ID}">selected</c:if>>
                                <c:out value="${parentCode.CD_NM}" />
                            </option>
                        </c:forEach>
                    </select>
                    <select id="industry2" name="industry2" class="sel02" style="width:150px;" >
                        <option value="">선택</option>
                        <c:forEach items="${codeChildList}" var="childCode">
	                       <option value="${childCode.CD_ID}" 
	                               <c:if test="${search.industry2 eq childCode.CD_ID}">selected</c:if>>
	                               <c:out value="${childCode.CD_NM}" />
	                           </option>
                        </c:forEach>
                    </select>
              </li>
                <li>
                    <span class="de_t">회사명</span>
                    <input name="comNm" type="text" class="in" value='<c:out value="${search.comNm}" />' style="width:300px;" />
                </li>
                <li>
                    <span class="de_t">컨설턴트</span>
                    <input name="conNm" type="text" class="in" value='<c:out value="${search.conNm}" />' style="width:300px;" />
                </li>
<!--                 <li> -->
<!--                     <span class="de_t">상세검색</span> -->
<!--                     <input id="searchDetails" type="text" class="in" style="width:300px;" /> -->
<!--                 </li> -->
            </ul>
            <ul class="de_s01">
                <li>
                    <span class="de_t">구분</span>
	                    <select name="section" class="sel02" style="width:160px;" >
	                        <option value="">전체</option>
	                        <option value="A" <c:if test="${search.section eq 'A'}">selected</c:if>>고객사</option>
	                        <option value="B" <c:if test="${search.section eq 'B'}">selected</c:if>>마케팅</option>
	                    </select>
              </li>
                <li>
                    <span class="de_t">기업형태</span>
                    <select name="comType" class="sel02" style="width:160px;" >
                        <option value="">전체</option>
                        <option value="A" <c:if test="${search.comType eq 'A'}">selected</c:if>>대기업</option>
                        <option value="B" <c:if test="${search.comType eq 'B'}">selected</c:if>>중견기업</option>
                        <option value="C" <c:if test="${search.comType eq 'C'}">selected</c:if>>중소기업</option>
                        <option value="D" <c:if test="${search.comType eq 'D'}">selected</c:if>>외국기업</option>
                    </select>
                </li>
                <li>
                    <span class="de_t">개런티</span>
                    <select name="guarantee" class="sel02" style="width:160px;" >
                        <option value="">선택</option>
                        <option value="0" <c:if test="${search.guarantee eq '0'}">selected</c:if>>0개월</option>
                        <option value="1" <c:if test="${search.guarantee eq '1'}">selected</c:if>>1개월</option>
                        <option value="2" <c:if test="${search.guarantee eq '2'}">selected</c:if>>2개월</option>
                        <option value="3" <c:if test="${search.guarantee eq '3'}">selected</c:if>>3개월</option>
                        <option value="4" <c:if test="${search.guarantee eq '4'}">selected</c:if>>4개월</option>
                        <option value="5" <c:if test="${search.guarantee eq '5'}">selected</c:if>>5개월</option>
                        <option value="6" <c:if test="${search.guarantee eq '6'}">selected</c:if>>6개월</option>
                        <option value="7" <c:if test="${search.guarantee eq '7'}">selected</c:if>>7개월</option>
                        <option value="8" <c:if test="${search.guarantee eq '8'}">selected</c:if>>8개월</option>
                        <option value="9" <c:if test="${search.guarantee eq '9'}">selected</c:if>>9개월</option>
                        <option value="10" <c:if test="${search.guarantee eq '10'}">selected</c:if>>10개월</option>
                        <option value="11" <c:if test="${search.guarantee eq '11'}">selected</c:if>>11개월</option>
                        <option value="12" <c:if test="${search.guarantee eq '12'}">selected</c:if>>12개월</option>
                   </select>
                </li>
            </ul>
            <ul class="de_s01">
                <li>
                    <span class="de_t">등록일</span>
                    <input id="startDate" name="startDate" type="text" class="in fl mr3" value='<c:out value="${search.startDate}" />' style="width:80px;" />
<!--                     <a href="#" id="startDate"><img src="/resources/images/b_cal.png" class="fl" /></a>  -->
                    <span class="fl mr5 ml5">~</span>
                    <input id="endDate" name="endDate" type="text" class="in fl mr3" value='<c:out value="${search.endDate}" />' style="width:80px;" />
<!--                     <a href="#"><img src="/resources/images/b_cal.png" class="fl"/></a> -->
                </li>
            </ul>
            <span id="searchDetails" class="b_det_s mr10"><a href="#">검색</a></span>
        
        </div>
        <!--상세검색끝-->                                     
    </div>
    <div class="swrap">
        <table class="board_list" style="width:100%;">
            <colgroup>
            <col width="8%" />
            <col width="10%" />
            <col width="20%" />
            <col width="15%" />
            <col width="15%" />
            <col width="10%" />
            <col width="10%" />
            <col width="*" />
            </colgroup>
            <tbody>
                <tr>
                    <th>No</th>
                    <th>구분</th>
                    <th>회사명</th>
                    <th>기업형태</th>
                    <th>수수료율</th>
                    <th>개런티</th>
                    <th>컨설턴트</th>
                    <th>등록일</th>
                </tr>
                <c:choose>
                    <c:when test="${!empty companyList}">
		                <c:forEach items="${companyList}" var="item">
			                <tr>
			                    <td><c:out value="${item.ROWNUM}" /></td>
			                    <td><c:out value="${item.SECTION_NM}" /></td>
			                    <td class="select" data-com-id='${item.COM_ID}'>
			                    	<a href="javascript:;"><c:out value="${item.COM_NM}" /></a>
			                    </td>
			                    <td><c:out value="${item.COM_TYPE_NM}" /></td>
			                    <td><c:out value="${item.COMMISSION}" /></td>
			                    <td><c:out value="${item.GUARANTEE}" /><c:if test="${!empty item.GUARANTEE}">개월</c:if></td>
			                    <td><c:out value="${item.CON_NM}" /></td>
			                    <td><c:out value="${item.REG_DATE}" /></td>
			                </tr>
		                </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <tr>
                        	<td colspan="8">목록이 존재하지 않습니다.</td>
                        </tr>
                    </c:otherwise>
                </c:choose>
            </tbody>
        </table>
        <c:if test="${!empty companyList}">
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
	    $("#startDate").datepicker();
        $("#endDate").datepicker();
        $(document).on('click', '.select', detailCompany);
        
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
	    var url = '<c:url value="./companyList" />';
	    var pageInput = $('<input type="hidden" name="pageNo" value="'+pageNo+'" />'); 
	    
	    $("#companyForm").append(pageInput);
	    $("#companyForm").attr('href', url).submit();
	}
	
	function search() {
	    var url = '<c:url value="./companyList" />';
	    
		//상세검색 초기화
		$('.sel02').each(function() {
		    this.value = '';
		});
		$('.in').each(function() {
		    this.value = '';
		});
	    
		$("#searchType").val('');
        $("#companyForm").attr('href', url).submit();
	}
	
	function searchBtn() {
        if ($('#searchDetailsDiv').css('display') == 'none') {
            $('#searchDetailsDiv').show();
        } else {
            $('#searchDetailsDiv').hide();
        }
	}
	
   function searchDetails() {
       var url = '<c:url value="./companyList" />';
       $('#searchType').val("detail"); 
       $('#searchText').val(""); //기본검색 초기화
       $("#companyForm").attr('href', url).submit();
   }
   
   function detailCompany() {
       var comId = $(this).data('comId');
       var url = '<c:url value="./companyDetail" />' + '?comId=' + comId;
       
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
</script>