<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<style>
.small-btn {
    padding: 10px 20px;
    font-size: 16px;
}
</style>
<head>
    <meta charset="UTF-8">
    <!-- <title>결재하기 모달</title> -->
</head>
<body>
    <!-- 결재모달 모달창 시작 -->
    <div class="modal fade" id="atrzApprovalModal" tabindex="-1" aria-labelledby="atrzApprovalModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content border-0 rounded-4 shadow-lg p-4">
        
            <!-- Modal Header -->
            <div class="modal-header border-0">
                <h5 class="modal-title fw-bold" id="atrzApprovalModalLabel">결재하기</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
        
            <!-- Modal Body -->
            <div class="modal-body">
                <form action="/selectForm/atrzDetail" method="post" id="atrzApprovalForm">
                <input type="hidden" id="atrzDocNo" name="atrzDocNo" value="${atrzVO.atrzDocNo}">
        
                <div class="mb-3">
                    <label class="form-label fw-semibold">결재 문서명</label>
                    <div class="form-control bg-light border-0">${atrzVO.atrzSj}</div>
                </div>
        
                <div class="mb-3">
                    <label for="approvalMessage" class="form-label fw-semibold">결재 의견</label>
                    <textarea class="form-control" id="approvalMessage" name="approvalMessage" rows="4">승인합니다.</textarea>
                </div>
        
                <!-- 전결 옵션 (나중에 활성화 예정) -->
                <!--
                <div class="form-check mt-3">
                    <input class="form-check-input" type="checkbox" id="authorStatus" name="authorStatus">
                    <label class="form-check-label" for="authorStatus">
                    전결 (체크 시 모든 결재가 완료 처리됩니다)
                    </label>
                </div>
                -->
                </form>
            </div>
        
            <!-- Modal Footer -->
            <div class="modal-footer border-0 d-flex justify-content-center gap-3">
                <button type="button" id="atrzDetailappBtn" class="btn btn-primary rounded-pill px-4">승인</button>
                <button type="button" class="btn btn-outline-secondary rounded-pill px-4" data-bs-dismiss="modal">취소</button>
            </div>
        
            </div>
        </div>
        </div>
    <!--결재모달 끝-->


    <!--반려모달-->
    <div class="modal fade" id="atrzCompanModal" tabindex="-1" aria-labelledby="atrzCompanModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content border-0 rounded-4 shadow-lg p-4">
    
            <!-- Modal Header -->
            <div class="modal-header border-0">
            <h5 class="modal-title fw-bold" id="atrzCompanModalLabel">반려하기</h5>
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
    
            <!-- Modal Body -->
            <div class="modal-body">
            <div class="mb-3">
                <label class="form-label fw-semibold">결재 문서명</label>
                <div class="form-control bg-light border-0">${atrzVO.atrzSj}</div>
            </div>
    
            <div class="mb-3">
                <label for="companionMessage" class="form-label fw-semibold">반려 의견 <span class="text-danger">*</span></label>
                <textarea class="form-control" id="companionMessage" rows="4" placeholder="반려 시 결재의견은 필수입력사항입니다."></textarea>
            </div>
            </div>
    
            <!-- Modal Footer -->
            <div class="modal-footer border-0 d-flex justify-content-center gap-3">
            <button type="button" id="atrzDetailComBtn" class="btn btn-danger rounded-pill px-4">반려</button>
            <button type="button" class="btn btn-outline-secondary rounded-pill px-4" data-bs-dismiss="modal">취소</button>
            </div>
    
        </div>
        </div>
    </div>
    <!--반려모달-->

    <!--반려사유모달-->
    <div class="modal fade" id="atrzComOptionModal" tabindex="-1" aria-labelledby="atrzComOptionModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content border-0 rounded-4 shadow-lg p-4">
            
            <!-- Modal Header -->
            <div class="modal-header border-0">
            <h5 class="modal-title fw-bold" id="atrzComOptionModalLabel">반려 사유</h5>
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
    
            <!-- Modal Body -->
            <div class="modal-body">
            <div class="mb-3">
                <textarea class="form-control bg-light border-0 rounded-3" id="recipient-name" rows="5" readonly disabled>${atrzVO.atrzOpinion}</textarea>
            </div>
            </div>
    
            <!-- Modal Footer -->
            <div class="modal-footer border-0 d-flex justify-content-center">
            <button type="button" class="btn btn-primary rounded-pill px-4" data-bs-dismiss="modal">확인</button>
            </div>
    
        </div>
        </div>
    </div>
    <!--반려사유모달-->

</body>

</html>