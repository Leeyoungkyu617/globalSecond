<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
 <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>DrinkList</title>
</head>
<body>
<div class="grid-Wrapper">
	<div class="grid">  
		<div class="grid-sizer"></div>
		<div class="gutter-sizer"></div>
			<div class="detail-item detail-width6">
				<h1 class="text-left pad-y10">주류정보목록</h1>
				<table class="tableCss table">
					<colgroup>
						<col width="15%" />
						<col width="*" />
						<col width="10%" />
						<col width="25%" />
						<col width="10%" />
					</colgroup>			
					<c:if test="${count == 0 || empty count}">
						<tr>
							<td colspan="5">
							 	등록된 주류 게시물이 없습니다.
							</td>
						</tr>
					</c:if>
					<c:if test="${count > 0}">
						<tr>
							<th>코드번호</th>
							<th>게시판 이름</th>
							<th>승인여부</th>
							<th>등록자</th>
							<th>등록일</th>
							<th>수정</th>
						</tr>
						<c:forEach var="drinkList" items="${drinkList}">
							<tr>
								<td><a href="/drink/detail?dkCode=${drinkList.dkCode }">${drinkList.dkCode}</a></td>
								<td>${drinkList.dkName}</td>
								<c:if test="${drinkList.dkApprove == 0 }">
									<td> 
										<p id="${drinkList.dkCode}">
											<button onclick="checkApprove('${drinkList.dkCode}','1')"> 승인</button>
											<button onclick="checkApprove('${drinkList.dkCode}','2')"> 거절</button>
										</p>
									 </td>
								</c:if>
								<c:if test="${drinkList.dkApprove == 1 }">
									<td>승인완료</td>
								</c:if>
								<c:if test="${drinkList.dkApprove == 2 }">
									<td>승인거절</td>
								</c:if>
								<td>${drinkList.insertId}</td>
								<td>
									<fmt:formatDate value="${drinkList.insertDay}" var="date" pattern="yyyy-MM-dd"  />
											${date}
								</td>
								<td><a href="/drink/modify?dkCode=${drinkList.dkCode}">수정</a></td>
							</tr>
						</c:forEach>
					</c:if>
				</table>
			<br/>
		<!-- pager -->
				<div class="page_wrap">
				<div class="page_nation">	
						<!-- 게시글이 있을때만 보여주기 -->
						<c:if test="${count>0}">
							<!-------------------------------------------------------------------------->
							<c:if test="${pageVO.startPage > pageVO.pageBlock}">
								<a class="arrow prev" href="/admin/drinkList?pageNum=${pageVO.startPage-pageVO.pageBlock}">&lt;</a>
							</c:if>
							<c:forEach var="i" begin="${pageVO.startPage}" end="${pageVO.endPage}" step="1"> 
								<c:if test="${i == pageNum}">
									<a class="active">${i}</a>		
								</c:if>		
								<c:if test="${i != pageNum}">			
									<a href="/admin/drinkList?pageNum=${i}" class="pageNums">&nbsp;${i}&nbsp;</a>			
								</c:if>		
							</c:forEach>
							<c:if test="${pageVO.endPage < pageVO.pageCount}">
								<a class="arrow next" href="/admin/drinkList?pageNum=${pageVO.startPage+pageVO.pageBlock}">&gt;</a>
							</c:if>
							<!-------------------------------------------------------------------------->
						</c:if>
				</div>
				</div>
		</div>
	</div>
</div>

<script>
function checkApprove(dkCode, check){

	alert("게시글 상태가 변경되었습니다.");

	

	
	var context = window.location.pathname.substring(0, window.location.pathname.indexOf("/",2));
	$.ajax({
		url: context + '/checkApprove?dkCode='+dkCode+'&'+'check='+check,
		type:"get",
		success : function(data){
			if(data == 1){
				alert("승인되었습니다");
				$('#' + dkCode).empty();
				$('#' + dkCode).append('<td>승인완료</td>');			
			}else if(data == 0){
				alert("거절되었습니다");
				$('#' + dkCode).empty();
				$('#' + dkCode).append('<td>승인거절</td>');			
			} 
			

		}
	})
	
}
</script>



</body>
</html>