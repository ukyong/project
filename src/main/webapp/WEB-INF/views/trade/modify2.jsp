<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ include file="../includes/header.jsp" %>
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
                <form role="form" action="/trade/modify2" method="post">
                <input type="hidden" id="tradeBno" name="tradeBno2" value="${pageInfo2.tradeBno2}">
               	 	<input type="hidden" name="pageNum" value='<c:out value="${cri.pageNum }"/>' >
               	 	<input type="hidden" name="amount" value='<c:out value="${cri.amount }"/>' >
               	 	<input type="hidden" name="keyword" value="${cri.keyword }">               	 	
               	 	
                <div class="form-group">
               		<label>번호</label>
               		<input class="form-control" name="tradeBno2" value="${pageInfo2.tradeBno2 }" readonly>
               	</div>
               	<div class="form-group">
               		<label>제목</label>
               		<input class="form-control" name="tradeTitle2" value="${pageInfo2.tradeTitle2 }">
               	</div>
               	<div class="form-group">
               		<label>내용</label>
               		<textarea class="form-control" rows="3" name="tradeContent2">${pageInfo2.tradeContent2 }</textarea>
               	</div>
               	<div class="form-group">
               		<label>작성자</label>
               		<input class="form-control" name="tradeWriter2" value="${pageInfo2.tradeWriter2}" readonly>
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


<!-- 첨부파일 -->
<div class="container">
	<div class="card">
		<div class="card-body">
			<div class="card-title">
				<div>첨부파일</div>
			</div>
			
			<div class='form-group uploadDiv'>
					<input type='file' name='uploadFile' multiple>
			</div>			
			
			<div class="uploadResult">
				<ul>
				
				</ul>
			</div>
			<div></div>
		</div>
	</div>
</div>

<script type="text/javascript">
$(document).ready(function(){
	
	//버튼 클릭시 동작
	var formObj=$("form");
	
	$("button[data-oper='modify']").on('click',function(e){
		e.preventDefault();
		
		console.log("submit clicked");
		var str="";
		
		$(".uploadResult ul li").each(function(i,obj){
			
			var jobj=$(obj);			
			console.log(jobj.data("filename2"));
			console.log(jobj.data("uuid2"));
			console.log(jobj.data("path2"));
			console.log(jobj.data("type2"));
									
			str+="<input type='hidden' name='attachList2["+i+"].fileName2'"
				+" value='"+jobj.data("filename")+"'>";
			str+="<input type='hidden' name='attachList2["+i+"].uuid2'"
				+" value='"+jobj.data("uuid")+"'>";
			str+="<input type='hidden' name='attachList2["+i+"].uploadPath2'"
				+" value='"+jobj.data("path")+"'>";
			str+="<input type='hidden' name='attachList2["+i+"].fileType2'"
				+" value='"+jobj.data("type")+"'>";
		});
		
		formObj.append(str).submit();		
	});
	
	$("button[data-oper='list']").on('click',function(e){
		e.preventDefault();
		
		formObj.attr("action","/trade/list2");
		formObj.attr("method","get");
		
		var pageNumTag=$("input[name='pageNum']").clone();
		var amountTag=$("input[name='amount']").clone();		
		var keywordTag=$("input[name='keyword']").clone();
		
		formObj.empty();
		
		formObj.append(pageNumTag);
		formObj.append(amountTag);		
		formObj.append(keywordTag);
		formObj.submit();
	});
	
	$("button[data-oper='remove']").on('click',function(e){
		e.preventDefault();
		
		formObj.attr('action','/trade/remove2');
		formObj.submit();
	});
	
});
</script>


<!-- 첨부파일 수정 -->
<script>
//첨부파일처리
$(document).ready(function(){
	var bno2 = ${pageInfo2.tradeBno2};
	
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
				
				str+="<li data-path='"+obj.uploadPath2+"' data-uuid='"+obj.uuid2+"' data-filename='"+obj.fileName2+"' data-type='"+obj.filetype2+"'><div>";
				str+="<span> "+obj.fileName2+"</span>";
				str+="<button type='button' data-file=\'"+fileCallPath+"\'data-type='image' ";
				str+="class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
				str+="<img src='/tradeDisplay2?fileName2="+fileCallPath+"'>";
				str+="</div></li>";
			}else{
				var fileCallPath = encodeURIComponent(obj.uploadPath2+"/s_"+obj.uuid2 +"_"+obj.fileName2);
				console.log(encodeURIComponent(obj.uploadPath2+"/s_"+obj.uuid2 +"_"+obj.fileName2))
				console.log(fileCallPath)
				
				str+="<li data-path='"+obj.uploadPath2+"' data-uuid='"+obj.uuid2+"' data-filename='"+obj.fileName2+"' data-type='"+obj.filetype2+"'><div>";
				str+="<span> "+obj.fileName2+"</span>";
				str+="<button type='button' data-file=\'"+fileCallPath+"\'data-type='image' ";
				str+="class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
				str+="<img src='/tradeDisplay2?fileName2="+fileCallPath+"'>";
				str+="</div></li>";
			}
		});
		
		uploadUL.append(str);	
	});

	
	$(".uploadResult").on("click","button",function(e){
		console.log("delete file2");
		
		if(confirm("첨부파일을 삭제하시겠습니까?")){
			var targetLi = $(this).closest("li");
			targetLi.remove();
		}
	});
	
	//파일 크기, 확장자 체크
	var regex = new RegExp("(.*?)\.(jpeg|jpg|png)$");
	var maxSize = 5242880;	//5MB 제한
	
	function checkExtension(fileName2, fileSize){
		if(fileSize >= maxSize){
			alert("5mb 이하 파일만 업로드 할 수 있습니다.");
			return false;
		}
		
		if(!regex.test(fileName2)){
			alert("이미지 파일만 업로드 할 수 있습니다.(jpeg,jpg,png)");
			return false;
		}
		return true;
	}
	
	
	//첨부파일 추가 또는 변경
	//파일 감지시 자동 업로드
	$("input[type='file']").change(function(e){
		var formData = new FormData();
		var inputFile = $("input[name='uploadFile']");
		var files = inputFile[0].files;
		
		for(var i=0; i<files.length; i++){
			if(!checkExtension(files[i].name, files[i].size)){
				return false;
			}
		formData.append("uploadFile", files[i]);
		}
		
		$.ajax({
			url: '/tradeUploadajaxAction2',
			processData: false,
			contentType: false, 
			data: formData,
			type: 'POST',
			dataType:'json',
			success: function(result){
				console.log(result);
				showUploadResult(result);
			}				
		});
	});
	
	function showUploadResult(uploadResultArr){
		
		if(!uploadResultArr || uploadResultArr.length==0){
			return;
		}
		
		var uploadUL=$(".uploadResult ul");
		var str="";
		
		$(uploadResultArr).each(function(i,obj){
			
			if(obj.image){
				var fileCallPath=encodeURIComponent(
						obj.uploadPath2+"/s_"+obj.uuid2+"_"+obj.fileName2);
				
				str+="<li data-path='"+obj.uploadPath2+"' data-uuid='"
							+obj.uuid2+"' data-filename='"+obj.fileName2
							+"' data-type='"+obj.image2+"'><div>"
						+"<span>"+obj.fileName2+" </span>"
						+"<button type='button' data-file=\'"+fileCallPath+"\' data-type='image' class='btn btn-warning btn-circle'>"
						+"<i class='fa fa-times'></i></button><br>"
						+"<img src='/tradeDisplay2?fileName2="+fileCallPath+"'>"
						+"</div></li>";
					
			}else{
				var fileCallPath=encodeURIComponent(
						obj.uploadPath2+"/s_"+obj.uuid2+"_"+obj.fileName2);
				
				str+="<li data-path='"+obj.uploadPath2+"' data-uuid='"
							+obj.uuid2+"' data-filename='"+obj.fileName2
							+"' data-type='"+obj.image2+"'><div>"
						+"<span>"+obj.fileName2+" </span>"
						+"<button type='button' data-file=\'"+fileCallPath+"\' data-type='image' class='btn btn-warning btn-circle'>"
						+"<i class='fa fa-times'></i></button><br>"
						+"<img src='/tradeDisplay2?fileName2="+fileCallPath+"'>"
						+"</div></li>";
				
			}	
		});
		
		uploadUL.append(str);
	}	
});
</script>
