<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
	<c:import url="../layout/prestyle.jsp" />
</head>
<style>
    .col-sm-12 img {
        width: 100px;
        height: 100px;
    }
	.ck-editor__editable {
	    min-height: 300px;
	}
    .preview{
        display: none;
    }
    .form-label{
        width: 10%;
        display: inline-block;
    }
    .form-control{
        width: 80%;
        display: inline-block;
        margin-left: 5px;
    }
    .emailTreeBtn{
        margin-left: 5px;
    }
    #emailTreeClose {
        display: block;
        margin-left: auto;
        padding: 8px 16px;
        background-color: #4e73df;
        color: white;
        border: none;
        border-radius: 6px;
        cursor: pointer;
        font-weight: 500;
        transition: all 0.2s;
    }
    #emailTreeClose:hover {
        background-color: #375ad3;
        transform: translateY(-2px);
    }
    #emailTree{
        border: 1px solid #e5e5e5;
        position: fixed;
        top: 65%;
        left: 60%;
        transform: translate(-50%, -50%);
        width: 500px; /* 원하는 크기로 조정 가능 */
        max-width: 90%;
        margin: 0;
        padding: 25px;
        background-color: #fff;
        border-radius: 12px;
        z-index: 1050;
        display: none;
        animation: fadeIn 0.3s ease-in-out;
    }
    @keyframes fadeIn {
        from { opacity: 0; transform: translate(-50%, -48%); }
        to { opacity: 1; transform: translate(-50%, -50%); }
    }
    /* 모달 배경 오버레이 */
    .email-tree-overlay {
        position: fixed;
        top: 0;
        left: 0;
        right: 0;
        bottom: 0;
        background-color: rgba(0, 0, 0, 0.5);
        z-index: 1040;
        display: none;
    }
    #orgTree {
        max-height: 450px;
        overflow-y: auto;
        margin-bottom: 20px;
        padding: 12px;
        border: 1px solid #e5e5e5;
        border-radius: 8px;
        /* background-color: #f8f9fc; */
    }
    /* 스크롤바 스타일 */
    #orgTree::-webkit-scrollbar {
        width: 6px;
    }
    #orgTree::-webkit-scrollbar-track {
    background: #f1f1f1;
    border-radius: 5px;
    }

    #orgTree::-webkit-scrollbar-thumb {
        background: #b9bfcf;
        border-radius: 5px;
    }

    #orgTree::-webkit-scrollbar-thumb:hover {
        background: #8c92a3;
    }

    #hiddenRefEmail, #refEmail, #recpEmail{
        margin-right: 3px;
        margin-bottom: 3px;
        width: 1px; /* 초기 너비를 최소화 */
        min-width: 10px; /* 매우 작은 최소 너비 */
        font: inherit;
        border: none;
        padding: 2px;
        outline: none;
    }
    #refEmailList > div:not(#refEmailTemp) {
        display: inline-flex;
        align-items: center;
        border: 1px solid #ddd;
        border-radius: 4px;
        padding: 2px 5px;
        margin: 2px;
        background-color: #f9f9f9;
    }
    #hiddenRefEmailList > div:not(#hiddenRefEmailTemp) {
        display: inline-flex;
        align-items: center;
        border: 1px solid #ddd;
        border-radius: 4px;
        padding: 2px 5px;
        margin: 2px;
        background-color: #f9f9f9;
    }
    #recpEmailList > div:not(#recpEmailTemp) {
        display: inline-flex;
        align-items: center;
        border: 1px solid #ddd;
        border-radius: 4px;
        padding: 2px 5px;
        margin: 2px;
        background-color: #f9f9f9;
    }
    .emailListDiv{
        display: none;
        border: 1px solid #ddd;
        padding: 2px; margin: 2px;
        border-radius: 4px;
        align-items: center;
    }

    /*사이드바 스타일 시작*/
    /* 사이드바 스타일 개선 */
    .email-sidebar {
      width: 260px;
      background-color: #ffffff;
      border-right: 1px solid #e0e0e0;
      overflow-y: auto;
      transition: all 0.3s ease;
      padding-top: 12px;
      flex-shrink: 0; /*사이드바 너비 고정*/
      /* height: 100%; */
    }
    
    .sidebar-compose {
      margin: 8px 12px 20px;
    }
    
    .compose-button {
      display: flex;
      align-items: center;
      justify-content: center;
      padding: 14px 18px;
      background: linear-gradient(135deg, #4776E6, #3b82f6);
      color: white;
      border-radius: 24px;
      border: none;
      font-weight: 500;
      cursor: pointer;
      font-size: 15px;
      transition: all 0.2s;
      width: 100%;
    }
    
    .compose-button:hover {
      background: linear-gradient(135deg, #3b6fe3, #2563eb);
      transform: translateY(-2px);
    }
    
    .compose-button i {
      margin-right: 12px;
      font-size: 16px;
    }
    
    .sidebar-section {
      margin-bottom: 12px;
    }
    
    .sidebar-item {
      display: flex;
      align-items: center;
      padding: 12px 18px;
      color: #4b5563;
      font-size: 14px;
      cursor: pointer;
      border-top-right-radius: 24px;
      border-bottom-right-radius: 24px;
      transition: all 0.2s;
      margin: 2px 0;
      position: relative;
    }
    
    .sidebar-item:hover {
      background-color: #eaecef;
      color: #1f2937;
    }
    
    .sidebar-item.active {
      background-color: #dbeafe;
      color: #2563eb;
      font-weight: 500;
    }
    
    .sidebar-item i {
      width: 24px;
      margin-right: 16px;
      text-align: center;
      font-size: 16px;
    }
    
    .sidebar-item.active i {
      color: #2563eb;
    }
    
    .sidebar-label {
      flex-grow: 1;
    }
    
    .sidebar-count {
      font-size: 12px;
      font-weight: 500;
      color: #6b7280;
      background-color: #e5e7eb;
      padding: 2px 8px;
      border-radius: 10px;
      min-width: 24px;
      text-align: center;
    }
    
    .sidebar-section-header {
      font-size: 12px;
      color: #6b7280;
      padding: 8px 16px;
      font-weight: 600;
      text-transform: uppercase;
      letter-spacing: 0.5px;
    }
    /*사이드바 스타일 끝*/

    .email-sidebar .dropdown-toggle::after,
    .email-sidebar .dropdown .dropdown-toggle::after {
        display: none !important;
    }
</style>
<script src="../organization/orgList.jsp"></script>
<body>
<c:import url="../layout/sidebar.jsp" />
<main class="main-wrapper">
	<c:import url="../layout/header.jsp" />
    <section class="section" style=" padding-left: 40px; padding-right: 40px; z-index: 999; display: flex; flex-direction: row; align-items: stretch; ">
        <!--  사이드바 시작 -->
        <div id="fixed" style="margin: 0px; position: sticky; top: 112px; width: 260px; height: 80vh; overflow-y: auto; flex-shrink: 0;">
            <div class="email-sidebar" style="width: 100%; height: 100%; background-color: #ffffff; border-right: 1px solid #e0e0e0; padding-top: 12px;">
                <div class="sidebar-compose">
                    <button class="compose-button" id="mailWrite">
                        <i class="fas fa-plus"></i>
                        <span>편지쓰기</span>
                    </button>
                </div>
                <!-- 사이드 바 -->
                <c:set var="emailClTy" value="${param.emailClTy}" />
                <div class="sidebar-section" id="emailClTy">
                    <div class="sidebar-item type-select ${mailVO.emailClTy eq '0' ? 'active' : ''}" data-emailClTy="0">
                        <i class="fas fa-paper-plane"></i>
                        <span class="sidebar-label">보낸편지함</span>
                    </div>
                    <div class="sidebar-item type-select ${mailVO.emailClTy eq '1' ? 'active' : ''}" data-emailClTy="1">
                        <i class="fas fa-inbox"></i>
                        <span class="sidebar-label">받은편지함</span>
                    </div>
                    <div class="sidebar-item type-select ${mailVO.emailClTy eq '2' ? 'active' : ''}" data-emailClTy="2">
                        <i class="far fa-file-alt"></i>
                        <span class="sidebar-label">임시보관함</span>
                    </div>
                    <div class="sidebar-item type-select ${mailVO.emailClTy eq '5' ? 'active' : ''}" data-emailClTy="5">
                        <i class="fas fa-star"></i>
                        <span class="sidebar-label">중요 메일함</span>
                    </div>
                    <div class="sidebar-item type-select ${mailVO.emailClTy eq '4' ? 'active' : ''}" data-emailClTy="4">
                        <i class="far fa-trash-alt"></i>
                        <span class="sidebar-label">휴지통</span>
                    </div>
                </div>
                <div class="sidebar-section">
                    <div class="sidebar-section-header">라벨</div>
                    <c:forEach items="${mailLabelList}" var="mailLabel">
                        <div class="sidebar-item label-select ${mailVO.lblNo == mailLabel.lblNo ? 'active' : ''}" data-lblNo="${mailLabel.lblNo}">
                            <i class="fas fa-tag" data-col="${mailLabel.lblCol}" style="color: ${mailLabel.lblCol};"></i>
                            <span class="sidebar-label">${mailLabel.lblNm}</span>
                            <div class="dropdown label-actions" style="margin-left: auto; position: relative;">
                                <button class="dropdown-toggle" style="background: none; border: none; cursor: pointer;">
                                    <i class="fas fa-ellipsis-v"></i>
                                </button>
                                <div class="dropdown-menu" style="display: none; position: absolute; right: 0; background: white; border: 1px solid #e5e7eb; border-radius: 4px; box-shadow: 0 4px 6px rgba(0,0,0,0.1); z-index: 1000;">
                                    <button class="dropdown-item edit-label" type="button" data-lblNo="${mailLabel.lblNo}" style="background: none; border: none; cursor: pointer; padding: 8px 16px; width: 100%; text-align: left;">
                                        <i class="fas fa-edit" style="margin-right: 8px;"></i> 수정
                                    </button>
                                    <button class="dropdown-item delete-label" type="button" data-lblNo="${mailLabel.lblNo}" style="background: none; border: none; cursor: pointer; padding: 8px 16px; width: 100%; text-align: left;">
                                        <i class="fas fa-trash-alt" style="margin-right: 8px;"></i> 삭제
                                    </button>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                    <div class="sidebar-item" id="addLabelBtn" style="cursor: pointer;">
                        <i class="fas fa-plus-circle" style="color: #34a853;"></i>
                        <span class="sidebar-label">라벨 추가</span>
                    </div>
                </div>
                <!-- 라벨 추가 팝업 -->
        <div id="label-popup" style="display: none; position: fixed; top: 50%; left: 50%; transform: translate(-50%, -50%); background: white; padding: 20px; border-radius: 8px; box-shadow: 0 4px 6px rgba(0,0,0,0.1); z-index: 1000;">
            <h3 style="margin-bottom: 10px;" id="lblPopTitle">라벨 추가</h3>
            <form action="/mail/mailLblAdd" method="post">
              <input type="text" name="lblNm" id="label-name" placeholder="라벨 이름 입력" style="width: 100%; padding: 8px; margin-bottom: 10px; border: 1px solid #d1d5db; border-radius: 4px;">
              <input type="hidden" name="lblNo" id="lblNo" value="0">
              <input type="hidden" name="lblCol" id="lblCol">
              <input type="hidden" name="emplNo" value="${emplNo}">
              <label for="label-color" style="display: block; margin-bottom: 5px;">라벨 색상 선택</label>
              <div id="label-color" style="display: grid; grid-template-columns: repeat(5, 1fr); gap: 5px;">
                <div class="color-option" style="width: 24px; height: 24px; background-color: #D50000; border-radius: 50%; cursor: pointer;" data-color="#D50000"></div>
                <div class="color-option" style="width: 24px; height: 24px; background-color: #C51162; border-radius: 50%; cursor: pointer;" data-color="#C51162"></div>
                <div class="color-option" style="width: 24px; height: 24px; background-color: #AA00FF; border-radius: 50%; cursor: pointer;" data-color="#AA00FF"></div>
                <div class="color-option" style="width: 24px; height: 24px; background-color: #6200EA; border-radius: 50%; cursor: pointer;" data-color="#6200EA"></div>
                <div class="color-option" style="width: 24px; height: 24px; background-color: #304FFE; border-radius: 50%; cursor: pointer;" data-color="#304FFE"></div>
                <div class="color-option" style="width: 24px; height: 24px; background-color: #2962FF; border-radius: 50%; cursor: pointer;" data-color="#2962FF"></div>
                <div class="color-option" style="width: 24px; height: 24px; background-color: #0091EA; border-radius: 50%; cursor: pointer;" data-color="#0091EA"></div>
                <div class="color-option" style="width: 24px; height: 24px; background-color: #00B8D4; border-radius: 50%; cursor: pointer;" data-color="#00B8D4"></div>
                <div class="color-option" style="width: 24px; height: 24px; background-color: #00BFA5; border-radius: 50%; cursor: pointer;" data-color="#00BFA5"></div>
                <div class="color-option" style="width: 24px; height: 24px; background-color: #00C853; border-radius: 50%; cursor: pointer;" data-color="#00C853"></div>
                <div class="color-option" style="width: 24px; height: 24px; background-color: #64DD17; border-radius: 50%; cursor: pointer;" data-color="#64DD17"></div>
                <div class="color-option" style="width: 24px; height: 24px; background-color: #AEEA00; border-radius: 50%; cursor: pointer;" data-color="#AEEA00"></div>
                <div class="color-option" style="width: 24px; height: 24px; background-color: #FFD600; border-radius: 50%; cursor: pointer;" data-color="#FFD600"></div>
                <div class="color-option" style="width: 24px; height: 24px; background-color: #FFAB00; border-radius: 50%; cursor: pointer;" data-color="#FFAB00"></div>
                <div class="color-option" style="width: 24px; height: 24px; background-color: #FF6D00; border-radius: 50%; cursor: pointer;" data-color="#FF6D00"></div>
                <div class="color-option" style="width: 24px; height: 24px; background-color: #DD2C00; border-radius: 50%; cursor: pointer;" data-color="#DD2C00"></div>
                <div class="color-option" style="width: 24px; height: 24px; background-color: #8D6E63; border-radius: 50%; cursor: pointer;" data-color="#8D6E63"></div>
                <div class="color-option" style="width: 24px; height: 24px; background-color: #9E9E9E; border-radius: 50%; cursor: pointer;" data-color="#9E9E9E"></div>
                <div class="color-option" style="width: 24px; height: 24px; background-color: #607D8B; border-radius: 50%; cursor: pointer;" data-color="#607D8B"></div>
                <div class="color-option" style="width: 24px; height: 24px; background-color: #000000; border-radius: 50%; cursor: pointer;" data-color="#000000"></div>
              </div>
              <div style="display: flex; justify-content: flex-end; gap: 10px; margin-top: 10px;">
                <button id="cancel-label" type="button" style="padding: 8px 16px; border: none; background-color: #e5e7eb; border-radius: 4px; cursor: pointer;">취소</button>
                <button id="save-label" type="submit" style="padding: 8px 16px; border: none; background-color: #2563eb; color: white; border-radius: 4px; cursor: pointer;">저장</button>
              </div>
            </form> 
          </div>
          <!-- 팝업 배경 -->
          <div id="popup-overlay" style="display: none; position: fixed; top: 0; left: 0; width: 100%; height: 100%; background: rgba(0, 0, 0, 0.5); z-index: 999;"></div>
            </div>
        </div>
        <!--  사이드바 끝 -->

        <!-- 메일 작성창 시작 -->
        <div class="container-fluid" style="flex: 1; background-color: #ffffff; padding: 20px; border: 1px solid #e0e0e0;">
            <section class="section">
                <div class="container-fluid">
                    <input type="hidden" id="modelEmplNm" value="${emplNm}">
                    <input type="hidden" id="modelEmail" value="${email}">
                    <input type="hidden" id="emailNo" value="${mailVO.emailNo}">
                    <input type="hidden" id="myEmplNo" name="myEmplNo" value="${myEmplNo}">
                    <div class="row">
                        <div class="col-12" style="margin-top: 20px;">
                            <div id="emailInpSection">
                                <!-- 송신 이메일 -->
                                <input type="hidden" id="trnsmitEmail" name="trnsmitEmail" class="form-control" readonly>
                                <!-- 수신 이메일 -->
                                <div class="mb-3" id="recpInp">
                                    <label class="form-label">수신 이메일</label>
                                    <div class="form-control" id="recpEmailList">
                                        <div class="emailListDiv" name="recpEmailTemp" id="recpEmailTemp">
                                            <span id="recpEmailInpSpan"></span>
                                            <input type="text" id="cloneInp" style="border: 0px; width: 1px;" class="form-control">
                                            <i class='fas fa-edit' id="editEmail" style="margin-left: 3px; cursor: pointer;"></i>
                                            <i class='fas fa-times' id="delEmail" style="margin-left: 3px; cursor: pointer;"></i>
                                        </div>
                                        <c:forEach items="${mailVO.recptnMapList}" var="recptnMap">
                                            <div class="emailListDiv" name="recpEmailTemp" id="recpEmailTemp" style="border: 1px solid #ddd; border-radius: 4px; padding: 2px 5px; margin: 2px; align-items: center; display: inline-flex;">
                                                <span id="recpEmailInpSpan">${recptnMap.emplNm}/</span>
                                                <input type="text" name="recpEmail" id="recpEmail" data-emplno="${recptnMap.emplNo}" class="recpEmailInp emailInput" value="${recptnMap.recptnEmail}" style="border: 0px; width: 1px;" readonly>
                                                <i class='fas fa-edit' id="editEmail" style="margin-left: 3px; cursor: pointer;"></i>
                                                <i class='fas fa-times' id="delEmail" style="margin-left: 3px; cursor: pointer;"></i>
                                            </div>
                                        </c:forEach>
                                        <c:if test="${recptnEmail != null && recptnEmail!=''}">
                                            <div class="emailListDiv" name="recpEmailTemp" id="recpEmailTemp" style="border: 1px solid #ddd; border-radius: 4px; padding: 2px 5px; margin: 2px; align-items: center; display: inline-flex;">
                                                <span id="recpEmailInpSpan">${emplNm}/</span>
                                                <input type="text" name="recpEmail" id="recpEmail" data-emplno="${emplNo}" class="recpEmailInp emailInput" value="${recptnEmail}" style="border: 0px; width: 1px;" readonly>
                                                <i class='fas fa-edit' id="editEmail" style="margin-left: 3px; cursor: pointer;"></i>
                                                <i class='fas fa-times' id="delEmail" style="margin-left: 3px; cursor: pointer;"></i>
                                            </div>
                                        </c:if>
                                        <input type="text" name="recpEmailInp" id="recpEmailInp" style="margin: 3px; border: 1px;">
                                    </div>
                                    <button class="emailTreeBtn btn btn-secondary" type="button" data-event="recpEmailInp">주소록</button>
                                </div>
                                <!-- 참조 -->
                                <div class="mb-3" id="refInp">
                                    <div class="form-label">
                                        <span id="hiddenIconSpan" style="margin-right: 5px;"><i class='fas fa-chevron-down' id="hiddenRefBtn" style="cursor: pointer;"></i></span><label>참조</label>
                                    </div>
                                    <div class="form-control" id="refEmailList">
                                        <div class="emailListDiv" name="refEmailTemp" id="refEmailTemp">
                                            <span id="refEmailInpSpan"></span>
                                            <input type="text" id="cloneInp" style="border: 0px; width: 1px;" class="form-control">
                                            <i class='fas fa-edit' id="editEmail" style="margin-left: 3px; cursor: pointer;"></i>
                                            <i class='fas fa-times' id="delEmail" style="margin-left: 3px; cursor: pointer;"></i>
                                        </div>
                                        <c:forEach items="${mailVO.refMapList}" var="refMap">
                                            <div class="emailListDiv" name="recpEmailTemp" id="refEmailTemp" style="border: 1px solid #ddd; border-radius: 4px; padding: 2px 5px; margin: 2px; align-items: center; display: inline-flex;">
                                                <span id="refEmailInpSpan">${refMap.emplNm}/</span>
                                                <input type="text" name="refEmail" id="refEmail" data-emplno="${refMap.emplNo}" style="border: 0px; width: 1px;" class="refEmailInp emailInput" value="${refMap.recptnEmail}" readonly>
                                                <i class='fas fa-edit' id="editEmail" style="margin-left: 3px; cursor: pointer;"></i>
                                                <i class='fas fa-times' id="delEmail" style="margin-left: 3px; cursor: pointer;"></i>
                                            </div>
                                        </c:forEach>
                                        <input type="text" name="refEmailInp" id="refEmailInp" style="margin: 3px; border: 1px;">
                                    </div>
                                    <button class="emailTreeBtn btn btn-secondary" type="button" data-event="refEmailInp">주소록</button>
                                </div>
                                <!-- 숨은 참조 -->
                                <div class="mb-3" id="hiddenRefInp">
                                    <label class="form-label">숨은 참조</label>
                                    <div class="form-control" id="hiddenRefEmailList">
                                        <div class="emailListDiv" name="hiddenRefEmailTemp" id="hiddenRefEmailTemp">
                                            <span id="hiddenRefEmailInpSpan"></span>
                                            <input type="text" id="cloneInp" style="border: 0px; width: 1px;" class="form-control">
                                            <i class='fas fa-edit' id="editEmail" style="margin-left: 3px; cursor: pointer;"></i>
                                            <i class='fas fa-times' id="delEmail" style="margin-left: 3px; cursor: pointer;"></i>
                                        </div>
                                        <c:forEach items="${mailVO.hiddenRefMapList}" var="hiddenRefMap">
                                            <div class="emailListDiv" name="recpEmailTemp" id="hiddenRefEmailTemp" style="border: 1px solid #ddd; border-radius: 4px; padding: 2px 5px; margin: 2px; align-items: center; display: inline-flex;">
                                                <span id="hiddenRefEmailInpSpan">${hiddenRefMap.emplNm}/</span>
                                                <input type="text" name="refEmail" id="refEmail" data-emplno="${hiddenRefMap.emplNo}" style="border: 0px; width: 1px;" class="hiddenRefEmailInp emailInput" value="${hiddenRefMap.recptnEmail}" readonly>
                                                <i class='fas fa-edit' id="editEmail" style="margin-left: 3px; cursor: pointer;"></i>
                                                <i class='fas fa-times' id="delEmail" style="margin-left: 3px; cursor: pointer;"></i>
                                            </div>
                                        </c:forEach>
                                        <input type="text" name="hiddenRefEmailInp" id="hiddenRefEmailInp" style="margin: 3px; border: 0px;">
                                    </div>
                                    <button class="emailTreeBtn btn btn-secondary" type="button" data-event="hiddenRefEmailInp">주소록</button>
                                </div>
                            </div>
                            <!-- 조직도 -->
                            <div style="width: 40%; float: right; margin-left: 30px;" id="emailTree">
                                <div id="searchBar">
                                    <c:import url="../organization/searchBar.jsp" />
                                </div>
                                <div id="orgTree" style="display: block;">
                                    <c:import url="../organization/orgList.jsp" />
                                </div>
                                <input id="btnEvent" type="hidden" value="ss" />
                                <button id="emailTreeClose" type="button">닫기</button>
                            </div>
                            <!-- 메일 제목 -->
                            <div class="mb-3">
                                <label class="form-label" >제목</label>
                                <input type="text" id="emailSj" name="emailSj" class="form-control" placeholder="제목을 입력해 주세요." required value="${mailVO.emailSj}" style="flex: 1;">
                            </div>
                            <!-- 작성자 번호 -->
                            <!-- <input type="hidden" name="emplNo" value="${myEmplNo}"> -->
                            <!-- 게시글 내용 (CKEditor) -->
                            <div class="col-sm-12">
                                <label class="form-label">내용</label>
                                <button class="toolbar-button dropdown-toggle" style="border: none; background: none; cursor: pointer; position: relative;">
                                </button>
                                <div class="dropdown-menu" style="display: none; position: absolute; background: white; border: 1px solid #e5e7eb; border-radius: 4px; box-shadow: 0 4px 6px rgba(0,0,0,0.1); z-index: 1000;">
                                    <c:if test="${mailTemplateVOList != null}">
                                        <c:forEach items="${mailTemplateVOList}" var="mailTemplate" >
                                            <button class="dropdown-item dropdown-template" data-templateNo="${mailTemplate.emailAtmcCmpltNo}" type="button" style="background: none; border: none; cursor: pointer; padding: 8px 16px; width: 100%; text-align: left; display: flex; justify-content: space-between; align-items: center;">
                                                <span>${mailTemplate.formSj}</span>
                                                <i class="material-icons dropdown-templateDel" style="font-family: 'Material Icons'; font-size: 16px; margin-left: auto;">close</i>
                                            </button>
                                        </c:forEach>
                                    </c:if>
                                    <button class="dropdown-item " type="button" id="addTemplate" style="background: none; border: none; cursor: pointer; padding: 8px 16px; width: 100%; text-align: left;">
                                        <i class="fas fa-plus" style="margin-right: 8px;"></i> 추가하기
                                    </button>
                                </div>
                                <div id="descriptionTemp">
                                    ${mailVO.emailCn}
                                </div>
                                <textarea id="emailCn" name="emailCn" rows="3" cols="30" class="form-control" hidden>${mailVO.emailCn}</textarea>
                            </div><br>
                            <!-- 작성자 이름 -->
                            <!-- <div class="mb-3">
                                <input type="hidden" name="emplNo" class="form-control" value="${myEmpInfo.emplNo}" readonly>
                            </div> -->
                            <!-- 파일 업로드 -->
                            <c:choose>
                                <c:when test="${not empty fileList}">
                                    <file-upload label="첨부파일" name="uploadFile" max-files="5" contextPath="${pageContext.request.contextPath}" uploaded-file="${fileList}" atch-file-no="${mailVO.atchFileNo}"></file-upload>
                                </c:when>
                                <c:otherwise>
                                    <file-upload label="첨부파일" name="uploadFile" max-files="5" contextPath="${pageContext.request.contextPath}"></file-upload>
                                </c:otherwise>
                            </c:choose>
                            <!-- 전송 버튼 -->
                            <button type="button" id="sendMail" data-ty="sub" class="btn btn-primary storeMail">전송</button>
                            <button type="button" id="toList" class="btn btn-secondary">목록</button>
                            <button type="button" id="tempStore" data-ty="temp" class="btn btn-secondary storeMail">임시저장</button>
                        </div>
                    </div>
                </div>
            </section>
        </div>
        <!-- 메일 작성창 끝 -->
    </section>
	<c:import url="../layout/footer.jsp" />
</main>
<c:import url="../layout/prescript.jsp" />

 
<script type="text/javascript">
	//ckeditor5
	//<div id="descriptionTemp"></div>
	//editor : CKEditor객체를 말함
	ClassicEditor
    .create(document.querySelector("#descriptionTemp"), {
      ckfinder: {
        uploadUrl: "/bbs/upload"
      }
    })
    .then(editor => {
      window.editor = editor;
    })
    .catch(err => {
      console.error(err.stack);
    });

  $(function () {
    // 텍스트만 추출하여 유효성 검사용
    function cleanText(html) {
      return html
        .replace(/<p><br\s*\/?><\/p>/gi, '') // 빈 p 태그 제거
        .replace(/<[^>]*>/g, '')             // 모든 태그 제거
        .replace(/&nbsp;/gi, '')             // &nbsp 제거
        .replace(/\u200B/g, '')              // zero-width space 제거
        .replace(/\s+/g, '')                 // 기타 공백 제거
        .trim();
    }

    // 저장용: 앞뒤 불필요한 빈 단락 제거 (공백 p, br, &nbsp)
    function cleanHtml(html) {
      return html
        .replace(/^(?:\s*<p>(&nbsp;|<br\s*\/?>|\s)*<\/p>\s*)+/gi, '') // 앞쪽
        .replace(/(?:\s*<p>(&nbsp;|<br\s*\/?>|\s)*<\/p>\s*)+$/gi, '') // 뒤쪽
        .trim();
    }

    function updateContent() {
      const rawHtml = window.editor.getData();
      const cleanedText = cleanText(rawHtml);   // 텍스트만 추출 (검사용)
      const cleanedHtml = cleanHtml(rawHtml);   // 저장할 HTML

      if (cleanedText === "") {
        console.warn("실제 내용 없음 (공백만 존재)");
        // 필요 시 alert 띄우기
        // Swal.fire({ icon: 'warning', title: '내용 없음', text: '본문을 입력해 주세요.' });
      }

      $("#content").val(cleanedHtml); // 최종 저장할 HTML
    //   console.log("저장될 내용 (HTML):", cleanedHtml);
    //   console.log("실제 텍스트만:", cleanedText);
    }

    $(".ck-blurred").on("input", updateContent);
    $(".ck-blurred").on("focusout", updateContent);
  });

  // 제출 버튼 클릭 시
  $("#submitBtn").on("click", function (e) {
    const rawHtml = window.editor.getData();
    const cleanedText = cleanText(rawHtml);
    const cleanedHtml = cleanHtml(rawHtml);

    if (cleanedText === '') {
      e.preventDefault(); // 전송 막기
      Swal.fire({
        icon: 'warning',
        title: '내용 없음',
        text: '본문을 입력해주세요!'
      });
      return;
    }

    $("#content").val(cleanedHtml); // 앞뒤 공백 제거된 HTML 저장
    $("#yourForm").submit();
  });





    $(document).ready(function(){

        $('#addTemplate').on('click', function() {
            console.log('템플릿 추가');
            
            // 팝업 생성
            const popupHtml = `
            <div id="template-popup" style="position: fixed; top: 50%; left: 50%; transform: translate(-50%, -50%); background: white; padding: 20px; border-radius: 4px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); z-index: 1000; width: 400px;">
                <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px; border-bottom: 1px solid #e5e7eb; padding-bottom: 10px;">
                    <h3 style="margin: 0; font-size: 16px; font-weight: 500;">템플릿 저장</h3>
                    <button id="close-template" type="button" style="background: none; border: none; cursor: pointer; font-size: 18px;">&times;</button>
                </div>
                
                <div style="margin-bottom: 20px;">
                    <p style="margin-bottom: 8px; font-size: 14px;">제목</p>
                    <input type="text" id="template-title" placeholder="템플릿 제목을 입력하세요" style="width: 100%; padding: 8px; border: 1px solid #d1d5db; border-radius: 4px; font-size: 14px;">
                </div>
                
                <div style="display: flex; justify-content: flex-end; gap: 10px;">
                    <button id="cancel-template" type="button" style="padding: 8px 16px; border: 1px solid #d1d5db; background-color: white; border-radius: 4px; cursor: pointer; font-size: 14px;">취소</button>
                    <button id="save-template" class="btn btn-primary" type="button" style="padding: 8px 16px; border: none; color: white; border-radius: 4px; cursor: pointer; font-size: 14px;">저장</button>
                </div>
            </div>
            <div id="popup-overlay" style="position: fixed; top: 0; left: 0; width: 100%; height: 100%; background: rgba(0, 0, 0, 0.3); z-index: 999;"></div>
            `;
            
            // 팝업 추가
            $('body').append(popupHtml);
            
            // 닫기 버튼 클릭 이벤트
            $('#close-template, #cancel-template, #popup-overlay').on('click', function() {
                $('#template-popup').remove();
                $('#popup-overlay').remove();
            });
            
            // 저장 버튼 클릭 이벤트
            $('#save-template').on('click', function() {
                const templateTitle = $('#template-title').val().trim();
                if (templateTitle === '') {
                    // 알림창 표시
                    Swal.fire({
                        icon: 'warning',
                        title: '입력 필요',
                        text: '템플릿 제목을 입력해주세요.'
                    });
                    return;
                }
                
                console.log('템플릿 제목 저장: ', templateTitle);
                let emailCn = $('#emailCn').val();
                console.log('emailCn : ',emailCn);
                // return;
                // AJAX 요청으로 템플릿 저장
                $.ajax({
                    url: '/mail/templateAdd',
                    type: 'post',
                    data: { formSj: templateTitle,formCn:emailCn },
                    success: function(resp) {
                        console.log('템플릿 추가 성공: ', resp);
                        console.log('템플릿 추가 성공: ', resp.emailAtmcCmpltNo);
                        // 팝업 닫기
                        // $('#template-popup').remove();
                        // $('#popup-overlay').remove();
                        
                        // 새 템플릿 추가
                        const newTemplate = `
                            <button class="dropdown-item dropdown-template" data-templateNo="\${resp.emailAtmcCmpltNo}" type="button" style="background: none; border: none; cursor: pointer; padding: 8px 16px; width: 100%; text-align: left; display: flex; justify-content: space-between; align-items: center;">
                                \${resp.formSj}
                                <i class="material-icons dropdown-templateDel" style="font-family: 'Material Icons'; font-size: 16px;">close</i>
                            </button>
                        `;
                        $('#addTemplate').before(newTemplate);
                    },
                    error: function(err) {
                        console.log('템플릿 추가 실패: ', err);
                        Swal.fire({
                            icon: 'error',
                            title: '저장 실패',
                            text: '템플릿 저장에 실패했습니다.'
                        });
                        // $('#template-popup').remove();
                        // $('#popup-overlay').remove();
                    }
                });
                $('#template-popup').remove();
                $('#popup-overlay').remove();
            });
            
            // 엔터키로 저장
            $('#template-title').on('keypress', function(e) {
                if (e.which === 13) {
                    $('#save-template').click();
                }
            });
            
            // 초기 포커스
            $('#template-title').focus();
        });

        $('.dropdown-template').on('click',function(){
            let templateNo = $(this).attr('data-templateNo');
            console.log('템플릿 선택',templateNo);
            $.ajax({
                url:'/mail/selectTemplate',
                type:'post',
                data:{templateNo:templateNo},
                success:function(resp){
                    console.log(resp);
                    $('#emailCn').val(resp);
                    // var editorInstance = Object.values(CKEDITOR.instances)[0];
                    editor.setData(resp);
                },
                error:function(err){
                    console.log(err);
                }
            })
        })

        $('.dropdown-templateDel').on('click',function(){
            console.log('템플릿 삭제 버튼 ',this);
            let templateNo = $(this).closest('button').attr('data-templateNo');
            console.log('templateNo : ',templateNo);
            
            $.ajax({
                url:"/mail/templateDel",
                type:"post",
                data:{templateNo:templateNo},
                success:function(resp){
                    console.log(resp);
                    let str = `.dropdown-template[date-templateNo=\${templateNo}]`;
                    console.log($(str));
                    $(str).remove();
                },
                error:function(err){
                    console.log(err);
                }
            })
        })

        $('#hiddenRefInp').hide();
        $('#emailTree').hide();
        $('#trnsmitEmail').val("${myEmpInfo.email}")

        // <input type="hidden" id="modelEmplNm" value="${emplNm}">
        // <input type="hidden" id="modelEmail" value="${email}">
        // if($('#modelEmail').length&&$('#modelEmplNm').length){
        // console.log("${mailVO}")

        // 주석
        {
            $('.emailInput').each(function(){
                const $this = $(this);
                const font = getComputedStyle(this).font;
                const width = getTextWidth($this.val(), font);
                $this.css('width', width + 'px');
            })
        }
        // if($('#modelEmail').val() && $('#modelEmplNm').val()){
        //     console.log($('#modelEmail').val())
        //     console.log($('#modelEmplNm').val())
        //     let email = $('#modelEmail').val();
        //     let emplNm = $('#modelEmplNm').val();
        //     console.log("email : ",email,"  emplNm : ",emplNm)
        //     $('#modelEmail').remove();
        //     $('#recpEmailInp').val(email);
        //     $('#recpEmailInpSpan').text(emplNm);
        //     setTimeout(function() {
        //         $('#recpEmailInp').trigger('change');
        //     }, 50);
        // }
        // ^^주석^^

        // ckeditor5 시작
        $(".ck-blurred").keydown(function(){
            console.log("str : ", window.editor.getData());
            $("#emailCn").val(window.editor.getData());
        })
        $(".ck-blurred").on("focusout",function(){
            $("#emailCn").val(window.editor.getData());
        })
        // ckeditor5 끝

        $('.storeMail').on('click', function() {
            let data = $(this).data('ty');
            console.log('data : ',data);
            let url;
            if(data=="sub"){
                url = "/mail/sendMail";
                if($('.recpEmailInp').length==0){
                    Swal.fire({
                        icon: 'warning',
                        title: '수신 이메일 없음',
                        text: '수신 이메일을 작성해 주세요.'
                    });
                    return;
                }
            }else if(data=="temp"){
                url = "/mail/tempStore";
            }
            let mailForm = new FormData();

            let trnsmitEmail = $('#trnsmitEmail').val();
            mailForm.append('trnsmitEmail', trnsmitEmail);
            let emplNo = $('input[name="myEmplNo"]').val();
            console.log('emplNo 이거 꼭 확인',emplNo);
            mailForm.append('emplNo', emplNo);

            // 여러 이메일을 처리하는 방법 수정
            $('.recpEmailInp').each(function() {  // 클래스로 가정, 실제 구조에 맞게 수정 필요
                let recEmail = $(this).val();
                let recEmplNo = $(this).attr('data-emplNo')|| "";
                mailForm.append('recptnEmailList', recEmplNo+"_"+recEmail);
                console.log('recptnEmail : ', recEmplNo+"_"+recEmail);
                // recpEmails.push(emailEmplNo);
            });
            
            $('.refEmailInp').each(function() {  // 클래스로 가정, 실제 구조에 맞게 수정 필요
                let recEmail = $(this).val();
                let recEmplNo = $(this).attr('data-emplNo')|| "";
                mailForm.append('refEmailList', recEmplNo+"_"+recEmail);
                console.log('refEmail : ', recEmplNo+"_"+recEmail);
                // recpEmails.push(refEmails);
            });
            
            $('.hiddenRefEmailInp').each(function() {  // 클래스로 가정, 실제 구조에 맞게 수정 필요
                let recEmail = $(this).val();
                let recEmplNo = $(this).attr('data-emplNo')|| "";
                mailForm.append('hiddenRefEmailList', recEmplNo+"_"+recEmail);
                console.log('hiddenRefEmail : ', recEmplNo+"_"+recEmail);
                // recpEmails.push(hiddenRefEmails);
            });
            // mailForm.append('recptnEmailList', JSON.stringify(recpEmails));
            // mailForm.append('refEmailList', JSON.stringify(refEmails));
            // mailForm.append('hiddenRefEmailList', JSON.stringify(hiddenRefEmails));
            
            let emailClTy = $('#emailClTy').val();
            mailForm.append('emailClTy', emailClTy);  // # 기호 제거
            
            let emailSj = $('#emailSj').val();  // # 기호 추가
            mailForm.append('emailSj', emailSj);
            
            let emailCn = $('#emailCn').val();
            mailForm.append('emailCn', emailCn);
            // 0 보낸메일
            mailForm.append('emailClTy', '0');

            // let fileInp = $("input[name='uploadFile']")[0];
            // console.log('fileInp',fileInp.value);

            $("input[name='uploadFile']").each(function(index,element){
                console.log('element : ',index," : ", element);
                console.log('element.files : ',index," : ",element.files[0]);
                console.log('element.value type : ', typeof(element.files[0]));
                mailForm.append('uploadFile', element.files[0]);
            })

            if(data!="temp"&&(emailCn == '' || emailCn == null)){
                Swal.fire({
                    title: '본문 내용이 없습니다.',
                    text: '본문 내용 없이 메일을 보내시겠습니까?',
                    icon: 'warning',
                    showCancelButton: true,
                    confirmButtonText: '보내기',
                    cancelButtonText: '취소'
                }).then((result) => {
                    if (result.isConfirmed) {
                        // 본문 내용 없이 메일 전송 진행
                        $.ajax({
                            url: url,
                            type: 'post',
                            data: mailForm,
                            processData: false,
                            contentType: false,
                            success: function(resp) {
                                console.log('이메일 전송 결과 : ', resp);
                                Swal.fire({
                                    icon: 'success',
                                    title: '메일 전송 성공',
                                    text: '메일이 성공적으로 전송되었습니다.',
                                    confirmButtonText: '확인'
                                }).then(() => {
                                    window.location.href = '/mail?emailClTy=0';
                                });
                            },
                            error: function(err) {
                                console.log(err);
                            }
                        });
                    } else {
                        // 취소 시 동작
                        console.log('메일 전송 취소됨');
                    }
                });
                return;
            }

            console.log("mailForm : ", mailForm);
            $.ajax({
                url: url,
                type: 'post',
                data: mailForm,
                processData: false,  // FormData 처리 시 필요
                contentType: false,  // FormData 처리 시 필요
                success: function(resp) {
                    console.log('이메일 전송 결과 : ',resp);
                    Swal.fire({
                        icon: 'success',
                        title: '메일 전송 성공',
                        text: '메일이 성공적으로 전송되었습니다.',
                        confirmButtonText: '확인'
                    }).then(() => {
                        window.location.href = '/mail?emailClTy=0';
                    });
                },
                error: function(err) {
                    console.log(err);
                }
            });
        });

        $('#toList').on('click',function(){
            console.log('toList 버튼 눌림.');
            window.location.href="/mail"
        })

        let refBtnIcon = `<i class='fas fa-chevron-up' id="hiddenRefBtn" style="cursor: pointer;"></i>`;
        // $('#hiddenRefBtn').on('click',function(){
        $(document).on('click','#hiddenRefBtn',function(){
            // console.log('확인',$('#hiddenRefInp'));
            $('#hiddenRefInp').toggle();
            let icon = refBtnIcon;
            refBtnIcon = $('#hiddenIconSpan').html();
            $('#hiddenIconSpan').html(icon);
        })

        // 기존 이벤트 핸들러 변경
        $('#refEmailList, #hiddenRefEmailList, #recpEmailList').on('click', function(e) {
            // 클릭된 요소가 refEmail 또는 hiddenRefEmail이거나 그 자식 요소인 경우 이벤트 처리 중단
            console.log('$(e.target) : ',$(e.target));
            if ($(e.target).is('#refEmailTemp, #hiddenRefEmailTemp, #recpEmailTemp, #editEmail, #delEmail') || 
                $(e.target).closest('#refEmail, #hiddenRefEmail, #recpEmail').length) {
                return;
            }
            
            // 그 외의 경우 원래대로 동작
            if(this.id == 'refEmailList') {
                $('#refEmailInp').focus();
            } else if(this.id == 'hiddenRefEmailList') {
                $('#hiddenRefEmailInp').focus();
            }else{
                $('#recpEmailInp').focus();
            }
        });
        $(document).on('click', '#refEmail, #hiddenRefEmail', function(e) {
            e.stopPropagation(); // 클릭 이벤트 전파 중단
        });

        // 텍스트 너비를 정확하게 측정하는 함수
        function getTextWidth(text, font) {
            // 임시 span 요소 생성
            let canvas = document.createElement("canvas");
            let context = canvas.getContext("2d");
            context.font = font || getComputedStyle(document.body).font;
            return context.measureText(text).width + 10; // 여백 10px 추가
        }
        
        // 수신 이메일
        $('#recpEmailInp').on('change',function(){
            let email = $('#recpEmailInp').val();
            let emplNm = $('#recpEmailInpSpan').text();
            let emplNo = $('#recpEmailInp').attr("data-emplNo");
            $('#recpEmailInp').val('');
            $('#recpEmailInpSpan').text('');
            $('#recpEmailInp').removeAttr("data-emplNo");
            console.log('recpEmailInp 값 변경 감지',email);
            console.log('recpEmailInp 값 변경 감지 emplNm : ',emplNm);
            console.log('recpEmailInp 값 변경 감지 emplNo : ',emplNo);
            let myMail = $('#trnsmitEmail').val();
            // if(email == myMail){
            //     swal({title:'자신의 이메일을 수신이메일란에 작성할 수 없습니다.',icon:'warning'})
            //     $('#recptnEmail').val('');
            //     return 
            // }
            if(email != '' && !(isValidEmail(email))){
                swal({title:'알맞지 않는 형식입니다.',icon:'warning'});
                $('#recptnEmail').val('');
                return
            }

            if(email != '' && validateDupl(email).length!=0){
                swal({title:'중복된 이메일입니다.',icon:'warning'});
                // console.log('이거 실행되면 안됨');
                $('#recptnEmail').val('');
                return;
            }
            // $('#recptnEmail').val(email);
            
            let inpDiv = $('#recpEmailTemp').clone();
            console.log('수신 이메일 inpDiv',inpDiv)
            inpDiv.css('display', 'inline-flex');
            inpDiv.css('border', '1px solid #ddd');
            inpDiv.css('border-radius', '4px');
            inpDiv.css('padding', '2px 5px');
            inpDiv.css('margin', '2px');
            inpDiv.css('align-items', 'center');
            
            if(emplNm != ''&& emplNm != null){
                let inpSpan = inpDiv.children('span');
                inpSpan.text(emplNm+" / ");
            }

            let inp = inpDiv.children('input');
            inp.prop('id','recpEmail');
            inp.prop('name','recpEmail');
            inp.prop('class','recpEmailInp emailInput');
            inp.attr('data-emplNo',emplNo);
            inp.prop('readonly',true);
            inp.val(email);
            console.log('inp : ',inp);

            // 텍스트 길이에 맞게 정확한 너비 설정
            const font = getComputedStyle(inp[0]).font;
            const width = getTextWidth(email, font);
            inp.css('width', width + 'px');

            $('#recpEmailInp').before(inpDiv);
            $('#recpEmailInp').val('');
            inp.trigger('change');
            setTimeout(function(){
                $('#recpEmailInp').focus();
            },10);
        })

        // 참조 이메일
        $('#refEmailInp').on('change',function(){
            let email = $('#refEmailInp').val();
            let emplNm = $('#refEmailInpSpan').text();
            let emplNo = $('#refEmailInp').attr("data-emplNo");
            $('#refEmailInp').val('');
            $('#refEmailInpSpan').text('');
            $('#refEmailInp').removeAttr("data-emplNo");
            // console.log('refEmailInp 값 변경 감지',email);
            let myMail = $('#trnsmitEmail').val();
            if(email==myMail){
                swal({title:'중복된 이메일입니다.',icon:'warning'});
                $('#refEmailInp').val('');
                return 
            }
            if(email!='' && !(isValidEmail(email))){
                swal({title:'알맞지 않는 형식입니다.',icon:'warning'});
                return
            }
            if(email!='' && validateDupl(email).length!=0){
                swal({title:'중복된 이메일입니다.',icon:'warning'});
                $('#refEmailInp').val('');
                return;
            }
            let inpDiv = $('#refEmailTemp').clone();
            inpDiv.css('display', 'inline-flex');
            inpDiv.css('border', '1px solid #ddd');
            inpDiv.css('border-radius', '4px');
            inpDiv.css('padding', '2px 5px');
            inpDiv.css('margin', '2px');
            inpDiv.css('align-items', 'center');
            console.log('emplNm : ',emplNm);
            if(emplNm != ''&&emplNm != null){
                let inpSpan = inpDiv.children('span');
                inpSpan.text(emplNm+" / ");
            }

            let inp = inpDiv.children('input');
            inp.prop('id','refEmail');
            inp.prop('name','refEmail');
            inp.prop('class','refEmailInp emailInput');
            inp.prop('readonly',true);
            inp.attr('data-emplNo',emplNo);
            inp.val(email);
            console.log('inp : ',inp);

            // 텍스트 길이에 맞게 정확한 너비 설정
            const font = getComputedStyle(inp[0]).font;
            const width = getTextWidth(email, font);
            inp.css('width', width + 'px');

            $('#refEmailInp').before(inpDiv);
            $('#refEmailInp').val('');
            inp.trigger('change');
            setTimeout(function(){
                $('#refEmailInp').focus();
            },10);
        })

        // 숨은 참조 이메일
        $('#hiddenRefEmailInp').on('change',function(){
            let email = $('#hiddenRefEmailInp').val();
            let emplNm = $('#hiddenRefEmailInpSpan').text();
            let emplNo = $('#hiddenRefEmailInp').attr("data-emplNo");
            $('#hiddenRefEmailInp').val('');
            $('#hiddenRefEmailInpSpan').text('');
            $('#refEmailInp').removeAttr("data-emplNo");
            // console.log('hiddenRefEmailInp 값 변경 감지',email);
            let myMail = $('#trnsmitEmail').val();
            if(email==myMail){
                swal({title:'자신의 이메일을 수신이메일란에 작성할 수 없습니다.',icon:'warning'});
                $('#hiddenRefEmailInp').val('');
                return;
            }
            if(email!='' && !(isValidEmail(email))){
                swal({title:'알맞지 않는 형식입니다.',icon:'warning'});
                return;
            }
            if(email!='' && validateDupl(email).length!=0){
                swal({title:'중복된 이메일입니다.',icon:'warning'});
                $('#hiddenRefEmailInp').val('')
                return;
            }
            let inpDiv = $('#hiddenRefEmailTemp').clone();
            inpDiv.css('display', 'inline-flex');
            inpDiv.css('border', '1px solid #ddd');
            inpDiv.css('border-radius', '4px');
            inpDiv.css('padding', '2px 5px');
            inpDiv.css('margin', '2px');
            inpDiv.css('align-items', 'center');
            
            if(emplNm != '' && emplNm!=null){
                let inpSpan = inpDiv.children('span');
                inpSpan.text(emplNm+" / ");
            }

            let inp = inpDiv.children('input');
            inp.prop('id','hiddenRefEmail');
            inp.prop('name','hiddenRefEmail');
            inp.prop('class','hiddenRefEmailInp emailInput');
            inp.prop('readonly',true);
            inp.attr('data-emplNo',emplNo);
            inp.val(email);
            console.log('inp : ',inp);

            // 텍스트 길이에 맞게 정확한 너비 설정
            const font = getComputedStyle(inp[0]).font;
            const width = getTextWidth(email, font);
            inp.css('width', width + 'px');

            $('#hiddenRefEmailInp').before(inpDiv);
            $('#hiddenRefEmailInp').val('');
            inp.trigger('change');
            setTimeout(function(){
                $('#hiddenRefEmailInp').focus();
            },10);
        })
        // $(document).on('input', '#refEmail', function() {
        //     $(this).css('width', ($(this).val().length * 8) + 'px');
        // });

        // <i class='fas fa-edit' id="editEmail" style="margin-left: 3px; cursor: pointer;"></i>
        // <i class='fas fa-times' id="delEmail" style="margin-left: 3px; cursor: pointer;"></i>

        // 수정 전 값들
        let emailState = '';
        let emplNmState='';
        // 편집 아이콘 클릭 이벤트
        $(document).on('click', '#editEmail', function(e) {
            e.stopPropagation(); // 클릭 이벤트 전파 중단
            
            // 현재 요소의 부모 요소(이메일 아이템) 찾기
            let emailItem = $(this).parent();
            let inputField = emailItem.find('input');
            emailState = inputField.val();
            let spanField = emailItem.find('span');
            emplNmState = spanField.text();
            spanField.text('');
            // readonly 속성 제거하고 포커스
            inputField.prop('readonly', false);
            inputField.focus();
            
            // 편집 모드에서는 이메일 필드에 직접 입력 가능
            // 커서를 텍스트 끝으로 이동
            let val = inputField.val();
            inputField.val('').val(val);
        });
        // 삭제 아이콘 클릭 이벤트
        $(document).on('click', '#delEmail', function(e) {
            e.stopPropagation(); // 클릭 이벤트 전파 중단
            
            // 현재 요소의 부모 요소(이메일 아이템) 제거
            $(this).parent().remove();
        });
        // 편집 완료 처리 (포커스 아웃 시)
        $(document).on('blur', '#refEmail, #hiddenRefEmail, #recpEmail', function() {
            console.log(this)
            let myMail = $('#trnsmitEmail').val();
            $(this).prop('readonly', true);
            let email = $(this).val();
            let emailField = $(this);
            let spanField = $(this).siblings('span');
            console.log('spanField : ',spanField)
            console.log('emailState : ',emailState)
            console.log('emplNmState : ',emplNmState)
            if(email==emailState){
                spanField.text(emplNmState);
            }
            if(email==myMail){
                swal({title:'자신의 이메일을 수신이메일란에 작성할 수 없습니다.',icon:'warning'});
                spanField.text(emplNmState);
                emailField.val(emailState);
                return;
            }
            if(emailState!='' && !(isValidEmail(email))){
                swal({title:'알맞지 않는 형식입니다.',icon:'warning'});
                spanField.text(emplNmState);
                emailField.val(emailState);
                return;
            }
            if((emailState!='' && validateDupl(email).length!=0) && email != emailState){
                swal({title:'중복된 이메일입니다.',icon:'warning'});
                spanField.text(emplNmState);
                emailField.val(emailState);
                return;
            }
            emailState = '';
            emplNmState = '';
            // 텍스트 길이에 맞게 너비 업데이트
            const font = getComputedStyle(this).font;
            const width = getTextWidth($(this).val(), font);
            $(this).css('width', width + 'px');
        });

        $('.emailTreeBtn').on('click',function(){
            // console.log('$(this) : ',$(this));
            // console.log("$(this).find('input') : ",$(this).closest('div').find('input').prop('id'));
            let idNm = $(this).data('event');
            $('#btnEvent').val(idNm);
            $("#emailTree").show();
            setTimeout(function() {
                $(document).on('click.modalClose', function(event) {
                    // 클릭된 요소가 모달 내부가 아니고, 주소록 버튼도 아닐 경우 모달 닫기
                    if (!$(event.target).closest('#emailTree').length && 
                        !$(event.target).closest('.emailTreeBtn').length) {
                        $("#emailTree").hide();
                        // 모달이 닫히면 이벤트 리스너 제거
                        $(document).off('click.modalClose');
                    }
                });
            }, 10);
        })

        $('#emailTreeClose').on('click',function(){
            console.log("$('#btnEvent') : ",$('#btnEvent'));
            $("#emailTree").hide();
        })

        $(document).on('click','.jstree-anchor',function(){
            // console.log('확인');
            let selId = this.id.split("_")[0];
            if(selId.length == 8){
                let btnEvent = $('#btnEvent').val();
                console.log('jstree 선택',selId);
                console.log('btnEvent 선택',btnEvent);
                let sel = '#'+btnEvent;
                let spanId = sel+'Span';
                $.ajax({
                    url: "/mail/selEmail",
                    type:'post',
                    data:JSON.stringify({emplNo:selId}),
                    contentType:'application/json',
                    success:function(resp){
                        console.log("email 요청 결과 : ",resp);
                        if(validateDupl(resp.email).length==0){
                            console.log('spanId : ',spanId)
                            console.log('resp.emplNm : ',resp.emplNm)
                            console.log('sel : ',sel)
                            $(sel).val(resp.email);
                            // $(sel).data('emplNo',selId);
                            $(sel).attr('data-emplNo', resp.emplNo);
                            $(spanId).text(resp.emplNm);
                            console.log("사번 확인1",resp.emplNo);
                            console.log("사번 확인2",$(sel).attr('data-emplNo'));
                            $(sel).val(resp.email).trigger('change');
                        }else{
                            swal({title:'중복된 이메일입니다.',icon:'warning'});
                        }
                        
                    }
                })
            }
        })

        function validateDupl(emailInp){
            console.log('기입 된 email : ',emailInp);
            let emails = $('.emailInput').get();
            console.log('기입되어있는 email',emails);
            let chkEmail = emails.filter(email=>{
                // console.log($(email).val());
                return $(email).val() == emailInp;
            }) 
            console.log('chkEmail : ',chkEmail);
            console.log('chkEmail.length : ',chkEmail.length);
            return chkEmail;
        }

        // validation(형식에 관한)
        function isValidEmail(email) {
            return /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email);
        }

        /*사이드바 관련 함수 시작*/
        			// 사이드바 아이템 클릭 이벤트 시작 //
      $('.sidebar-item.type-select').on('click', function() {
        // $('.sidebar-item').removeClass('active');
        // $(this).addClass('active');
        emailClTy = $(this).attr('data-emailClTy');
        if(emailClTy){
          // console.log('emailClTy -> ',emailClTy);
          window.location.href = "/mail?emailClTy="+emailClTy;
        }
      });
      
      $('.sidebar-item.label-select').on('click',function(){
        // console.log('.label-select 클릭 이벤트 : ',this);
        let lblNo = $(this).data('lblno');
        console.log('.label-select 클릭 이벤트 lblNo : ',lblNo);
        window.location.href="/mail/labeling?lblNo="+lblNo;
        // window.location.href="/mail?lblNo="+lblNo;
      })
      // 사이드바 아이템 클릭 이벤트 끝 //
      let selectedColor = "#000000"; // Default color

// 라벨 추가 버튼 클릭 이벤트
$('#addLabelBtn').on('click', function() {
  $('#label-popup').show();
  $('#popup-overlay').show();
  $('.color-option').css('border', 'none');
  $('#label-name').val('');
  $('#lblPopTitle').text('라벨 추가');
});

// 라벨 색상 선택 이벤트
$('.color-option').on('click', function() {
  $('.color-option').css('border', 'none'); // Reset border
  $(this).css('border', '3px solid #2563eb');// Highlight selected color
  selectedColor = $(this).data('color');
  $('#lblCol').val(selectedColor);
  console.log("$('#lblCol').val() : ",$('#lblCol').val());
});

// 저장 버튼 클릭 이벤트
$('#save-label').on('click', function() {
  let labelName = $('#label-name').val().trim();
  let labelCol = $('#lblCol').val();
  console.log('라벨 추가 labelName: ',labelName);
  console.log('라벨 추가 labelCol: ',labelCol);
});

// 취소 버튼 클릭 이벤트
$('#cancel-label').on('click', function() {
  $('#label-popup').hide();
  $('#popup-overlay').hide();
});
            // 드롭다운 토글
            $('.dropdown-toggle').on('click', function(e) {
              e.stopPropagation();
              const dropdownMenu = $(this).siblings('.dropdown-menu');
              $('.dropdown-menu').not(dropdownMenu).hide(); // 다른 드롭다운 닫기
              dropdownMenu.toggle();
            });

            // 페이지 외부 클릭 시 드롭다운 닫기
            $(document).on('click', function() {
              $('.dropdown-menu').hide();
            });

            // 라벨 수정 버튼 클릭 이벤트
            $('.edit-label').on('click', function(e) {
              e.stopPropagation();
              // console.log(this);
              const lblNo = $(this).data('lblno');
              const lblNm = $(this).closest('.dropdown-menu').parent().siblings('.sidebar-label').text();
              const lblCol = $(this).closest('.dropdown-menu').parent().siblings('.fas').data('col');
              console.log('수정 -> lblNo : ',lblNo);
              console.log('수정 -> lblNm : ',lblNm);
              console.log('수정 -> lblCol : ',lblCol);
              $('#lblNo').val(lblNo);
              $('#addLabelBtn').trigger('click');
              $('#lblPopTitle').text('라벨 수정');
              // $(`.color-option[data-color=\${lblCol}]`).css('border', '2px solid #2563eb');
              $('.color-option[data-color="' + lblCol + '"]').css('border', '3px solid #2563eb');
              $('#label-name').val(lblNm);
              $('#lblCol').val(lblCol);
              // $('color-option').css('border', '2px solid #2563eb'); // Highlight selected color
            });
            
            // 라벨 삭제 버튼 클릭 이벤트
            $('.delete-label').on('click', function(e) {
              e.stopPropagation();
              const lblNo = $(this).data('lblno');
              console.log('삭제 -> lblNo : ',lblNo);
              $.ajax({
                url:'mail/deleteLbl',
                method:'post',
                data:{lblNo:lblNo},
                success:function(resp){
                  if(resp=='success'){
                    $('.label-select[data-lblno="' + lblNo + '"]').hide();
                  }else{

                  }
                },
                error:function(err){
                  console.log('ajax요청결과 에러 발생 : ',err);
                }
              })
            });
        /*사이드바 관련 함수 끝*/
    });
    // $(window).unload(function() {
    //     // 언로드시 임시저장 (적힌게 있다면 y/n으로 물어보고 y면 저장 아니면 날림)
    // })

</script>
</body>
</html>
