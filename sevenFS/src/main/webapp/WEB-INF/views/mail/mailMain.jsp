<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<script src="https://code.jquery.com/jquery-3.5.0.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
<script type="text/javascript">
  $(document).ready(function(){
      $('.tab').prop('disabled',true)
      // $('#emailClTy ').val();
      /* 리스트 조회 조건 시작 */
      let emailClTy = '';
      let label = ''
      /* 리스트 조회 조건 끝 */

      $('.email-section').hide();
      $('.email-section-list').show();
      console.log($('.email-section-list'));
      
      
      $('#mailWrite').on('click',function(){
        // console.log('클릭 확인');
        // $('.email-section').hide();
        // console.log($('.email-section'));
        // $('.email-section write').show();
        // console.log($('.email-section write'));
        window.location.href="mail/mailSend";
      })

      // 탭 클릭 이벤트
      // $('.tab').on('click', function() {
      //   $('.tab').removeClass('active');
      //   $(this).addClass('active');
      // });
      

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


      $('#select-all').on('change',function(){
        console.log(this);
        console.log($(this).is(":checked"));
        if($(this).is(":checked")){
          $('.email-checkbox').prop('checked',true);
        }else{
          $('.email-checkbox').prop('checked',false);
        }
        $('.email-checkbox').first().trigger('change');
      })

      // 삭제
      $('#tab-del').on('click',function(){
        let emailNoList = [];
        let chkList = $('.email-checkbox:checked').get();
        chkList.forEach(chk=>{
          let emailNo = $(chk).closest('.email-item').attr('data-emailno');
          emailNoList.push(emailNo);
        })
        // 현재 URL에서 쿼리스트링 가져오기
        let queryString = window.location.search;

        // URLSearchParams 객체를 사용하여 쿼리스트링을 파싱
        let urlParams = new URLSearchParams(queryString);
        
        // 특정 파라미터 값 가져오기
        let paramValue = urlParams.get('emailClTy'); // 'name'이라는 키의 값을 가져옴
        // console.log('전',paramValue);
        if(paramValue == null || paramValue == ''){
          paramValue='1';
        }
        let url="";
        // console.log('후',paramValue);
        if(paramValue == '4'){
          url = "/mail/realDelete"
          console.log('realDelete')

          Swal.fire({
            title: '정말 삭제하시겠습니까?',
            text: "삭제된 메일은 복구할 수 없습니다.",
            icon: 'warning',
            showCancelButton: true,
            // confirmButtonColor: '#3085d6',
            // cancelButtonColor: '#d33',
            confirmButtonText: '확인',
            cancelButtonText: '취소'
          }).then((result) => {
            if (result.isConfirmed) {
              $.ajax({
                url: url,
                method: 'post',
                data: { "emailNoList": emailNoList },
                success: function(resp) {
                  window.location.href = resp + '?emailClTy=' + paramValue;
                },
                error: function(err) {
                  console.log(err);
                }
              });
            }
          });
        }else{
          url="/mail/delete"
          console.log('delete')

          $.ajax({
            url:url,
            method:'post',
            data:{"emailNoList":emailNoList},
            success:function(resp){
              window.location.href = resp+'?emailClTy='+paramValue;
            },
            error:function(err){
              console.log(err);
            }
          })
        }
        console.log(paramValue);
        console.log('삭제 할 메일',emailNoList);
      })

      $('#tab-repl').on('click',function(e){
        e.preventDefault();
        console.log('답장 버튼 클릭 : ',this);
        let chk = $('.email-checkbox:checked').get()[0];
        let emailNo = $(chk).closest('.email-item').attr('data-emailno');
        console.log('답장 버튼 클릭 emailNo : ',emailNo);
        window.location.href="/mail/mailRepl?emailNo="+emailNo;
        // window.location.href=`/mail/mailSend?emplNm=\${emplNm}&&email=\${emplEmail}`;
      })

      $('#tab-trnsms').on('click',function(){
        console.log('전달 버튼 클릭 : ',this);
        let chk = $('.email-checkbox:checked').get()[0];
        let emailNo = $(chk).closest('.email-item').attr('data-emailno');
        console.log('전달 버튼 클릭 emailNo : ',emailNo);
        window.location.href="/mail/mailTrnsms?emailNo="+emailNo;
      })

      $('#tab-restoration').on('click',function(){
        let lblNo = this.value
        console.log('라벨 no : ',lblNo);
        console.log('checkedList 라벨링 : ',checkedList);
        data = {
          checkedList:checkedList
        }
        $.ajax({
          url:'/mail/restoration',
          data:data,
          method:'post',
          success:function(resp){
            console.log(resp);
            // $('#labeling option:eq(0)').prop('selected',true);
            $('.email-checkbox').prop("checked",false);
            window.location.href="/mail?emailClTy=4"
          },
          error:function(err){
            console.log(err);
          }
        })
      })

      $('#labeling').on('change',function(){
        let lblNo = this.value
        console.log('라벨 no : ',lblNo);
        console.log('checkedList 라벨링 : ',checkedList);
        data = {
          lblNo:lblNo,
          checkedList:checkedList
        }
        $.ajax({
          url:'/mail/labelingUpt',
          data:data,
          method:'post',
          success:function(resp){
            console.log(resp);
            labeling(checkedList,lblNo,resp)
            $('#labeling option:eq(0)').prop('selected',true);
            $('.email-checkbox').prop("checked",false);
          },
          error:function(err){
            console.log(err);
          }
        })
      })

      function labeling(mailList,lblNo,color){
        mailList.forEach(mail => {
          console.log('mail : ',mail);
          console.log('lblNo : ',lblNo);
          console.log('color : ',color);
          let mailiNo = mail
          if(color == null || color == '' ){
            console.log('라벨 삭제')
            $(`.email-item[data-emailno=\${mailiNo}]`).find(`.fas.fa-tag`).remove();
          }else{
            console.log($(`.email-item[data-emailno=\${mailiNo}]`).find(`.fas.fa-tag[data-lblno=\${lblNo}]`));
            if($(`.email-item[data-emailno=\${mailiNo}]`).find(`.fas.fa-tag[data-lblno=\${lblNo}]`).length>0){
              console.log('이미 라벨 존재',$(`.email-item[data-emailno=\${mailiNo}]`).find(`.fas.fa-tag[data-lblno=\${lblNo}]`));
            }else{
              console.log('라벨 추가 혹은 변경')
              $(`.email-item[data-emailno=\${mailiNo}]`).find('.tag-box').html(`<i class="fas fa-tag" data-col="\${color}" data-lblno="\${lblNo}" style="color: \${color}; margin-right: 2px;"></i>`);
            }
          }
        })
        $('#select-all').prop('checked',false)
      }

      // 리스트 클릭 이벤트
      $('.email-item').on('click',function(){
        let emailNoSel = $(this).attr('data-emailno');
        let emailcltySel = $(this).attr('data-emailclty');
        console.log('emailNo -> ',emailNoSel);
        console.log('emailclty -> ',emailcltySel);
        if(emailcltySel == '2'){
          window.location.href="/mail/emailTemp?emailNo="+emailNoSel;
        }else{
          window.location.href="/mail/emailDetail?emailNo="+emailNoSel;
        }
      })

      // 별표 클릭
      $('.fa-star').on('click',function(e){
        e.stopPropagation();
        let starredYN = '';
        $(this).toggleClass('fas');
        $(this).toggleClass('far');
        let className = $(this).prop('className')
        let emailNo = $(this).closest('button').data('emailno');
        console.log('별표 이벤트 -> emailNo : ',emailNo);
        console.log('별표 이벤트 -> className : ',className);
        if(className.indexOf('far') != -1){
          starredYN = 'N';
        }else if(className.indexOf('fas') != -1){
          starredYN = 'Y';
        }
        console.log('별표 이벤트 -> starredYN : ',starredYN);
        $.ajax({
          url:'/mail/starred',
          data:{emailNo:emailNo,starred:starredYN},
          method:'post',
          success:function(resp){
            console.log('ajax 요청 결과 : ',resp);
          },
          error:function(err){
            console.log('에러 발생 : ',err)
          }
        })
      })


      let checkedList;
      $('.email-checkbox').on('click', function(e) {
        e.stopPropagation(); // 이벤트 전파 중단
      });
      // $(document).on('change','.email-checkbox',function(){
      $('.email-checkbox').on('change',function(){
        // 현재 URL에서 쿼리스트링 가져오기
        let queryString = window.location.search;

        // URLSearchParams 객체를 사용하여 쿼리스트링을 파싱
        let urlParams = new URLSearchParams(queryString);

        // 특정 파라미터 값 가져오기
        let paramValue = urlParams.get('emailClTy'); // 'name'이라는 키의 값을 가져옴
        let emailNoList = [];
        console.log('클릭 확인 : ',this)
        let chkList = $('.email-checkbox:checked').get();
        console.log(chkList);
        console.log("$('#tab-restoration')",$('#tab-restoration'));
        chkList.forEach(chk=>{
          let emailNo = $(chk).closest('.email-item').attr('data-emailno');
          emailNoList.push(emailNo);
        })
        console.log("체크된 리스트 : ",emailNoList);
        console.log("체크된 리스트 길이 : ",emailNoList.length);
        if(emailNoList.length>1){
          $('#tab-del').prop('disabled',false);
          $('#tab-restoration').prop('disabled',false);
          $("#tab-repl").prop('disabled',true);
          $("#tab-trnsms").prop('disabled',true);
          $('#labeling').prop('disabled',false);
        }else if(emailNoList.length == 0){
          $('#tab-del').prop('disabled',true);
          $('#tab-restoration').prop('disabled',true);
          $("#tab-repl").prop('disabled',true);
          $("#tab-trnsms").prop('disabled',true);
          $('#labeling').prop('disabled',true);
        }else if(emailNoList.length == 1){
          $('#tab-del').prop('disabled',false);
          $('#tab-restoration').prop('disabled',false);
          $("#tab-repl").prop('disabled',false);
          $("#tab-trnsms").prop('disabled',false);
          $('#labeling').prop('disabled',false);
        }

        if(paramValue != '1' && paramValue == ''){
          $("#tab-repl").prop('disabled',true);
        }

        checkedList = emailNoList;

      })
      // <i class="${mailVO.starred=='Y'?'fas':'far'} fa-star"></i>
  });

</script>
  <div class="email-container">
    <!-- 메인 콘텐츠 영역 (사이드바 + 이메일 영역) -->
    <div class="email-main-content">
      <!-- 이메일 사이드바 -->
      <div class="email-sidebar">
        <div class="sidebar-compose">
          <button class="compose-button" id="mailWrite">
            <i class="fas fa-plus"></i>
            <span>편지쓰기</span>
          </button>
        </div>
        <!-- 사이드 바 -->
        <c:set var="emailClTy" value="${param.emailClTy}" />
        <div class="sidebar-section " id="emailClTy">
          
          <div class="sidebar-item type-select ${mailVO.emailClTy eq '0' ? 'active' : ''}" data-emailClTy="0">
            <i class="fas fa-paper-plane"></i>
            <span class="sidebar-label">보낸편지함</span>
          </div>
          <div class="sidebar-item type-select ${mailVO.emailClTy eq '1' ? 'active' : ''}" data-emailClTy="1">
            <i class="fas fa-inbox"></i>
            <span class="sidebar-label">받은편지함</span>
            <!-- <span class="sidebar-count">2,307</span> -->
          </div>
          <div class="sidebar-item type-select ${mailVO.emailClTy eq '2' ? 'active' : ''}" data-emailClTy="2">
            <i class="far fa-file-alt"></i>
            <span class="sidebar-label">임시보관함</span>
            <!-- <span class="sidebar-count">11</span> -->
          </div>
          <!-- <div class="sidebar-item type-select ${mailVO.emailClTy eq '3' ? 'active' : ''}" data-emailClTy="3">
            <i class="far fa-file-alt"></i>
            <span class="sidebar-label">스팸함</span>
            <span class="sidebar-count">11</span>
          </div> -->
          <div class="sidebar-item type-select ${mailVO.emailClTy eq '5' ? 'active' : ''}" data-emailClTy="5">
            <i class="fas fa-star"></i>
            <span class="sidebar-label">중요 메일함</span>
            <!-- <span class="sidebar-count">11</span> -->
          </div>
          <div class="sidebar-item type-select ${mailVO.emailClTy eq '4' ? 'active' : ''}" data-emailClTy="4">
            <i class="far fa-trash-alt"></i>
            <!-- <i class="fas fa-trash"></i> -->
              <span class="sidebar-label">휴지통</span>
            <!-- <span class="sidebar-count">11</span> -->
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
          <!-- <div class="sidebar-item label-select ${mailVO.lblNo == mailLabel.lblNo ? 'active' : ''}" data-lblNo="${mailLabel.lblNo}">
            <i class="bi bi-pin-angle-fill" style="color: red;"></i>
            <span class="sidebar-label">이 아이콘은 어떤가?</span>
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
          </div> -->
          <div class="sidebar-item" id="addLabelBtn" style="cursor: pointer;">
            <i class="fas fa-plus-circle" style="color: #34a853;"></i>
            <span class="sidebar-label">라벨 추가</span>
          </div>
        </div>

        <script>
          $(document).ready(function() {
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
              Swal.fire({
                title: '라벨을 삭제하시겠습니까?',
                text: "삭제된 라벨은 복구할 수 없습니다.",
                icon: 'warning',
                showCancelButton: true,
                // confirmButtonColor: '#3085d6',
                // cancelButtonColor: '#d33',
                confirmButtonText: '확인',
                cancelButtonText: '취소'
              }).then((result) => {
                if (result.isConfirmed) {
                  $.ajax({
                    url: 'mail/deleteLbl',
                    method: 'post',
                    data: { lblNo: lblNo },
                    success: function(resp) {
                      if (resp == 'success') {
                        $('.label-select[data-lblno="' + lblNo + '"]').hide();
                        $('.fas.fa-tag[data-lblno="' + lblNo + '"]').remove();
                        Swal.fire('삭제 완료', '라벨이 삭제되었습니다.', 'success');
                      } else {
                        Swal.fire('오류', '라벨 삭제에 실패했습니다.', 'error');
                      }
                    },
                    error: function(err) {
                      console.log('ajax 요청 결과 에러 발생 : ', err);
                      Swal.fire('오류', '라벨 삭제 중 문제가 발생했습니다.', 'error');
                    }
                  });
                }
              });
            });
          });
        </script>

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

        <script>
          $(document).ready(function() {
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
          });
        </script>

        <!-- 팝업 배경 -->
        <div id="popup-overlay" style="display: none; position: fixed; top: 0; left: 0; width: 100%; height: 100%; background: rgba(0, 0, 0, 0.5); z-index: 999;"></div>

      </div>

      <!-- 메일 콘텐츠 영역 -->
      <div class="emial-box" style="width: 90%; margin-left: 20px;">
        <!-- 이메일 listSection 시작 -->
        <div class="email-section email-section-list">
          <div class="email-content-area">
            <!-- 이메일 툴바 -->
            <div class="email-toolbar">
              <div class="checkbox-container">
                <input type="checkbox" id="select-all">
              </div>
            <div class="email-tabs">
              <button class="tab" id="tab-del">
                <c:if test="${articlePage.searchVo.emailClTy == '4'}">
                  삭제
                </c:if>
                <c:if test="${articlePage.searchVo.emailClTy != '4'}">
                  휴지통
                </c:if>
              </button>
              <button class="tab" id="tab-repl">답장</button>
              <button class="tab" id="tab-trnsms">전달</button>
              <c:if test="${mailVO.emailClTy == '4'}">
                <button class="tab" id="tab-restoration">복구</button>
              </c:if>
              <c:if test="${mailVO.emailClTy == '0'||mailVO.emailClTy == '1'}">
                <select class="tab" name="mailLbl" id="labeling">
                  <option id="defaultOption" value="" disabled selected>라벨 선택</option>
                  <c:forEach items="${mailLabelList}" var="mailLabel">
                    <option value="${mailLabel.lblNo}">${mailLabel.lblNm}</option>
                  </c:forEach>
                  <option id="detLabel" value="0">라벨 해제</option>
                </select>
              </c:if>
            </div>
          <div class="d-flex justify-content-end align-items-center" style="margin-left: auto; gap: 10px;">
          <c:set var="searchOption" value="${param.searchOption}"/>
          <form action="/mail" class="d-flex align-items-center" style="gap: 10px;">
            <input type="hidden" name="emailClTy" id="emailClTy" value="${searchVO.emailClTy}">
            <select name="searchOption" id="searchOption" class="form-select" style="width: auto; padding: 8px 12px; border-radius: 4px; border: 1px solid #d1d5db;">
              <option value="title" ${searchOption eq 'title' ? 'selected' : ''} >제목</option>
              <option value="content" ${searchOption eq 'content' ? 'selected' : ''} >내용</option>
              <option value="title_content" ${searchOption eq 'title_content' ? 'selected' : ''} >제목+내용</option>
            </select>
            <input type="text" value="${searchVO.keyword}" name="keyword" id="search" class="form-control" placeholder="검색어 입력" style="width: 200px; padding: 8px 12px; border-radius: 4px; border: 1px solid #d1d5db;">
            <button type="submit" class="btn btn-primary" style="padding: 8px 16px; border-radius: 4px; background-color: #2563eb; color: white; border: none; cursor: pointer; transition: background-color 0.2s;">
              검색
            </button>
          </form>
          </div>
            </div>
            <!-- 이메일 목록 - 여기에 스크롤이 적용됩니다 -->
            <div class="email-list" id="email-list">
              <!-- 헤더 추가 -->
              <div class="email-list-header" style="display: flex; padding: 10px; border-bottom: 1px solid #e5e7eb; background-color: #f9fafb; font-weight: bold;">
                <div id="balnk" style="width: 68px;"></div>
                <div class="email-header-sender" style="flex: 1; text-align: left; padding-right: 12px ;">이메일</div>
                <div class="email-header-subject" style="flex: 2; text-align: left; padding-left: 20px;">제목</div>
                <div class="email-header-date" style="flex: 1; text-align: center;">날짜</div>
              </div>
                <c:if test="${mailVOList.size() == 0}">
                  <div style="text-align: center; padding: 20px; font-size: 16px; color: #6b7280;">
                    메일이 없습니다.
                  </div>
                </c:if>
              <!-- forEach 시작 -->
              <c:forEach items="${mailVOList}" var="mailVO">
                <div class="email-item ${mailVO.readngAt}" data-emailclty="${mailVO.emailClTy}" data-emailNo="${mailVO.emailNo}">
                <div class="email-actions">
                  <input type="checkbox" class="email-checkbox">
                  <c:if test="${mailVO.emailClTy == '0' || mailVO.emailClTy == '1'}">
                    <button class="star-button ${mailVO.starred}" data-emailNo="${mailVO.emailNo}">
                      <i class="${mailVO.starred=='Y'?'fas':'far'} fa-star"></i>
                    </button>
                  </c:if>
                </div>
                <div class="email-sender" style="flex: 1;">${mailVO.trnsmitEmail}</div>

                <div class="email-content" style="flex: 2; display: flex; align-items: center; position: relative;">
                  <div class="tag-box" style="width: 20px; display: inline-block;">
                    <c:if test="${(mailVO.lblCol != null and mailVO.lblCol != '')&&(mailVO.emailClTy=='0' || mailVO.emailClTy=='1')}">
                      <i class="fas fa-tag" data-col="${mailVO.lblCol}" data-lblNo="${mailVO.lblNo}" style="color: ${mailVO.lblCol};"></i>
                    </c:if>
                  </div>
                  <c:if test="${mailVO.emailSj != null}">
                    <span class="email-subject">${mailVO.emailSj}</span>
                  </c:if>
                  <c:if test="${mailVO.emailSj == null}">
                    <span class="email-subject">(제목 없음)</span>
                  </c:if>
                </div>

                <div class="email-date" style="flex: 1; text-align: center;">${mailVO.trnsmitDt}</div>
                </div>
              </c:forEach>
              <!-- forEach 끝 -->
            </div>
          </div>
          <c:if test="${mailVOList.size()>0}">
            <!-- 페이지네이션 -->
            <div style="margin-top: 20px;">
            
              <c:if test="${labelingPage != 'true'}">
                <!-- ${labelingPage} -->
                <page-navi
                url="/mail?${articlePage.getSearchVo()}"
                current="${articlePage.getCurrentPage()}"
                show-max="5"
                total="${articlePage.getTotalPages()}"
                ></page-navi>
              </c:if>
              <c:if test="${labelingPage == 'true'}">
                <page-navi
                url="/mail/labeling?${articlePage.getSearchVo()}"
                current="${articlePage.getCurrentPage()}"
                show-max="5"
                total="${articlePage.getTotalPages()}"
                ></page-navi>
              </c:if>
            </div>
          </c:if>
        </div>
        <!-- 이메일 listSection 끝 -->
         
      </div>
    </div>
  </div>
<style>
  .star-button>i {
    color: #FFD700; /* 밝은 금색으로 변경 */
  }
  /* 기본 스타일 */
* {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
}

body {
  font-family: 'Roboto', 'Noto Sans KR', Arial, sans-serif;
  background-color: #f8f9fa;
  color: #202124;
  line-height: 1.5;
}
.dropdown-toggle::after {
  display: none !important;
}
.email-container {
  font-family: 'Roboto', 'Noto Sans KR', Arial, sans-serif;
  background-color: #ffffff;
  /* border-radius: 8px; */
  height: 80vh;
  width: 100%;
  display: flex;
  flex-direction: column;
  /* box-shadow: 0 4px 6px rgba(0,0,0,0.1); */
  overflow: hidden; /* 바깥쪽 스크롤 제거 */
}

/* 메인 콘텐츠 영역 (사이드바 + 이메일 리스트) */
.email-main-content {
  display: flex;
  flex-grow: 1;
  overflow: hidden;
}

/* 사이드바 스타일 개선 */
.email-sidebar {
  width: 260px;
  border-right: 1px solid #e0e0e0;
  overflow-y: auto;
  transition: all 0.3s ease;
  padding-top: 12px;
  flex-shrink: 0;
  /* box-shadow: 1px 0 5px rgba(0,0,0,0.05); */
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
  /* box-shadow: 0 4px 10px rgba(59, 130, 246, 0.4); */
  transform: translateY(-2px);
}

.compose-button:active {
  transform: translateY(0);
  /* box-shadow: 0 2px 5px rgba(59, 130, 246, 0.2); */
}

.compose-button i {
  margin-right: 12px;
  font-size: 16px;
}

.sidebar-section {
  margin-bottom: 16px;
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
  background-color: #edf2f7;
  color: #1a202c;
}

.sidebar-item.active {
  background-color: #e1effe;
  color: #2563eb;
  font-weight: 500;
}

.sidebar-item i {
  width: 24px;
  margin-right: 16px;
  text-align: center;
  font-size: 16px;
  transition: transform 0.2s;
}

.sidebar-item:hover i {
  transform: scale(1.1);
}

.sidebar-item.active i {
  color: #2563eb;
}

.sidebar-label {
  flex-grow: 1;
  transition: transform 0.1s;
}

.sidebar-item:active .sidebar-label {
  transform: translateX(3px);
}

.sidebar-count {
  font-size: 12px;
  font-weight: 500;
  color: #4b5563;
  background-color: #e5e7eb;
  padding: 2px 10px;
  border-radius: 12px;
  min-width: 26px;
  text-align: center;
  transition: all 0.2s;
}

.sidebar-item:hover .sidebar-count {
  background-color: #d1d5db;
}

.sidebar-item.active .sidebar-count {
  background-color: #bfdbfe;
  color: #2563eb;
}

.sidebar-section-header {
  font-size: 12px;
  color: #6b7280;
  padding: 10px 18px;
  font-weight: 600;
  text-transform: uppercase;
  letter-spacing: 0.5px;
}

/* 이메일 툴바 */
.email-toolbar {
  display: flex;
  align-items: center;
  padding: 12px 16px;
  border-bottom: 1px solid #e0e0e0;
  background-color: #fff;
  z-index: 10;
}

.checkbox-container {
  margin-right: 12px;
}

.checkbox-container input[type="checkbox"] {
  cursor: pointer;
  width: 18px;
  height: 18px;
  border-radius: 3px;
}

.toolbar-actions {
  display: flex;
  margin-left: 16px;
}

.toolbar-button {
  padding: 8px;
  margin-right: 10px;
  background: none;
  border: none;
  border-radius: 4px;
  cursor: pointer;
  color: #4b5563;
  transition: all 0.2s;
}

.toolbar-button:hover {
  background-color: #f3f4f6;
  color: #1f2937;
}

.email-tabs {
  display: flex;
  margin-left: 10px;
  align-items: center;
}

.tab {
  padding: 8px 16px;
  font-size: 14px;
  cursor: pointer;
  border: none;
  background: none;
  border-radius: 4px;
  margin-right: 4px;
  transition: all 0.2s;
  color: #4b5563;
}

.tab:hover {
  background-color: #f3f4f6;
  color: #1f2937;
}

.tab.active {
  color: #2563eb;
  background-color: #e1effe;
  font-weight: 500;
}
.tab:disabled{
  opacity: 0.5;  /* 투명도를 낮춰 흐리게 보이게 */
  cursor: not-allowed;  /* 마우스 커서를 '사용 불가' 형태로 변경 */
}

#labeling {
  margin-left: 8px;
  padding: 8px 10px;
  border: 1px solid #d1d5db;
  border-radius: 4px;
  background-color: white;
  font-size: 14px;
  color: #4b5563;
  cursor: pointer;
  outline: none;
  transition: all 0.2s;
}

#labeling:hover {
  border-color: #9ca3af;
}

#labeling:focus {
  border-color: #3b82f6;
  /* box-shadow: 0 0 0 2px rgba(59, 130, 246, 0.2); */
}

/* 이메일 콘텐츠 영역 */
.email-content-area {
  display: flex;
  flex-direction: column;
  flex-grow: 1;
  overflow: hidden;
  background-color: #ffffff;
}

.emial-box {
  transition: all 0.3s ease;
}

/* 이메일 목록 */
.email-list {
  flex-grow: 1;
  overflow-y: auto; /* 여기에 스크롤 적용 */
  scrollbar-width: thin;
  scrollbar-color: #cbd5e1 #f1f5f9;
  /* height: calc(100vh - 60px); 툴바 높이를 제외한 나머지 공간email-list */
}

.email-list::-webkit-scrollbar {
  width: 8px;
}

.email-list::-webkit-scrollbar-track {
  background: #f1f5f9;
}

.email-list::-webkit-scrollbar-thumb {
  background-color: #cbd5e1;
  border-radius: 4px;
}

.email-item {
  display: flex;
  align-items: center;
  padding: 7px 8px;
  border-bottom: 1px solid #e5e7eb;
  cursor: pointer;
  transition: all 0.15s ease;
  position: relative;
  width: 100%;
  box-sizing: border-box;
}

.email-item:hover {
  background-color: #f3f4f6;
  transform: translateY(-1px);
  /* box-shadow: 0 1px 3px rgba(0,0,0,0.05); */
}

.email-item.N {
  background-color: #f0f7ff;
}

.email-item.N:hover {
  background-color: #e6f0fd;
}

.email-item::after {
  content: '';
  position: absolute;
  left: 0;
  top: 0;
  height: 100%;
  width: 4px;
  background-color: transparent;
  transition: background-color 0.2s;
}

.email-item.N::after {
  background-color: #3b82f6;
}

.email-actions {
  display: flex;
  align-items: center;
  width: 60px;
  margin-right: 8px;
}

.email-checkbox {
  margin-right: 10px;
  cursor: pointer;
  width: 18px;
  height: 18px;
}

.star-button {
  background: none;
  border: none;
  cursor: pointer;
  padding: 4px;
  color: #9ca3af;
  transition: all 0.2s;
  border-radius: 50%;
}

.star-button:hover {
  background-color: #f3f4f6;
  color: #f59e0b;
}

.email-sender {
  width: 180px;
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
  font-weight: 500;
  color: #374151;
  padding-right: 12px;
}

.email-content {
  flex-grow: 1;
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
  padding-right: 16px;
  min-width: 0;
}

.email-subject {
  font-weight: 500;
  color: #1f2937;
}

.email-snippet {
  color: #6b7280;
  margin-left: 4px;
}

.email-date {
  width: 80px;
  min-width: 160px;
  text-align: right;
  color: #6b7280;
  font-size: 13px;
  white-space: nowrap;
  margin: auto;
  flex-shrink: 0;
  text-overflow: ellipsis;
}

.email-item.N .email-date {
  color: #4b5563;
  font-weight: 500;
}

/* 반응형 스타일 */
@media (max-width: 768px) {
  .email-sidebar {
    width: 60px;
  }
  
  .sidebar-label, .sidebar-count, .compose-button span {
    display: none;
  }
  
  .compose-button {
    padding: 12px;
    border-radius: 50%;
    justify-content: center;
  }
  
  .compose-button i {
    margin-right: 0;
  }
  
  .emial-box {
    width: calc(100% - 60px) !important;
    margin-left: 0 !important;
  }
  
  .email-sender {
    width: 120px;
  }
}

.close-button {
  background: none;
  border: none;
  color: #9aa0a6;
  cursor: pointer;
  margin-left: 16px;
  font-size: 18px;
  transition: all 0.2s;
}

.close-button:hover {
  color: #ffffff;
}

/* 이메일 상세 페이지 스타일 (현재는 사용하지 않지만 추가) */
.email-detail-header {
  padding: 16px;
  border-bottom: 1px solid #e5e7eb;
}

.email-detail-subject {
  font-size: 18px;
  font-weight: 600;
  color: #1f2937;
  margin-bottom: 8px;
}

.email-detail-info {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.sender-info {
  display: flex;
  align-items: center;
}

.sender-avatar {
  width: 36px;
  height: 36px;
  border-radius: 50%;
  background-color: #3b82f6;
  color: white;
  display: flex;
  align-items: center;
  justify-content: center;
  font-weight: 600;
  margin-right: 12px;
}

.sender-details {
  display: flex;
  flex-direction: column;
}

.sender-name {
  font-weight: 500;
  color: #374151;
}

.sender-email {
  font-size: 13px;
  color: #6b7280;
}

.email-detail-body {
  padding: 20px;
  line-height: 1.6;
  color: #374151;
}
    
</style>
    
  
  
