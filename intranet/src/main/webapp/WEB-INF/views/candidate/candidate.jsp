<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div id="Contents">
    <form id="candidateForm" name="candidateForm" method="post" enctype="multipart/form-data">
        <input type="hidden" id="usrId" name="usrId" value='<c:out value="${getCandidate.USR_ID}" />' />
        <input type="hidden" name="job1Nm" value='<c:out value="${getCandidate.JOB1_NM}" />' />
        <input type="hidden" name="job2Nm" value='<c:out value="${getCandidate.JOB2_NM}" />' />
        <input type="hidden" name="delFiles" />
        <input type="hidden" id="currentUser" name="currentUser" value='<c:out value="${userInfo.CON_ID}" />' />
        
    <div class="swrap">
        <div class="search2">
        	<c:choose>
        		<c:when test="${empty getCandidate.USR_ID}">
        			<span class="d_search"><a href="javascript:;" id="setCandidate">등록</a></span>
        			<span class="d_search"><a href="/candidate/candidateList">목록</a></span>
        		</c:when>
        		<c:otherwise>
		            <span class="d_search"><a href="<c:url value="./candidate" />">신규</a></span>
		            <c:if test="${userInfo.CON_ID eq getCandidate.CON_ID || userInfo.ADMIN_YN eq 'Y'}">
			            <span class="d_search"><a href="javascript:;" id="modCandidate">수정</a></span>
		            </c:if>
		            <span class="d_search"><a href="<c:url value="javascript:location.replace(document.referrer);" />">목록</a></span>
        		</c:otherwise>
        	</c:choose>
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
                    <th>후보자코드</th>
                    <td id="usrIdClean"><c:out value="${getCandidate.USR_ID}" /></td>
                    <th>등록일</th>
                    <td id="regDateClean"><c:out value="${getCandidate.REG_DATE}" /></td>	  	
                </tr>
                <tr>	
                    <th class="re">성명</th>
                    <td>
	                    <input id="usrNm" name="usrNm" type="text" class="in2" value="<c:out value="${getCandidate.USR_NM}" />" style="width:30%;" />
	                    <span class="t_search"><a href="#" id="candidateOverlapPop">중복검색</a></span>
	                    <c:if test="${!empty getCandidate.USR_ID}">
		                    <span class="t_search"><a href="#" id="smsPop">SMS</a></span>
	                    </c:if>
	                    <div style="margin-top: 4px;"><label for="usrNm" class="error"></label></div>
                    </td>
                    <th class="re">업종</th>
                    <td>
                        <select id="industry1" name="industry1" class="sel02" style="width:170px;" >
                            <option value="">선택</option>
                            <c:forEach items="${codeMap.codeList1}" var="parentCode">
	                            <option value="${parentCode.CD_ID}" 
	                                <c:if test="${getCandidate.INDUSTRY1 eq parentCode.CD_ID}">selected</c:if>>
	                                <c:out value="${parentCode.CD_NM}" />
	                            </option>
	                        </c:forEach>
                        </select>
                        <select id="industry2" name="industry2" class="sel02" style="width:170px;" >
                        <option value="">선택</option>
                            <c:forEach items="${codeChildList1}" var="childCode">
		                       <option value="${childCode.CD_ID}" 
		                               <c:if test="${getCandidate.INDUSTRY2 eq childCode.CD_ID}">selected</c:if>>
		                               <c:out value="${childCode.CD_NM}" />
		                           </option>
	                        </c:forEach>
                        </select>
                        <div style="margin-top: 4px;"><label for="industry1" class="error"></label></div>
                    </td>
                </tr>
                <tr>
                    <th>출생년도</th>
                    <td>
                    	<input name="year" type="text" class="in2" value="<c:out value="${getCandidate.YEAR}" />" style="width:150px" maxlength="4" /> 년 /
                    	<label><input type="radio" name="gender" value="M" <c:if test="${getCandidate.GENDER eq 'M'}">checked</c:if> /> 남</label>
                    	<label><input type="radio" name="gender" value="W" <c:if test="${getCandidate.GENDER eq 'W'}">checked</c:if> /> 여</label>
                    	<label for="year" class="error"></label>
                    </td>
                    <th class="re">직무</th>
                    <td>
	                    <select id="job1" name="job1" class="sel02" style="width:170px;" >
                            <option value="">선택</option>
                            <c:forEach items="${codeMap.codeList2}" var="parentCode">
	                            <option value="${parentCode.CD_ID}" 
	                                <c:if test="${getCandidate.JOB1 eq parentCode.CD_ID}">selected</c:if>>
	                                <c:out value="${parentCode.CD_NM}" />
	                            </option>
	                        </c:forEach>
                        </select>
                        <select id="job2" name="job2" class="sel02" style="width:170px;" >
                        <option value="">선택</option>
                            <c:forEach items="${codeChildList2}" var="childCode">
		                       <option value="${childCode.CD_ID}" 
		                               <c:if test="${getCandidate.JOB2 eq childCode.CD_ID}">selected</c:if>>
		                               <c:out value="${childCode.CD_NM}" />
		                           </option>
	                        </c:forEach>
                        </select>
                        <div style="margin-top: 4px;"><label for="job1" class="error"></label></div>
                    </td>
                </tr>
                <tr>
                    <th>주소</th>
                    <td>
                        <input name="address" type="text" class="in2" value="<c:out value="${getCandidate.ADDRESS}" />" style="width:80%;" />
                    </td>
                    <th>인트라넷 공개</th>
                    <td>
						<select name="publicYn" class="sel02" style="width:250px;" >
                            <option value="Y" <c:if test="${getCandidate.PUBLIC_YN eq '1'}">selected</c:if>>공개</option>
                            <option value="N" disabled <c:if test="${getCandidate.PUBLIC_YN eq '0'}">selected</c:if>>비공개</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <th>외국어</th>
                    <td>
                        <input name="lang" type="text" class="in2" value="<c:out value="${getCandidate.LANG}" />" style="width:80%;" />
                    </td>
                    <th>자격증</th>
                    <td>
                    	<input name="license" type="text" class="in2" value="<c:out value="${getCandidate.LICENSE}" />" style="width:80%;" />
                    </td>
                </tr>
                <tr>
                    <th>현재(최종)연봉</th>
                    <td>
                        <input name="base" type="text" class="in2" value="<c:out value="${getCandidate.BASE}" />" style="width:50%;" /> 만원
                    </td>
                    <th>희망연봉</th>
                    <td>
                    	<input name="bonus" type="text" class="in2" value="<c:out value="${getCandidate.BONUS}" />" style="width:50%;" /> 만원
                    </td>
                </tr>
                <tr>
                	<th>학력사항</th>
                	<td colspan="3">
                		<table class="board_h" style="width:100%; margin:0; ">
            				<colgroup>
					            <col width="25%" />
					            <col width="25%" />
					            <col width="25%" />
					            <col width="25%" />
            				</colgroup>
            				<tbody>
            					<tr>
            						<th style="text-align: center;">학력</th>
            						<th style="text-align: center;">학교</th>
            						<th style="text-align: center;">전공</th>
            						<th style="text-align: center;">졸업구분</th>
            					</tr>
            					<c:choose>
            						<c:when test="${empty getUsrAcademicList}">
	            						<c:forEach begin="0" end="3" varStatus="status">
			            					<tr>
			            						<td style="text-align: center;">
			            							<select name="list[${status.index}].usrLevel" class="sel02">
								                    	<option value="">선택</option>
								                        <option value="1">박사</option>
							                            <option value="2">석사</option>
							                            <option value="3">학사</option>
							                            <option value="4">전문학사</option>
							                            <option value="5">무관</option>
								                    </select>
			            						</td>
			            						<td style="text-align: center;"><input type="text" class="in2" name="list[${status.index}].usrSchool" /></td>
			            						<td style="text-align: center;"><input type="text" class="in2" name="list[${status.index}].usrMajor" /></td>
			            						<td style="text-align: center;">
			            							<select name="list[${status.index}].usrType" class="sel02">
								                    	<option value="">선택</option>
								                        <option value="1">졸업</option>
							                            <option value="2">졸업예정</option>
							                            <option value="3">수료</option>
							                            <option value="4">편입</option>
							                            <option value="5">중퇴</option>
							                            <option value="6">재학중</option>
							                            <option value="7">기타</option>
								                    </select>
			            						</td>
			            					</tr>
	            					</c:forEach>
            						</c:when>
            						<c:otherwise>
	            						<c:forEach var="item" begin="0" end="3" items="${getUsrAcademicList}" varStatus="status">
			            					<tr>
			            						<td style="text-align: center;">
			            							<select name="list[${status.index}].usrLevel" class="sel02">
								                    	<option value="">선택</option>
								                        <option value="1" <c:if test="${item.USR_LEVEL eq '1'}">selected</c:if>>박사</option>
							                            <option value="2" <c:if test="${item.USR_LEVEL eq '2'}">selected</c:if>>석사</option>
							                            <option value="3" <c:if test="${item.USR_LEVEL eq '3'}">selected</c:if>>학사</option>
							                            <option value="4" <c:if test="${item.USR_LEVEL eq '4'}">selected</c:if>>전문학사</option>
							                            <option value="5" <c:if test="${item.USR_LEVEL eq '5'}">selected</c:if>>무관</option>
								                    </select>
			            						</td>
			            						<td style="text-align: center;"><input type="text" class="in2" name="list[${status.index}].usrSchool" value="<c:out value="${item.USR_SCHOOL}" />" /></td>
			            						<td style="text-align: center;"><input type="text" class="in2" name="list[${status.index}].usrMajor" value="<c:out value="${item.USR_MAJOR}" />" /></td>
			            						<td style="text-align: center;">
			            							<select name="list[${status.index}].usrType" class="sel02">
								                    	<option value="">선택</option>
								                        <option value="1" <c:if test="${item.USR_TYPE eq '1'}">selected</c:if>>졸업</option>
							                            <option value="2" <c:if test="${item.USR_TYPE eq '2'}">selected</c:if>>졸업예정</option>
							                            <option value="3" <c:if test="${item.USR_TYPE eq '3'}">selected</c:if>>수료</option>
							                            <option value="4" <c:if test="${item.USR_TYPE eq '4'}">selected</c:if>>편입</option>
							                            <option value="5" <c:if test="${item.USR_TYPE eq '5'}">selected</c:if>>중퇴</option>
							                            <option value="6" <c:if test="${item.USR_TYPE eq '6'}">selected</c:if>>재학중</option>
							                            <option value="7" <c:if test="${item.USR_TYPE eq '7'}">selected</c:if>>기타</option>
								                    </select>
			            						</td>
			            					</tr>
	            						</c:forEach>
            						</c:otherwise>
            					</c:choose>
            				</tbody>
            			</table>
            			<c:if test="${empty getCandidate.USR_ID}"><div style="margin-top: 10px;">※ 최종 학교를 첫번째 행에 입력해주세요.</div></c:if>
                	</td>
                </tr>
                <tr>
                    <th class="re">경력회사(최근순)</th>
                    <td colspan="3">
                    	<input name="cName" type="text" class="in2" value="<c:out value="${getCandidate.C_NAME}" />" style="width:97%;" />
                    </td>
                </tr>
                <tr>
					<th>경력요약</th>
                   	<td colspan="3">
                   		<textarea name="summary" cols="" rows="10" placeholder="[경력요약]" style="width:98%;"><c:out value="${getCandidate.SUMMARY}" /></textarea>
					</td>
                </tr>
                <tr>
                	<th>상세경력</th>
					<td colspan="3">
						<textarea name="detail" cols="" rows="10" placeholder="[상세경력]" style="width:98%;"><c:out value="${getCandidate.DETAIL}" /></textarea>
					</td>
                </tr>
                <tr>
                    <th class="re">출처</th>
                    <td>
						<select name="sources" class="sel02" style="width:200px;" >
	                        <option value="">전체</option>
	                        <option value="A" <c:if test="${getCandidate.SOURCES eq 'A'}">selected</c:if>>잡코리아</option>
	                        <option value="B" <c:if test="${getCandidate.SOURCES eq 'B'}">selected</c:if>>인크루트</option>
	                        <option value="C" <c:if test="${getCandidate.SOURCES eq 'C'}">selected</c:if>>스카우트</option>
	                        <option value="D" <c:if test="${getCandidate.SOURCES eq 'D'}">selected</c:if>>사람인</option>
	                        <option value="E" <c:if test="${getCandidate.SOURCES eq 'E'}">selected</c:if>>기타 잡포탈</option>
	                        <option value="F" <c:if test="${getCandidate.SOURCES eq 'F'}">selected</c:if>>명부</option>
	                        <option value="G" <c:if test="${getCandidate.SOURCES eq 'G'}">selected</c:if>>지인소개</option>
	                        <option value="H" <c:if test="${getCandidate.SOURCES eq 'H'}">selected</c:if>>개인DB</option>
	                        <option value="I" <c:if test="${getCandidate.SOURCES eq 'I'}">selected</c:if>>직접지원</option>
	                        <option value="J" <c:if test="${getCandidate.SOURCES eq 'J'}">selected</c:if>>기타</option>
	                        <option value="K" <c:if test="${getCandidate.SOURCES eq 'K'}">selected</c:if>>Old DB</option>
	                    </select>
                    </td>
                    <th>등록자</th>
                    <td>
	                    <select name="conId" class="sel02" style="width:200px;" <c:if test="${!empty getCandidate.USR_ID}"><c:if test="${userInfo.ADMIN_YN ne 'Y'}">disabled</c:if></c:if>>
                            <option value="">선택</option>
                            <c:forEach items="${consultantList}" var="consultant">
                                <option value="${consultant.CON_ID}" <c:if test="${getCandidate.CON_ID eq consultant.CON_ID}">selected</c:if>>
                                	<c:out value="${consultant.CON_NM}" />
                                </option>
                            </c:forEach>
                        </select>
                    </td>
                </tr>
                <tr>
                    <th class="re">연락처</th>
                    <td>
                    	(HP) <input name="mobile" type="text" class="in2" value="<c:out value="${getCandidate.MOBILE}" />" style="width:30%" />
						&nbsp; ☎  <input name="phone" type="text" class="in2" value="<c:out value="${getCandidate.PHONE}" />" style="width:30%" />
						<div style="margin-top: 4px;"><label for="mobile" class="error"></label></div>
                    </td>
                    <th class="re">E-mail</th>
                    <td>
	                    <input name="email" type="text" class="in2" value="<c:out value="${getCandidate.EMAIL}" />" style="width:80%" />
                    </td>
                </tr>
                <tr>
                    <th>국문이력서1</th>
                    <td>
                    	<div class="filebox">
                            <c:choose>
                                <c:when test="${empty fileMap.originalFileNm_1}">
                                    <a href="javascript:;" class="upload-name">파일선택</a>
                                </c:when>
                                <c:otherwise>
                                	<input type="hidden" name="attId_1" value='<c:out value="${fileMap.attId_1}"></c:out>' />
                                    <a href="javascript:;" data-att-id='<c:out value="${fileMap.attId_1}" />' class="upload-name">
                                    	<c:out value="${fileMap.originalFileNm_1}" /> (<c:out value="${fileMap.fileSize_1}" />kb)
                                    </a>
                                </c:otherwise>
                            </c:choose>

							<label for="file1">파일첨부</label> 
							<input type="file" id="file1" name="file1" class="upload-hidden"> 
							<c:if test="${!empty fileMap.originalFileNm_1}">
								<c:if test="${userInfo.CON_ID eq getCandidate.CON_ID || userInfo.ADMIN_YN eq 'Y'}">
									<span class="d_btn"><a href="javascript:;">삭제</a></span>
                                </c:if>
							</c:if>
                        </div>
                    </td>
                    <th>영문이력서1</th>
                    <td>
	                    <div class="filebox">
                            <c:choose>
                                <c:when test="${empty fileMap.originalFileNm_2}">
                                    <a href="javascript:;" class="upload-name">파일선택</a>
                                </c:when>
                                <c:otherwise>
                                	<input type="hidden" name="attId_2" value='<c:out value="${fileMap.attId_2}"></c:out>' />
                                    <a href="javascript:;" data-att-id='<c:out value="${fileMap.attId_2}" />' class="upload-name">
                                    	<c:out value="${fileMap.originalFileNm_2}" /> (<c:out value="${fileMap.fileSize_2}" />kb)
                                    </a>
                                </c:otherwise>
                            </c:choose>

							<label for="file2">파일첨부</label> 
							<input type="file" id="file2" name="file2" class="upload-hidden">
							<c:if test="${!empty fileMap.originalFileNm_2}">
								<c:if test="${userInfo.CON_ID eq getCandidate.CON_ID || userInfo.ADMIN_YN eq 'Y'}">
									<span class="d_btn"><a href="javascript:;">삭제</a></span>
                                </c:if>
							</c:if> 
                        </div>
                    </td>
                </tr>
                <tr>
                    <th>국문이력서2</th>
                    <td>
                    	<div class="filebox">
                            <c:choose>
                                <c:when test="${empty fileMap.originalFileNm_3}">
                                    <a href="javascript:;" class="upload-name">파일선택</a>
                                </c:when>
                                <c:otherwise>
                                	<input type="hidden" name="attId_3" value='<c:out value="${fileMap.attId_3}"></c:out>' />
                                    <a href="javascript:;" data-att-id='<c:out value="${fileMap.attId_3}" />' class="upload-name">
                                    	<c:out value="${fileMap.originalFileNm_3}" /> (<c:out value="${fileMap.fileSize_3}" />kb)
                                    </a>
                                </c:otherwise>
                            </c:choose>

							<label for="file3">파일첨부</label> 
							<input type="file" id="file3" name="file3" class="upload-hidden">
							<c:if test="${!empty fileMap.originalFileNm_3}">
								<c:if test="${userInfo.CON_ID eq getCandidate.CON_ID || userInfo.ADMIN_YN eq 'Y'}">
									<span class="d_btn"><a href="javascript:;">삭제</a></span>
                                </c:if>
							</c:if> 
                        </div>
                    </td>
                    <th>영문이력서2</th>
                    <td>
	                    <div class="filebox">
                            <c:choose>
                                <c:when test="${empty fileMap.originalFileNm_4}">
                                    <a href="javascript:;" class="upload-name">파일선택</a>
                                </c:when>
                                <c:otherwise>
                                	<input type="hidden" name="attId_4" value='<c:out value="${fileMap.attId_4}"></c:out>' />
                                    <a href="javascript:;" data-att-id='<c:out value="${fileMap.attId_4}" />' class="upload-name">
                                    	<c:out value="${fileMap.originalFileNm_4}" /> (<c:out value="${fileMap.fileSize_4}" />kb)
                                    </a>
                                </c:otherwise>
                            </c:choose>

							<label for="file4">파일첨부</label> 
							<input type="file" id="file4" name="file4" class="upload-hidden">
							<c:if test="${!empty fileMap.originalFileNm_4}">
								<c:if test="${userInfo.CON_ID eq getCandidate.CON_ID || userInfo.ADMIN_YN eq 'Y'}">
									<span class="d_btn"><a href="javascript:;">삭제</a></span>
                                </c:if>
							</c:if>
                        </div>
                    </td>
                </tr>
                <tr>
                    <th>추천서</th>
                    <td>
                    	<div class="filebox">
                            <c:choose>
                                <c:when test="${empty fileMap.originalFileNm_5}">
                                    <a href="javascript:;" class="upload-name">파일선택</a>
                                </c:when>
                                <c:otherwise>
                                	<input type="hidden" name="attId_5" value='<c:out value="${fileMap.attId_5}"></c:out>' />
                                    <a href="javascript:;" data-att-id='<c:out value="${fileMap.attId_5}" />' class="upload-name">
                                    	<c:out value="${fileMap.originalFileNm_5}" /> (<c:out value="${fileMap.fileSize_5}" />kb)
                                    </a>
                                </c:otherwise>
                            </c:choose>

							<label for="file5">파일첨부</label> 
							<input type="file" id="file5" name="file5" class="upload-hidden"> 
							<c:if test="${!empty fileMap.originalFileNm_5}">
								<c:if test="${userInfo.CON_ID eq getCandidate.CON_ID || userInfo.ADMIN_YN eq 'Y'}">
									<span class="d_btn"><a href="javascript:;">삭제</a></span>
                                </c:if>
							</c:if>
                        </div>
                    </td>
                    <th>기타</th>
                    <td>
	                    <div class="filebox">
                            <c:choose>
                                <c:when test="${empty fileMap.originalFileNm_6}">
                                    <a href="javascript:;" class="upload-name">파일선택</a>
                                </c:when>
                                <c:otherwise>
                                	<input type="hidden" name="attId_6" value='<c:out value="${fileMap.attId_6}"></c:out>' />
                                    <a href="javascript:;" data-att-id='<c:out value="${fileMap.attId_6}" />' class="upload-name">
                                    	<c:out value="${fileMap.originalFileNm_6}" /> (<c:out value="${fileMap.fileSize_6}" />kb)
                                    </a>
                                </c:otherwise>
                            </c:choose>

							<label for="file6">파일첨부</label> 
							<input type="file" id="file6" name="file6" class="upload-hidden">
							<c:if test="${!empty fileMap.originalFileNm_6}">
								<c:if test="${userInfo.CON_ID eq getCandidate.CON_ID || userInfo.ADMIN_YN eq 'Y'}">
									<span class="d_btn"><a href="javascript:;">삭제</a></span>
                                </c:if>
							</c:if>
                        </div>
                    </td>
                </tr>
            </tbody>
        </table>
        
        <c:if test="${!empty getCandidate.USR_ID}">
			<jsp:include page="/WEB-INF/views/common/comment.jsp" />        
        </c:if>
        
        <c:if test="${!empty getCandidate.USR_ID}">
        <p class="s_title">진행현황</p>
        <p style="float:right; margin-top:15px;">
            <span class="d_search"><a href="javascript:;" id="delPresent">삭제</a></span>
            <span class="p_search"><a href="javascript:;" id="positionAddPop">등록</a></span>
        </p>
        
        <table id="preTable" class="board_list" style="width:100%;">
            <colgroup>
            <col width="4%" />
            <col width="4%" />
            <col width="20%" />
            <col width="20%" />
            <col width="10%" />
            <col width="10%" />
            <col width="25%" />
            <col width="*" />
            </colgroup>
            <tbody>
                <tr>
                	<th>선택</th>
                    <th>No</th>
                    <th>회사명</th>
                    <th>포지션</th>
                    <th>포지션등록일</th>
                    <th>등록자</th>
                    <th>상태</th>
                    <th>비고</th>
                </tr>
                <c:forEach var="item" items="${progressList}" >
	                <tr>
	                	<td>
	                		<input type="checkbox" name="chk" value="<c:out value="${item.REC_ID}" />" />
	                		<input type="hidden" id="recConId" value="<c:out value="${item.CON_ID}" />" />
	                	</td>
	                    <td><c:out value="${item.ROWNUM}" /></td>
	                    <td><c:out value="${item.COM_NM}" /></td>
	                    <td><c:out value="${item.POS_NM}" /></td>
	                    <td><c:out value="${item.REG_DATE}" /></td>
	                    <td><c:out value="${item.CON_NM}" /></td>
	                    <td>
	                    	<div style="margin-bottom:10px;" class="state">
		                    	<select class="sel02" style="width:80px;" >
		                    		<option value="">선택</option>
		                    		<option value="A">추천</option>
		                    		<option value="B">1차면접</option>
		                    		<option value="C">2차면접</option>
		                    		<option value="D">3차면접</option>
		                    		<option value="E">실기</option>
		                    		<option value="F">인적성</option>
		                    		<option value="G">입사확정</option>
		                    		<option value="H">입사</option>
		                    		<option value="I">빌링</option>
		                    		<option value="J">탈락</option>
		                    		<option value="K">보류</option>
		                    		<option value="L">미검토</option>
		                    		<option value="M">협상결렬</option>
		                    		<option value="N">본인포기</option>
		                    		<option value="O">입금</option>
		                    		<option value="P">빌링취소</option>
		                    		<option value="Q">리플접수</option>
		                    		<option value="R">리플</option>
		                    		<option value="S">정산</option>
		                    		<option value="T">call</option>
		                    		<option value="U">이메일</option>
		                    		<option value="V">프리뷰</option>
		                    		<option value="W">기타</option>
		                    	</select>
	                    		<input name="statusDate" type="text" class="in" style="width:70px;" />
	                    		<a href="javascript:;" name="statusDateImg"><img src="/resources/images/b_cal.png" style="vertical-align: middle;"/></a>
	                    	</div>
	                    	<c:forEach var="chlidstate" items="${item.posProStatusList}">
		                    	<div class="divState">
		                    		<span class="spanStateDate"><c:out value="${chlidstate.STATE_NM}" /></span> 
		                    		<span style="color: #999999; margin-left: 10px;"><c:out value="${chlidstate.STATE_DATE}" /></span>
		                    		<c:if test="${chlidstate.CON_ID eq userInfo.CON_ID || userInfo.ADMIN_YN eq 'Y'}">
		                    			<span class="delState" id="<c:out value="${chlidstate.STA_ID}" />">x</span>
		                    		</c:if>
		                    	</div>
	                    	</c:forEach> 
	                    </td>
	                    <td>
	                    	<c:if test="${item.CON_ID eq userInfo.CON_ID || getCandidate.CON_ID eq userInfo.CON_ID || userInfo.ADMIN_YN eq 'Y'}">
	                    		<span class="t_p"><a href="javascript:;">추가</a></span>
	                    	</c:if>
	                    </td>
	                </tr>
                </c:forEach>
                <c:if test="${empty progressList}">
                	<tr>
                		<td colspan="8">진행현황 목록이 없습니다.</td>
                	</tr>
                </c:if>
			</tbody>
		</table>
		</c:if>
	</div>
	</form>
</div>

<script type="text/javascript">

	$(document).ready(init);
	
	function init() {
		adjustHeight(); //textarea 크기 자동지정
	    $('#setCandidate').on('click', setCandidate);
	    $('#modCandidate').on('click', setCandidate);	    
	    
	    $('#industry1').on('change', getIndustry);
	    $('#job1').on('change', getJob);
	    $('#candidateOverlapPop').on('click', candidateOverlapPop);
	    $('#smsPop').on('click', smsPop);
	    $('.upload-name').on('click', downloadFile);
	    $('input[type=file]').on('change', setFile);
	    $(document).on('click', '.d_btn', delFile);
	    $('#usrNm').on('keyup', this, enterEvent);
	    
	    $('#positionAddPop').on('click', positionAddPop);
	    $('#delPresent').on('click', delPresent);
	    $('input[name="statusDate"]').datepicker();
	    $(document).on('click','a[name="statusDateImg"]',openDate);
	    $(document).on('click','.t_p',addStatus);
	    $(document).on('click','.delState',delStatus);
	    
	}
	
	var adjustHeight = function() {
		var textEle1 = $('textarea[name="summary"]');
		var textEle2 = $('textarea[name="detail"]');
		var textEleHeight1 = textEle1.prop('scrollHeight');
		var textEleHeight2 = textEle2.prop('scrollHeight');
// 		var height = textEleHeight1 > textEleHeight2 ?  textEleHeight1 : textEleHeight2;
		textEle1.css('height', textEleHeight1);
		textEle2.css('height', textEleHeight2);
	};

	function setCandidate() {
	    $.validator.addMethod(
	            'mobilephone', function (value, element) {
	                return (value.substring(0, 1) == 0) ? true : false;
	            }, '휴대전화 번호는 0 으로 시작하여야 합니다.'
	        );
	    
		$("#candidateForm").validate({
	        onfocusout: true,
	        rules : {
	            usrNm : {required : true}
	    		,industry1 : {required : true}
	            ,job1 : {required : true}
				,cName : {required : true}
	    		,sources : {required : true}
				,mobile : {required : true}
				,email : {required : true}
// 				,mobile : {required : true, minlength : 10, mobilephone : true}
// 	            ,email : {required : true, email: true}
				,year : {required : false, minlength : 4, maxlength: 4, digits: true}
	        },
	        messages : {
	            usrNm  : {required : '후보자 성명을 입력하세요.'}
	        	,industry1 : {required : '업종을 선택하세요.'}
	            ,job1 : {required : '직무를 선택하세요.'}
	        	,cName  : {required : '경력회사를 입력하세요.'}
	            ,sources : {required : '출처를 선택하세요.'}
	            ,mobile : {required : '연락처를 입력하세요.'}
	            ,email : {required : '메일을 입력하세요.'}
// 	            ,mobile : {required : '연락처를 입력하세요.', minlength: $.validator.format("전화번호는 최소 {0} 글자 이상 입력하세요.")}
// 	            ,email : {required : '메일을 입력하세요.', email : '메일규칙에 어긋납니다.', minlength : '최소 {0}글자이상이어야 합니다.', remote : '중복된 E-mail 입니다.'}
	            ,year : {minlength : '출생년도는 4자리 입니다.', digits : '숫자만 입력 가능합니다.'}
	        },
	        submitHandler : function(form) {
	            callAjaxSubmit(form);
	        }
	    });
	    
	    $("#candidateForm").submit();
	}
	
	/*저장 */
	function callAjaxSubmit(form) {
	    var url = ($('#usrId').val() == '') ? '<c:url value="./setCandidate" />' : '<c:url value="./modCandidate" />';
	    $('select[name="conId"]').attr('disabled', false);
        form.job1Nm.value = $.trim($('#job1 option:selected').text());
        form.job2Nm.value = $.trim($('#job2 option:selected').text());

		$(form).ajaxSubmit({
		    url : url,
		    type : 'post',
		    success : function(res) {
		        if (res.result === 'success') {
            		toastr.success('저장 되었습니다.');

            		window.setTimeout(function() {
			            document.location.href = '<c:url value="./candidateList" />';
		            }, 300);
		        }
		    }
		});
	}
	
	function getIndustry() {
	    var url = '<c:url value="/admin/childList" />';
	    var parentId = $(this).val(); 
	    $('#industry2').empty();
	    
	    $.ajax({
	        url :  url,
	        data : {'parentId' : parentId},
	        success : function(res) {
	            var str = "";
	            str += '<option value="">선택</option>'; 
	            $.each(res, function(i, item) {
	                str += '<option value="'+item.CD_ID+'">' +item.CD_NM+ '</option>'; 
	                
	            });
	            $('#industry2').append(str);
	        }
	    });
	}
	
	function getJob() {
	    var url = '<c:url value="/admin/childList" />';
	    var parentId = $(this).val(); 
	    $('#job2').empty();
	    
	    $.ajax({
	        url :  url,
	        data : {'parentId' : parentId},
	        success : function(res) {
	            var str = "";
	            str += '<option value="">선택</option>'; 
	            $.each(res, function(i, item) {
	                str += '<option value="'+item.CD_ID+'">' +item.CD_NM+ '</option>'; 
	                
	            });
	            $('#job2').append(str);
	        }
	    });
	}
	
	/* 중복검색 팝업창 */
	function candidateOverlapPop() {
	    var url = '<c:url value="./candidateOverlapPop" />';
	    url += '?usrNm=' + $('#usrNm').val();
	    
	    popupCenter(encodeURI(url), "overlapUsrPop", 500, 450);
	}
	
	/* SMS 팝업창 */
	function smsPop() {
	    var url = '<c:url value="./smsPop" />';
	    url += '?toTarget=${getCandidate.MOBILE}';
	    
	    popupCenter(encodeURI(url), "smsPop", 540, 450);
	}
	
	function positionAddPop() {
	    var url = '<c:url value="./positionAddPop" />';
	    
	    popupCenter(encodeURI(url), "positionAddPop", 500, 450);
	}
	
	function setFile() {
	    if(window.FileReader){  // modern browser
	        var filename = $(this)[0].files[0].name;
	      } 
	      else {  // old IE
	        var filename = $(this).val().split('/').pop().split('\\').pop();  // 파일명만 추출
	      }
	    
	    // 추출한 파일명 삽입
	    $(this).siblings('.upload-name').text(filename);
	    if ($(this).parent().find('.d_btn').length === 0)  {
		    $(this).after('<span class="d_btn"><a href="#this" id="delFile">삭제</a></span>');
	    }
	    
	    //파일을 수정할 경우 attId를 넘긴다.
	    var delFileAttId = $('input[name=delFiles]').val();
	    var attIdVal = $(this).parent().find(':hidden').val();
	    if (attIdVal != '') {
	        $('input[name=delFiles]').val(delFileAttId + '@' + attIdVal);
	    }
	}
	
	function delFile() {
	    var agent = navigator.userAgent.toLowerCase();
	    var delFileAttId = $('input[name=delFiles]').val();
	    var attIdVal = $(this).parent().find(':hidden').val();
	    
	  //IE 일때와 타브라우저일때 
		if ( (navigator.appName == 'Netscape' && navigator.userAgent.search('Trident') != -1) || (agent.indexOf("msie") != -1) ) {
		    $(this).parent().find('input[type=file]').replaceWith( $("#file").clone(true) );	
		} else {
		    $(this).parent().find('input[type=file]').val('');
		}
	    
	    //파일 삭제를 위해 attId 넘긴다.
		$('input[name=delFiles]').val(delFileAttId + '@' + attIdVal);
	    
	    $(this).parent().find('.upload-name').text('파일선택').off('click', downloadFile);
	    $(this).parent().find(':hidden').val('');
	    $(this).remove();
	}
	
	function downloadFile() {
	    var attId = $(this).data('attId');
	    var authUserType = '${userInfo.AUTH_USER_TYPE}';
	    var currentUserId = '${userInfo.CON_ID}';
	    var conId = $('select[name=conId]').val();
	    
	    if (authUserType === '1' || conId === currentUserId) {
		    if (attId != undefined) {
			    var url = '<c:url value="/downloadFile" />';
			    url += '?attId=' + attId;
			    
			    $(location).attr('href', url);
		    }
	    } else {
	        toastr.info('다운로드 권한이 없습니다.');    
	    }
	    
	}
	
	/** 진행현황 등록 **/
	function addPostionPresent(param) {
	    var url = '<c:url value="./addPositionPresent" />';
	    var data = {
	      usrId : $('#usrId').val(),
	      posId : param.posId,
	      conId : $('#currentUser').val()
	    };
	    var $preTableTd = $('#preTable tbody').find('td');
	    var tdCnt = $preTableTd.length;
	    var indexTxt = $preTableTd.eq(1).text()
		if (tdCnt === 1) { //첫등록
		    $preTableTd.parent().remove();
		    indexTxt = 0;
		};

	    $.ajax({
	        url :  url,
	        type : 'post',
	        data : data,
	        success : function(res) {
	            var result = res.result;
	            var str = '';
	            str += '<tr>';
	            str += '<td><input type="checkbox" name="chk" value="' + result.REC_ID + '" /></td>';
	            str += '<td>' + (Number(indexTxt)+1) + '</td>';
	            str += '<td>' + result.COM_NM + '</td>';
	            str += '<td>' + result.POS_NM + '</td>';
	            str += '<td>' + result.REG_DATE + '</td>';
	            str += '<td>' + result.CON_NM + '</td>';
	            str += '<td>';
	            str += '<div style="margin-bottom:10px;" class="state">'; 
	            str += '<select class="sel02" style="width:80px;" >';
	            str += '<option>선택</option>';
	            str += '<option value="A">추천</option><option value="B">1차면접</option><option value="C">2차면접</option><option value="D">3차면접</option>' +
            			'<option value="E">실기</option><option value="F">인적성</option><option value="G">입사확정</option><option value="H">입사</option>' +
            			'<option value="I">빌링</option><option value="J">탈락</option><option value="K">보류</option><option value="L">미검토</option>' +
            			'<option value="M">협상결렬</option><option value="N">본인포기</option><option value="O">입금</option><option value="P">빌링취소</option>' +
            			'<option value="Q">리플접수</option><option value="R">리플</option><option value="S">정산</option><option value="T">call</option>' +
            			'<option value="U">이메일</option><option value="V">프리뷰</option><option value="W">기타</option>';
	            str += '</select>';
	            str += ' <input name="statusDate" type="text" class="in" style="width:70px;" /> ';
	            str += '<a href="javascript:;" name="statusDateImg"><img src="/resources/images/b_cal.png" style=" vertical-align: middle;"/></a>';
	            str +='</div>';
	            str +='</td>';
	            str += '<td>';
	            str += '<span class="t_p"><a href="javascript:;">추가</a></span> ';
	            str += '</td>';
	            str += '</tr>';
	            
				$('#preTable tbody').find('tr').first().after(str);
				
				$(document).scrollTop($(document).height());
				$('input[name="statusDate"]').removeClass('hasDatepicker').datepicker();
	        }
	    });
	}
	
	/** 진행현황 삭제 **/
	function delPresent() {
	    var url = '<c:url value="./delPosRecPresent" />';
	    var $chk = $('input:checkbox[name="chk"]:checked');
	    var result = '';
	    
	    if (!$chk.is(':checked')) {
	        toastr.warning('<div class="font14">삭제할 진행현황을 체크해 주세요.</div>');
	        return;
	    }
	    else {
	        if ($chk.parent().parent().find('.divState').length != 0) {
	            toastr.warning('<div class="font14">진행상태값이 존재하여 삭제가<br/>불가능 합니다.</div>');
	            return;
	        }
	        
	        $chk.each(function() {
	            var recConId = $(this).next().val();
	            if (recConId !=  '${userInfo.CON_ID}' && '${userInfo.ADMIN_YN}' === 'N') {
	                result += 'N';
	            } else {
	                result += 'Y';
	            }
	        });
	        
	        if (result.indexOf('N') === -1) 
	        {
		        if (confirm('정말 삭제 하시겠습니까?')) {
			        var arrayChk = [];
			        
			        $chk.each(function() {
			            arrayChk.push(this.value);
			            $(this).parent().parent().remove();
			        	
			            var $preTableTr = $('#preTable tbody').find('tr');
			            if ($preTableTr.length === 1) {
			                var str = '<tr><td colspan="8">진행현황 목록이 없습니다.</td></tr>';
			                $preTableTr.after(str)
			            }
			        });
			        var data = {'arrayChk' : arrayChk}
			        
			        $.ajax({
		    	        url :  url,
		    	        type : 'post',
		    	        data : data,
		    	        traditional: true,
		    	        success : function(res) {
		    	            if (res.result === 'success')  
		    	                toastr.success('삭제 되었습니다.');
		    	        }
		    	    });
		        }
	        }
	        else 
	        {
	            toastr.warning('<div class="font14">본인이 등록한 진행현황만 삭제</br>가능 합니다.</div>');
	        }
	        
	    }
	}
	
	/** 진행상태 등록 **/
	function addStatus() {
	    var url = '<c:url value="./addPosProStatus" />';
	    var $stateTd = $(this).parent().parent();
	    var recId = $stateTd.find(':checkbox').val();
	    var $selected = $stateTd.find('select option:selected');
	    var stateVal = $selected.val();
	    var stateNm = $selected.text();
	    var stateDate = $stateTd.find('.hasDatepicker').val();
	    
	    if (stateVal == '' || stateDate == '') {
	        toastr.warning('상태값을 입력하셔야 합니다.');
	        return;
	    }
	    
	    var data = {
			'recId' : recId,
			'state' : stateVal,
			'stateNm' : stateNm,
			'stateDate' : stateDate,
			'conId' : $('#currentUser').val()
	    };

	    $.ajax({
	        url :  url,
	        type : 'post',
	        data : data,
	        success : function(res) {
	            var result = res.result;
	            
	            if (result === 'success') {
		            var str = '';
		            str += '<div class="divState">';
		            str += '<span class="spanStateDate">' + stateNm + '</span>&nbsp;';
		            str += '<span style="color: #999999; margin-left: 10px;">' + stateDate + '</span>';
		            str += '<span class="delState" id="' + res.staId + '">x</span>';
		            str += '</div>';
		            
		            $stateTd.find('.state').after(str);
	            }
	        }
	    });
	}
	
	/** 진행상태 삭제 **/
	function delStatus() {
	    var url = '<c:url value="./delPosProStatus" />';
	    var $sta = $(this);
	    
	    if (confirm('정말 삭제 하시겠습니까?')) {
		    $.ajax({
		        url :  url,
		        type : 'post',
		        data : {'staId' : $sta.attr('id')},
		        success : function(res) {
		            var result = res.result;
		            
		            if (result === 'success') {
		                $sta.parent().remove();
		            }
		        }
		    });
	    }
	}
	
	//달력 포커스
	function openDate() {
	    $(this).parent().find('input[name="statusDate"]').focus();
	};

	function enterEvent(key) {
        if (key.keyCode == 13) {
            candidateOverlapPop();
        }
    }
	
</script>