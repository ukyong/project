<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ include file="../includes/header.jsp" %>

<div class="container-lg">
    <div class="col-lg-12">
            <h1 class="page-header">수정</h1>	            	      
    </div>
</div>

<!-- /.container -->
<div class="container">
    <div class="col-lg-12">
        <div class="panel panel-default">
            <div class="panel-heading">Board Read</div>
            <!-- /.panel-heading -->
            
            <div class="panel-body">                
                <form role="form" action="/trade/modifyNotice" method="post">
                <input type="hidden" id="noticeBno" name="noticeBno" value="${pageInfo3.noticeBno}">
             	 <input type="hidden" name="pageNum" value='<c:out value="${cri.pageNum }"/>' >
             	 <input type="hidden" name="amount" value='<c:out value="${cri.amount }"/>' >               	 	            	          	 
               	 	
                <div class="form-group">
               		<label>번호</label>
               		<input class="form-control" name="noticeBno" value="${pageInfo3.noticeBno}" readonly>
               	</div>
               	<div class="form-group">
               		<label>제목</label>
               		<input class="form-control" name="noticeTitle" value="${pageInfo3.noticeTitle }">
               	</div>
               	<div class="form-group">
               		<label>내용</label>
               		<textarea class="form-control" rows="3" name="noticeContent">${pageInfo3.noticeContent }</textarea>
               	</div>
               	<div class="form-group">
               		<label>작성자</label>
               		<input class="form-control" name="noticeWriter" value="${pageInfo3.noticeWriter}" readonly>
               	</div>                      
					<button data-oper='modify' class="btn btn-primary">수정 완료</button>
	               	<button data-oper='remove' class="btn btn-danger">삭제</button>
	               	<button data-oper='list' class="btn btn-success">목록</button>	 	 
            	</form>            	                                                         
            </div>
            <!-- /.panel-body -->
        </div>
        <!-- /.panel -->
    </div>
    <!-- /.col-lg-12 -->
</div>
<!-- /.container -->


<script type="text/javascript">
$(document).ready(function(){

	//버튼 클릭시 동작
	var formObj=$("form");
	
	$("button[data-oper='modify']").on('click',function(e){
		e.preventDefault();
		
		console.log("submit clicked");

		formObj.submit();		
	});
	
	$("button[data-oper='list']").on('click',function(e){
		e.preventDefault();
		
		formObj.attr("action","/trade/notice");
		formObj.attr("method","get");
		
		var pageNumTag=$("input[name='pageNum']").clone();
		var amountTag=$("input[name='amount']").clone();			
		
		formObj.empty();
		
		formObj.append(pageNumTag);
		formObj.append(amountTag);		
		formObj.submit();
	});
	
	$("button[data-oper='remove']").on('click',function(e){
		e.preventDefault();
		
		formObj.attr('action','/trade/removeNotice');
		formObj.submit();
	});
	
});
</script>

