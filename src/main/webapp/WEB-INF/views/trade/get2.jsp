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
            <h1 class="page-header">구매게시판</h1>	            	      
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
            		<input class="form-control" name="tradeBno2" value="${pageInfo2.tradeBno2 }" readonly>
            	</div>
            	<div class="form-group">
            		<label>제목</label>
            		<input class="form-control" name="tradeTitle2" value="${pageInfo2.tradeTitle2 }" readonly>
            	</div>
            	<div class="form-group">
            		<label>내용</label>
            		<textarea class="form-control" rows="3" name="tradeContent2" readonly>${pageInfo2.tradeContent2 }</textarea>
            	</div>
            	<div class="form-group">
            		<label>작성자</label>
            		<input class="form-control" name="tradeWriter2" value="${pageInfo2.tradeWriter2}" readonly>
            	</div>
            	               	
                      <button class="btn btn-success" id="list_btn">목록</button> 
                      <sec:authentication property="principal" var="pinfo"/>
                      	<sec:authorize access="isAuthenticated()">
                      		<c:if test="${pinfo.username eq pageInfo.tradeWriter }">
                	  			<button class="btn btn-primary" id="modify_btn">수정</button>
                	  		</c:if>
                      </sec:authorize>
            	 
            	 <form id="infoForm" action="/trade/modify2" method="get">
            	 	<input type="hidden" id="tradeBno2" name="tradeBno2" value="${pageInfo2.tradeBno2}">
               	 	<input type="hidden" name="pageNum" value="${cri.pageNum }">
            	 	<input type="hidden" name="amount" value="${cri.amount }"> 
            	 	<input type="hidden" name="keyword" value="${cri.keyword }">
            	 	<input type="hidden" name="type" value="${cri.type }">
            	 </form>                             
      		 </div>                     
		</div>
	</div>
</div>
</div>    

<!-- 첨부파일 -->
<div class="container-lg">
<div class="card">
	<div class="card-body">
		<div class="card-title">
			<div>첨부파일</div>
		</div>
		
		<div class="uploadResult">
			<ul>
			</ul>
		</div>
		<div></div>
	</div>
</div>
</div>

<!-- 댓글 -->
<div class="container-lg" id="reply">	
		<div class="card">
			<div class="card-header">
				<i class="fa fa-comments fa-fw"></i> Reply
					<sec:authorize access="isAuthenticated()">	
						<button id='addReplyBtn' class='btn btn-primary btn-sm pull-right'>새 댓글</button>
					</sec:authorize>				
			</div>
		
			<div class="card-body">
				<ul class="chat list-group list-group-flush">
					<li class="list-group-item" data-rno='12'>
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
	 				<input class="form-control" name='reply2' value='New Reply!!!'>
	 			</div>
	 			<div class="form-group">
	 				<label>Replyer</label>
	 				<input class="form-control" name='replyer2' value='replyer'>
	 			</div>
	 			<div class="form-group">
	 				<label>Reply Date</label>
	 				<input class="form-control" name='replyDate2' value=''>
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

<!-- 댓글 처리 스크립트 -->
<script type="text/javascript" src="/resources/js/TradeReply2.js"></script>
<script>
$(document).ready(function(){
	history.replaceState({},null,null);
	
	var bnoValue='<c:out value="${pageInfo2.tradeBno2}"/>';
	var replyUL = $(".chat");
	
	showList(1);
	
	//댓글 전체 조회
	function showList(page){		
		replyService.getList2({tradeBno2:bnoValue, page:page || 1},				
		function(replyCnt2, list2){			
			console.log("댓글 목록2:"+list2);
			console.log("댓글 수2:" + replyCnt2)

			if(page == -1){
				pageNum = Math.ceil(replyCnt2/10.0);
				showList(pageNum);
				return;
			}
			
			if(list2==null || list2.length==0){	
				replyUL.html("");
				return;
			}
			
			var str="";			
			
			for(var i=0, len = list2.length || 0; i<len; i++){
				
				str+="<li class='list-group-item' data-rno2='"+list2[i].rno2+"'>";
				str+="	<div>";
				str+="		<div class='header'>";
				str+="			<strong class='primary-font'>["+list2[i].rno2+"] "+list2[i].replyer2+"</strong>";
				str+="			<small class='pull-right text-muted'>"+replyService.displayTime(list2[i].replyDate2)+"</small>";
				str+="		</div>";
				str+="		<p>"+list2[i].reply2+"</p>";
				str+="	</div>";
				str+="</li>";
				
			}
			replyUL.html(str);	//기존 내용 덮어쉬우기
			
			showReplyPage(replyCnt2);
					
		});  			
	}
	
	//댓글 페이징
	//댓글 페이지 처리
	var pageNum=1;
	var replyPageFooter=$(".panel-footer");
	
	function showReplyPage(replyCnt2){
		var endNum=Math.ceil(pageNum/10.0)*10;
		var startNum=endNum-9;
		
		var prev=startNum!=1;
		var next=false;
		
		if(endNum*10>=replyCnt2){
			endNum=Math.ceil(replyCnt2/10.0);
		}
		if(endNum*10<replyCnt2){
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
	
	
	
	
	//댓글 모달창
	var modal=$('.modal');
	var modalInputReply=modal.find("input[name='reply2']");
	var modalInputReplyer=modal.find("input[name='replyer2']");
	var modalInputReplyDate=modal.find("input[name='replyDate2']");
	
	var modalModBtn=$('#modalModBtn');
	var modalRemoveBtn=$('#modalRemoveBtn');
	var modalRegisterBtn=$('#modalRegisterBtn');
	var modalCloseBtn=$('#modalCloseBtn');
	
	$("#addReplyBtn").on("click", function(e){
		modal.find("input[name='reply']").val('').attr("readonly", false);
		<sec:authorize access="isAuthenticated()">
		<sec:authentication property="principal" var="pinfo"/>		
		modal.find("input[name='replyer']").val('<c:out value="${pinfo.username}"/>').attr("readonly","readonly");
		</sec:authorize>
		modalInputReplyDate.closest("div").hide();
		modal.find("button[id !='modalCloseBtn']").hide();
		
		modalRegisterBtn.show();
		
		$(".modal").modal("show");
	});
	
	modalRegisterBtn.on("click",function(e){
		var reply2 = {
				reply2: modalInputReply.val(),
				replyer2: modalInputReplyer.val(),
				bno2: bnoValue
		};
		replyService.add2(reply2, function(result){
			alert(result);
			modal.find("input").val("");
			modal.modal("hide");
			
			showList(1);
		});
	});
	
	modalCloseBtn.on('click',function(e){
		modal.modal('hide');		
	});
	
	//댓글 조회 클릭 이벤트 처리
	$(".chat").on("click", "li", function(e){
		var rno2 = $(this).data("rno2");
		replyService.get2(rno2, function(reply2){
			modalInputReply.val(reply2.reply2).attr("readonly",true);
			modalInputReplyer.val(reply2.replyer2).attr("readonly","readonly");
			modalInputReplyDate.val(
					replyService.displayTime(reply2.replyDate2)).attr("readonly","readonly");
			
			modal.data("rno2",reply2.rno2);
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
		})
	});
	
	
	
	//댓글 페이지 이동
	replyPageFooter.on("click", "li a", function(e){
		e.preventDefault();
		console.log("page click");
		var targetPageNum = $(this).attr("href");
		console.log("타겟 페이지:" + targetPageNum);
		pageNum = targetPageNum;
		showList(pageNum);
	});
	
	//댓글 수정
	modalModBtn.on("click", function(e){
		var reply2 = {rno2:modal.data("rno2"), reply2: modalInputReply.val()};
		replyService.update2(reply2, function(result){
			alert(result);
			modal.modal("hide");
			showList(pageNum);
		})
	})
	
	//댓글 삭제
	modalRemoveBtn.on("click",function(e){
		var rno2=modal.data("rno2");
		
		replyService.remove2(rno2,function(result){
			alert("삭제 완료2..."+result);		
			modal.modal("hide");
			
			showList(pageNum);	//댓글 갱신
		});
	});
})	
	
</script>

<!-- form 처리 -->
<script>
	var form = $("#infoForm");
	
	$("#list_btn").on("click", function(e){
		form.find("#tradeBno2").remove();
		form.attr("action", "/trade/list2");
		form.submit();
	})
	
	$("#modify_btn").on("click", function(e){	
		form.attr("action", "/trade/modify2");		
		form.submit();
	})

</script>

<!-- 첨부파일 처리 -->
<script>
$(document).ready(function(){
	var bno2 = ${pageInfo2.tradeBno2};
	console.log(bno2);
	$.getJSON("/trade/getAttachList2",{bno2:bno2},function(arr){
		console.log(arr);
		
		var uploadUL=$(".uploadResult ul");
		var str="";
		
		$(arr).each(function(i,obj){
			console.log(obj.uuid2)
			console.log(obj.filetype2)
			console.log(obj.fileName2)
			console.log(obj.uploadPath2)
			
			if(obj.filetype){
				var fileCallPath = encodeURIComponent(obj.uploadPath2+"/s_"+obj.uuid2 +"_"+obj.fileName2);
				console.log(encodeURIComponent(obj.uploadPath2+"/s_"+obj.uuid2 +"_"+obj.fileName2))
				console.log(fileCallPath)
				
				str+="<li data-path='"+obj.uploadPath2+"' data-uuid='"
							+obj.uuid2+"' data-filename='"+obj.fileName2
							+"' data-type='"+obj.filetype2+"'><div>";
							
				str+="<img src='/tradeDisplay2?fileName2="+fileCallPath+"'>";
				str+="</div></li>";
			}else{
				var fileCallPath = encodeURIComponent(obj.uploadPath2+"/s_"+obj.uuid2 +"_"+obj.fileName2);
				console.log(encodeURIComponent(obj.uploadPath2+"/s_"+obj.uuid2 +"_"+obj.fileName2))
				console.log(fileCallPath)
				
				str+="<li data-path='"+obj.uploadPath2+"' data-uuid='"
							+obj.uuid2+"' data-filename='"+obj.fileName2
							+"' data-type='"+obj.filetype2+"'><div>";
							
				str+="<img src='/tradeDisplay2?fileName2="+fileCallPath+"'>";
				str+="</div></li>";
			}
		});
		
		uploadUL.append(str);
	});
	
	//이미지 클릭시 확대
	$(".uploadResult").on("click","li",function(e){
		console.log("이미지 보기");
		
		var liObj=$(this);
		
		var path=encodeURIComponent(liObj.data("path2")+"/"+liObj.data("uuid2")+"_"+liObj.data("filename2"));
		
		if(liObj.data("type2")){
			showImage(path.replace(new RegExp(/\\/g),"/"));
		}
	});
	
	function showImage(fileCallPath){		
		
		$(".bigPictureWrapper").css("display","flex").show();
		
		$(".bigPicture")
		.html("<img src='/tradeDisplay2?fileName="+fileCallPath+"'>")
		.animate({width:'100%', height: '100%'}, 1000);
		
		$(".bigPictureWrapper").on("click",function(e){
			$(".bigPicture").animate({width:'0%',height:'0%'},1000);
			setTimeout(()=>{
				$(this).hide();
			},1000);
		});
	}
})

</script>