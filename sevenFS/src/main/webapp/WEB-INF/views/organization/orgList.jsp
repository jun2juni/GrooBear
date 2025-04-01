<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!-- 검색 -->
<div>
    <nav class="navbar navbar-light" style="margin-bottom: 20px; flex-wrap: nowrap;">
        <div style="flex-wrap: nowrap;">
            <input class="dataTable-input" style="width: 200px;" placeholder="Search" aria-label="Search" id="schName">
            <button class="btn btn-outline-dark" onclick="fSch()">검색</button>
        </div>
    </nav>
    <div style="float: left;">
        <button id="allBtn" class="main-btn dark-btn rounded-full btn-hover btn-sm"
                style="font-size: 0.7rem; padding: 0.2rem 0.4rem;" onclick="openTree();">전체
        </button>
    </div>

    <!-- 조직도 -->
    <div id="jstree" style="clear: both;margin-top: 20px;"></div>
</div>

<script type="text/javascript">
    document.addEventListener("DOMContentLoaded", function() {
        function deptClick(e, data) {
            console.log(data.node);
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
        
        // 비동기로 조직도 데이터 가져오기
        fetch("/organization", {
            method : "get",
            headers : {"Content-Type": "application/json"}
        })
            .then(resp => resp.json())
            .then(res => {
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
    })
    
    // 검색기능
    function fSch() {
        console.log("검색");
        $('#jstree').jstree(true).search($("#schName").val());
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