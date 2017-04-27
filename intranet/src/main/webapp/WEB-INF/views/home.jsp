<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ page session="false" %>

<div id="Contents">

ip : ${clientIP}
<!--     검색영역 -->
<!-- 	<div class="search"> -->
<!--     	<div class="b_search"> -->
<!--         	<div class="b_search2"> -->
<!--          		<input name="" type="text" class="t_search" /> -->
<!--          		<span class="search_icon pl5"><a href=""></a></span> -->
<!--                 <span class="d_search"><a href="">상세검색</a></span> -->
<!--                 <span class="p_search"><a href="">등록</a></span> -->
<!--             </div> -->
<!--         </div> -->
<!--         상세검색시작 -->
<!--         <div class="de_search"> -->
<!--         	<ul class="de_s01"> -->
<!--             	<li> -->
<!--                 	<span class="de_t">업종</span> -->
<!--                 	<select class="sel02" style="width:170px;" > -->
<!--                     <option>선택</option> -->
<!--                     </select> -->
<!--               </li> -->
<!--                 <li> -->
<!--                     <span class="de_t">회사명</span> -->
<!--                     <input name="" type="text" class="in" style="width:160px;" /> -->
<!--               	</li> -->
<!--                 <li> -->
<!--                     <span class="de_t">컨설턴트</span> -->
<!--                     <input name="" type="text" class="in" style="width:160px;" /> -->
<!--                 </li> -->
<!--             </ul> -->
<!--             <ul class="de_s01"> -->
<!--             	<li> -->
<!--                 	<span class="de_t">구분</span> -->
<!--                 	<select class="sel02" style="width:160px;" > -->
<!--                     <option>선택</option> -->
<!--                     </select> -->
<!--               </li> -->
<!--                 <li> -->
<!--                     <span class="de_t">기업형태</span> -->
<!--                     <select class="sel02" style="width:160px;" > -->
<!--                     <option>선택</option> -->
<!--                     </select> -->
<!--               	</li> -->
<!--                 <li> -->
<!--                     <span class="de_t">개런티</span> -->
<!--                     <select class="sel02" style="width:160px;" > -->
<!--                     <option>선택</option> -->
<!--                     </select> -->
<!--                 </li> -->
<!--             </ul> -->
<!--             <ul class="de_s01"> -->
<!--             	<li> -->
<!--                     <span class="de_t">등록일</span> -->
<!--                     <input name="" type="text" class="in fl mr3" style="width:55px;" /> -->
<!--                     <a href=""><img src="/resources/images/b_cal.png" class="fl" /></a>  -->
<!--                     <span class="fl mr5 ml5">~</span> -->
<!--                     <input name="" type="text" class="in fl mr3" style="width:55px;" /> -->
<!--                     <a href=""><img src="/resources/images/b_cal.png" class="fl"/></a> -->
<!--                 </li> -->
<!--                 <li> -->
<!--                     <span class="de_t">상세검색</span> -->
<!--                     <input name="" type="text" class="in" style="width:190px;" /> -->
<!--                 </li> -->
<!--             </ul> -->
<!--             <span class="b_det_s mr10"><a href="">검색</a></span> -->
        
<!--         </div> -->
<!--         상세검색끝                                      -->
<!--     </div> -->
<!--     <div class="swrap"> -->
<!--     데이타테이블시작 -->
<!--         <table class="board_list table-hover" style="width:100%;"> -->
<%--             <colgroup> --%>
<%--             <col width="8%" /> --%>
<%--             <col width="10%" /> --%>
<%--             <col width="20%" /> --%>
<%--             <col width="15%" /> --%>
<%--             <col width="15%" /> --%>
<%--             <col width="10%" /> --%>
<%--             <col width="10%" /> --%>
<%--             <col width="*" /> --%>
<%--             </colgroup> --%>
<!--             <tbody> -->
<!--                 <tr> -->
<!--                     <th>No</th> -->
<!--                     <th>구분</th> -->
<!--                     <th>회사명</th> -->
<!--                     <th>기업형태</th> -->
<!--                     <th>수수료율</th> -->
<!--                     <th>개런티</th> -->
<!--                     <th>컨설턴트</th> -->
<!--                     <th>등록일</th> -->
<!--                 </tr> -->
<!--                 <tr> -->
<!--                     <td>21</td> -->
<!--                     <td>고객사</td> -->
<!--                     <td>삼성전자</td> -->
<!--                     <td>대기업</td> -->
<!--                     <td>15.17.20%_4천,6천</td> -->
<!--                     <td>3개월</td> -->
<!--                     <td>박지성</td> -->
<!--                     <td>16/02/20</td> -->
<!--                 </tr> -->
<!--                 <tr> -->
<!--                     <td>21</td> -->
<!--                     <td>고객사</td> -->
<!--                     <td>삼성전자</td> -->
<!--                     <td>대기업</td> -->
<!--                     <td>15.17.20%_4천,6천</td> -->
<!--                     <td>3개월</td> -->
<!--                     <td>박지성</td> -->
<!--                     <td>16/02/20</td> -->
<!--                 </tr> -->
<!--                 <tr> -->
<!--                     <td>21</td> -->
<!--                     <td>고객사</td> -->
<!--                     <td>삼성전자</td> -->
<!--                     <td>대기업</td> -->
<!--                     <td>15.17.20%_4천,6천</td> -->
<!--                     <td>3개월</td> -->
<!--                     <td>박지성</td> -->
<!--                     <td>16/02/20</td> -->
<!--                 </tr> -->
<!--                 <tr> -->
<!--                     <td>21</td> -->
<!--                     <td>고객사</td> -->
<!--                     <td>삼성전자</td> -->
<!--                     <td>대기업</td> -->
<!--                     <td>15.17.20%_4천,6천</td> -->
<!--                     <td>3개월</td> -->
<!--                     <td>박지성</td> -->
<!--                     <td>16/02/20</td> -->
<!--                 </tr> -->
<!--                 <tr> -->
<!--                     <td>21</td> -->
<!--                     <td>고객사</td> -->
<!--                     <td>삼성전자</td> -->
<!--                     <td>대기업</td> -->
<!--                     <td>15.17.20%_4천,6천</td> -->
<!--                     <td>3개월</td> -->
<!--                     <td>박지성</td> -->
<!--                     <td>16/02/20</td> -->
<!--                 </tr> -->
<!--             </tbody> -->
<!--         </table> -->
<!--         <div class="paging mt25" > -->
<!--             <ul>   -->
<!--                 <li><a href="">&#60;</a></li> -->
<!--                 <li><a href='#' class='p_on'>1</a></li> -->
<!--                 <li><a href="">2</a></li>  -->
<!--                 <li><a href="">3</a></li>          -->
<!--                 <li><a href="">4</a></li>                            -->
<!--                 <li><a href="">5</a></li> -->
<!--                 <li class='last'><a href="">&#62;</a></li>				 -->
<!--             </ul> -->
<!--         </div> -->
<!--         </div> -->
</div>