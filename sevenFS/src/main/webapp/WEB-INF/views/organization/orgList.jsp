<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!-- 검색 -->
<div>
    <div class="input-group rounded mb-3">
    	<sec:authentication property="principal.empVO" var="emp" />
        <input type="search" class="form-control rounded" placeholder="이름 입력" aria-label="Search"
               aria-describedby="search-addon" id="schName"
               onkeydown="fSchEnder(event)"
        />
        <span class="input-group-text border-0" id="search-addon"
              onclick="fSch()">
            <i class="fas fa-search"></i>
        </span>
    </div>
    
  	<div class="d-flex justify-content-between">
       <button type="button" id="allBtn" class="main-btn dark-btn rounded-full btn-hover btn-xs" onclick="openTree();">전체</button>    <!-- 성실 수정함 버튼 타입 버튼 추가 -->
	    <div class="content text-center">
	    	<c:if test="${fn:contains(pageContext.request.requestURL, 'orglistAdmin')}" >
	            <%-- <sec:authentication property="principal" /> --%>
	            <sec:authorize access="hasRole('ROLE_ADMIN')">
	                <button id="deptInsert" class="main-btn dark-btn-light rounded-full btn-hover btn-xs"
	                        onclick="deptInsert();">부서등록
	                </button>
	                <button id="emplInsert" class="main-btn dark-btn-light rounded-full btn-hover btn-xs"
	                        onclick="emplInsert();">사원등록
	                </button>
	            </sec:authorize>
	        </c:if>
        </div>
    </div>
    
   

    <!-- 조직도 -->
    <div id="jstree" class="mb-2"></div>
</div>



<script type="text/javascript">
    document.addEventListener("DOMContentLoaded", function() {
        function deptClick(e, data) {
            // 클릭한게 사원일때
            if(data.node.original.deptYn == false) {
                // 여기는 사원 클릭 한 경우 작동
                if (typeof clickEmp === "function") {
                    clickEmp(data);
                }
                
            }
            
            // 클릭한게 부서일때
            if(data.node.original.deptYn == true){
                // 여기는 부서 클릭 한경우 사용
                if (typeof clickDept === "function") {
                    clickDept(data);
                }
            }
        } // end function

        // 비동기로 조직도 데이터 가져오기
        fetch("/organization", {
            method : "get",
            headers : {"Content-Type": "application/json"}
        })
            .then(resp => resp.json())
            .then(res => {
                //console.log("부서! : ", res.deptList);
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

      	// 트리 더블 클릭 기능
        $('#jstree').on("dblclick.jstree", function (e) {
          var tree = $(this).jstree();
          var node = tree.get_node(event.target);
          
          if(node.original.deptYn === false) {
            if (typeof dbClickEmp === "function") {
              dbClickEmp(node);
            }
          }
          
          if(node.original.deptYn === true) {
            if (typeof dbClickDept === "function") {
              dbClickDept(node);
            }
          }
      
        });
        
        $('#jstree').on("changed.jstree", function (e, data) {
            //console.log(data.selected);
        });
        
        // node 열렸을때
        $('#jstree').on("open_node.jstree", function (e, data) {
            //console.log("노드open", data.node);
        });
        
        $('#jstree').on("select_node.jstree", deptClick);
    })
    
    // 검색기능
    function fSch() {
        console.log("검색");
        $('#jstree').jstree(true).search($("#schName").val());
        
    }
    
    function fSchEnder(e) {
        if (e.code === "Enter") {
            $('#jstree').jstree(true).search($("#schName").val());
        }
    }
    
    function openTree() {
        let bTreeOpen = $('#allBtn').html() === "전체";
        if(bTreeOpen){
            // 열기
            $("#jstree").jstree("open_all");
            $('#allBtn').html("닫기");
            
        }else{
            // 닫기
            $("#jstree").jstree("close_all");
            $('#allBtn').html("전체");
        }
    }
    
   

</script>