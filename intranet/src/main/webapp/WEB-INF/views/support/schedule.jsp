<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<link href="/resources/css/fullcalendar.css" type="text/css" rel="stylesheet" />
<script src="/resources/js/vendor/moment.min.js" type="text/javascript"></script>
<script src="/resources/js/vendor/fullcalendar.min.js" type="text/javascript"></script>
<!-- <script src="/resources/js/fullcalendar.js" type="text/javascript"></script> -->

<div id="Contents">
	<div class="search" style="font-size: 14px;">
		<div class="b_search">
			<div id='calendar'></div>
		</div>
	</div>
</div>

<script>
	$(document).ready(init); 
	
	function init() {
	    $('#calendar').fullCalendar({
	        contentHeight: 700,
			header: {
				left: 'prev,next today',
				center: 'title',
				right: 'month,listWeek'
			},
			views : {
			    month : {titleFormat : 'YYYY.MM'},
				week : {titleFormat : 'YYYY.MM.DD', columnFormat : 'M/D ddd'}
			},
			monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'] ,
			monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
			dayNames: ['일요일', '월요일', '화요일', '수요일', '목요일', '금요일', '토요일'],
	 		dayNamesShort: ['일', '월', '화', '수', '목', '금', '토'],
	 		buttonText: {today: '오늘', month: '월간', week: '주간', day: '일간'},
	 		allDaySlot: true,
			allDayText: '종일',
	 		selectable: true,
	 		eventLimit: true,
	 		select: function(start, end, jsEvent, view) {
				if (view.name === 'month') {
				    var endDate = new Date(end.format());
				    endDate.setDate(endDate.getDate() -1);
				    var yyyy = endDate.getFullYear().toString();
				    var mm = (endDate.getMonth()+1).toString();
				    var dd = endDate.getDate().toString();
				    var endYmd = yyyy + '-' + (mm[1] ? mm : '0'+mm[0]) + '-' +(dd[1] ? dd : '0'+dd[0]);
				    
				    scheduleWritePop(start.format(), endYmd);
				}
	 		    
				$('#calendar').fullCalendar('unselect');
	 		},
	 		timeFormat: 'HH:mm',
	 		events : function(start, end, timezone, callback) {
	 		    $.ajax({
	 		        url : '<c:url value="./scheduleList" />', 
	 		        dataType : 'json',
	 		        data : {
	 		            startYmd : start.format(),
	 		            endYmd :end.format()
	 		        },
	 		        success : function(res) {
						var events = [];
						res.scheduleList.forEach(function(v) {
						    var allDay = v.START_TM === undefined ? true : false;  
						    
						    events.push({
						        schId : v.SCH_ID,
						    	title : v.SCH_NM,
						    	start : v.START,
						    	end : v.END,
						    	allDay : allDay
						    });
						});
	 		            callback(events);
	 		        }
	 		        
	 		    });
	 		},
			eventClick: function(calEvent, jsEvent, view) {
			    scheduleWritePop('', '', calEvent.schId);
				return false;
			},
	 		noEventsMessage : '일정 목록이 없습니다.'
		});
	}
	
	function scheduleWritePop(start, end, schId) {
	    var url = '<c:url value="./scheduleWritePop" />?startYmd=' + start + '&endYmd=' + end;
	    url += schId != undefined ? '&schId=' + schId : '';  
		var popWidth = 530, popHeight = 470;
		var mtWidth = document.body.clientWidth;
		var mtHeight = document.body.clientHeight;
		var scX = window.screenLeft;
		var scY = window.screenTop;
		var popX = scX + (mtWidth - popWidth) / 2 - 50;
		var popY = scY + (mtHeight - popHeight) / 2 - 50;
		
		window.open(encodeURI(url), "scheduleWritePop", "width=" + popWidth + ", height=" + popHeight + ", left=" + popX + ", top=" + popY, 
		        "scrollbars=yes, toolbar=no menubar=no, location=no");
	}
	
</script>