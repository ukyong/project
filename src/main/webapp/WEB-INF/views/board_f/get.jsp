<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@include file="../includes/header.jsp" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

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

<!-- 이미지 확대 보기 -->
<div class='bigPictureWrapper'>
	<div class='bigPicture'></div>
</div>

				<div class="container-xxl flex-grow-1 container-p-y">
                  <div class="card-mb-4" >
                    <h5 class="card-header">조회</h5>
                    <div class="card-body">                    
                    
                      <div class="form-group">
                      	<label>게시판:</label>
                      	<span class="badge bg-secondary"><c:out value="${board.cgo}"/></span>                      	
                      </div>
                    
                      <div class="form-group">
                        <label for="exampleFormControlInput1" class="form-label">제목</label>
                        <input
                          class="form-control"
                          name="title"
                          value='<c:out value="${board.title}"/>' readonly="readonly">                                                 
                      </div>
                   	                    	
                   	  <div class="form-group">
                        <label for="exampleFormControlInput1" class="form-label">작성자</label>
                        <input
                          class="form-control"
                          name="writer"
                           value='<c:out value="${board.writer}"/>' readonly="readonly"                          
                        />
                      </div>
                     
                      <div class="form-group">
                        <label for="exampleFormControlTextarea1" class="form-label">내용</label>
                        <textarea class="form-control" id="exampleFormControlTextarea1" name="content" rows="7" readonly="readonly"><c:out value="${board.content}"/></textarea>
                      </div>
                      
                      
<div class="row">
	<div class="col-lg-12">	
		<div class="panel panel-default">
			
			<div class="panel-heading">첨부 파일</div>
			<div class="panel-body">				
				
				<div class='uploadResult'>
					<ul>
						<!-- 자바스크립트 추가될 li 자리-->
					</ul>
				</div>
			</div>
			
		</div>
	</div>
</div>              
                      
                      <button data-oper="list" class="btn btn-outline-secondary">목록</button>
                      <sec:authentication property="principal" var="pinfo"/>
                      <sec:authorize access="isAuthenticated()">
                      <c:if test="${pinfo.username eq board.writer }">
                	  <button data-oper="modify"  class="btn btn-outline-primary">수정</button>
                	  </c:if>
                      </sec:authorize>
                     	
                      <form id="operForm" action="/board_f/modify" method="get">
                      	<input type='hidden' id='bno' name='bno' value='<c:out value="${board.bno}"/>'>
                      	<input type='hidden' name='pageNum' value='<c:out value="${cri.pageNum}"/>'>
                      	<input type='hidden' name='amount' value='<c:out value="${cri.amount}"/>'>
                      	<input type='hidden' name='keyword' value='<c:out value="${cri.keyword }"/>'>
                      	<input type='hidden' name='type' value='<c:out value="${cri.type }"/>'>
                      </form>
                    </div>
                    
                    
                    
       <div class="row">
				<div class="col-lg-12">
					
					<div class="panel panel-default">
						<div class="panel-heading">
							<i class="fa fa-comments fa-fw"></i> Reply
							<sec:authorize access="isAuthenticated()">	
							<button id='addReplyBtn' class='btn btn-primary btn-xs pull-right'>새 댓글</button>
							</sec:authorize>
						</div>
					
					
						<div class="panel-body">
							<ul class="chat">
								<li class="left clearfix" data-rno='12'>
									<div>
										<div class="header">
											<strong class="primary-font">user00</strong>
											<small class="pull-right text-muted">2022-01-01</small>
										</div>
										<p>Good job!</p>
									</div>
								</li>				
							</ul>
						</div>
						
						<!-- 페이지 번호 -->
						<div class="panel-footer">								
						</div>		
					</div>
				</div>
			</div>
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
	 			<button id='modalModBtn' type="button" class="btn btn-warning">수정</button>
	 			<button id='modalRemoveBtn' type="button" class="btn btn-danger">삭제</button>
	 			<button id='modalRegisterBtn' type="button" class="btn btn-primary">등록</button>
	 			<button id='modalCloseBtn' type="button" class="btn btn-dark" data-dismiss="modal">닫기</button>
	 		</div>
		</div>
	</div>
</div>
			
			
 		</div>
      </div>
                

			                
                
                
                <script src="/resources/js/reply.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	//댓글 페이지 처리
	var pageNum=1;
	var replyPageFooter=$(".panel-footer");
	
	function showReplyPage(replyCnt){
		var endNum=Math.ceil(pageNum/10.0)*10;
		var startNum=endNum-9;
		
		var prev=startNum!=1;
		var next=false;
		
		if(endNum*10>=replyCnt){
			endNum=Math.ceil(replyCnt/10.0);
		}
		if(endNum*10<replyCnt){
			next=true;
		}
		var str="<ul class='pagination pull-right'>";
		
		if(prev){
			str+="<li class='page-item'><a class='page-link' href='"+(startNum-1)+"'>이전</a></li>";
		}
		
		for(var i=startNum;i<=endNum;i++){
			var active=pageNum==i?"active":"";
			
			str+="<li class='page-item "+active+"'><a class='page-link' href='"+i+"'>"+i+"</a></li>";
		}
		
		if(next){
			str+="<li class='page-item'><a class='page-link' href='"+(endNum+1)+"'>다음</a></li>";
		}
		
		str+="</ul>";
		
		//replyPageFooter.append(str);
		replyPageFooter.html(str);
	}
	
	//댓글 페이지 번호 클릭시
	replyPageFooter.on("click","li a",function(e){
		e.preventDefault();
		console.log("page click");
		
		var targetPageNum=$(this).attr("href");
		console.log("targetPageNum:"+targetPageNum);
		
		pageNum=targetPageNum;
		
		showList(pageNum);		
	});
	
	//댓글 조회,추가,수정,삭제
	var bnoValue='${board.bno}';
	var replyUL=$(".chat");
	
	showList(1);
	
	//댓글 전체 조회
	function showList(page){
		
		replyService.getList({bno:bnoValue,page:page},				
			function(replyCnt,list){
				console.log("댓글 전체 갯수:"+replyCnt);
				console.log("댓글 목록:"+list);
				
				if(page==-1){
					pageNum=Math.ceil(replyCnt/10.0);
					showList(pageNum);
					return;
				}
							
				if(list==null || list.length==0){
					replyUL.html("");
					
					return;
				}
				
				var str="";			
				var len=list.length || 0;
				
				for(var i=0;i<len;i++){
					console.log(list[i]);
					
					str+="<li class='left clearfix' data-rno='"+list[i].rno+"'>";
					str+="	<div>";
					str+="		<div class='header'>";
					str+="			<strong class='primary-font'>"+list[i].replyer+"</strong>";
					str+="			<small class='pull-right text-muted'>"+replyService.displayTime(list[i].replyDate)+"</small>";
					str+="		</div>";
					str+="		<p>"+list[i].reply+"</p>";
					str+="	</div>";
					str+="</li>";
					
				}
				replyUL.html(str);	//기존 내용 덮어쉬우기
				
				showReplyPage(replyCnt); //페이징 호출
			}); 
	}
	
	//댓글 모달창
	var modal=$('.modal');
	var modalInputReply=modal.find("input[name='reply']");
	var modalInputReplyer=modal.find("input[name='replyer']");
	var modalInputReplyDate=modal.find("input[name='replyDate']");
	
	var modalModBtn=$('#modalModBtn');
	var modalRemoveBtn=$('#modalRemoveBtn');
	var modalRegisterBtn=$('#modalRegisterBtn');
	var modalCloseBtn=$('#modalCloseBtn');
	
	$('#addReplyBtn').on('click',function(e){
		//댓글 등록에서 보일 입력
		modal.find("input[name='reply']").val('').attr("readonly", false);
		<sec:authorize access="isAuthenticated()">
		<sec:authentication property="principal" var="pinfo"/>		
		modal.find("input[name='replyer']").val('<c:out value="${pinfo.username}"/>').attr("readonly","readonly");
		</sec:authorize>
		modalInputReplyDate.closest('div').hide();
		modal.find("button[id!='modalCloseBtn']").hide();		
		modalRegisterBtn.show();

		
		$(".modal").modal("show");
	});
	
	//댓글 등록
	modalRegisterBtn.on('click',function(e){
		
		var reply={
				reply:modalInputReply.val(),
				replyer:modalInputReplyer.val(),
				bno:bnoValue};
		
		replyService.add(reply,function(result){			
			alert("응답결과:"+result);
			
			modal.find('input').val('');
			modal.modal('hide');
			
			showList(-1);	//댓글 등록후 1페이지로 이동
		});
	});
	
	modalCloseBtn.on('click',function(e){
		modal.modal('hide');		
	});
	
	//댓글 li 클릭시 동작
	$(".chat").on("click","li",function(e){
		var rno=$(this).data("rno");
		
		console.log(rno);
		
		replyService.get(rno,function(reply){
			console.log(reply);
			
			modalInputReply.val(reply.reply).attr("readonly",true);
			modalInputReplyer.val(reply.replyer).attr("readonly","readonly");
			modalInputReplyDate.val(
					replyService.displayTime(reply.replyDate)).attr("readonly","readonly");
			
			modal.data("rno",reply.rno);
			var replyer=reply.replyer;
			
			modal.find("button[id!='modalCloseBtn']").hide();		
            <sec:authentication property="principal" var="pinfo"/>
                <sec:authorize access="isAuthenticated()">
                if('<c:out value="${pinfo.username}"/>' === replyer){
                		modalInputReply.attr("readonly",false);
						modalModBtn.show();
						modalRemoveBtn.show();
                };
	            </sec:authorize>
			$(".modal").modal("show");
			
		});
	});
	
	//댓글 수정
	modalModBtn.on("click",function(e){
		var reply={
				rno:modal.data("rno"),
				reply:modalInputReply.val()};
		
		replyService.update(reply,function(result){
			alert("수정 완료..."+result);
			modal.modal("hide");
			
			showList(pageNum);	//댓글 갱신
		}); 
	});
	
	//댓글 삭제
	modalRemoveBtn.on("click",function(e){
		var rno=modal.data("rno");
		
		replyService.remove(rno,function(result){
			alert("삭제 완료..."+result);		
			modal.modal("hide");
			
			showList(pageNum);	//댓글 갱신
		});
	});	
	
});


</script>

                
               	<script>
                	$(document).ready(function(){
                		var operForm=$("#operForm");
                		
                		$("button[data-oper='modify']").on("click",function(e){
                			operForm.attr("action","/board_f/modify").submit();
                		});
                		
                		$("button[data-oper='list']").on("click",function(e){
                			operForm.find("#bno").remove();
							
                			operForm.attr("action","/board_f/list_f");                			
                			
                			operForm.submit();               			
                		});
                	});
                </script>
                
                
                
<script>
//첨부파일처리
$(document).ready(function(){
	(function(){
		var bno='${board.bno}';
		
		$.getJSON("/board_f/getAttachList",{bno:bno},function(arr){
			console.log(arr);
			
			var uploadUL=$(".uploadResult ul");
			var str="";
			
			$(arr).each(function(i,obj){
				
				if(obj.fileType){
					var fileCallPath=encodeURIComponent(
							obj.uploadPath+"/s_"+obj.uuid+"_"+obj.fileName);
					
					str+="<li data-path='"+obj.uploadPath+"' data-uuid='"
								+obj.uuid+"' data-filename='"+obj.fileName
								+"' data-type='"+obj.fileType+"'><div>"							
							+"<img src='/display?fileName="+fileCallPath+"'>"
							+"</div></li>";
						
				}else{
					var fileCallPath=encodeURIComponent(
							obj.uploadPath+"/"+obj.uuid+"_"+obj.fileName);
					var fileLink=fileCallPath.replace(new RegExp(/\\/g),"/");
					
					str+="<li data-path='"+obj.uploadPath+"' data-uuid='"
								+obj.uuid+"' data-filename='"+obj.fileName
								+"' data-type='"+obj.fileType+"'><div>"
							+"<span>"+obj.fileName+"</span><br>"							
							+"<img src='/resources/img/attach.png'>"
							+"</div></li>";
				}
			});
			
			uploadUL.append(str);
		});
	})();
	
	$(".uploadResult").on("click","li",function(e){
		console.log("view image");
		
		var liObj=$(this);
		
		var path=encodeURIComponent(liObj.data("path")+"/"+liObj.data("uuid")+"_"+liObj.data("filename"));
		
		if(liObj.data("type")){
			showImage(path.replace(new RegExp(/\\/g),"/"));
		}else{
			self.location="/download?fileName="+path;
		}
	});
	
	function showImage(fileCallPath){
		//alert(fileCallPath);
		
		$(".bigPictureWrapper").css("display","flex").show();
		
		$(".bigPicture")
		.html("<img src='/display?fileName="+fileCallPath+"'>")
		.animate({width:'100%',height:'100%'},1000);
		
		$(".bigPictureWrapper").on("click",function(e){
			$(".bigPicture").animate({width:'0%',height:'0%'},1000);
			setTimeout(()=>{
				$(this).hide();
			},1000);
		});
	}
});
</script>

                
                
<%@include file="../includes/footer.jsp" %>                