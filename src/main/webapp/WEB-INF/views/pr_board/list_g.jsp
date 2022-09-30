<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@include file="../includes/header.jsp" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

          <!-- Content wrapper -->
          <div class="content-wrapper">
            <!-- Content -->

            <div class="container-xxl flex-grow-1 container-p-y">
              <h4 class="fw-bold py-3 mb-4">가게홍보게시판 </h4>

              <!-- Basic Bootstrap Table -->
              <div class="card">
              <div class="demo-inline-spacing">
                       	<button type="button" class="btn rounded-pill btn-outline-primary">
                            <a href="/pr_board/list_r">		
                        		식당
                        	</a>
                        </button>
                        <button type="button" class="btn rounded-pill btn-outline-primary">
                            <a href="/pr_board/list_c">		
                        		카페
                        	</a>
                        </button>
                        <button type="button" class="btn rounded-pill btn-outline-primary">
                            <a href="/pr_board/list_l">		
                        		생활
                        	</a>
                        </button>
                        </button>
                        <button type="button" class="btn rounded-pill btn-outline-primary">
                            <a href="/pr_board/list_b">		
                        		뷰티
                        	</a>
                        </button>
                        </button>
                        <button type="button" class="btn rounded-pill btn-outline-primary">
                            <a href="/pr_board/list_g">		
                        		기타
                        	</a>
                        </button>                                               
                        </button>
                       
                        
                      </div>
                <h5 class="card-header">기타&nbsp;&nbsp;&nbsp;&nbsp;
                <sec:authorize access="hasRole('ROLE_CEO')">
                <button id="regBtn" type="button" class="btn btn-sm btn-primary">내 가게 홍보하기</button></h5>
                </sec:authorize></h5>
                </h5>
                      
                  <div class='row'>
                	<div class="col-lg-12">
                	
                	<form id='searchForm' action="/pr_board/list_g" method="get">
                		<select name='type'>
                			<option value="" ${pageMaker.cri.type==null?'selected':'' }>--</option>
                			<option value="T" ${pageMaker.cri.type eq 'T'?'selected':'' }>제목</option>
                			<option value="C" ${pageMaker.cri.type eq 'C'?'selected':'' }>내용</option>
                			<option value="W" ${pageMaker.cri.type eq 'W'?'selected':'' }>작성자</option>
                			<option value="TC" ${pageMaker.cri.type eq 'TC'?'selected':'' }>제목 or 내용</option>
                			<option value="TW" ${pageMaker.cri.type eq 'TW'?'selected':'' }>제목 or 작성자</option>
                			<option value="TWC" ${pageMaker.cri.type eq 'TWC'?'selected':'' }>제목 or 내용 or 작성자</option>
                		</select>
                	
                		<input type='text' name='keyword' value="${pageMaker.cri.keyword }">
                		<input type='hidden' name='pageNum' value='${pageMaker.cri.pageNum }'>
                		<input type='hidden' name='amount' value='${pageMaker.cri.amount }'>
                		<button class='btn rounded-pill btn-dark'>검색</button>
                	</form>
                	
                	</div>
                </div>                           
                <div class="table-responsive text-nowrap">
                  <table class="table">
					<thead>
                      <tr>
                        <th>게시판</th>
                        <th>가게이름</th>
                        <th>소개</th>
                        <th>위치</th>
                        <th>등록일</th>
                      </tr>
                    </thead>
					<c:forEach items="${list}" var="board">
						
                    <tr>
                    	<td><span class="badge bg-secondary"><c:out value="${board.cgo}"/></span></td>
                    	<td><a class='move' href='<c:out value="${board.bno}"/>'><c:out value="${board.title}"/>
                    	</a></td>
                    	<td><c:out value="${board.front}"/></td>
                    	<td><c:out value="${board.map}"/></td>
                    	<td><fmt:formatDate pattern="yyyy-MM-dd" value="${board.updateDate}"/></td>
                    </tr>
		                
                    </c:forEach>
                  </table>                  
                </div>                                   
              </div>
              
             	<div class="demo-inline-spacing">
                        <!-- Basic Pagination -->
                        <nav aria-label="Page navigation">
                          <ul class="pagination">
                          
                          <c:if test="${pageMaker.prev}">
                            <li class="page-item prev">
                              <a class="page-link" href="${pageMaker.startPage-1}">prev</a>
                            </li>
                          </c:if>
                          
                          <c:forEach var="num" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
                            <li class="page-item ${pageMaker.cri.pageNum==num?"active":""}" >
                              <a class="page-link" href="${num}">${num}</a>
                            </li>
                          </c:forEach>
                            
                          <c:if test="${pageMaker.next}">
                            <li class="page-item next">
                              <a class="page-link" href="${pageMaker.endPage + 1}">next</a>
                            </li>
                          </c:if>
                          
                          </ul>
                        </nav>
                        <!--/ Basic Pagination -->
                      </div>
                      
              		 <form id='actionForm' action="/pr_board/list_r" method='get'>
              		 	<input type='hidden' name='pageNum' value='${pageMaker.cri.pageNum }'>
              		 	<input type='hidden' name='amount' value='${pageMaker.cri.amount }'>
              		 	<input type='hidden' name='type' value='${pageMaker.cri.type }'>
              		 	<input type='hidden' name='keyword' value='${pageMaker.cri.keyword }'>
              		 </form>
              
                     <div class="modal fade" id="basicModal" tabindex="-1" aria-hidden="true">
                          <div class="modal-dialog" role="document">
                            <div class="modal-content">
                              <div class="modal-header">
                                <h5 class="modal-title" id="exampleModalLabel1">Modal title</h5>
                                <button
                                  type="button"
                                  class="btn-close"
                                  data-bs-dismiss="modal"
                                  aria-label="Close"
                                ></button>
                              </div>
                              <div class="modal-body">
                                	처리가 완료되었습니다.
                              </div>
                              <div class="modal-footer">
                                <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">
                                  Close
                                </button>                               
                              </div>
                            </div>
                          </div>
                        </div>
             	
             </div>           
            </div>
                 
              

              
              
              
                            		
              <script type="text/javascript">
              
              	$(document).ready(function(){
              		var result = '<c:out value="${result}"/>';
              		
              		checkModal(result);
              		
              		history.replaceState({},null,null);
              		
              		function checkModal(result){
                  		if(result==='' || history.state){
                  			return;              			
                  		}
                  		if(parseInt(result)>0){
                  			$(".modal-body").html("게시글"+parseInt(result)+"번이 등록되었습니다.");
                  		}
                  		$("#basicModal").modal("show");
                  	}
              		
              	$('#regBtn').on("click",function(){
              		self.location="/pr_board/register";
              	});
              		var actionForm=$("#actionForm");
              		$(".page-item a").on("click", function(e){
              			e.preventDefault();
              			
              			console.log('click');
              			
              			actionForm.find("input[name='pageNum']").val($(this).attr("href"));
              			actionForm.submit();
              		});
              	
              	$(".move").on("click",function(e){
              		e.preventDefault();
              		
              		actionForm.append("<input type='hidden' name='bno' value='"+$(this).attr("href")+"'>");
              		actionForm.attr("action","/pr_board/get");
              		actionForm.submit();
              	});
              	
            	var searchForm=$('#searchForm');
            	
            	$('#searchForm button').on('click',function(e){
            		e.preventDefault();
            		
            		if(!searchForm.find('option:selected').val()){
            			alert('검색종류를 선택하세요');
            			return false;
            		}
            		if(!searchForm.find("input[name='keyword']").val()){
            			alert('키워드를 입력하세요');
            			return false;
            		}
            		
            		searchForm.find("input[name='pageNum']").val("1");		
            		searchForm.submit();
            	});
              	
              });
              
              
              </script>
              
<%@include file="../includes/footer.jsp" %>                                