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
                <form role="form" action="/trade/modify" method="post">
                	<input type="hidden" id="tradeBno" name="tradeBno" value="${pageInfo.tradeBno}">
               	 	<input type="hidden" name="pageNum" value="${cri.pageNum }" >
               	 	<input type="hidden" name="amount" value="${cri.amount }" >
               	 	<input type="hidden" name="keyword" value="${cri.keyword }">               	 	
               	 	
                <div class="form-group">
               		<label>번호</label>
               		<input class="form-control" name="tradeBno" value="${pageInfo.tradeBno }" readonly>
               	</div>
               	<div class="form-group">
               		<label>제목</label>
               		<input class="form-control" name="tradeTitle" value="${pageInfo.tradeTitle }">
               	</div>
               	<div class="form-group">
               		<label>내용</label>
               		<textarea class="form-control" rows="3" name="tradeContent">${pageInfo.tradeContent }</textarea>
               	</div>
               	<div class="form-group">
               		<label>작성자</label>
               		<input class="form-control" name="tradeWriter" value="${pageInfo.tradeWriter}" readonly>
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
				<div>이미지 파일</div>
			</div>
			
			<div class='form-group uploadDiv'>
					<input type='file' name='uploadFile' multiple>
			</div>			
			
			<div class="uploadResult">
				<ul>
				
				</ul>
			</div>
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
			console.log(jobj.data("filename"));
			console.log(jobj.data("uuid"));
			console.log(jobj.data("path"));
			console.log(jobj.data("type"));
									
			str+="<input type='hidden' name='attachList["+i+"].fileName'"
				+" value='"+jobj.data("filename")+"'>";
			str+="<input type='hidden' name='attachList["+i+"].uuid'"
				+" value='"+jobj.data("uuid")+"'>";
			str+="<input type='hidden' name='attachList["+i+"].uploadPath'"
				+" value='"+jobj.data("path")+"'>";
			str+="<input type='hidden' name='attachList["+i+"].fileType'"
				+" value='"+jobj.data("type")+"'>";
		});
		
		formObj.append(str).submit();		
	});
	
	$("button[data-oper='list']").on('click',function(e){
		e.preventDefault();
		
		formObj.attr("action","/trade/list");
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
		
		formObj.attr('action','/trade/remove');
		formObj.submit();
	});
	
});
</script>


<!-- 첨부파일 수정 -->
<script>
//첨부파일처리
$(document).ready(function(){
	var bno = ${pageInfo.tradeBno};
	
	$.getJSON("/trade/getAttachList",{bno:bno},function(arr){
		console.log(arr);
		
		var uploadUL=$(".uploadResult ul");
		var str="";
		
		$(arr).each(function(i,obj){
			console.log(obj.uuid)
			console.log(obj.filetype)
			console.log(obj.fileName)
			console.log(obj.uploadPath)
			
			if(obj.filetype){
				var fileCallPath = encodeURIComponent(obj.uploadPath+"/s_"+obj.uuid +"_"+obj.fileName);
				console.log(encodeURIComponent(obj.uploadPath+"/s_"+obj.uuid +"_"+obj.fileName))
				console.log(fileCallPath)
				
				str+="<li data-path='"+obj.uploadPath+"' data-uuid='"+obj.uuid+"' data-filename='"+obj.fileName+"' data-type='"+obj.filetype+"'><div>";
				str+="<span> "+obj.fileName+"</span>";
				str+="<button type='button' data-file=\'"+fileCallPath+"\'data-type='image' ";
				str+="class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
				str+="<img src='/tradeDisplay?fileName="+fileCallPath+"'>";
				str+="</div></li>";
			}else{
				var fileCallPath = encodeURIComponent(obj.uploadPath+"/s_"+obj.uuid +"_"+obj.fileName);
				console.log(encodeURIComponent(obj.uploadPath+"/s_"+obj.uuid +"_"+obj.fileName))
				console.log(fileCallPath)
				
				str+="<li data-path='"+obj.uploadPath+"' data-uuid='"+obj.uuid+"' data-filename='"+obj.fileName+"' data-type='"+obj.filetype+"'><div>";
				str+="<span> "+obj.fileName+"</span>";
				str+="<button type='button' data-file=\'"+fileCallPath+"\'data-type='image' ";
				str+="class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
				str+="<img src='/tradeDisplay?fileName="+fileCallPath+"'>";
				str+="</div></li>";
			}
		});
		
		uploadUL.append(str);	
	});

	
	$(".uploadResult").on("click","button",function(e){
		console.log("delete file");
		
		if(confirm("첨부파일을 삭제하시겠습니까?")){
			var targetLi = $(this).closest("li");
			targetLi.remove();
		}
	});
	
	//파일 크기, 확장자 체크
	var regex = new RegExp("(.*?)\.(jpeg|jpg|png)$");
	var maxSize = 5242880;	//5MB 제한
	
	function checkExtension(fileName, fileSize){
		if(fileSize >= maxSize){
			alert("5mb 이하 파일만 업로드 할 수 있습니다.");
			return false;
		}
		
		if(!regex.test(fileName)){
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
			url: '/tradeUploadajaxAction',
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
						obj.uploadPath+"/s_"+obj.uuid+"_"+obj.fileName);
				
				str+="<li data-path='"+obj.uploadPath+"' data-uuid='"
							+obj.uuid+"' data-filename='"+obj.fileName
							+"' data-type='"+obj.image+"'><div>"
						+"<span>"+obj.fileName+" </span>"
						+"<button type='button' data-file=\'"+fileCallPath+"\' data-type='image' class='btn btn-warning btn-circle'>"
						+"<i class='fa fa-times'></i></button><br>"
						+"<img src='/tradeDisplay?fileName="+fileCallPath+"'>"
						+"</div></li>";
					
			}	
		});
		
		uploadUL.append(str);
	}	
});
</script>
