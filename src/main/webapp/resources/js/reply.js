console.log("댓글 Module.....");

var replyService={};

var replyService=(function(){
	
	function add(reply,callback){
		console.log("add 댓글........");
		console.log("reply:"+reply.reply);
		console.log("replyer:"+reply.replyer);
		console.log("bno:"+reply.bno);
		
		$.ajax({
			type:'post',
			url:'/replies/new',
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
	
	function getList(param,callback,error){
		var bno=param.bno;
		
		console.log("bno:"+bno);
		
		var page=param.page || 1;
		
		$.getJSON("/replies/pages/"+bno+"/"+page+".json",
			function(data){
				if(callback){
					callback(data.replyCnt,data.list);
				}
			}).fail(function(xhr,status,err){
				if(error){
					error();
				}
			});
	}
	
	
	function remove(rno,callback,error){
		$.ajax({
			type:'delete',
			url:'/replies/'+rno,			
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
	
	function update(reply,callback,error){
		console.log("update 댓글번호:"+reply.rno);
				
		$.ajax({
			type:'put',
			url:'/replies/'+reply.rno,
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
	
	function get(rno,callback,error){				
		console.log("rno:"+rno);
				
		$.get("/replies/"+rno+".json",
			function(result){
				if(callback){
					callback(result);
				}
			}).fail(function(xhr,status,err){
				if(error){
					error();
				}
			});
	}
	
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
	
	return {
		add:add,
		getList:getList,
		remove:remove,
		update:update,
		get:get,
		displayTime:displayTime
	};
})();
