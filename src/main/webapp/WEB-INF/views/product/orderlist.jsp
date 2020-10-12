<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>판매자 </title>
</head>
<div class="grid-Wrapper">
	<div class="grid">
		<div class="grid-sizer"></div>
		<div class="gutter-sizer"></div>
		<div class="grid-item grid-item--width3">
			<form action="/product/orderlist" name="schMember" id="schMember">
				<input type="hidden" name="isSearch" value="true">
				<div>
					<table class="tableCss">
						<tr>
							<td>상품명</td>
							<td align="left"><input type="text" name="prName" /></td>
						</tr>
						<tr>
							<td>구매자명</td>
							<td align="left"><input type="text" name="prName" /></td>
						</tr>
						<tr>
							<td>구매일자</td>
							<td align="left"><input type="text" name="prName" /></td>
						</tr>
						<tr>
							<td>주문상태</td>
							<td align="left">
								<input type="checkbox" name="orStatus" value="1" />결재완료
								<input type="checkbox" name="orStatus" value="2" />배송준비중
								<input type="checkbox" name="orStatus" value="1" />출고완료
								<input type="checkbox" name="orStatus" value="1" />취소접수
								<input type="checkbox" name="orStatus" value="1" />취소
							</td>
						</tr>
					</table>
				</div>
				
						
						<div><input type="submit" value="검색" class="btn btn-sm btn-blue" /></div>
			</form>
		</div>
		<c:if test="${ordercount==0}">
			<h1>주문받은 상품이 없습니다</h1>
		</c:if>
		<c:if test="${ordercount >0}">
			<div class="grid-item grid-item--width6">
				<table class="tableCss table">
						<tr>
							<td>주문번호</td>
							<td>상품명</td>
							<td>수량</td>
							<td>주문자아이디/수령자명</td>
							<td>주문상태</td>
						</tr>
						<c:forEach var="order" items="${orderlist}">
								<tr>
									<td>${order.orCode}</td>
									<td><a href="orderdetail?orcode=${order.orCode}">${order.prName}</a></td>
									<td>${order.prCount}</td>
									<td>${order.userId}/${order.receiverName}</td>
									<c:choose>
										<c:when test="${order.orStatus ==1}"><td>주문 미확인</td></c:when>
										<c:when test="${order.orStatus ==2}"><td>주문 확인</td></c:when>
										<c:when test="${order.orStatus ==3}"><td>배송 준비</td></c:when>
										<c:when test="${order.orStatus ==4}"><td>배송 완료</td></c:when>
										<c:when test="${order.orStatus ==5}"><td>택배로 이동중</td></c:when>
										<c:otherwise><td>확인 요망</td></c:otherwise>
									</c:choose>
								</tr>
						</c:forEach>
				</table>
				<!-- 더 보기 구현하기 -->
				<div>
					<button id="addBtn" onclick="moreList();">더보기</button>
				</div>
				<!-- pager -->
				<div align="center" class="pageNums">
							<c:if test="${pageVO.startPage > pageVO.pageBlock}">
								<a href="/product/orderlist?pageNum=${pageVO.startPage-pageVO.pageBlock}">&lt;</a>
							</c:if>
							<c:forEach var="i" begin="${pageVO.startPage}" end="${pageVO.endPage}" step="1"> 
										<a href="/product/orderlist?pageNum=${i}" class="pageNums">&nbsp;${i}&nbsp;</a>
							</c:forEach>
							<c:if test="${pageVO.endPage < pageVO.pageCount}">
								<a href="/product/orderlist?pageNum=${pageVO.startPage+pageVO.pageBlock}">&gt;</a>
							</c:if>
				</div>
			
			</div>	
		</c:if>	
	</div>
</div>

</html>