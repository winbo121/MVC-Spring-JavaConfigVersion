<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">

<%-- BASIC PAGING --%>
function BasicPaging(){
	var _method;
	var _action;
	var _form_id;
	

	<%-- 대상 FORM DATA 조회 --%>
	BasicPaging.prototype.get_form_data = function (){
		var target_form = $( "#"+ this._form_id );
		var form_data = new FormData( target_form[0] );
		return form_data;
	};

	<%-- 페이지 번호로 이동  --%>
	BasicPaging.prototype.move_page_no = function( page_no ){
		var form_data = this.get_form_data();
		var range_no =  form_data.get("rangeNo");

		this.move( page_no, range_no  );
	};

	<%-- 다음 RANGE 이동 --%>
	BasicPaging.prototype.move_next_range = function(){
		var form_data = this.get_form_data();
		var range_no =  form_data.get("rangeNo");
			 range_no = parseInt( range_no );
		var range_size = form_data.get("rangeSize");
			 range_size = parseInt( range_size );
		var page_no = ( range_no * range_size )  + 1;

		this.move( page_no, ( range_no + 1 ) );
	};

	<%-- 이전 RANGE 이동  --%>
	BasicPaging.prototype.move_prev_range = function(){
		var form_data = this.get_form_data();
		var range_no =  form_data.get("rangeNo");
		 	 range_no = parseInt( range_no );
		var range_size = form_data.get("rangeSize");
			 range_size = parseInt( range_size );
		var page_no = ( (range_no - 2) * range_size ) + 1;

		this.move( page_no, ( range_no - 1 ) );
	};


	<%-- 페이지 이동 --%>
	BasicPaging.prototype.move = function( page_no, range_no ){
		var form_data = this.get_form_data();
			form_data.delete("pageNo");
			form_data.delete("rangeNo");
			form_data.append( "pageNo", page_no );
			form_data.append( "rangeNo", range_no );

		var movePage = new MovePage();
		movePage._method = this._method;
		movePage._action = this._action;
		movePage._formData = form_data;
		movePage.move();
	};
}


<%-- GET MOVE --%>
function move_get( action, form_data ){
	var movePage = new MovePage();
	movePage._method = "GET"; 
	movePage._action = action; 
	movePage._formData = form_data;
	movePage.move();
}

<%-- 페이지 이동 --%>
function MovePage(){
	var _action;
	var _method;
	var _formData;
	var _target;


	MovePage.prototype.move = function(){
		var action = this._action;
		var method = this._method;
		var formData = this._formData;
		var target  = this._target;


		var contextPath = '${pageContext.request.contextPath}';
		var url = contextPath + action;
		
		<%-- formData 존재유무 확인  --%>
		if( !(formData instanceof FormData) ){
			formData = new FormData();
		}

		var $form = $('<form></form>');
		$form.attr('action', url);
		$form.attr('method', method);

		<%-- IE 때문에 구현함  --%>
		var es, e, pair;
	    for (es = formData.entries(); !(e = es.next()).done && (pair = e.value);) {
	        var name = pair[0];
	        var value = pair[1];

			var field = $('<input></input>');
			field.attr("type", "hidden");
			field.attr("name", name);
			field.attr("value", value);

			$form.append( field );
	    }

		$form.appendTo('body');
		$form.submit();
	};

}



<%-- AJAX JSON POST --%>
function ajax_json_post( action, json, succ_func ){
	
	var ajaxJson = new AjaxJson();
	
	ajaxJson._method = "POST";
	ajaxJson._action = action; 
	ajaxJson._json = json; 
	ajaxJson._succ_func = succ_func;
	
	ajaxJson.send();
}

<%-- AJAX JSON --%>
function AjaxJson(){
	var _method;
	var _action;
	var _json;
	var _succ_func;
	
	AjaxJson.prototype.send = function(){
		var method = this._method;
		var url = '${pageContext.request.contextPath}' + this._action;

		var json = this._json;
		var succ_func = this._succ_func;

		$.ajax({
			type: method ,
			url:  url ,
			data: json,
			success: function( resData, status ){
				if( $.isFunction( succ_func ) ){
					succ_func(resData,status);
				}
			}
		});

	};
}


</script>
</head>
<body>

</body>
</html>