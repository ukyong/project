<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../includes/header.jsp" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
</head>
<body>
<div class="jumbotron">
	<div class="container-lg">
	    <div class="col-lg-12">
	        <h1 class="page-header">게시판 글쓰기</h1>
	    </div>	    
	</div>
	
<div class="container">
    <div class="col-lg-12">
        <div class="card-body">
            <!-- /.panel-heading -->            
            <div class="card-body">            	
				<form role="form" action="/trade/insert" method="post">
				
					<div class="mb-3">
						<label class="form-group">제목</label>
						<input name="tradeTitle" class="form-control">
					</div>
					<div class="mb-3">
						<label class="form-group">내용</label>
						<textarea class="form-control" rows="3" name="tradeContent"></textarea>
					</div>
					<div class="mb-3">
						<label class="form-group">작성자</label>
						<sec:authentication property="principal" var="pinfo"/>						
						<input name="tradeWriter" class="form-control" value="${pinfo.username}" readonly="readonly">
					</div>		
					<button type="submit" class="btn btn-primary">등록</button>
					<button type="submit" class="btn btn-secondary">취소</button>
					
				</form>	
            <!-- /.panel-body -->
    		</div>
        <!-- /.panel -->
		</div>
    <!-- /.col-lg-12 -->
	</div>
	<!-- /.row -->
	</div>

	<!-- 첨부파일 업로드 -->
	<div class="container">
	<div class="card">
		<div class="card">		
			<div class="card-body ">
				<div class="card-title">이미지 등록</div>
			</div>			
		</div>
		<div class="card-body">
		<div class="form-group uploadDiv">
			<input type="file" name="uploadFile" multiple="multiple">
		</div>
		
		<div class="uploadResult">
			<ul>
			
			</ul>
		</div>
		</div>			
	</div>
	</div>
</div>            
</body>

<script>
//이미지 업로드 자바스크립트
$(document).ready(function(e){
	
	//게시물 등록버튼
	var formObj=$("form[role='form']");
	
	$("button[type='submit']").on('click',function(e){
		e.preventDefault();
		
		console.log("submit clicked");
		
		var str="";
		
		$(".uploadResult ul li").each(function(i,obj){
			var jobj=$(obj);
			
			console.dir(jobj);
			
			str+="<input type='hidden' name='attachList["+i+"].fileName'"
				+" value='"+jobj.data("filename")+"'>";
			str+="<input type='hidden' name='attachList["+i+"].uuid'"
				+" value='"+jobj.data("uuid")+"'>";
			str+="<input type='hidden' name='attachList["+i+"].uploadPath'"
				+" value='"+jobj.data("path")+"'>";
			str+="<input type='hidden' name='attachList["+i+"].filetype'"
				+" value='"+jobj.data("type")+"'>";				
		});
		console.log("1");
		formObj.append(str).submit();
		console.log("2");
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
	
	//첨부파일 삭제
	$(".uploadResult").on("click", "button", function(e){
		console.log("delete file");
		
		var targetFile = $(this).data("file");
		var type = $(this).data("type");
		
		var targetLi = $(this).closest("li");
		
		$.ajax({
			url: '/tradeDeleteFile',
			data: {fileName: targetFile, type:type},
			dataType: 'text',
			type: 'POST',
			success: function(result){
				alert(result);
				targetLi.remove();
			}
		});
	})
});




</script>
</html>









