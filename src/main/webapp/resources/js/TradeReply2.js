console.log("댓글 모듈 ......")

var replyService={};

var replyService = (function(){
	
	//댓글 등록
	function add2(reply2, callback, error){
		console.log("add 댓글........");
		console.log("reply2:"+reply2.reply2);
		console.log("replyer2:"+reply2.replyer2);
		console.log("bno2:"+reply2.bno2);
		
		$.ajax({
			type:'post',
			url:'/tradeReplies/new2',
			data:JSON.stringify(reply2),
			contentType:"application/json;charset=utf-8",
			success:function(result,status,xhr){
				if(callback){
					callback(result);					
				}
			},
			error:function(xhr,status,er){
				if(error){
					error(er);					
				}
			}
		});
	}
	
	//댓글 목록
	function getList2(param, callback, error){
		
		var tradeBno2 = param.tradeBno2;
		var page = param.page || 1;
		
		$.getJSON("/tradeReplies/pages2/"+tradeBno2+"/"+page+".json",
			function(data){
				if(callback){
					callback(data.replyCnt2, data.list2);
				}
			}).fail(function(xhr, status, err){
				if(error){
					error();
				}
			});
	}
	
	//댓글 삭제
	function remove2(rno2, callback, error){
		$.ajax({
			type : 'delete',
			url : '/tradeReplies/delete/' + rno2,
			success : function(deleteResult, status, xhr){
				if(callback){
					callback(deleteResult);
				}
			},
			error : function(xhr, status, er){
				if(error){
					error(er);
				}
			}
		});
	}
	
	//댓글 수정
	function update2(reply2, callback, error){
		console.log("RNO2: " + reply2.rno2)
		
		$.ajax({
			type : 'put',
			url : '/tradeReplies/update2/' + reply2.rno2,
			data : JSON.stringify(reply2),
			contentType : "application/json; charset=utf-8",
			success : function(result, status, xhr){
				if(callback){
					callback(result);
				}
			},
			error : function(xhr, status, er){
				if(error){
					error(er);
				}
			}
		});
	}
	
	//댓글 조회
	function get2(rno2, callback, error){
		$.get("/tradeReplies/pages2/"+rno2+".json",function(result){
			if(callback){
				callback(result);
			}
		}).fail(function(xhr, status, err){
			if(error){
				error();
			}
		});
	}
	
	//시간 처리
	function displayTime(timeValue){
		
		var today=new Date();
		var dateObj=new Date(timeValue);
		var str="";
				
		var yy=dateObj.getFullYear();
		var mm=dateObj.getMonth()+1;
		var dd=dateObj.getDate();
		
		var yy2=today.getFullYear();
		var mm2=today.getMonth()+1;
		var dd2=today.getDate();
		
		if(yy==yy2 && mm==mm2 && dd==dd2){
			var hh=dateObj.getHours();
			var mi=dateObj.getMinutes();
			var ss=dateObj.getSeconds();
			
			return [(hh>9?'':'0')+hh,':',
					(mi>9?'':'0')+mi,':',
					(ss>9?'':'0')+ss].join('');
		}else{
						
			return [yy,'/',(mm>9?'':'0')+mm,'/',
						   (dd>9?'':'0')+dd].join('');
		}
	}
	
	return{
		add2 : add2,
		getList2 : getList2,
		remove2 : remove2,
		update2 : update2,
		get2 : get2,
		displayTime : displayTime
	};
})();