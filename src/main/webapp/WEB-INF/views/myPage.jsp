<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
    
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">

    <title>관리자페이지</title>

    <title>게시판</title>

    <script src="https://code.jquery.com/jquery-1.11.3.js"></script>
   <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
   <link rel="stylesheet" href="/resources/css/myPage.css"> 
    <style>
    
   td a{
   	text-decoration:none;
   	color:black;
   }
   .button-group{
	   text-align: center;
   }
   .btn-secondary{
   		display :inline-block;
   }
    </style>
    
</head>
<body>
<%@include file="includes/header.jsp" %>
<div class = "container mt-5 py-5" style="text-align:center">
	<div class="row">
		<h2><Strong>마이페이지</Strong></h2>
	</div>
</div>
<div class="container mt-5 py-5">
		<div class="addressInfo_div">
					<div class="addressInfo_button_div">
						<button class="address_btn address_btn_1" onclick="getUserInfo(1)">내 정보</button>

						<button class="address_btn address_btn_2" onclick="getUserOrder(2)">내가 쓴 글</button>

					</div>
					<div class="addressInfo_input_div_wrap">
						<div class="addressInfo_input_div addressInfo_input_div_1" style="display: block" id="myPage">
							
							
						</div>

					</div>
				</div>
			</div>
			
		<div class = "container mt-5 py-5" style="text-align:center" id="button-group">
	
</div>
<div class="modal" tabindex="-1" id="testModal">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">리뷰 작성하기</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
      	<input type="hidden" name="pno" id="pno" value="">
      	<input type="hidden" name="orderno" id="orderno" value="">
        <textarea class="form-control h-25" rows="10" style="width:100%" name="comment" id="comment"></textarea>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">창 닫기</button>
        <button type="button" class="btn btn-warning" id="reviewsubmit">작성</button>
      </div>
    </div>
  </div>
</div>

<%@include file="includes/footer.jsp" %>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
function getUserOrder(className){
	$.ajax({
		type:'GET',
		url:'/user/userOrder',
		success:function(data){
			var str = '<table class="table table-hover table-condensed mt-5">';
			str+= '<tr>';
			str+='<th>상품명</th>';	
	        str+='<th>수량</th>';
	        str+='<th>금액</th>';
	        str+='<th>주문 날짜</th>';
	        str+='<th>배송상태</th>';
	        str+='<th>리뷰</th>';
	        str+='</tr>';
			$(data).each(function(){
			str+='<tr data-pno="'+this.pno+'">';
			str+='<td>';
			str+=this.productName;
			str+='</td>';
			str+='<td>';
			str+=this.amount;
			str+='</td>';
			str+='<td>';
			str+=this.totalPrice;
			str+='</td>';
			str+='<td>';
			var time= new Date(this.reg_date);
			var date=time.toLocaleDateString(); 
			str+=date;
			str+='</td>';
			str+='<td>';
			str+=this.state;
			str+='</td>';
			if(this.review=='미작성'){
				str+='<td data-orderno ="'+this.orderno+'">';
				str+='<button type="button" class="btn btn-primary" id="writeBtn">리뷰 작성</button>';
				str+='</td>';
			}else{
			str+='<td data-orderno ="'+this.orderno+'">';
			str+='작성 완료';
			str+='</td>';
			}
			str+='</tr>';
			
			

			});
			str+='</table>';
			$("#myPage").html(str);
			$("#button-group").html("");
		},
		error: function(){alert("error");}
	});
	$(".address_btn").css('backgroundColor', '#555');
	/* 지정 색상 변경 */
		$(".address_btn_"+className).css('backgroundColor', '#3c3838');
}

function modify(){
	$.ajax({
		type:'GET',
		url:'/user/userInfo',
		success:function(data){
			var str = '<table class="py-5 mt-5">';
			str +=' <colgroup>';
			str +='<col width="25%">';
			str +='<col width="*">';
			str +='</colgroup>';
			str +='<tbody>';
			str += '<tr>';
			str += '<th>아이디</th>';
			str += '<td>';
			str +='<input class="userId" type="text" name="userId" value="'+data.userId+'" readonly="readonly">';
			str +='</td>';
			str +='</tr>';
			str += '<tr>';
			str += '<th>이름</th>';
			str += '<td>';
			str +='<input class="userName" type="text" name="userName" value="'+data.userName+'" readonly="readonly">';
			str +='</td>';
			str +='</tr>';
			str += '<tr>';
			str += '<th>이메일</th>';
			str += '<td>';
			str +='<input class="userEmail" type="text" name="userEmail" value="'+data.userEmail+'">';
			str +='</td>';
			str +='</tr>';
			str += '<tr>';
			str += '<th>주소</th>';
			str += '<td>';
			str +='<input class="address_input_1" name="userAddr1" readonly="readonly" value="'+data.userAddr1+'">&nbsp';
			str +='<input class="address_input_2" name="userAddr2" readonly="readonly" value="'+data.userAddr2+'"size=50><br>';
			str +='<input class="address_input_3 mt-3" name="userAddr3"  value="'+data.userAddr3+'">&nbsp&nbsp';
			str += '<button class="btn btn-primary ml-5" onclick="execution_daum_address()">주소찾기</button>';
			str +='</td>';
			str +='</tr>';
			str +='</tbody>';
			str +='</table';
			var str2 ='<div class="button-group">';
			str2+=	'<button type="button" class="btn btn-warning" onclick="modifyPost()" >수정하기</button>';
			str2+=	'</div>';	


				 
			$("#myPage").html(str);
			$("#button-group").html(str2);
		},
		error: function(){alert("error");}
	});
}
function modifyPost(){
	var userId = $(".userId").val();
	var userName = $(".userName").val();
	var userEmail = $(".userEmail").val();
	var userAddr1 = $(".address_input_1").val();
	var userAddr2 = $(".address_input_2").val();
	var userAddr3 = $(".address_input_3").val();
	$.ajax({
		type:'PATCH',
		url:'/user/modify',
		headers : {"content-type": "application/json"},
		data: JSON.stringify({userId:userId,userName:userName,userEmail:userEmail,userAddr1:userAddr1,userAddr2:userAddr2,userAddr3:userAddr3}),
		success:function(list){
			alert("수정 완료");
			getUserInfo();
		},
		error: function(){alert("error");
		}
			
	});
}
function getUserInfo(className){
	$.ajax({
		type:'GET',
		url:'/user/userInfo',
		success:function(data){
			var str = '<table class="py-5 mt-5">';
			str +=' <colgroup>';
			str +='<col width="25%">';
			str +='<col width="*">';
			str +='</colgroup>';
			str +='<tbody>';
			str += '<tr>';
			str += '<th>아이디</th>';
			str += '<td>';
			str +=data.userId;
			str +='</td>';
			str +='</tr>';
			str += '<tr>';
			str += '<th>이름</th>';
			str += '<td>';
			str +=data.userName;
			str +='</td>';
			str +='</tr>';
			str += '<tr>';
			str += '<th>이메일</th>';
			str += '<td>';
			str +=data.userEmail;
			str +='</td>';
			str +='</tr>';
			str += '<tr>';
			str += '<th>주소</th>';
			str += '<td>';
			str +=data.userAddr1+" "+data.userAddr2+"<br>"+data.userAddr3;
			str +='</td>';
			str +='</tr>';
			str +='</tbody>';
			str +='</table';
			var str2 ='<div class="button-group">';
			str2+=	'<button type="button" class="btn btn-secondary" onclick="modify()" >회원정보수정</button>';
			str2+=	'</div>';	


				 
			$("#myPage").html(str);
			$("#button-group").html(str2);
		},
		error: function(){alert("error");}
	});
	$(".address_btn").css('backgroundColor', '#555');
	/* 지정 색상 변경 */
		$(".address_btn_"+className).css('backgroundColor', '#3c3838');
}
function execution_daum_address(){
	
    new daum.Postcode({
        oncomplete: function(data) {
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분입니다.
            
            // 각 주소의 노출 규칙에 따라 주소를 조합한다.
            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
            var addr = ''; // 주소 변수
            var extraAddr = ''; // 참고항목 변수
            //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
            if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                addr = data.roadAddress;
            } else { // 사용자가 지번 주소를 선택했을 경우(J)
                addr = data.jibunAddress;
            }
            // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
            if(data.userSelectedType === 'R'){
                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraAddr !== ''){
                    extraAddr = ' (' + extraAddr + ')';
                }
                // 주소변수 문자열과 참고항목 문자열 합치기
      			addr += extraAddr;
            
            } else {
                addr += ' ';
            }
            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            $(".address_input_1").val(data.zonecode);
            //$("[name=memberAddr1]").val(data.zonecode);	// 대체가능
            $(".address_input_2").val(addr);
            //$("[name=memberAddr2]").val(addr);			// 대체가능
            // 상세주소 입력란 disabled 속성 변경 및 커서를 상세주소 필드로 이동한다.
            $(".address_input_3").attr("readonly",false);
            $(".address_input_3").focus();
            
        }
    }).open();  
}
$("#reviewsubmit").click(function(){
	var pno = $("#pno").val();
	var orderno = $("#orderno").val();
	var comment = $("#comment").val();
	$.ajax({
		type:'POST',
		url:'/review/'+orderno,
		headers : {"content-type": "application/json"},
		data: JSON.stringify({pno:pno,comment:comment}),
		success:function(list){
			getUserOrder(2);
			$('#testModal').modal("hide");
		},
		error: function(){alert("error");
		}
			
	});
});
$("#myPage").on("click","#writeBtn",function(){
	let pno = $(this).closest("tr").attr("data-pno");
	let orderno = $(this).parent().attr("data-orderno");
	$("#pno").val(pno);
	$("#orderno").val(orderno);
	$('#testModal').modal("show");
});
</script>
</body>
</html>