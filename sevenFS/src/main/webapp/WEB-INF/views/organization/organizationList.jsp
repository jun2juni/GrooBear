<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import="org.springframework.security.core.context.SecurityContextHolder" %>
<%@ page import="org.springframework.security.core.Authentication" %>

<%--해당 파일에 타이틀 정보를 넣어준다--%>
<c:set var="title" scope="application" value="조직도" />
<c:set var="copyLight" scope="application" value="by 박호산나" />

<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8" />
	<meta
		  name="viewport"
		  content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0"
	/>
	<meta http-equiv="X-UA-Compatible" content="ie=edge" />
	<title>${title}</title>
	<c:import url="../layout/prestyle.jsp" />
</head>
<body>
<c:import url="../layout/sidebar.jsp" />
<main class="main-wrapper">
	<c:import url="../layout/header.jsp" />
	<section class="section">
	  <div class="container-fluid">
	  	<div class="row">
		 <div class="col-4">
			<c:import url="../organization/searchBar.jsp"></c:import>
			<div class="card-style overflow-scroll mt-15" style="height: 95%;">
			<c:import url="../organization/orgList.jsp" />	
			</div>
	 	</div>
		  			
		  <!-- 사원상세 페이지 -->
		  <div class="col-8">
			<div id="emplDetail" style="text-align: center;">
			  <p id="employeeDetail" style="margin-top: 150px;">
				<span  class="material-symbols-outlined">person_check</span>
				사원을 선택하면 상세조회가 가능합니다.
			  </p>
			</div>
		  </div>
		</div>
	  </div>
	</section>
	<c:import url="../layout/footer.jsp" />
	<c:import url="../layout/prescript.jsp" />
	
</main>

<script type="text/javascript">
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



  // 사원 클릭 한 경우
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
      })
  }
  
  // 부서 클릭 한 경우
  function clickDept(data) {
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
        	  	if($('.jstree-children').length > 0){
        	  		swal('소속된 사원이 있어 부서 삭제가 불가능합니다.')
        	  		.then(()=>{
        	  			location.href = '/orglistAdmin';	
        	  		})
        	  	}	
          else{
            	swal({
                    title: "정말 삭제하시겠습니까?",
                    icon: "warning",
                    confirmButtonColor : '#d33',
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
                  fetch("deptDelete?cmmnCode="+ data.node.id,{
                    method : "get",
                    headers : {
                      "Content-Type": "application/json"
                    }
                  })
                    .then(resp => resp.text())
                    .then(res => {
                      console.log("삭제성공? : " , res);
                    })
                  swal("삭제되었습니다.", {
                    icon: "success"
                  })
                    .then((res)=>{
                      location.href = "/orglistAdmin";
                    })
                } else {
                	swal({
               		  title: "취소되었습니다.",
               		  icon: "info",
               		  buttons: {
               		    confirm: {
               		      text: "확인",
               		      value: true
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
  
  // 엔터치면 검색 + 상세보기 창 열림
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
				 swal('해당 사원을 찾을 수 없습니다.')
				 .then((result) => {
					 $("#schName").focus();
				 })
			 }
	
		 })
      }
  }
  

  

 </script>


</body>
</html>
