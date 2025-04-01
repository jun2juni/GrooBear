<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%--해당 파일에 타이틀 정보를 넣어준다--%>
<c:set var="title" scope="application" value="메인" />

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
					<div class="card-style">
			            <!-- 검색 -->
			            <nav class="navbar navbar-light" style="margin-bottom: 20px; flex-wrap: nowrap;">
			                <div style="flex-wrap: nowrap;">
			                    <input class="dataTable-input" style="width: 200px;" placeholder="Search" aria-label="Search" id="schName" >
							    <button class="btn btn-outline-dark" onclick="fSch()" >검색</button>
			                </div>
			            </nav>
			            <div style="float: left;">
			            	<button id="allBtn" class="main-btn dark-btn rounded-full btn-hover btn-sm" style="font-size: 0.7rem; padding: 0.2rem 0.4rem;" onclick="openTree();">전체</button>
			            </div>
			            <div style="float: right;">
			            	<button id="insBtn" class="main-btn dark-btn rounded-full btn-hover btn-sm" style="font-size: 0.7rem; padding: 0.2rem 0.4rem;" onclick="deptInsert();">부서등록</button>
			            </div>
			            <!-- 조직도 -->
			            <div id="jstree" style="clear: both;margin-top: 20px;"></div>
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
</main>
<c:import url="../layout/prescript.jsp" />
<script type="text/javascript">
   function deptClick(e, data) {
   		// 클릭한게 사원일때
          if(data.node.original.deptYn == false) {
          	fetch("/emplDetail?emplNo=" + data.node.id, {
          		method : "get",
	           	headers : {
	           		"Content-Type": "application/json"
	           	}
          	})
          	.then(resp => resp.text())
          	.then(res => {
          		
          		console.log("사원상세정보 : " , res);
          		$("#emplDetail").html(res);
          	})
          }
          // 클릭한게 부서일때
          if(data.node.original.deptYn == true){
          	fetch("/deptDetail?cmmnCode=" + data.node.id, {
          		method : "get",
           	headers : {
           		"Content-Type": "application/json"
           	}
          	})
          	.then(resp => resp.text())
          	.then(res => {
          		console.log("부서상세정보 : " , res);
          		$("#emplDetail").html(res);
          		
          	// 부서 삭제 - 관리자만 가능
    		$(function(){
    			$("#deptDeleteBtn").on("click", function(){
	   				swal({
	   					  title: "정말 삭제하시겠습니까?",
	   					  icon: "warning",
	   					  buttons: true,
	   					  dangerMode: true,
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
							 swal("식제되었습니다.]", {
	    					      icon: "success",
    					     })
    					     .then((res)=>{
    					    	location.href = "/orglist";
    					     })
    					  } else {
    					    swal("취소되었습니다.");
    					  }
    					});
    				}); // end function
    			}); // end del function
	          	})
	          }
		} // end function

	
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
       		console.log("부서등록 : " , res);
       		$("#emplDetail").html(res);
       		
       		$("#insertBtn").on("click", function(){
       			swal("등록되었습니다.")
       			.then((value)=>{
       				$("#depInsertForm").submit();
       			});
       			});
       	 	
       	})
	} 
		
   
   	let treeOpen = false;
   	
    function openTree(){
		if(!treeOpen){
			// 열기
			$("#jstree").jstree("open_all");
			treeOpen = true;
			$('#allBtn').html("닫기");
			
		}else{
			// 닫기
			$("#jstree").jstree("close_all");
			treeOpen = false;
			$('#allBtn').html("전체");
		}
	}
   	
   	// 비동기로 조직도 데이터 가져오기
   	fetch("/organization", {
          		method : "get",
           	headers : {
           		"Content-Type": "application/json"
           	}
          	})
          	.then(resp => resp.json())
          	.then(res => {
          		console.log("냐냐냐냐 : " , res);
          		
          		console.log("부서! : ", res.deptList);
          		const dep = res.deptList;
          		const emp = res.empList;
          		
          		const json = new Array();
  		    	
  		    	for(let i = 0; i < dep.length; i++) {
        				json.push({
        					"id": dep[i].cmmnCode,
        					"parent": dep[i].upperCmmnCode,
        					"text": dep[i].cmmnCodeNm,
        					"icon" : "/assets/images/organization/depIcon.svg",
        					"deptYn" : true
       					})
        			}
  		    	
  		    	for(let i = 0; i < emp.length; i++) {
        				json.push({
        					"id": emp[i].emplNo,
        					"parent": emp[i].deptCode,
        					"text": emp[i].emplNm,
        					"icon" : "/assets/images/organization/employeeImg.svg",
        					"deptYn" : false
       					})
        			}
  		    	fnCreatejsTree(json);
          	});
   
       // 검색기능
       function fSch() {
           console.log("검색");
           $('#jstree').jstree(true).search($("#schName").val());
       }
       
       function fnCreatejsTree(jsonData){
        $("#jstree").jstree({
            "plugins": ["search", "dnd"],
            'core': 
	            {
	                'data': jsonData,
	                "check_callback" : true
	            }
        })
       };

       $('#jstree').on("changed.jstree", function (e, data) {
           console.log(data.selected);
       });

       // node 열렸을때
       $('#jstree').on("open_node.jstree", function (e, data) {
           console.log("노드open", data.node);
       });
       
       $('#jstree').on("select_node.jstree", deptClick);
   </script>
</body>
</html>
