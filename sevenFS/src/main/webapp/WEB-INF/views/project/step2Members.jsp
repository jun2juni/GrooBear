<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<div class="form-step" id="step2" style="display: none;">
  <div class="row">
    <div class="col-12 mb-4">
      <div class="card border p-3">
        <h6 class="mb-3">프로젝트 참여자</h6>
        <div class="row g-3">
          <div class="col-md-12">
            <div class="input-style-1 mb-2">
              <label>책임자 <span class="text-danger">*</span></label>
              <div class="input-group">
                <input type="text" id="responsibleManager" class="bg-transparent" placeholder="책임자 명" readonly />
                <input type="hidden" id="responsibleManagerEmpno" name="responsibleManagerEmpno" />
                <button type="button" class="btn btn-outline-secondary open-org-chart" data-target="responsibleManager">
                  <i class="fas fa-search me-1"></i> 조직도
                </button>
              </div>
            </div>
          </div>
          <div class="col-md-12">
            <div class="input-style-1 mb-2">
              <label>참여자 <span class="text-danger">*</span></label>
              <div class="input-group">
                <input type="text" id="participants" class="bg-transparent" placeholder="참여자 명" readonly />
                <input type="hidden" id="participantsEmpno" name="participantsEmpno" />
                <button type="button" class="btn btn-outline-secondary open-org-chart" data-target="participants">
                  <i class="fas fa-search me-1"></i> 조직도
                </button>
              </div>
            </div>
          </div>
          <div class="col-md-12">
            <div class="input-style-1 mb-2">
              <label>참조자</label>
              <div class="input-group">
                <input type="text" id="observers" class="bg-transparent" placeholder="참조자 명" readonly />
                <input type="hidden" id="observersEmpno" name="observersEmpno" />
                <button type="button" class="btn btn-outline-secondary open-org-chart" data-target="observers">
                  <i class="fas fa-search me-1"></i> 조직도
                </button>
              </div>
            </div>
          </div>
        </div>
      </div>

      <!-- 선택된 인원 리스트 -->
      <div class="mt-4">
        <h6 class="mb-3">선택된 프로젝트 참여자</h6>
        <div class="table-responsive">
          <table class="table table-bordered" id="selectedMembersTable">
            <thead>
              <tr>
                <th>역할</th>
                <th>이름</th>
                <th>부서</th>
                <th>직위</th>
                <th>연락처</th>
                <th>이메일</th>
                <th>작업</th>
              </tr>
            </thead>
            <tbody>
              <!-- 선택된 인원 목록이 여기에 표시됩니다 -->
              <tr class="empty-row">
                <td colspan="7" class="text-center text-muted">선택된 인원이 없습니다.</td>
              </tr>
            </tbody>
          </table>
        </div>
      </div>
    </div>
  </div>
</div>