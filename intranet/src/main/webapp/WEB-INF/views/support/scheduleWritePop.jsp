<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div id="wrapper_p">
	<form id="frm" name="frm" method="post" enctype="multipart/form-data">
	<input type="hidden" id="schId" name="schId" value='<c:out value="${scheduleData.SCH_ID}" />' />
	
    <!--팝업타이틀 시작-->
    <div class="top">
   		<c:choose>
       		<c:when test="${empty scheduleData.SCH_ID}">
       			<span class="pop_st">일정 등록</span>
       		</c:when>
       		<c:otherwise>
       			<span class="pop_st">일정 수정</span>
       		</c:otherwise>
       	</c:choose>
        <span class="close"><a href=""><img src="/resources/images/p_close.png" title="닫기"/></a></span>
    </div>
    <!--팝업타이틀 끝-->

    <div class="b_search">
        <div class="b_search2" style="float: right; padding: 0px 15px 5px 0px">
        	<c:choose>
        		<c:when test="${empty scheduleData.SCH_ID}">
        			<span class="p_search" id="setSchedule"><a href="javascript:;">등록</a></span>
        		</c:when>
        		<c:otherwise>
        			<c:if test="${userInfo.CON_ID eq scheduleData.CON_ID || userInfo.ADMIN_YN eq 'Y'}">
		        		<span class="p_search" id="delSchedule"><a href="javascript:;">삭제</a></span>
	        			<span class="p_search" id="modSchedule"><a href="javascript:;">수정</a></span>
        			</c:if>
        		</c:otherwise>
        	</c:choose>
        </div>
    </div>

    <div id="popcontents">
        <table class="board_h2" style="width:100%;">
            <colgroup>
            	<col width="20%" />
            	<col width="*%" />
            </colgroup>
            <tbody>
                <tr> 
                	<th>제목</th>
                    <td style="border-top: 1px solid #e3e3e3;">
                    	<c:choose>
                    		<c:when test="${empty scheduleData.SCH_ID}">
                    			<input id="schNm" name="schNm" type="text" class="in2" value='<c:out value="${userInfo.CON_NM}" /> : ' style="width: 100%;" />
                    		</c:when>
                    		<c:otherwise>
		                    	<input id="schNm" name="schNm" type="text" class="in2" value='<c:out value="${scheduleData.SCH_NM}" />' style="width: 100%;" />
                    		</c:otherwise>
                    	</c:choose>
                    </td>
				</tr>
				<tr>
                	<th>날짜</th>
                    <td>
                    	<input id="startYmd" name="startYmd" type="text" class="in mr3" value='<c:out value="${scheduleData.START_YMD}" />' style="width:65px;" />
                    	<select name="startTm" id="startTm" class="sel02" style="width: 89px; height: 23px;">
                    		<option value="0800" <c:if test="${scheduleData.START_TM eq '0800'}">selected</c:if>>오전 08:00</option>
                    		<option value="0830" <c:if test="${scheduleData.START_TM eq '0830'}">selected</c:if>>오전 08:30</option>
                    		<option value="0900" <c:if test="${scheduleData.START_TM eq '0900'}">selected</c:if>>오전 09:00</option>
                    		<option value="0930" <c:if test="${scheduleData.START_TM eq '0930'}">selected</c:if>>오전 09:30</option>
                    		<option value="1000" <c:if test="${scheduleData.START_TM eq '1000'}">selected</c:if>>오전 10:00</option>
                    		<option value="1030" <c:if test="${scheduleData.START_TM eq '1030'}">selected</c:if>>오전 10:30</option>
                    		<option value="1100" <c:if test="${scheduleData.START_TM eq '1100'}">selected</c:if>>오전 11:00</option>
                    		<option value="1130" <c:if test="${scheduleData.START_TM eq '1130'}">selected</c:if>>오전 11:30</option>
                    		<option value="1200" <c:if test="${scheduleData.START_TM eq '1200'}">selected</c:if>>오후 12:00</option>
                    		<option value="1230" <c:if test="${scheduleData.START_TM eq '1230'}">selected</c:if>>오후 12:30</option>
                    		<option value="1300" <c:if test="${scheduleData.START_TM eq '1300'}">selected</c:if>>오후 01:00</option>
                    		<option value="1330" <c:if test="${scheduleData.START_TM eq '1330'}">selected</c:if>>오후 01:30</option>
                    		<option value="1400" <c:if test="${scheduleData.START_TM eq '1400'}">selected</c:if>>오후 02:00</option>
                    		<option value="1430" <c:if test="${scheduleData.START_TM eq '1430'}">selected</c:if>>오후 02:30</option>
                    		<option value="1500" <c:if test="${scheduleData.START_TM eq '1500'}">selected</c:if>>오후 03:00</option>
                    		<option value="1530" <c:if test="${scheduleData.START_TM eq '1530'}">selected</c:if>>오후 03:30</option>
                    		<option value="1600" <c:if test="${scheduleData.START_TM eq '1600'}">selected</c:if>>오후 04:00</option>
                    		<option value="1630" <c:if test="${scheduleData.START_TM eq '1630'}">selected</c:if>>오후 04:30</option>
                    		<option value="1700" <c:if test="${scheduleData.START_TM eq '1700'}">selected</c:if>>오후 05:00</option>
                    		<option value="1730" <c:if test="${scheduleData.START_TM eq '1730'}">selected</c:if>>오후 05:30</option>
                    		<option value="1800" <c:if test="${scheduleData.START_TM eq '1800'}">selected</c:if>>오후 06:00</option>
                    		<option value="1830" <c:if test="${scheduleData.START_TM eq '1830'}">selected</c:if>>오후 06:30</option>
                    		<option value="1900" <c:if test="${scheduleData.START_TM eq '1900'}">selected</c:if>>오후 07:00</option>
                    		<option value="1930" <c:if test="${scheduleData.START_TM eq '1930'}">selected</c:if>>오후 07:30</option>
                    		<option value="2000" <c:if test="${scheduleData.START_TM eq '2000'}">selected</c:if>>오후 08:00</option>
                    		<option value="2030" <c:if test="${scheduleData.START_TM eq '2030'}">selected</c:if>>오후 08:30</option>
                    		<option value="2100" <c:if test="${scheduleData.START_TM eq '2100'}">selected</c:if>>오후 09:00</option>
                    		<option value="2130" <c:if test="${scheduleData.START_TM eq '2130'}">selected</c:if>>오후 09:30</option>
                    		<option value="2200" <c:if test="${scheduleData.START_TM eq '2200'}">selected</c:if>>오후 10:00</option>
                    		<option value="2230" <c:if test="${scheduleData.START_TM eq '2230'}">selected</c:if>>오후 10:30</option>
                    		<option value="2300" <c:if test="${scheduleData.START_TM eq '2300'}">selected</c:if>>오후 11:00</option>
                    	</select>
	                    <span>-</span>
	                    <input id="endYmd" name="endYmd" type="text" class="in mr3" value='<c:out value="${scheduleData.END_YMD}" />' style="width:65px;" />
	                    <select name="endTm" id="endTm" class="sel02" style="width: 89px; height: 23px;">
                    		<option value="0800" <c:if test="${scheduleData.END_TM eq '0800'}">selected</c:if>>오전 08:00</option>
                    		<option value="0830" <c:if test="${scheduleData.END_TM eq '0830'}">selected</c:if>>오전 08:30</option>
                    		<option value="0900" <c:if test="${scheduleData.END_TM eq '0900'}">selected</c:if>>오전 09:00</option>
                    		<option value="0930" <c:if test="${scheduleData.END_TM eq '0930'}">selected</c:if>>오전 09:30</option>
                    		<option value="1000" <c:if test="${scheduleData.END_TM eq '1000'}">selected</c:if>>오전 10:00</option>
                    		<option value="1030" <c:if test="${scheduleData.END_TM eq '1030'}">selected</c:if>>오전 10:30</option>
                    		<option value="1100" <c:if test="${scheduleData.END_TM eq '1100'}">selected</c:if>>오전 11:00</option>
                    		<option value="1130" <c:if test="${scheduleData.END_TM eq '1130'}">selected</c:if>>오전 11:30</option>
                    		<option value="1200" <c:if test="${scheduleData.END_TM eq '1200'}">selected</c:if>>오후 12:00</option>
                    		<option value="1230" <c:if test="${scheduleData.END_TM eq '1230'}">selected</c:if>>오후 12:30</option>
                    		<option value="1300" <c:if test="${scheduleData.END_TM eq '1300'}">selected</c:if>>오후 01:00</option>
                    		<option value="1330" <c:if test="${scheduleData.END_TM eq '1330'}">selected</c:if>>오후 01:30</option>
                    		<option value="1400" <c:if test="${scheduleData.END_TM eq '1400'}">selected</c:if>>오후 02:00</option>
                    		<option value="1430" <c:if test="${scheduleData.END_TM eq '1430'}">selected</c:if>>오후 02:30</option>
                    		<option value="1500" <c:if test="${scheduleData.END_TM eq '1500'}">selected</c:if>>오후 03:00</option>
                    		<option value="1530" <c:if test="${scheduleData.END_TM eq '1530'}">selected</c:if>>오후 03:30</option>
                    		<option value="1600" <c:if test="${scheduleData.END_TM eq '1600'}">selected</c:if>>오후 04:00</option>
                    		<option value="1630" <c:if test="${scheduleData.END_TM eq '1630'}">selected</c:if>>오후 04:30</option>
                    		<option value="1700" <c:if test="${scheduleData.END_TM eq '1700'}">selected</c:if>>오후 05:00</option>
                    		<option value="1730" <c:if test="${scheduleData.END_TM eq '1730'}">selected</c:if>>오후 05:30</option>
                    		<option value="1800" <c:if test="${scheduleData.END_TM eq '1800'}">selected</c:if>>오후 06:00</option>
                    		<option value="1830" <c:if test="${scheduleData.END_TM eq '1830'}">selected</c:if>>오후 06:30</option>
                    		<option value="1900" <c:if test="${scheduleData.END_TM eq '1900'}">selected</c:if>>오후 07:00</option>
                    		<option value="1930" <c:if test="${scheduleData.END_TM eq '1930'}">selected</c:if>>오후 07:30</option>
                    		<option value="2000" <c:if test="${scheduleData.END_TM eq '2000'}">selected</c:if>>오후 08:00</option>
                    		<option value="2030" <c:if test="${scheduleData.END_TM eq '2030'}">selected</c:if>>오후 08:30</option>
                    		<option value="2100" <c:if test="${scheduleData.END_TM eq '2100'}">selected</c:if>>오후 09:00</option>
                    		<option value="2130" <c:if test="${scheduleData.END_TM eq '2130'}">selected</c:if>>오후 09:30</option>
                    		<option value="2200" <c:if test="${scheduleData.END_TM eq '2200'}">selected</c:if>>오후 10:00</option>
                    		<option value="2230" <c:if test="${scheduleData.END_TM eq '2230'}">selected</c:if>>오후 10:30</option>
                    		<option value="2300" <c:if test="${scheduleData.END_TM eq '2300'}">selected</c:if>>오후 11:00</option>
                    	</select>
                    </td>
				</tr>
				<tr>
                	<th>종일</th>
                    <td><input type="checkbox" id="allDay" value="Y" /></td>
				</tr>
				<tr>
                	<th>장소</th>
                    <td><input id="place" name="place" type="text" class="in2" value='<c:out value="${scheduleData.PLACE}" />' /></td>
				</tr>
				<tr>
                	<th>내용</th>
                    <td>
                        <textarea name="memo" cols="" rows="4" style="width:97%;"><c:out value="${scheduleData.MEMO}" /></textarea>
                    </td>
				</tr>
				<tr>
					<th>첨부파일</th>
	                    <td>
	                    	<div class="filebox">
	                            <c:choose>
	                                <c:when test="${empty scheduleData.ORIGINAL_FILE_NM}">
	                                    <a href="#this" class="upload-name">파일선택</a>
	                                </c:when>
	                                <c:otherwise>
	                                    <input type="hidden" name="attId" id="attId" value='<c:out value="${scheduleData.ATT_ID}"></c:out>' />
	                                    <input type="hidden" name="orgId" id="orgId" value='<c:out value="${scheduleData.CON_ID}"></c:out>' />
	                                    <a href="#this" id="downloadFile" class="upload-name">${scheduleData.ORIGINAL_FILE_NM} (${scheduleData.FILE_SIZE}kb)</a>
	                                </c:otherwise>
	                            </c:choose>
	
								<label for="file">파일첨부</label> 
								<input type="file" id="file" name="file" class="upload-hidden">
								
								<c:if test="${!empty scheduleData.ORIGINAL_FILE_NM}">
									<span class="d_btn"><a href="#this" id="delFile">삭제</a></span>
								</c:if>
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
        $("#startYmd").datepicker();
        $("#endYmd").datepicker();
        $('#allDay').on('click', this, allDayEvent);
        $("#setSchedule").on('click', setSchedule);
        $("#modSchedule").on('click', setSchedule);
        $("#delSchedule").on('click', delSchedule);
        $('#file').on('change', setFile);
	    $(document).on('click', '#delFile', delFile);
	    $('#downloadFile').on('click', downloadFile);
        
        $('.close').on('click', function() {
            self.opener = self;
            window.close();
        });
    }
    
    /* 종일 체크박스 이벤트 */
    function allDayEvent(allDay) {
        if ($(this).is(':checked')) {
            $('#startTm').attr('disabled', true);
			$('#endTm').attr('disabled', true);
        } else {
            $('#startTm').attr('disabled', false);
			$('#endTm').attr('disabled', false);
        }
    }
    
    /* 일정 등록 */
    function setSchedule() {
	    var url = ($('#schId').val() == '') ? '<c:url value="./setSchedule" />' : '<c:url value="./modSchedule" />';

		$('#frm').ajaxSubmit({
		    url : url,
		    type : 'post',
		    success : function(res) {
		        if (res.result === 'success') {
		            opener.parent.location.reload();
		            opener.parent.toastr.success('저장 되었습니다.');
		            window.close();
		        }
		    }
		});
    }
    
    /* 일정 삭제 */
    function delSchedule() {
	    if (confirm('정말 삭제 하시겠습니까?')) {
	        var url = '<c:url value="./delSchedule" />';
	        $('#frm').ajaxSubmit({
			    url : url,
			    type : 'post',
			    success : function(res) {
			        if (res.result === 'success') {
			            opener.parent.location.reload();
			            opener.parent.toastr.info('삭제 되었습니다.');
			            window.close();
			        }
			    }
			});
	    }
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
	}
	
	function delFile() {
	    var agent = navigator.userAgent.toLowerCase();
	    
	    //IE 일때와 타브라우저일때 
		if ( (navigator.appName == 'Netscape' && navigator.userAgent.search('Trident') != -1) || (agent.indexOf("msie") != -1) ) {
			$("#file").replaceWith( $("#file").clone(true) );	
		} else {
		    $("#file").val('');
		}
	    $('.upload-name').text('파일선택').off('click', downloadFile);
	    $('#attId').val('');
        $('.d_btn').remove();
	}
	
	function downloadFile() {
	    var attId = $('#attId').val();
	    var url = '<c:url value="/downloadFile" />';
	    url += '?attId=' + attId;
	    
	    $(location).attr('href', url);
	}
</script>
