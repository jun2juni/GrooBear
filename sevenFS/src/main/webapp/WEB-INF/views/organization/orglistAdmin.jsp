<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>




<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<%--해당 파일에 타이틀 정보를 넣어준다--%>
<c:set var="title" scope="application" value="메인" />

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
				<div class="card-style">
					<%@ include file="orgList.jsp" %>
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
	</section>
  <%@ include file="../layout/footer.jsp" %>
</main>
<%@ include file="../layout/prescript.jsp" %>
</body>
</html>


<script>
// 부서등록 - 관리자만 가능
function deptInsert(){
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
}

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
       
   
	// 삭제 클릭한 경우
	 $(function(){
	     $("#emplDeleteBtn").on("click", function(){
        swal({
            text: "정말 삭제하시겠습니까?",
            icon: "warning",
            showCancelButton: true,
            confirmButtonText: "Select Patient?",
            cancelButtonText: "Speed Case?"
            })
            .then((willDelete) => {
              if (willDelete) {
                swal("식제되었습니다.", {
                  icon: "success",
                })
                .then((res)=>{
                    location.href = "/emplDelete?emplNo=" + data.node.id;
                  })
              } else {
                swal("취소되었습니다.");
              }
            });
	     })
	     });
	 });
 }
 
//부서 클릭 한 경우
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
    	  swal({
              title: "정말 삭제하시겠습니까?",
              icon: "warning",
              buttons : {
            	  cancle : {
            		  text : '삭제 취소',
            		  value : false,
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
              swal("식제되었습니다.", {
                icon: "success",
              })
                .then((res)=>{
                  location.href = "/orglistAdmin";
                })
            } else {
              swal("취소되었습니다.");
            }
          });
      }); // end function
    }); // end del function
  })
}
 


		
</script>