<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>    
<%@ include file="../includes/header.jsp" %>
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
	        <h1 class="page-header">구매게시판</h1>
	    </div>
	    <!-- /.col-lg-12 -->
	</div>

<!-- /.container -->
<div class="container text-center">
    <div class="col-lg-12">
        <div class="panel panel-default">
            <div class="panel-heading">                
                <button id="regBtn" type="button" class="btn btn-primary pull-right">새글 등록</button>
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
                    
                    <c:forEach items="${list2}" var="list2">
                    <tr>
                    	<td>${list2.tradeBno2 }</td>
                    	<td><a class="move" href='<c:out value="${list2.tradeBno2}"/>'>
                    		${list2.tradeTitle2 } <b>[${list2.tradeReplyCnt2 }]</b></a>                   		                   		
                   		</td>
                    	<td>${list2.tradeWriter2 }</td>
                    	<td><fmt:formatDate pattern="yyyy-MM-dd" value="${list2.tradeRegdate2 }"/></td>
                    	<td><fmt:formatDate pattern="yyyy-MM-dd" value="${list2.tradeUpdatedate2 }"/></td>
                    </tr>                   
                    </c:forEach>                    
                </table>
                

                <!-- 검색처리 -->
                <div class='row'>
                	<div class="col">                
                	<div class="p-3">
                	<form id='searchForm' action="/trade/list2" method="get">
                		<select name='type' class="select">
                			<option value="" ${pageMaker2.cri.type==null?'selected':'' }>--</option>
                			<option value="T" ${pageMaker2.cri.type eq 'T'?'selected':'' }>제목</option>
                			<option value="C" ${pageMaker2.cri.type eq 'C'?'selected':'' }>내용</option>
                			<option value="W" ${pageMaker2.cri.type eq 'W'?'selected':'' }>작성자</option>
                			<option value="TC" ${pageMaker2.cri.type eq 'TC'?'selected':'' }>제목 or 내용</option>
                			<option value="TW" ${pageMaker2.cri.type eq 'TW'?'selected':'' }>제목 or 작성자</option>
                			<option value="TWC" ${pageMaker2.cri.type eq 'TWC'?'selected':'' }>제목 or 내용 or 작성자</option>
                		</select>
                	            
                		<input type='text' name='keyword' value="${pageMaker2.cri.keyword }">
                		<input type='hidden' name='pageNum' value='${pageMaker2.cri.pageNum }'>
                		<input type='hidden' name='amount' value='${pageMaker2.cri.amount }'>
                		<input type='hidden' name='type' value='${pageMaker2.cri.type }'>
                		<button class='btn btn-primary'>검색</button>
                	</form>
                	 </div>
                	</div>
              	</div>

                
                <!-- 페이징 처리 -->
                <div class="position-relative" id="paging">
                	<div class="position-absolute top-100 start-50 translate-middle">
                	
		                <nav aria-label="Page navigation">               	                	
		                	<ul class="pagination">
		                		<c:if test="${pageMaker2.prev }">
		                			<li class="page-item previous"><a class="page-link" href="${pageMaker2.startPage-1 }">이전</a></li>
		                		</c:if>
		                		
			                	<c:forEach var="num" begin="${pageMaker2.startPage }" end="${pageMaker2.endPage }">
			                		<li class="page-item ${pageMaker2.cri.pageNum==num?'active':'' }"><a class="page-link" href="${num }">${num }</a></li>
			                	</c:forEach>
			                		                	
			               		<c:if test="${pageMaker2.next }">
			               			<li class="page-item next"><a class="page-link" href="${pageMaker2.endPage+1 }">다음</a></li>
			               		</c:if>
		               		</ul>    
		               	</nav>               
               		</div>	            	                	
                </div>
                           
                <form id="moveForm" method="get">
                	<input type="hidden" name="pageNum" value="${pageMaker2.cri.pageNum }">
                	<input type="hidden" name="amount" value="${pageMaker2.cri.amount }">
                	<input type="hidden" name="keyword" value="${pageMaker2.cri.keyword }">
                	<input type='hidden' name='type' value='${pageMaker2.cri.type }'>
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
				$(".modal-body").html("게시글 "+parseInt(result)+" 번이 등록되었습니다.");
			}
			
			$("#myModal").modal("show");
	}
	
	$('#regBtn').on('click',function(){		
		self.location='/trade/insert2';		
	});
});
	var moveForm = $("#moveForm");
	$(".move").on("click", function(e){
		e.preventDefault();
		
		moveForm.append("<input type='hidden' name='tradeBno2' value='"+ $(this).attr("href")+ "'>");
		moveForm.attr("action", "/trade/get2");
		moveForm.submit();		
	});
	
    $(".page-item a").on("click", function(e){
		e.preventDefault();
		moveForm.find("input[name='pageNum']").val($(this).attr("href"));
		moveForm.attr("action", "/trade/list2");
		moveForm.submit();
		
	});	 
	
	
  //검색
	var searchForm=$('#searchForm');
	
	$('#searchForm button').on('click',function(e){
		e.preventDefault();
		
		if(!searchForm.find('option:selected').val()){
			alert('검색종류를 선택하세요');
			return false;
		}
		if(!searchForm.find("input[name='keyword']").val()){
			alert('키워드를 입력하세요');
			return false;
		}
		
		searchForm.find("input[name='pageNum']").val("1");		
		searchForm.submit();
	});
	
	
</script>
</body>
</html>