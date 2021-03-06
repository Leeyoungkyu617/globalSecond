<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>eventList view</title>

<!-- 검색기능 value 없을때 넘기기 없기, href 걸기 디자인하기 -->

	<!-- 날짜 -->
  <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
  
  <script>
$( function() {
    var dateFormat = "mm/dd/yy",
      from = $( "#from" )
        .datepicker({
        	
          dateFormat: "yy-mm-dd",
          defaultDate: "+1w",
          changeMonth: true,
          numberOfMonths: 3
        })
        .on( "change", function() {
          to.datepicker( "option", "minDate", getDate( this ) );
        }),
      to = $( "#to" ).datepicker({
        dateFormat: "yy-mm-dd",
        defaultDate: "+1w",
        changeMonth: true,
        numberOfMonths: 3
      })
      .on( "change", function() {
        from.datepicker( "option", "maxDate", getDate( this ) );
      });
 
    function getDate( element ) {
      var date;
      try {
        date = $.datepicker.parseDate( dateFormat, element.value );
      } catch( error ) {
        date = null;
      }
 
      return date;
    }
    
  } );

</script>
</head>
<body>
<div class="grid-Wrapper">
	<div class="grid">  
		<div class="grid-sizer"></div>
		<div class="gutter-sizer"></div>
			<div class="detail-item detail-width6" >
			<h1 class="text-left pad-y10">이벤트목록</h1>
			<form action="eventList" method="get">
				<input type="hidden" name="isSearch" value="true">
				<table class="tableCss table">
					<colgroup>
						<col width="15%" />
						<col width="*" />
						<col width="10%" />
						<col width="25%" />
						<col width="10%" />
					</colgroup>
					<tr>
						<th>이벤트명</th>
						<td><input name="schEvName"></td>
					</tr>
					<tr>
						<th>판매상품</th>
						<td><input name="schPrName"></td>
					</tr>
					<tr>
						<th>기간</th>
						<td>
							<div>
								<label for="from">시작일</label>
								<input type="text" name="schEvStart" id="from"/>
								<label for="to">종료일</label>
								<input type="text" name="schEvEnd" id="to"/>
							</div>
						</td>
					</tr>
					<tr>
						<th>상태</th>
						<td>
							<label><input type="radio" value="Y" name="schIsOpen">활성</label>
							<label><input type="radio" value="N" name="schIsOpen">비활성</label>							
						</td>
					</tr>
					<tr>
						<td colspan="2">
							<input type="submit" class="btn-md" value="검색">
						</td>
					</tr>
				</table>
			</form>
		
			<table class="tableCss table">
				<colgroup>
					<col width="15%" />
					<col width="*" />
					<col width="10%" />
					<col width="25%" />
					<col width="10%" />
				</colgroup>
				<tr align="right">
					<td colspan="6">
						<button class="btn btn-md btn-blue"  onclick="window.location='/admin/event/insertEvent?pageNum=${pageNum}'">등록</button>
					</td>
				</tr>
				<tr>
					<th>No</th>
					<th>이벤트명</th>
					<th>판매상품</th>
					<th>기간</th>
					<th>이벤트 상태</th>
					<th>이벤트 참가자</th>
				</tr>
				<c:if test="${count == 0 || empty count }">
					<tr>
						<td colspan="6">
							등록된 이벤트가 없습니다.
						</td>
					</tr>
				</c:if>
				
				<c:if test="${count > 0 }">
					<c:forEach var="eventList" items="${eventList }">
						<tr>
							<td>${number}</td>
								<c:set var="number" value="${number-1}" />
							<td><a href="/admin/event/modifyEvent?eventCode=${eventList.eventCode }&pageNum=${pageNum}">${eventList.eventName}</a></td>
							<td>${eventList.prName }</td>
							<td>${eventList.evStart} ~ ${eventList.evEnd}</td>
							<td>
								<p id=${number }>
								<c:if test="${eventList.isOpen == 'Y'}"><a onclick="chOpen('${ eventList.eventCode}', '${number }')">활성</a></c:if>
								<c:if test="${eventList.isOpen == 'N'}">비활성</c:if>
								</p>
							</td>
							<td>
								<a onclick="showJoinMember('${eventList.eventCode}')">참가인원보기</a>
							</td>
						</tr>
					</c:forEach>
				</c:if>
			</table>
			
			<!-- pager -->
				<div class="page_wrap">
				<div class="page_nation">
						<!-- 게시글이 있을때만 보여주기 -->
						<c:if test="${count>0}">
							<!-------------------------------------------------------------------------->
							<c:if test="${pageVO.startPage > pageVO.pageBlock}">
								<a class="arrow next" href="/admin/event/eventList?pageNum=${pageVO.startPage-pageVO.pageBlock}">&lt;</a>
							</c:if>
							<c:forEach var="i" begin="${pageVO.startPage}" end="${pageVO.endPage}" step="1">
								<c:if test="${i == pageNum}">
									<a class="active">${i}</a>		
								</c:if>			
								<c:if test="${i != pageNum}">			
									<a href="/admin/event/eventList?pageNum=${i}" class="pageNums">&nbsp;${i}&nbsp;</a>			
								</c:if>		
							</c:forEach>
							<c:if test="${pageVO.endPage < pageVO.pageCount}">
								<a class="arrow next" href="/admin/event/eventList?pageNum=${pageVO.startPage+pageVO.pageBlock}">&gt;</a>
							</c:if>
							<!-------------------------------------------------------------------------->
						</c:if>
				</div>
				</div>
		</div> <!-- grid-item--width6  -->
	</div><!-- grid -->
</div>	<!-- grid-Wrapper -->

<script>
function chOpen(eventCode, number){

	alert("해당 이벤트가 비활성화로 변경되었습니다.");


	
	var context = window.location.pathname.substring(0, window.location.pathname.indexOf("/",2));
	$.ajax({
		url: context + '/event/chEventCode?eventCode='+eventCode,
		type:"get",
		success : function(data){
			$('#' + number).empty();
			$('#' + number).append('<p>비활성</p>')
			

		}
	})
	
}

function showJoinMember(eventCode){
	console.log(eventCode);
	var url="/admin/event/eventJoinList?eventCode=" + eventCode;
	console.log(url);
	window.open(url, "", "width=400,height=400,left=600");
}
</script>


</body>
</html>