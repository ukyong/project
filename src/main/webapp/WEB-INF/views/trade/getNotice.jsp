<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ include file="../includes/header.jsp" %>
<style>
	#reply{
		margin-top: 20px;
	}
	
	<style>
	.uploadResult{
		width:100%;
		background:gray;
	}
	.uploadResult ul{
		display:flex;
		flex-flow:row;
		justify-content:center;
		align-items:center;
	}
	.uploadResult ul li{
		list-style:none;
		padding:10px;
		align-content:center;
		text-align:center;
	}
	.uploadResult ul li img{
		width:100px;
	}
	.uploadResult ul li span{
		color:white;
	}
	.bigPictureWrapper{
		position:absolute;
		display:none;
		justify-content:center;
		align-items:center;
		top:0%;
		width:100%;
		height:100%;
		/* background-color:gray; */
		z-index:100;
		background:rgba(255,255,255,0.5);
	}
	.bigPicture{
		position:relative;
		display:flex;
		justify-content:center;
		align-items:center;
	}
	.bigPicture img{
		width:600px;
	}
</style>

<div class="bigPictureWrapper card">
	<div class="bigPicture card-body">
	</div>
</div>

<div class="container-lg">
    <div class="col-lg-12">
            <h1 class="page-header">공지사항</h1>	            	      
    </div>
</div>

<div class="container-lg">	
<div class="row">	
	<div class="col-lg-12">
		<div class="panel panel-default">
            <div class="panel-heading">Board Read</div>
            <!-- /.panel-heading -->
            
         <div class="panel-body">  
             <div class="form-group">
            		<label>번호</label>
            		<input class="form-control" name="noticeBno" value="${pageInfo3.noticeBno }" readonly>
            	</div>
            	<div class="form-group">
            		<label>제목</label>
            		<input class="form-control" name="noticeTitle" value="${pageInfo3.noticeTitle }" readonly>
            	</div>
            	<div class="form-group">
            		<label>내용</label>
            		<textarea class="form-control" rows="3" name="noticeContent" readonly>${pageInfo3.noticeContent }</textarea>
            	</div>
            	<div class="form-group">
            		<label>작성자</label>
            		<input class="form-control" name="tradeWriter" value="${pageInfo3.noticeWriter}" readonly>
            	</div>
            	               	
                      <button class="btn btn-success" id="list_btn">목록</button> 
                      <sec:authentication property="principal" var="pinfo"/>
                      	<sec:authorize access="isAuthenticated()">
                      		<c:if test="${pinfo.username eq pageInfo.tradeWriter }">
                	  			<button class="btn btn-primary" id="modify_btn">수정</button>
                	  		</c:if>
                      </sec:authorize>
            	 
            	 <form id="infoForm" action="/trade/modifyNotice" method="get">
            	 	<input type="hidden" id="noticeBno" name="noticeBno" value="${pageInfo3.noticeBno}">
            	 	<input type="hidden" name="pageNum" value="${cri.pageNum }">
            	 	<input type="hidden" name="amount" value="${cri.amount }">            	 	
            	 </form>                             
      		 </div>                     
		</div>
	</div>
</div>
</div>    

		
<!-- 페이지 번호 -->
<div class="panel-footer"></div>

	

<!-- Modal 추가 -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
	 		<div class="modal-header">
	 			<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
	 			<h4 class="modal-title" id="myModalLabel">REPLY MODAL</h4>
	 		</div>
	 		
	 		<div class="modal-body">
	 			<div class="form-group">
	 				<label>Reply</label>
	 				<input class="form-control" name='reply' value='New Reply!!!'>
	 			</div>
	 			<div class="form-group">
	 				<label>Replyer</label>
	 				<input class="form-control" name='replyer' value='replyer'>
	 			</div>
	 			<div class="form-group">
	 				<label>Reply Date</label>
	 				<input class="form-control" name='replyDate' value=''>
	 			</div>
	 		</div>
	 		
	 		<div class="modal-footer">
	 			<button id='modalModBtn' type="button" class="btn btn-primary">수정</button>
	 			<button id='modalRemoveBtn' type="button" class="btn btn-danger">삭제</button>
	 			<button id='modalRegisterBtn' type="button" class="btn btn-primary">등록</button>
	 			<button id='modalCloseBtn' type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
	 		</div>
		</div>
	</div>
</div>


<!-- form 처리 -->
<script>
	var form = $("#infoForm");
	
	$("#list_btn").on("click", function(e){
		form.find("#noticeBno").remove();
		form.attr("action", "/trade/notice");
		form.submit();
	})
	
	$("#modify_btn").on("click", function(e){	
		form.attr("action", "/trade/modifyNotice");
		form.submit();
	})

</script>
