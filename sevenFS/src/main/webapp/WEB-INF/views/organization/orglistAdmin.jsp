<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ page import="org.springframework.security.core.context.SecurityContextHolder" %>
<%@ page import="org.springframework.security.core.Authentication" %>


<%--해당 파일에 타이틀 정보를 넣어준다--%>
<c:set var="title" scope="application" value="조직관리" />
<c:set var="copyLight" scope="application" value="by 박호산나" />

<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8" />
 	<meta name="viewport"
		  content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0"/>
	<meta http-equiv="X-UA-Compatible" content="ie=edge" />
	<title>${title}</title>
  <%@ include file="../layout/prestyle.jsp" %>
</head>
<body>
<%@ include file="../layout/sidebar.jsp" %>
<main class="main-wrapper">
  <%@ include file="../layout/header.jsp" %>
	<section class="section">
		<div class="container-fluid">
			<div class="row">
			<div class="col-4">
				<c:import url="../organization/searchBar.jsp"></c:import>
				<div class="card-style overflow-scroll mt-15" style="height: 95%;">
					<c:import url="./orgList.jsp"></c:import>
				</div>
		 	</div>
		 	
		 	<!-- 사원상세 페이지 -->
		  <div class="col-8">
			<div id="emplDetail" style="text-align: center;">
			  <p id="employeeDetail" style="margin-top: 150px;">
				<span  class="material-symbols-outlined">group_add</span>
					변경할 부서와 사원을 선택해주세요.
			  </p>
			</div>
		  </div>
		  </div>
		</div>
		
		<!-- 부서등록 Modal -->
		<div class="modal fade" tabindex="-1" id="deptInsertModal" aria-labelledby="exampleModalLabel" aria-hidden="true"> 
		  <div class="modal-dialog modal-lg">
		    <div class="modal-content">
		      <div class="modal-header">
		        <h5 class="modal-title"></h5>
		        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
		      </div>
		      <div class="modal-body" id="deptInsertModalBody">
		        <c:import url="./depInsert.jsp"></c:import>
		    </div>
		  </div>
		</div>
		</div>
		<!-- 부서등록 Modal -->
		
		
	</section>
  <%@ include file="../layout/footer.jsp" %>
</main>
<%@ include file="../layout/prescript.jsp" %>
</body>
</html>


<script>

$('#jstree').on('ready.jstree', function() {
	<%
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		String username = auth.getName(); // 사용자 이름 가져오기
	%>
	console.log('현재사용자 : ' , <%= username %>);
	
	// 이름 검색 디폴트를 위한 사원 상세 정보 가져오기
	fetch('/emplDetailData?emplNo='+<%= username %>,{
		 method : 'get',
   	 headers : {
   		 "Content-Type": "application/json"
   	 }
	})
	.then(resp => resp.json())
	.then(res => {
		console.log(res.empDetail);
		
		const emplDetail = res.empDetail;
		const emplNm = emplDetail.emplNm;
		
		if(emplNm){
			
			const schName = document.getElementById("schName");
			schName.value = emplNm;

			const input = document.getElementById("schName");
			
			const fakeEnterEvent = new KeyboardEvent("keydown", {
		          code: "Enter",
		          key: "Enter",
		          bubbles: true
		        });
			input.dispatchEvent(fakeEnterEvent);
			$('#schName').focus();
		}
		
	})
})

// 부서등록 - 모달
function deptInsert(){
	fetch('/depInsert', {
		method : 'get',
		headers : {
            "Content-Type": "application/json"
        }
	})
	.then(resp => resp.text())
	.then(res => {
		console.log("부서 정보 : " , res);
		$('#deptInsertModalBody').html(res);
		$('#deptInsertModal').show();
		
		$("#insertBtn").on("click", function(){
        	
       	 // 입력 필드 가져오기
           var departmentName = document.getElementById("cmmnCodeNm").value.trim();
           var departmentDesc = document.getElementById("cmmnCodeDc").value.trim();

           // 유효성 검사
           if (departmentName === "") {
               swal("부서명을 입력하세요.");
               document.getElementById("cmmnCodeNm").focus();
               return;
           }
           
           if (departmentDesc === "") {
           	swal("부서설명을 입력하세요.");
               document.getElementById("cmmnCodeDc").focus();
               return;
           }
       	if(departmentName != "" && departmentDesc != ""){
       		swal({
       			icon : 'success',
       			text : '등록되었습니다.',
       			buttons : {
       				confirm : {
       					text : '확인',
       					value : true
       				}
       			}
       		})
            .then((value)=>{
                $("#depInsertForm").submit();
            });
       	}
       });
	})
}


// 부서등록 - 관리자만 가능
/* function deptInsert(){
    fetch("/depInsert", {
        method : "get",
        headers : {
            "Content-Type": "application/json"
        }
    })
        .then(resp => resp.text())
        .then(res => {
            //console.log("부서등록 : " , res);
            $("#emplDetail").html(res);
            
            $("#insertBtn").on("click", function(){
            	
            	 // 입력 필드 가져오기
                var departmentName = document.getElementById("cmmnCodeNm").value.trim();
                var departmentDesc = document.getElementById("cmmnCodeDc").value.trim();

                // 유효성 검사
                if (departmentName === "") {
                    swal("부서명을 입력하세요.");
                    document.getElementById("cmmnCodeNm").focus();
                    return;
                }
                
                if (departmentDesc === "") {
                	swal("부서설명을 입력하세요.");
                    document.getElementById("cmmnCodeDc").focus();
                    return;
                }
            	if(departmentName != "" && departmentDesc != ""){
            		swal("등록되었습니다.")
                    .then((value)=>{
                        $("#depInsertForm").submit();
                    });
            	}
            });
        })
} */

// 사원 등록
function emplInsert(){
	location.href = "/emplInsert";
}

// 사원상세
function clickEmp(data) {
    fetch("/emplDetail?emplNo=" + data.node.id, {
      method : "get",
      headers : {
        "Content-Type": "application/json"
      }
    })
     .then(resp => resp.text())
     .then(res => {

       //console.log("사원상세정보 : " , res);
       $("#emplDetail").html(res);
       
   
	// 사원 삭제 클릭한 경우
	  $(function(){
	     $("#emplDeleteBtn").on("click", function(){
	    	 swal({
                 title: "정말 삭제하시겠습니까?",
                 icon: "warning",
                 buttons: {
                 	cancle : {
                 		text : '삭제 취소',
                 		value : false
                 	},
                 	confirm : {
                 		text : '확인',
                 		value : true
                 	}
                 },
                 dangerMode: true
               })
            .then((willDelete) => {
              if (willDelete) {
                swal("삭제되었습니다.", {
                  icon: "success",
                  buttons: {
	           		    confirm: {
	           		      text: "확인",
	           		      value: true
	           		    }
           		    }
                 })
                .then((res)=>{
                    location.href = "/emplDelete?emplNo=" + data.node.id;
                  })
              } else {
                swal({
                	text : '취소되었습니다.',
                	buttons : {
                		confirm : {
                			text : '확인',
                			value : true
                		}
                	}
                })
                ;
              }
            });
	     })
	     });
	 });
 }
 
//부서 클릭 한 경우
function clickDept(data) {
   console.log('data : ' , data.node.children_d);
  fetch("/deptDetail?cmmnCode=" + data.node.id, {
    method : "get",
    headers : {
      "Content-Type": "application/json"
    }
  })
  .then(resp => resp.text())
  .then(res => {
    //console.log("부서상세정보 : " , res);
    $("#emplDetail").html(res);

    // 부서 삭제 - 관리자만 가능
    $(function(){
      $("#deptDeleteBtn").on("click", function(){
    	  // 하위부서팀이나 사원이 있을경우 삭제 안됨
    	  if(data.node.children.length > 0 || data.node.children_d > 0){
    		  swal({
					 text : '소속된 사원이 있어 부서 삭제가 불가능합니다.',
					 buttons : {
						 confirm : {
							 text : '확인',
							 value : true
						 }
					 }
				 })
    		  .then(() => {
	    		  location.href = '/orglistAdmin';
    		  })
    	  }
    	  else{
	    	  swal({
	              title: "정말 삭제하시겠습니까?",
	              icon: "warning",
	              buttons : {
	            	  cancle : {
	            		  text : '삭제 취소',
	            		  value : false
	            	  },
	            	  confirm : {
	            		  text : '확인',
	            		  value : true
	            	  }
	              }
	              })
	          .then((willDelete) => {
	            if (willDelete) {
	              fetch("deptDelete?cmmnCode="+ data.node.id,{
	                method : "get",
	                headers : {
	                  "Content-Type": "application/json"
	                }
	              })
	                .then(resp => resp.text())
	                .then(res => {
	                  //console.log("삭제성공? : " , res);
	                })
	              swal("삭제되었습니다.", {
	                icon: "success",
	              })
	                .then((res)=>{
	                  location.href = "/orglistAdmin";
	                })
	            } else {
	            	swal({
	             		  text : "취소 되었습니다.",
	             		  icon : "info",
	             		  buttons : {
	             		    confirm : {
	             		      text : '확인',
	             		      value : true
	             		    }
	             		  }
	             		});
	            	}
	          });
    	  }
      }); // end function
    }); // end del function
  })
}


//엔터치면 검색 + 상세보기 창 열림
function fSchEnder(e) {
    if (e.code === "Enter") {
       $('#jstree').jstree(true).search($("#schName").val());
       
       let empList = "";
       let inputName = $("#schName").val();
       let schEmplNo = "";
       let schDeptNo = "";
       
       //console.log(inputName);
       
       // 검색한 사원의 사원번호 넘겨주기
       fetch('/organization',{
      	 method : 'get',
      	 headers : {
      		 "Content-Type": "application/json"
      	 }
       })
       .then(resp => resp.json())
		 .then(res => {
			 //console.log(res);
		 
			 // 전체사원 목록
			 empList = res.empList;
			 //console.log('전체사원 : ' , empList);
			 
			 // 전체부서 목록
			 deptList = res.deptList;
			 //console.log('전체 부서 : ' , deptList);
			 
			 let found = false;
			 
			 // 사원 검색했을경우
			 empList.forEach(emp => {
				 if(emp.emplNm === inputName){
					 found = true;
					 
					 schEmplNo = emp.emplNo;
					 
					 let emplNo = schEmplNo;
					 //console.log('검색한 사원번호 : ' , emplNo);
					 
					 fetch('/emplDetail?emplNo='+emplNo,{
			        	 method : 'get',
			        	 headers : {
			        		 "Content-Type": "application/json"
			        	 }
			         })
			         .then(resp => resp.text())
			         .then(res => {
			        	 //console.log('엔터치고 받은 결과 : ' , res);
			        	 $("#emplDetail").html(res);
			         })
				 }
			 })
			
	         // 부서 검색했을경우
	         deptList.forEach(dep => {
	        	 if(dep.cmmnCodeNm === inputName){
	        		 found = true;
	        		 
	        		 schDeptNo = dep.cmmnCode;
	        		 
		        	 let deptNo = schDeptNo;
		        	 
		        	 fetch("/deptDetail?cmmnCode=" + deptNo, {
		        	      method : "get",
		        	      headers : {
		        	        "Content-Type": "application/json"
		        	      }
		        	    })
	        	       .then(resp => resp.text())
	        	       .then(res => {
	        	        //console.log("부서상세정보 : " , res);
	        	        $("#emplDetail").html(res);
		         })
	        	 }
      	 })
      	 
      	 if(!found){
				 swal({
					 text : '해당 사원을 찾을 수 없습니다.',
					 buttons : {
						 confirm : {
							 text : '확인',
							 value : true
						 }
					 }
				 })
			 }
	
		 })
    }
}
 


		
</script>