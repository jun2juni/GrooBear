<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<footer class="footer">
  <div class="container-fluid">
    <div class="row">
      <div class="col-md-6 order-last order-md-first">
        <div class="copyright text-center text-md-start">
        </div>
      </div>
      <!-- end col-->
      <div class="col-md-6">
        <div class="terms d-flex justify-content-center justify-content-md-end">
        </div>
      </div>
    </div>
    <!-- end row -->
  </div>
  <!-- end container -->
</footer>

<%-- INFO 알림 --%>
<div class="toast-container position-fixed end-0 p-3" style="top: 80px">
  <div class="toast fade hide p-2 bg-white" role="alert" aria-live="assertive" id="infoSuccess" aria-atomic="true" data-bs-delay="10000">
    <div class="toast-header border-0">
      <span class="material-symbols-outlined">notifications</span>
      <span class="alert-title ms-2 me-auto text-bold">{{title}}</span>
      <small class="alert-sender text-body">{{sender}}</small>
      <i class="fas fa-times text-md ms-3 cursor-pointer" data-bs-dismiss="toast" aria-label="Close"></i>
    </div>
    <hr class="horizontal dark m-0">
    <div class="toast-body">
      {{body}}
    </div>
  </div>
</div>
<%-- INFO 알림 --%>

<%-- 다음 주소 모달 --%>
<div class="modal fade" id="postcodeModal" tabindex="-1" role="dialog">
  <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">주소 검색</h5>
      </div>
      <div class="modal-body">
        <div class="postcode-wrap"></div>
      </div>
      <div class="modal-footer border-0 pt-0">
        <button class="btn btn-secondary" type="button" data-bs-dismiss="modal">닫기</button>
      </div>
    </div>
  </div>
</div>