<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="../includes/header.jsp" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	#paging{
		padding: 15px;
	}
	
</style>
</head>
<body>

<div class="jumbotron">
	<div class="container-lg">
	    <div class="col-lg-12">
	        <h1 class="page-header">공지사항</h1>
	    </div>
	    <!-- /.col-lg-12 -->
	</div>

<!-- /.container -->
<div class="container text-center">
    <div class="col-lg-12">
        <div class="panel panel-default">
            <div class="panel-heading">
            <sec:authorize access="hasRole('ROLE_ADMIN')">                
                <button id="regBtn" type="button" class="btn btn-primary pull-right">새글 등록</button>
            </sec:authorize>
            </div>
            <!-- /.panel-heading -->
            <div class="panel-body">
                <table width="100%" class="table table-striped table-bordered table-hover">
                    <thead>
                    	<th>번호</th>                    	
                    	<th>제목</th>
                    	<th>작성자</th>
                    	<th>작성일</th>
                    	<th>수정일</th>                    	                    
                    </thead>
                    
                    <c:forEach items="${notice}" var="notice">
                    <tr>
                    	<td>${notice.noticeBno }</td>                   		
                    	<td><a class="move" href='<c:out value="${notice.noticeBno}"/>'>
                    		${notice.noticeTitle }</a>                   		                   		
                   		</td>
                    	<td>${notice.noticeWriter }</td>
                    	<td><fmt:formatDate pattern="yyyy-MM-dd" value="${notice.noticeRegdate }"/></td>
                    	<td><fmt:formatDate pattern="yyyy-MM-dd" value="${notice.noticeUpdatedate }"/></td>
                    </tr>                   
                    </c:forEach>                    
                </table>
                
                <!-- 페이징 처리 -->
                <div class="position-relative" id="paging">
                	<div class="position-absolute top-100 start-50 translate-middle">
                	
		                <nav aria-label="Page navigation">               	                	
		                	<ul class="pagination">
		                		<c:if test="${pageMaker3.prev }">
		                			<li class="page-item previous"><a class="page-link" href="${pageMaker3.startPage-1 }">이전</a></li>
		                		</c:if>
		                		
			                	<c:forEach var="num" begin="${pageMaker3.startPage }" end="${pageMaker3.endPage }">
			                		<li class="page-item ${pageMaker3.cri.pageNum==num?'active':'' }"><a class="page-link" href="${num }">${num }</a></li>
			                	</c:forEach>
			                		                	
			               		<c:if test="${pageMaker3.next }">
			               			<li class="page-item next"><a class="page-link" href="${pageMaker3.endPage+1 }">다음</a></li>
			               		</c:if>
		               		</ul>    
		               	</nav>               
               		</div>	            	                	
                </div>
                           
                <form id="moveForm" method="get">
                	<input type="hidden" name="pageNum" value="${pageMaker3.cri.pageNum }">
                	<input type="hidden" name="amount" value="${pageMaker3.cri.amount }">
                </form>      
            <!-- /.panel-body -->
            
            <!-- Modal 추가 -->
                <div class="modal" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                	<div class="modal-dialog">
                		<div class="modal-content">
	                		<div class="modal-header">
	                			<h4 class="modal-title" id="myModalLabel">Modal title</h4>
	                			<button type="button" class="close" data-dismiss="modal" aria-hidden="close">&times;</button>
	                		</div>
	                		<div class="modal-body">처리가 완료되었습니다.</div>
	                		<div class="modal-footer">
	                			<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
	                			<button type="button" class="btn btn-primary">Save changes</button>
	                		</div>
                		</div>
                	</div>
                </div>    
        </div>
        <!-- /.panel -->                
    </div>
    <!-- /.col-lg-12 -->
</div>
<!-- /.container -->	
</div>
<!-- ./jumbotron -->
</div>

<script type="text/javascript">
$(document).ready(function(){
	
	var result='${result}';
	
	checkModal(result);
		
	history.replaceState({},null,null);
	
		function checkModal(result){
			if(result==='' || history.state){
				return;
			}
			
			if(parseInt(result)>0){
				$(".modal-body").html("공지사항"+parseInt(result)+" 번이 등록되었습니다.");
			}
			
			$("#myModal").modal("show");
	}
	
	$('#regBtn').on('click',function(){		
		self.location='/trade/insertNotice';		
	});
});
	var moveForm = $("#moveForm");
	$(".move").on("click", function(e){
		e.preventDefault();
		
		moveForm.append("<input type='hidden' name='noticeBno' value='"+ $(this).attr("href")+ "'>");
		moveForm.attr("action", "/trade/getNotice");
		moveForm.submit();
	});
	
    $(".page-item a").on("click", function(e){
		e.preventDefault();
		moveForm.find("input[name='pageNum']").val($(this).attr("href"));
		moveForm.attr("action", "/trade/notice");
		moveForm.submit();
		
	});	 
	
	
</script>
</body>
</html>