<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!-- 검색 -->
<div>
    
    <div class="d-flex justify-content-between">
        <button type="button" id="allBtn" class="main-btn dark-btn rounded-full btn-hover btn-xs"
            onclick="openTree();">전체</button>
        
        <c:if test="${fn:contains(pageContext.request.requestURL, 'orglistAdmin')}" >
            <sec:authorize access="hasRole('ROLE_ADMIN')">
                <button id="deptInsert" class="main-btn dark-btn rounded-full btn-hover btn-xs"
                        onclick="deptInsert();">부서등록
                </button>
            </sec:authorize>
        </c:if>
    </div>

    <!-- 조직도 -->
    <div id="jstree" class="mb-2"></div>
</div>



<script type="text/javascript">
    document.addEventListener("DOMContentLoaded", function() {
        function deptClick(e, data) {
            console.log(data.node);
            // 클릭한게 사원일때
            if(data.node.original.deptYn == false) {
                // 여기는 사원 클릭 한 경우 작동
                if (typeof clickEmp === "function") {
                    clickEmp("사원클릭 :" ,data);
                }
            }
            
            // 클릭한게 부서일때
            if(data.node.original.deptYn == true){
                // 여기는 부서 클릭 한경우 사용
                if (typeof clickDept === "function") {
                    clickDept("부서클릭 :" ,data);
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
                //조직도확인
                // console.log("부서! : ", res.deptList);
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
        
        $('#jstree').on("changed.jstree", function (e, data) {
            console.log("클릭한사원(부서) : ",data.selected);
        });
        
        // node 열렸을때
        $('#jstree').on("open_node.jstree", function (e, data) {
            // console.log("노드open", data.node);
        });
        
        $('#jstree').on("select_node.jstree", deptClick);

        //검색했을때 사원으로 포커스 변경
        $('#jstree').on('search.jstree', function (e, data) {
        setTimeout(() => {
            const matchedEls = document.querySelectorAll('#jstree .jstree-search');
            if (matchedEls.length > 0) {
                matchedEls[0].scrollIntoView({ behavior: "smooth", block: "center" });
            }
        }, 300); // DOM 렌더링 후 실행되도록 약간의 delay 추가
    });



    })
    
    // 검색기능
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