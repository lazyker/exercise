<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<form id="frm" name="frm" method="post">

<div id="Contents">
<input type="hidden" id="parentId" name="parentId" />
<input type="hidden" id="cdLevel" name="cdLevel" />

    <div class="search">
        <div class="b_search">
            <div class="b_search2">
            <span class="pr5" style="font-size:13px; font-weight:600;">구분 : </span>
                <label>
                    <input name="cdType" type="radio" value="1" <c:if test="${cdType eq '1'}">checked</c:if> />
                    
                    <span class="pr5" style="font-size:13px; font-weight:600;">업종</span>
                </label>
                <label>
                    <input name="cdType" type="radio" value="2" <c:if test="${cdType eq '2'}">checked</c:if> />
                    <span class="pr5" style="font-size:13px; font-weight:600;">직종</span>
                </label>
            </div>
        </div>
        </div>
    <div class="swrap">
       <table summary="분할" style="width:800px; margin: auto; margin-top:30px;">
            <caption>분할</caption>
            <colgroup>
            <col width="350px" />
            <col width="100px" />
            <col width="350px" />
            </colgroup>
            <tbody>
                <tr>
                    <td style="text-align:left;">
                        <table summary="1단계" class="m_table">
                            <caption>1단계</caption>
                            <colgroup>
                            <col width="*" />
                            </colgroup>
                            <tbody>
                                <tr>
                                    <th>1단계</th>
                                </tr>
                                <tr>
                                    <td class="td_search">
                                        <input name="parentCdNm" type="text" class="in" style="width:150px;" />
                                        <span class="t_search"><a href="#none" id="setParentCode">등록</a></span>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <ul class="drag" id="group1">
                                        <c:forEach items="${codeParentList}" var="parentCode" varStatus="status" >
                                            <li class="liCode" 
                                                        data-parent-id="${parentCode.CD_ID}"
                                                        data-cd-order="${parentCode.CD_ORDER}">
                                                <c:out value="${parentCode.CD_NM}" />
                                                <span class="c_del" data-cd-id="${parentCode.CD_ID}"><a href="#none"></a></span>
                                            </li>
                                        </c:forEach>
                                        </ul>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </td>
                    <td style="vertical-align:middle; text-align:center;">
                    </td>
                    <td style="text-align:right;">
                        <table summary="2단계" class="s_table">
                            <caption>2단계</caption>
                            <colgroup>
                            <col width="*" />
                            </colgroup>
                            <tbody>
                                <tr>
                                    <th>2단계</th>
                                </tr>
                                <tr>
                                    <td class="td_search">
                                    <input name="childCdNm" type="text" class="in" style="width:150px;" />
                                    <span class="t_search"><a href="#none" id="setChildCode">등록</a></span>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <ul class="drag" id="group2">
                                        </ul>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </td>
                </tr>
                </tbody>
            </table>
        </div>
</div>
</form>

<script src="/resources/js/vendor/jquery-sortable.js" type="text/javascript"></script>
<script>
	$(document).ready(init); 
	
	function init() {
	    group1();
	    group2();
	    
	    $('#setParentCode').on('click', setParentCode);
	    $('#setChildCode').on('click', setChildCode);
	    $('input[name=cdType]').on('click', getCodeList);
	    $('.liCode').on('click', getChildList);
	    $('.c_del').on('click', delCode);
	    
	    $('input[name="parentCdNm"]').on('keydown', function(key) {
	        if (key.keyCode == 13) {
	            setParentCode();
	        }
	    });
	    $('input[name="childCdNm"]').on('keydown', function(key) {
	        if (key.keyCode == 13) {
	            setChildCode();
	        }
	    });
	}
	
	function getCodeList() {
	    var url =  '<c:url value="./codeList" />';
	    $('#frm').attr('action', url).submit();
	}
	
	function getChildList() {
	    var url =  '<c:url value="./childList" />';
        var parentId = $(this).data('parentId');
        
        $('#parentId').val(parentId);
        $('#group1').find('li').removeClass('selected');
        $(this).addClass('selected');
        
        $.ajax({
            url: url,
            data: { 'parentId': parentId },
            cache: false,
        }).done(function(res) {
            $('#group2').empty();
            
            $.each(res, function(index, item) {
                var str = '';
                str = '<li class="liCode" data-cd-Id="'+item.CD_ID+'" data-cd-order="'+item.CD_ORDER+'">';
                str += item.CD_NM;
                str += '<span class="c_del" data-cd-id="'+item.CD_ID+'"><a href="#none" id="delChildCode"></a></span>';
                str += '</li>';
                
                $('#group2').append(str);
            });
            
            $('.c_del').on('click', delCode); //삭제 이벤트 할당
       });
	}
	
	//1단계 등록
	function setParentCode() {
	    var url =  '<c:url value="./setParentCode" />';
	    $('#cdLevel').val('1');
	    
	    if ($('#parentCdNm').val() == '') {
	        alert('코드명을 입력해주세요.');
	        return;
	    }
	    
	    $('#frm').attr('action', url).submit();
	}
	
	//2단계 등록
	function setChildCode() {
	    var url =  '<c:url value="./setChildCode" />';
	    $('#cdLevel').val('2');
	    var params = $('#frm').serialize();
	    var dataSort = new Array();
	    var max = undefined;
	    
	    if ($('#parentId').val() == '') {
	        alert('1단계를 선택해 주세요.');
	        return;
	    }
	    if ($('#childCdNm').val() == '') {
            alert('코드명을 입력해주세요.');
            return;
        }
	    
	    $('#group2 > li').each(function() {
	        dataSort.push($(this).data('cdOrder'));
	    });
	    
	    max = dataSort.sort().reverse()[0];
	    
	    $.ajax({
            url: url,
            data: params,
            cache: false,
        }).done(function(res) {
            $.each(res, function(index, item) {
                var str = '';
                str = '<li class="liCode" data-cd-Id="'+item.cdId+'" data-cd-order="'+(Number(max)+1)+'">';
                str += item.cdNm;
                str += '<span class="c_del" data-cd-id="'+item.cdId+'"><a href="#none" id="delChildCode"></a></span>';
                str += '</li>';
                
                $('#group2').append(str);
                $('.c_del').on('click', delCode);
            });
       });
	}

    function group1() {
        var group = $("#group1").sortable({
            delay: 300,
            onDrop: function ($item, container, _super) {
            var data = group.sortable('serialize').get(0);
            
            $('#group1 > li').each(function(i) {
                data[i].cdOrder = i+1;
                $(this).attr('data-cd-order', i+1);
            });
            
            var jsonString = JSON.stringify(data);
            var request = $.ajax({
                                    method : 'post',
                                    dataType : 'json',
                                    contentType : "application/json; charset=UTF-8",
                                    url : '<c:url value="./dragCode" />',
                                    data : jsonString
                              });
            request.done(function() {
            });
            _super($item, container);
          }
        
        });
    }
    
    function group2() {
        var group = $("#group2").sortable({
            delay: 300,
            onDrop: function ($item, container, _super) {
            var data = group.sortable('serialize').get(0);
            
            $('#group2 > li').each(function(i) {
                data[i].cdOrder = i+1;
                $(this).attr('data-cd-order', i+1);
            });
            
            var jsonString = JSON.stringify(data);
            var request = $.ajax({
                                    method : 'post',
                                    dataType : 'json',
                                    contentType : "application/json; charset=UTF-8",
                                    url : '<c:url value="./dragCode" />',
                                    data : jsonString
                              });
            request.done(function() {
            });
            _super($item, container);
          }
        
        });
    }
    
    function delCode() {
        var url =  '<c:url value="./delCode" />';
        var cdId = $(this).data('cdId');
        var $taget = $(this);
        
        $.ajax({
            url : url,
            method : 'post',
            data : {'cdId' : cdId},
            success : function(res) {
                if (res.result == 'success') {
	                $taget.parent().remove();
                }
            }
        });
    }
</script>