<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div id="wrapper_p">
    <!--팝업타이틀 시작-->
    <div class="top">
        <span class="pop_st">SMS 발송</span>
        <span class="close"><a href=""><img src="/resources/images/p_close.png" title="닫기"/></a></span>
    </div>
    <!--팝업타이틀 끝-->

	<div id="subContents">
	    <div class="sms_in">
			<table class="cu_t" width="100%">
				<tr>
					<td>
						<label for="tranType1"><input id="tranType1" name="tranType" type="radio" value="4"  checked /> 단문 </label>&nbsp;
						<label for="tranType2"><input id="tranType2" name="tranType" type="radio" value="6" /> 장문</label>
						<span class="ti" id="smsTspan" style="display:none;">제목</span>
							<input name="title" id="smsTitle" maxlength ="20" value="" type="text" class="man" style="width:220px; display:none;"/>
					</td>
				</tr>
			</table>
			<div id="sms" style="margin-left: 20px;">
				<div class="phone">
					<textarea name="to_message1" id="to_message1" cols="26" rows="7" class="text_area" onKeyUp="check_length();">${base.ret_mag}</textarea>
					<p class="inb">
						<input name="msglen1" id="msglen1" type="text" class="byte" style="width:30px;"/>
						<em>byte</em> / 80byte
					</p>
				</div>
			</div>
			<div id="lms" style="margin-left: 20px; display:none">
				<div class="phone">
					<textarea name="to_message2" id="to_message2" cols="26" rows="7" class="text_area" onKeyUp="check_length();">${base.ret_mag}</textarea>
					<p class="inb">
						<input name="msglen2" id="msglen2" type="text" class="byte" style="width:30px;"/>
						<em>byte</em> / 1000byte
					</p>
				</div>
			</div>
			
			<div style="float: left; width:250px; margin-left: 10px;">
				<table class="cu_t" width="100%">
					<colgroup>
					<col width="25%" /><col width="*" />
					</colgroup>
					<tr>
						<th>받는사람</th>
						<td>
							<input class="tel_area" type="text" name="toTarget" value="${toTarget}" />
							<span class="exn">전화번호 입력 (예)<br />
							0165556666 ("-"없이 입력)</span>
						</td>
					</tr>
					<tr>
						<th rowspan="2">보내는사람</th>
						<td>
							<input class="tel_area" type="text" name="fromTarget" value="${fromTarget}" />
						</td>
						<input type="hidden" name="user_hp" value="${base.user_hp}" />
						<input type="hidden" name="user_tel" value="${base.user_tel}" />
					</tr>
				</table>
			</div>
				
			<div style="margin-left: 320px;"><span class="p_search"><a href="javascript:;" id="send">메세지 전송</a></span></div>
		</div>
	</div>
</div>

<script type="text/javascript">
    $(document).ready(init);
    
    function init() {
        window.document.body.scroll = 'auto';
        
        $('.close').on('click', function() {
            self.opener = self;
            window.close();
        });
        
        $('#send').on('click', fn_smsSd);
        
        //단문, 장문 이벤트
        $('input[name=tranType]').on('click', function() {
            if ($(this).val() == '4') {
                $("#lms").hide();
        		$("#smsTspan").hide();
        		$("#smsTitle").hide();
        		$("#sms").show();
            } else {
                $("#sms").hide();
                $("#lms").show();
        		$("#smsTspan").show();
        		$("#smsTitle").show();
            }
        });
    }
    
  //SMS 메세지 발송
    function fn_smsSd() {
    	var type_chk = $(':radio[name="tranType"]:checked').val();
    	
    	if($("input[name=toTarget]").val() == "") {
    		alert("받는사람 번호를 입력하세요.");
    		$("input[name=toTarget]").focus();
    		return;
    	}

    	if($("input[name=fromTarget]").val() == "") {
    		alert("보내는 사람의 번호를 입력하세요.");
    		$("input[name=fromTarget]").focus();
    		return;
    	}

    	if (type_chk == "4"){
    		if($("textarea[name=to_message1]").val() == "") {
    			alert("메세지를 입력하세요!");
    			$("textarea[name=to_message1]").focus();
    			return;
    		}
    	} else if (type_chk == "6"){
    		if($("input[name=title]").val() == "") {
    			alert("제목을 입력하세요!");
    			$("input[name=title]").focus();
    			return;
    		}
    		if($("textarea[name=to_message2]").val() == "") {
    			alert("메세지를 입력하세요!");
    			$("textarea[name=to_message2]").focus();
    			return;
    		}
    		if ( $("#msglen2").val() <= 80) {
    			alert("메세지 내용이 80바이트 이내 입니다. 단문을 선택해주세요");
    			return;
    		}
    	}

   		if(confirm('전송 하시겠습니까?')) {
	   		var param = {};
	
	   		param.tranType		= $(':radio[name="tranType"]:checked').val();
	   		param.toMessage1	= $("textarea[name=to_message1]").val();
	   		param.toMessage2	= $("textarea[name=to_message2]").val();
	   		param.title				= $("input[name=title]").val();
	   		param.toTarget		= $("input[name=toTarget]").val();
	   		param.fromTarget		= $("input[name=fromTarget]").val();
	   		param.tran_etc2		= 'cozel';
	   		param.tran_etc3		= 'cozel';
	
	   		$.ajax({
	   			type :"POST",
	   			async : false,
	   			url : '<c:url value="/common/smsSend" />',
	   			dataType :"json", 
	   			data : param, 
	   			success  :function(json_data) {
	   				try {
	   				    debugger;
	   					var result = json_data.result;
	   					
	   			   		if(result == 1) {
	   			   			alert("SMS를 전송했습니다.");
	   			   			document.location.href = '<c:url value="./smsPop" />';
	   			   		}
	   			   		else {
	   			   			alert('SMS 발송에 실패하였습니다.\n재 로그인후  다시 한번 해보시기 바랍니다.\n계속 오류시 관리자에게 문의하여 주십시오.');
	   			   		}
	   				}
	   				catch(e) { }
	   			}
	   		});
	
   		}
   	}
  
    /* SMS Byte check */
    function check_length() {
    	var tmpStr, nStrLen, reserve, f;
    	var type_chk = $(':radio[name="tranType"]:checked').val();
    	
    	if (type_chk == "4"){
    		var limit_length = 80;
    		sInputStr = $("#to_message1").val();
    		nStrLen = calculate_byte(sInputStr);

    		if ( nStrLen > limit_length ) {
    			tmpStr = Cut_Str(sInputStr,limit_length);
    			$("#to_message1").val(tmpStr);
    			nStrLen = calculate_byte(tmpStr);

    			alert("바이트가 초과되었습니다.(최대 "+limit_length+"Bytes)\r\n초과된 부분은 전송되지 않습니다."); 

    			// 390byte에 맞게 입력내용 수정
    			$("#msglen1").val(nStrLen);

    		} else {
    			$("#msglen1").val(nStrLen);
    		}
    	} else if (type_chk == "6"){
    		var limit_length = 2000;
    		sInputStr = $("#to_message2").val();
    		nStrLen = calculate_byte(sInputStr);
    		if ( nStrLen > limit_length ) {
    			tmpStr = Cut_Str(sInputStr,limit_length);
    			$("#to_message2").val(tmpStr);
    			nStrLen = calculate_byte(tmpStr);

    			alert("바이트가 초과되었습니다.(최대 "+limit_length+"Bytes)\r\n초과된 부분은 전송되지 않습니다."); 

    			// 390byte에 맞게 입력내용 수정
    			$("#msglen2").val(nStrLen-1);

    		} else {
    			$("#msglen2").val(nStrLen);
    		}
    	}
    return;
    }
    
    function calculate_byte( sTargetStr ) {
    	var sTmpStr, sTmpChar;
    	var nOriginLen = 0;
    	var nStrLength = 0;

    	sTmpStr = new String(sTargetStr);
    	nOriginLen = sTmpStr.length;

    	for ( var i=0 ; i < nOriginLen ; i++ ) {
    		sTmpChar = sTmpStr.charAt(i);

    		if (escape(sTmpChar).length > 4) {
    			nStrLength += 2;
    		} else if (sTmpChar!='\r') {
    			nStrLength ++;
    		}
    	}
    	return nStrLength;
    }
</script>