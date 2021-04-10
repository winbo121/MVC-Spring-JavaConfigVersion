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
	
	
	$("#search").submit(function() {
		<%-- SEARCH FORM SUBMIT 으로 페이징 리스트 조회시에는 항상 PAGE NO , RANGE NO 를 1로 세팅한다. --%>
		$( this ).find( "#pageNo" ).val("1");
		$( this ).find( "#rangeNo" ).val("1");
	});
	
	<%-- 검색버튼 클릭시 --%>
	$("#ancher_search").click(function() {
		$("#search").submit();
	});
	
	<%-- 리스트 삭제 --%>
	$("#delete_list").on("click",function(e){
		
		e.preventDefault();

		if($("input:checkbox[name=name]").is(":checked") == true) {


				
				var arr = []			
				var json = {}
				
				$("input[name=name]:checked").each(function() {
					arr.push($(this).val());
				});
				json['del_list'] = arr;
				console.log(json);
				
				var succ_func = function(resData, status){
			
					if(status=='success'){
						
						alert("삭제완료")
						var url = "/start.do"
						move_get(url, null)						
					}					
					else{
						alert("삭제오류")
					}	
				}
				
				ajax_json_post("/delete.do", json, succ_func);
			
				
		
		}
		else{
			alert("삭제할 리스트를 선택하세요!");
		}
				
		

	});

	
	<%-- 전체 클릭 사용 --%>
    $("#checkall").click(function(){

        if($("#checkall").prop("checked")){
            $("input[name=name]").prop("checked",true);
        }else{
            $("input[name=name]").prop("checked",false);
        }

    });

    
    <%-- 일반체크박스에 따라 전체 체크박스 상태조정 --%>
    $("input:checkbox[name=name]").on("click",function(){

    	if($( "input:checkbox[name=name]:checked").length== $("input:checkbox[name=name]").length ){
    		$("#checkall").prop("checked",true);
    	}
    	else{
    		$("#checkall").prop("checked",false);
    	}

    });
    
    
    $("#insert_form").on("click",function(){
    	move_get("/insertPro.do", $("#search")[0])		
    })
    
    $("a.read_form").on("click",function(){
		var formData = new FormData($("#search")[0]);
		console.log($( this ).text());
		formData.append("name",$( this ).text())
    	move_get("/read.do", formData)		
    })

	
});

</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/com.jsp" />

<form:form modelAttribute="search" method="GET">
<form:hidden path="pageNo"/>	<%-- JSP PAGING 현재 페이지 번호 --%>
<form:hidden path="rangeNo"/> <%-- JSP PAGING 현재 범위 번호 --%>
<form:hidden path="pageSize"/> <%-- JSP PAGING 페이지 당 레코드 카운트 --%>
<form:hidden path="rangeSize"/> <%-- JSP PAGING 범위 당 페이지 사이즈   --%>
<form:hidden path="totalCount"/> <%-- JSP PAGING 현재 검색조건 글의 카운트   --%>
<form:hidden path="pageCount"/> <%-- JSP PAGING 현재 검색조건 페이지 카운트   --%>
<form:hidden path="rangeCount"/> <%-- JSP PAGING 현재 검색조건 범위 카운트   --%>
<form:input path="search_text" maxlength="100" placeholder="검색어를 입력해 주세요" name="search_val" value=""/>
<button id="ancher_search"><em>검색</em></button>
</form:form>

<table>
    <thead>
       <tr>
          <th><input type="checkbox" id="checkall" ></th>
          <th>이름</th>
          <th>비밀번호</th>
       </tr>
    </thead>
    <tbody>
       <c:choose>
           <c:when test="${!empty paging.data }">
                <c:forEach items="${paging.data}"  var="data">
	                 <tr>
	                    <td><input type="checkbox" name="name" value='${data.name}'></td>
	                    <td><a href="javascript:void(0)" class="read_form">${data.name}</a></td>
						<td>${data.password}</td>
	                  </tr>
	            </c:forEach>
          </c:when>
          <c:otherwise>
               <tr><td colspan="2">조회된 데이터가 없습니다.</td></tr>
          </c:otherwise>
        </c:choose>
   </tbody>
</table>

<c:choose>
   <c:when test="${!empty paging.data }">
		<button disabled="disabled" id="btn_prev_range">[-</button>

			<c:forEach begin="${paging.startRange}" end="${paging.endRange}" var="idx">

					<a href="javascript:void(0)" class="ancher_page_no">${idx}</a>
	
			</c:forEach>

          <button disabled="disabled" id="btn_next_range">-]</button>
	</c:when>
	<c:otherwise>
	</c:otherwise>
</c:choose>
<br>

<button type="button" id="insert_form">등록</button>
<button type="button" id="delete_list">삭제</button>
</body>
<script type="text/javascript">

$(document).ready(function(){

	var basic_paging = new BasicPaging();
	basic_paging._method = "GET";
	basic_paging._action = "/start.do";
	basic_paging._form_id = "search";


	<%-- 이전 RANGE BUTTON 활성화 --%>
	<c:if test="${paging.prevRange}">
		$("#btn_prev_range").prop('disabled', false);
	</c:if>
	<%-- 다음 RANGE BUTTON 활성화 --%>
	<c:if test="${paging.nextRange}">
		$("#btn_next_range").prop('disabled', false);
	</c:if>


	$("#btn_prev_range").click(function(){
		<%-- 이전 범위로 이동 --%>
		basic_paging.move_prev_range();
	});
	$("#btn_next_range").click(function(){
		<%-- 다음 범위로 이동 --%>
		basic_paging.move_next_range();
	});


	$("a.ancher_page_no").click(function(){
		var page_no = $( this ).text();
		if( $.isNumeric( page_no ) ){
			<%-- 선택된 PAGE NO 로 이동 --%>
			basic_paging.move_page_no( page_no );
		}
	});

});
</script>
</html>