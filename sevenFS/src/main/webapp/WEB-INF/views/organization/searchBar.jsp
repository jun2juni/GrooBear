<%@ page language="java" contentType="text/html; charset=UTF-8" %>

<!-- 검색 -->
<div style="background-color: white; position:sticky; top: 90px; z-index:900; height:20px;" >
   <div class="input-group rounded mb-3" id="schDiv" >
       <input type="search" class="form-control rounded" placeholder="이름 입력" aria-label="Search"
              aria-describedby="search-addon" id="schName"
              onkeydown="fSchEnder(event)"
       />
       <span class="input-group-text border-0" id="search-addon"
             onclick="fSch()">
           <i class="fas fa-search"></i>
       </span>
  </div>
</div>
 
<script type="text/javascript">
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
</script>