console.log("댓글 모듈 ......")

var replyService={};

var replyService = (function(){
	
	//댓글 등록
	function add(reply, callback, error){
		console.log("add 댓글........");
		console.log("reply:"+reply.reply);
		console.log("replyer:"+reply.replyer);
		console.log("bno:"+reply.bno);
		
		$.ajax({
			type:'post',
			url:'/tradeReplies/new',
			data:JSON.stringify(reply),
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
	function getList(param, callback, error){
		
		var tradeBno = param.tradeBno;
		var page = param.page || 1;
		
		$.getJSON("/tradeReplies/pages/"+tradeBno+"/"+page+".json",
			function(data){
				if(callback){
					callback(data.replyCnt, data.list);
				}
			}).fail(function(xhr, status, err){
				if(error){
					error();
				}
			});
	}
	
	//댓글 삭제
	function remove(rno, callback, error){
		$.ajax({
			type : 'delete',
			url : '/tradeReplies/' + rno,
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
	function update(reply, callback, error){
		console.log("RNO : " + reply.rno)
		
		$.ajax({
			type : 'put',
			url : '/tradeReplies/' + reply.rno,
			data : JSON.stringify(reply),
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
	function get(rno, callback, error){
		$.get("/tradeReplies/"+rno+".json",function(result){
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
		add : add,
		getList : getList,
		remove : remove,
		update : update,
		get : get,
		displayTime : displayTime
	};
})();