<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<% pageContext.setAttribute("cn", "\n"); %>

<div id="Contents">
    <form id="companyForm" name="companyForm" method="post">
        <input type="hidden" id="comId" name="comId" value='<c:out value="${getCompany.COM_ID}" />' />
        
    <div class="swrap">
        <div class="search2">
            <span class="d_search"><a href="<c:url value="./company" />">신규</a></span>
            <c:if test="${userInfo.CON_ID eq getCompany.CON_ID || userInfo.ADMIN_YN eq 'Y'}">
	            <span class="d_search"><a href="javascript:;" id="modCompany">수정</a></span>
            </c:if>
			<c:if test="${userInfo.ADMIN_YN eq 'Y'}">
				<span class="d_search"><a href="javascript:;" id="delCompany">삭제</a></span>
			</c:if>
            <span class="d_search"><a href="javascript:history.back(-1);">목록</a></span>
        </div>
        <!--데이타테이블시작-->
        <table class="board_h" style="width:100%;">
            <colgroup>
            <col width="16%" />
            <col width="34%" />
            <col width="16%" />
            <col width="*" />
            </colgroup>
            <tbody>
                <tr>
                    <th>회사코드</th>
                    <td id="comIdClean"><c:out value="${getCompany.COM_ID}" /></td>
                    <th>등록일</th>
                    <td id="regDateClean"><c:out value="${getCompany.REG_DATE}" /></td>	  	
                </tr>
                <tr>	
                    <th class="re">회사명</th>
                    <td><c:out value="${getCompany.COM_NM}" /></td>
                    <th class="re">구분</th>
                    <td><c:out value="${getCompany.SECTION_NM}" /></td>
                </tr>
                <tr>
                    <th class="re">기업형태</th>
                    <td><c:out value="${getCompany.COM_TYPE_NM}" /></td>
                    <th>매출|인원</th>
                    <td>
                    	<c:out value="${getCompany.SALES}" /> |
                    	<c:out value="${getCompany.PEOPLE}" />
                    </td>
                </tr>
                <tr>
                    <th class="re">업종</th>
                    <td>
                    	<c:out value="${getCompany.INDUSTRY1_NM}" /> / 
                    	<c:out value="${getCompany.INDUSTRY2_NM}" />
                    </td>
                    <th>인트라넷 공개</th>
                    <td><c:out value="${getCompany.PUBLIC_YN_NM}" /></td>
                </tr>
                <tr>
                    <th>
                    	회사개요
                    </th>
                    <td colspan="3"><c:out escapeXml="false" value="${fn:replace(getCompany.SUMMARY, cn, '<br/>')}" /></td>
                </tr>
                <tr>
                    <th>주소</th>
                    <td colspan="3"><c:out value="${getCompany.ADDRESS}" /></td>
                </tr>
                <tr>
                    <th>처우수준</th>
                    <td colspan="3"><c:out value="${getCompany.STANDARD}" /></td>
                </tr>
                <tr>
                    <th>URL</th>
                    <td><a style="color:blue;" href='<c:out value="${getCompany.URL}" />'><c:out value="${getCompany.URL}" /></a></td>
                    <th>등록경로</th>
                    <td><c:out value="${getCompany.SOURCE_NM}" /></td>
                </tr>
                <tr>
                    <th>수수료율</th>
                    <td><c:out value="${getCompany.COMMISSION}" /></td>
                    <th>개런티</th>
                    <td><c:out value="${getCompany.GUARANTEE}" />개월</td>
                </tr>
                <tr>
                    <th>등록자</th>
                    <td><c:out value="${getCompany.USR_NM}" /></td>
                    <th class="re">컨설턴트</th>
                    <td><c:out value="${getCompany.CON_NM}" /></td>
                </tr>
            </tbody>
        </table>
        
        <table class="board_list" style="width:100%;">
            <colgroup>
            <col width="12%" />
            <col width="22%" />
            <col width="15%" />
            <col width="15%" />
            <col width="20%" />
            <col width="*" />
            </colgroup>
            <tbody>
                <tr>
                    <th><img src="../resources/images/ne.png" alt="" />&nbsp;담당자</th>
                    <th>부서|직위</th>
                    <th><img src="../resources/images/ne.png" alt="" />&nbsp;연락처1</th>
                    <th>연락처2</th>
                    <th><img src="../resources/images/ne.png" alt="" />&nbsp;E-mail</th>
                    <th>비고</th>
                </tr>
				<c:forEach var="item" items="${getPersonList}" begin="0" end="2" varStatus="status">
					<c:choose>
						<c:when test="${fn:trim(item.PERSON_NM) ne '' || fn:trim(item.PHONE1) ne '' || fn:trim(item.EMAIL) ne ''}">
							<c:choose>
							<c:when test="${userInfo.CON_ID eq getCompany.CON_ID || userInfo.ADMIN_YN eq 'Y'}">
								<tr>
				                    <td><c:out value="${item.PERSON_NM}" /></td>
				                    <td>
				                    	<c:out value="${item.DEPT_NM}" />
				                    	<c:out value="${item.POS_NM}" />
				                    </td>
				                    <td><c:out value="${item.PHONE1}" /></td>
				                    <td><c:out value="${item.PHONE2}" /></td>
				                    <td><c:out value="${item.EMAIL}" /></td>
				                    <td><c:out value="${item.ETC}" /></td>
				                </tr>
							</c:when>
							<c:otherwise>
								<tr>
									<td>****</td>
				                    <td>****</td>
				                    <td>****</td>
				                    <td>****</td>
				                    <td>****</td>
				                    <td>****</td>
								</tr>
							</c:otherwise>
							</c:choose>
						</c:when>
						<c:otherwise>
							<c:if test="${status.index eq 0}">
								<tr>
									<td colspan="6">등록된 담당자가 없습니다.</td>
								</tr>
							</c:if>
						</c:otherwise>
					</c:choose>
				</c:forEach>
              </tbody>
            </table>
            
            <c:if test="${!empty getCompany.COM_ID}">
	        	<jsp:include page="/WEB-INF/views/common/comment.jsp" />        
            </c:if>
        </div>
        </form>
        
</div>

<script type="text/javascript">
	$(document).ready(init);
	
	function init() {
	    $('#modCompany').on('click', modCompany);
	    $('#delCompany').on('click', delCompany);
	}
	
	function modCompany() {
		var comId = $('#comId').val();
		var url = '<c:url value="./company" />' + '?comId=' + comId;
	       
		document.location.href = url;
	}
	
	function delCompany() {
	    if (confirm('정말 삭제 하시겠습니까?')) {
			var url = '<c:url value="./delCompany" />';
			var form = document.companyForm;
			form.action = url;
			form.submit();
	    }
	}
		
</script>