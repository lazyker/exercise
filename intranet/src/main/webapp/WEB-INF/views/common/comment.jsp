<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<spring:eval expression="@requestUtil" var="requestUtil"/>

	<!--코멘트-->
	<p class="s_title">Comment</p>
	<p style="clear:both;"></p>
	<div class="com_bg">
	    <div class="c_g">
	        <textarea name="contents" cols="" rows="3" placeholder="코멘트를 작성하실 수 있습니다." style="width:650px;" class="ta"></textarea>
	        <span class="b_c_s mr10"><a href="javascript:;" id="setComment">등록</a></span>
	    </div>
	    
	    <c:forEach items="${getCommentList}" var="cmt">
		    <div class="c_g commentBody">
		        <span class="c_name mr5"><c:out value="${cmt.CON_NM}" /></span>
		        <span class="c_date"><c:out value="${cmt.REG_DATE}" /></span>
		        <div class="c_bu">
			        <c:if test="${userInfo.CON_ID eq cmt.CON_ID || userInfo.ADMIN_YN eq 'Y'}">
			            <span class="c_modi mr10" style="font-size: 9px;"><a href="javascript:;" id="<c:out value="${cmt.CMT_ID}" />"></a></span>
			            <span class="c_del" style="margin-top: 0;"><a href="javascript:;" id="<c:out value="${cmt.CMT_ID}" />"></a></span> 
			        </c:if>
		        </div>
		        <p style="clear:both;"></p>
		        <p class="com_in"><c:out value="${cmt.CONTENTS}" escapeXml="false" /></p>
		    </div>
	    </c:forEach>
	</div>
	
	<script type="text/javascript">
		$(document).ready(function() {
		    
			$('#setComment').on('click', function() {
			    var url = '<c:url value="/comment/setComment" />';
			    var menu = '${requestUtil.menuPath}';
			    var $cmt = $(this).parent().parent();
			    var cmtType, itemVal = '';
			    
			    switch(menu) {
					case 'company' :
					    itemVal = $('#comId').val();
					    cmtType = 1;
			    	    break;
					case 'position' :
					    itemVal = $('#posId').val();
					    cmtType = 2;
			    	    break;
					case 'candidate' :
					    itemVal = $('#usrId').val();
					    cmtType = 3;
					    break;
			    }
			    
			    $.ajax({
			        url :  url,
			        type : 'POST',
			        data : {
			            		'cmtType' : cmtType,
			            		'itemId' : itemVal,
			            		'contents' : $cmt.find('textarea[name=contents]').val()
			            	 },
			        success : function(res) {
			            var str = "";
			            str += '<div class="c_g">';
			            str += '<span class="c_name mr5">' + res.conNm + '</span>';
			            str += '<span class="c_date">' + res.regDate + '</span>';
			            str += '<div class="c_bu">';
			            str += '<span class="c_modi mr10" style="font-size: 9px;"><a href="javascript:;" id="' + res.cmtId + '"></a></span>';
			            str += '<span class="c_del" style="margin-top: 0;"><a href="javascript:;" id="' + res.cmtId + '"></a></span>';
			            str += '</div>';
			            str += '<p style="clear:both;"></p>';
			            str += '<p class="com_in">' + res.contents + '</p>';
			            str += '</div>';
			            
			            $('.com_bg').append(str);
			            $cmt.find('textarea[name=contents]').val('');
			            $('html, body').animate({'scrollTop' : document.body.scrollHeight});
			            
			        }
			    });
			}); 
			
			$(document).on('click', '.c_modi', function() {
			    var $cmt = $(this);
			    var $cmtDiv = $cmt.parent().parent();
			    
			    if ($cmtDiv.find('textarea').length == 0) {
			        var contentsHtml = $cmtDiv.find('.com_in').html();
				    var contents = contentsHtml.replace(/<br>/gi, '\n');
				    var textareaHtml = '<textarea name="contents" cols="" rows="3" style="width:650px;" class="ta">'
												+ contents + '</textarea>'
				    							+ '<span class="b_c_s mr10 mod" id="'+$cmt.find('a').attr('id')+'">'
												+ '<a href="javascript:;">수정</a></span>';
				    
					$cmt.find('a').addClass('c_modi_y').text('취소');
					$cmtDiv.find('.com_in').text('').append(textareaHtml);
					$cmtDiv.find('textarea').focus();
			    }
			    else{
			        var $target = $cmtDiv.find('.com_in');
			        var textareaHtml = $cmtDiv.find('textarea').html();
			        var contents = textareaHtml.replace(/\n/gi, '<br/>');
			        
					$cmt.find('a').removeClass('c_modi_y').text('');
			        $target.find('textarea').remove();
			        $target.find('span').remove();
			        $target.html(contents);
			    }
			    
			});
			
			$(document).on('click', '.c_del', function() {
			    if (confirm('정말 삭제 하시겠습니까?')) {
				    var url = '<c:url value="/comment/delComment" />';
				    var $cmt = $(this);
				    
				    $.ajax({
				        url :  url,
				        type : 'POST',
				        data : {
				            		'cmtId' : $cmt.find('a').attr('id')
				            	 },
				        success : function(res) {
				            $cmt.parent().parent().remove();
				        }
				    });
			    }
			});
			
			$(document).on('click', '.mod', function() {
			    var url = '<c:url value="/comment/modComment" />';
			    var $cmt = $(this);
			    var cmtId = $cmt.attr('id');
			    var contentsVal = $cmt.parent().find('textarea').val();
			    
	 		    $.ajax({
			        url :  url,
			        type : 'POST',
			        data : {
			            		'cmtId' : cmtId,
			            		'contents' : contentsVal
			            	 },
			        success : function(res) {
			            $cmt.parent().parent().find('a').removeClass('c_modi_y').text('');
			            $cmt.parent().parent().find('.c_date').text(res.regDate);
			            $cmt.parent().empty().html(res.contents);
			        }
		   		});
			});
		});
		
	</script>