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
 
	
				<div class="container-xxl flex-grow-1 container-p-y">
                  <div class="card-mb-4" >
                    <h2 class="card-header">게시글 수정</h2>
                    <div class="card-body">
                                        
                    <form role="form" action="/pr_board/modify" method="post">
                    <input type='hidden' name='pageNum' value='${cri.pageNum }'>
                	<input type='hidden' name='amount' value='${cri.amount }'>
                	<input type='hidden' name='type' value='${cri.type }'>
                	<input type='hidden' name='keyword' value='${cri.keyword }'>
                    	
                    	
                      <div class="form-group">
                        <label for="exampleFormControlInput1" class="form-label">번호</label>
                        <input
                          class="form-control"
                          name="bno"
                          value='<c:out value="${board.bno}"/>'
                          readonly="readonly">                            
                      </div>
                      
                    	
                      <div class="form-group">
                        <label for="exampleFormControlInput1" class="form-label">제목</label>
                        <input
                          class="form-control"
                          name="title"
                          value='<c:out value="${board.title}"/>'>                                                 
                      </div>
                   	                    	
                   	  <div class="form-group">
                        <label for="exampleFormControlInput1" class="form-label">작성자</label>
                        <sec:authentication property="principal" var="pinfo"/>
                        <input
                          class="form-control"
                          name="writer" value="${pinfo.username}" readonly="readonly"                          
                        />
                      </div>
                      
                      <div class="form-group">
                        <label for="exampleFormControlInput1" class="form-label">소개말</label>
                        <input
                          class="form-control"
                          name="front"
                           value='<c:out value="${board.front}"/>'/>
                      </div>
                      
                     
                      <div class="form-group">
                        <label for="exampleFormControlTextarea1" class="form-label">내용</label>
                        <textarea class="form-control" id="exampleFormControlTextarea1" name="content" rows="7"><c:out value="${board.content}"/></textarea>
                      </div>
                      
                      <div class="form-group">
                        <label for="exampleFormControlSelect1" class="form-label">카테고리</label>
                        <select class="form-select" id="exampleFormControlSelect1" name="cgo" aria-label="Default select example">
                          <option value="식당">식당</option>
                          <option value="카페">카페</option>
                          <option value="생활">생활</option>
                          <option value="뷰티">뷰티</option>
                          <option value="기타">기타</option>
                        </select>
                      </div>
                      
                    <div class="form-group">
	               		<label>주소</label>
                		<input type="text" id="sample6_postcode" placeholder="우편번호">
						<input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기"><br>
						<input class="form-control" type="text" id="sample6_address" name="map" value='<c:out value="${board.map}"/>' placeholder="주소"><br>
						<input class="form-control" type="text" id="sample6_address" name="address" value='<c:out value="${board.address}"/>' placeholder="상세주소"><br>
                	</div>
                      
                                            	
                      	<!-- 이미지 확대 보기 -->
<div class='bigPictureWrapper'>
	<div class='bigPicture'></div>
</div>

<div class="row">
	<div class="col-lg-12">	
		<div class="panel panel-default">
			
			<div class="panel-heading">첨부 파일</div>
			<div class="panel-body">				
				<div class="form-group uploadDiv">
					<input type="file" name='uploadFile' multiple="multiple">
				</div>
				<div class='uploadResult'>
					<ul>
						<!-- 자바스크립트 추가될 li 자리-->
					</ul>
				</div>
			</div>
			
		</div>
	</div>
</div> 
   	                      	          
                      <button type="submit" data-oper="list" class="btn btn-outline-secondary">목록</button>
                	  <button type="submit" data-oper="modify"  class="btn btn-outline-primary">수정</button>
                      <button type="submit" data-oper="remove" class="btn btn-outline-danger">삭제</button>
                      	
                	</form>
                    </div>
                  </div>
                </div>

<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript">

/*  var geocoder = new kakao.maps.services.Geocoder(); */
    function sample6_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }
                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('sample6_postcode').value = data.zonecode;
                document.getElementById("sample6_address").value = addr;
                // 커서를 상세주소 필드로 이동한다.               
            }
        }).open();
    } 
    
</script>



				
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
		if('${board.cgo}'==="식당"){
		formObj.attr("action","/pr_board/list_r");
		}
		if('${board.cgo}'==="카페"){
			formObj.attr("action","/pr_board/list_c");
			}
		if('${board.cgo}'==="생활"){
			formObj.attr("action","/pr_board/list_l");
			}
		if('${board.cgo}'==="뷰티"){
			formObj.attr("action","/pr_board/list_b");
			}
		if('${board.cgo}'==="기타"){
			formObj.attr("action","/pr_board/list_g");
			}
		formObj.attr("method","get");
		
		var pageNumTag=$("input[name='pageNum']").clone();
		var amountTag=$("input[name='amount']").clone();
		var typeTag=$("input[name='type']").clone();
		var keywordTag=$("input[name='keyword']").clone();
		
		formObj.empty();
		
		formObj.append(pageNumTag);
		formObj.append(amountTag);
		formObj.append(typeTag);
		formObj.append(keywordTag);
		formObj.submit();
	});
	
	$("button[data-oper='remove']").on('click',function(e){
		e.preventDefault();
		
		formObj.attr('action','/pr_board/remove');
		formObj.submit();
	});
	
});
</script>

<script>
//첨부파일처리
$(document).ready(function(){
	(function(){
		var bno='${board.bno}';
		
		$.getJSON("/pr_board/getAttachList",{bno:bno},function(arr){
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
							+"<span>"+obj.fileName+" </span>"
							+"<button type='button' data-file=\'"+fileCallPath+"\' data-type='image' class='btn btn-warning btn-circle'>"
							+"<i class='fa fa-times'></i></button><br>"
							+"<img src='/display?fileName="+fileCallPath+"'>"
							+"</div></li>";
						
				}else{
					var fileCallPath=encodeURIComponent(
							obj.uploadPath+"/"+obj.uuid+"_"+obj.fileName);
					var fileLink=fileCallPath.replace(new RegExp(/\\/g),"/");
					
					str+="<li data-path='"+obj.uploadPath+"' data-uuid='"
								+obj.uuid+"' data-filename='"+obj.fileName
								+"' data-type='"+obj.fileType+"'><div>"
							+"<span>"+obj.fileName+" </span>"
							+"<button type='button' data-file=\'"+fileCallPath+"\' data-type='file' class='btn btn-warning btn-circle'>"
							+"<i class='fa fa-times'></i></button><br>"						
							+"<img src='/resources/img/attach.png'>"
							+"</div></li>";
				}
			});
			
			uploadUL.append(str);
		});
	})();
	
	$(".uploadResult").on("click","button",function(e){
		console.log("delete file");
		
		var targetFile=$(this).data("file");
		var type=$(this).data("type");
		console.log(targetFile);
		
		var targetLi=$(this).closest("li");
		targetLi.remove();
	});
	
	//파일 크기, 확장자 체크
	var regex=new RegExp("(.*?)\.(exe|sh|alz)$");
	var maxSize=5242880;	//5MB 제한
	
	function checkExtension(fileName,fileSize){
		
		if(fileSize>=maxSize){
			alert("파일 사이즈 초과");
			return false;
		}
		if(regex.test(fileName)){
			alert("해당 종류의 파일은 업로드할 수 없습니다.");
			return false;
		}
		return true;
	}
	
	//파일 초기화 복제
	var cloneObj=$(".uploadDiv").clone();
	
	//첨부파일 변경
	$("input[type='file']").change(function(e){
		var formData=new FormData();
		var inputFile=$("input[name='uploadFile']");
		var files=inputFile[0].files;
		
		console.log(files);
		
		for(var i=0;i<files.length;i++){
			//파일 크기, 확장자 체크
			if(!checkExtension(files[i].name,files[i].size))
				return false;
				
			formData.append("uploadFile",files[i]);
		}
		
		$.ajax({
			url:'/uploadAjaxAction',
			processData:false,
			contentType:false,
			data:formData,
			type:'POST',
			dataType:'json',
			success:function(result){
				console.log(result);
				
				//input file 입력창 초기화
				$(".uploadDiv").html(cloneObj.html());
				
				showUploadedFile(result);
			}
		});
	});
	
	//첨부파일 보이기
	function showUploadedFile(uploadResultArr){
		
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
						+"<i class='fa fa-times'>x</i></button><br>"
						+"<img src='/display?fileName="+fileCallPath+"'>"
						+"</div></li>";
					
			}else{
				var fileCallPath=encodeURIComponent(
						obj.uploadPath+"/"+obj.uuid+"_"+obj.fileName);
				var fileLink=fileCallPath.replace(new RegExp(/\\/g),"/");
				
				str+="<li data-path='"+obj.uploadPath+"' data-uuid='"
							+obj.uuid+"' data-filename='"+obj.fileName
							+"' data-type='"+obj.image+"'><div>"
						+"<span>"+obj.fileName+" </span>"
						+"<button type='button' data-file=\'"+fileCallPath+"\' data-type='file' class='btn btn-warning btn-circle'>"
						+"<i class='fa fa-times'>x</i></button><br>"
						+"<img src='/resources/img/attach.png'>"
						+"</div></li>";
			}			
		});
		
		uploadUL.append(str);
	}

});
</script>


<%@include file="../includes/footer.jsp" %> 