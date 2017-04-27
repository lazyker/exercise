<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div id="Contents">
    <!--검색영역-->
    <form id="candidateForm" name="candidateForm" method="post">
    <input type="hidden" id="searchType" name="searchType" value="<c:out value="${search.searchType}" />" />
    
    <div class="search">
        <div class="b_search">
            <div class="b_search2" style="width: 380px;">
                <input class="t_search" type="text" name="searchText" id="searchText" style="width: 190px;" placeholder="후보자, 전공, 경력회사, 직무" value='<c:out value="${search.searchText}" />' />
                <span class="search_icon pl5"><a href="#" id="search"></a></span>
                <span class="d_search"><a href="#" id="searchBtn">상세검색</a></span>
                <span class="p_search"><a href="<c:url value="./candidate" />">등록</a></span>
            </div>
        </div>
        <!--상세검색시작-->
        <div class="de_search" id="searchDetailsDiv" style="display:none;">
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
	                    <span class="de_t">후보자</span>
	                    <input name="usrNm" type="text" class="in" value='<c:out value="${search.usrNm}" />' style="width:200px;" />
	                </li>
					<li>
	                    <span class="de_t">경력회사</span>
	                    <input name="cName" type="text" class="in" value='<c:out value="${search.cName}" />' style="width:200px;" />
	                </li>
	                <li>
	                    <span class="de_t">상세경력</span>
	                    <input name="contents" type="text" class="in" value='<c:out value="${search.contents}" />' style="width:200px;" />
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
	                    <span class="de_t">학교</span>
	                    <input name="usrSchool" type="text" class="in" value='<c:out value="${search.usrSchool}" />' style="width:200px;" />
	                </li>
	                <li>
	                    <span class="de_t">전공</span>
	                    <input name="usrMajor" type="text" class="in" value='<c:out value="${search.usrMajor}" />' style="width:200px;" />
	                </li>
	                <li>
	                    <span class="de_t">자격증</span>
	                    <input name="license" type="text" class="in" value='<c:out value="${search.license}" />' style="width:200px;" />
	                </li>
	                <li>
	                    <span class="de_t">등록자</span>
	                    <input name="conNm" type="text" class="in" value='<c:out value="${search.conNm}" />' style="width:200px;" />
	                </li>
	            </ul>
	            <ul class="de_s01">
	            	<li>
	                    <span class="de_t">성별</span>
	                    <select name=gender class="sel02" style="width:183px;" >
	                        <option value="">전체</option>
	                        <option value="M" <c:if test="${search.gender eq 'M'}">selected</c:if>>남자</option>
	                        <option value="W" <c:if test="${search.gender eq 'W'}">selected</c:if>>여자</option>
	                    </select>
	                </li>
	                <li>
	                    <span class="de_t">최종학력</span>
	                    <select name=usrLevel class="sel02" style="width:120px;" >
	                    	<option value="">전체</option>
	                        <option value="1" <c:if test="${search.usrLevel eq '1'}">selected</c:if>>박사</option>
                            <option value="2" <c:if test="${search.usrLevel eq '2'}">selected</c:if>>석사</option>
                            <option value="3" <c:if test="${search.usrLevel eq '3'}">selected</c:if>>학사</option>
                            <option value="4" <c:if test="${search.usrLevel eq '4'}">selected</c:if>>전문학사</option>
                            <option value="5" <c:if test="${search.usrLevel eq '5'}">selected</c:if>>무관</option>
	                    </select>
	                    <span style="font-size: 13px;">
	                    	<label for="usrLevelMore">
	                    		<input type="checkbox" id="usrLevelMore" name="usrLevelMore" value="Y" <c:if test="${search.usrLevelMore eq 'Y'}">checked</c:if> /> 이상
	                    	</label>
	                    </span>
	                </li>
	                <li>
	                    <span class="de_t">출생연도</span>
	                    <select id="startYear" name="startYear" class="sel02" style="width:80px;" >
                            <option value="">전체</option>
                        </select>
                        ~
                    	<select id="endYear" name="endYear" class="sel02" style="width:80px;" >
                            <option value="">전체</option>
                        </select>
	                </li>
	                <li>
	                    <span class="de_t">출처</span>
	                    <select name="sources" class="sel02" style="width:183px;" >
	                        <option value="">전체</option>
	                        <option value="A" <c:if test="${search.sources eq 'A'}">selected</c:if>>잡코리아</option>
	                        <option value="B" <c:if test="${search.sources eq 'B'}">selected</c:if>>인크루트</option>
	                        <option value="C" <c:if test="${search.sources eq 'C'}">selected</c:if>>스카우트</option>
	                        <option value="D" <c:if test="${search.sources eq 'D'}">selected</c:if>>사람인</option>
	                        <option value="E" <c:if test="${search.sources eq 'E'}">selected</c:if>>기타 잡포탈</option>
	                        <option value="F" <c:if test="${search.sources eq 'F'}">selected</c:if>>명부</option>
	                        <option value="G" <c:if test="${search.sources eq 'G'}">selected</c:if>>지인소개</option>
	                        <option value="H" <c:if test="${search.sources eq 'H'}">selected</c:if>>개인DB</option>
	                        <option value="I" <c:if test="${search.sources eq 'I'}">selected</c:if>>직접지원</option>
	                        <option value="J" <c:if test="${search.sources eq 'J'}">selected</c:if>>기타</option>
	                    </select>
	                </li>
	            </ul>
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
	            <col width="11%" />
	            <col width="14%" />
	            <col width="14%" />
	            <col width="*%" />
	            <col width="22%" />
	            <col width="7%" />
            </colgroup>
            <tbody>
                <tr>
                    <th>No</th>
                    <th>후보자</th>
                    <th>최종학교</th>
                    <th>전공</th>
                    <th>경력회사</th>
                    <th>직무</th>
                    <th>등록자</th>
                </tr>
                <c:choose>
                    <c:when test="${!empty candidateList}">
		                <c:forEach items="${candidateList}" var="item">
			                <tr>
			                    <td><c:out value="${item.ROWNUM}" /></td>
			                    <td class="select" data-usr-id='${item.USR_ID}' data-con-id='${item.CON_ID}'>
			                    	<a href="javascript:;"><c:out value="${item.USR_INFO}" /></a>
			                    </td>
			                    <td ><c:out value="${item.USR_SCHOOL}" /></td>
			                    <td><c:out value="${item.USR_MAJOR}" /></td>
			                    <td class="left"><c:out value="${item.C_NAME}" /></td>
			                    <td class="left"><c:out value="${item.JOB1_NM}" /><c:if test="${!empty item.JOB2_NM }"> / <c:out value="${item.JOB2_NM }" /></c:if></td>
			                    <td><c:out value="${item.CON_NM}" /></td>
			                </tr>
		                </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <tr>
                        	<td colspan="7">목록이 존재하지 않습니다.</td>
                        </tr>
                    </c:otherwise>
                </c:choose>
            </tbody>
        </table>
        <c:if test="${!empty candidateList}">
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
        $(document).on('click', '.select', detailCandidate);
        
        //상세검색 초기화
        if ($("#searchType").val() != '') {
            $('#searchDetailsDiv').show();
        }
	    
	    $('#searchText').on('keydown', function(key) {
	        if (key.keyCode == 13) {
	            search();
	        }
	    });
	    
	    for (var i = new Date().getFullYear(); i > 1939; i--)
	    {
	        $('#startYear').append($('<option />').val(i).html(i + '년'));
	        $('#endYear').append($('<option />').val(i).html(i + '년'));
	    }
	    $('#startYear').val('${search.startYear}')
        $('#endYear').val('${search.endYear}')
	}
	
	function goPage(pageNo) {
	    var url = '<c:url value="./candidateList" />';
	    var pageInput = $('<input type="hidden" name="pageNo" value="'+pageNo+'" />'); 
	    
	    $("#candidateForm").append(pageInput);
	    $("#candidateForm").attr('href', url).submit();
	}
	
	function search() {
	    var url = '<c:url value="./candidateList" />';
	    
	    //상세검색 초기화
	    $('.sel02').each(function() {
	        this.value = '';
	    });
	    $('.in').each(function() {
	        this.value = '';
	    });
	    
	    $("#searchType").val('');
        $("#candidateForm").attr('href', url).submit();
	}
	
	function searchBtn() {
        if ($('#searchDetailsDiv').css('display') == 'none') {
            $('#searchDetailsDiv').show();
        } else {
            $('#searchDetailsDiv').hide();
        }
	}
	
   function searchDetails() {
       var url = '<c:url value="./candidateList" />';
       $('#searchType').val("detail");
       $('#searchText').val(""); //기본검색 초기화
       $("#candidateForm").attr('href', url).submit();
   }
   
   function detailCandidate() {
       var authType = '${userInfo.AUTH_USER_TYPE}';
       var conId = $(this).data('conId');
       var currentConId = '${userInfo.CON_ID}';
       
       if (authType === '3' && conId != currentConId) {
           toastr.info('이력서를 조회할 권한이<br/>없습니다.');
       } else {
	       var usrId = $(this).data('usrId');
	       var url = '<c:url value="./candidateDetail" />' + '?usrId=' + usrId;
	       
	       document.location.href = url;
       }
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