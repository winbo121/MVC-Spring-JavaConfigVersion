<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>

<script type="text/javascript" > 

$(document).ready(function(){

	if("${readBoard.name }" != ""){
		$("#name").attr("readonly","true");
	}

	$("#save").on("click", function(){
		
		var succ = function(resData, status){
			alert("저장 -> "+status);
			
			if($(this).text() =="입력"){
				
				var url = "/start.do"
				move_get(url, null)	
			
			}
			else{
				
				var formData = new FormData($("#search")[0]);
				var url = "/start.do"
				move_get(url, formData);
			}
			
		}
		
		var json = {
				name: $("#name").val(),
				password: $("#password").val()
		};
		var url=""
		
		if($(this).text() =="입력"){
			url="/insert.do"
		}
		else{
			url="/update.do"
		}
		
		ajax_json_post(url,json,succ);
	});
	
	
	$("#goList").on("click", function(){
		var formData = new FormData($("#search")[0]);
		var url = "/start.do"
		move_get(url, formData);	
	});
	
});
</script>
</head>
<jsp:include page="/WEB-INF/views/com.jsp" />
<body>
<form:form modelAttribute="search" method="GET">

<form:hidden path="pageNo"/>	<%-- JSP PAGING 현재 페이지 번호 --%>
<form:hidden path="rangeNo"/> <%-- JSP PAGING 현재 범위 번호 --%>
<form:hidden path="pageSize"/> <%-- JSP PAGING 페이지 당 레코드 카운트 --%>
<form:hidden path="rangeSize"/> <%-- JSP PAGING 범위 당 페이지 사이즈   --%>
<form:hidden path="totalCount"/> <%-- JSP PAGING 현재 검색조건 글의 카운트   --%>
<form:hidden path="pageCount"/> <%-- JSP PAGING 현재 검색조건 페이지 카운트   --%>
<form:hidden path="rangeCount"/> <%-- JSP PAGING 현재 검색조건 범위 카운트   --%>
<form:hidden path="search_text"/>
</form:form>
아이디 : <input type="text" id="name" value="${readBoard.name }"/>
<br>
비밀번호 : <input type="text" id="password" value="${readBoard.password }"/>	
<br>

<c:choose>
<c:when test="${!empty readBoard.name }">
<button id="save">수정</button>
</c:when>
<c:otherwise>
<button id="save">입력</button>
</c:otherwise>
</c:choose>

<button id="goList">목록</button>
</body>
</html>