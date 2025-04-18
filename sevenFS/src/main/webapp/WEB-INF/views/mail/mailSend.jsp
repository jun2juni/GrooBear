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
        top: 50%;
        left: 50%;
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
</style>
<script src="../organization/orgList.jsp"></script>
<body>
<c:import url="../layout/sidebar.jsp" />
<main class="main-wrapper">
	<c:import url="../layout/header.jsp" />
	<section class="section" style="z-index: 999;">
		<div class="container-fluid">
			<section class="section">
			<div class="container-fluid">
                <!--
                    == 메일 전송에 필요한 데이터 ==
                    * emailTrnsmisTy ( 참조시에 필요 )
                    * emailClTy (메일함 분류시 필요)
                  v * trnsmitEmail (송신 이메일)
                  v * recptnEmail	(수신 이메일)
                  v * emailSj
                  v * emailCn
                  v * 첨부파일
                -->
                <input type="hidden" id="modelEmplNm" value="${emplNm}">
                <input type="hidden" id="modelEmail" value="${email}">
				<div class="row">
					<div class="col-12">
						<div class="card-style">
							<!-- <h2 class="text-primary text-center"></h2> -->
                            <div>
                                <div id="emailInpSection" >
                                    <!-- 송신 이메일 -->
                                    <input type="hidden" id="trnsmitEmail" name="trnsmitEmail" class="form-control" placeholder="hidden처리할 예정" readonly>
                                    <!-- 수신 이메일 -->
                                    <div class="mb-3" id="recpInp" >
                                        <label class="form-label">수신 이메일</label>
                                        <div class="form-control" id="recpEmailList">
                                            <div class="emailListDiv"  name="recpEmailTemp" id="recpEmailTemp">
                                                <span id="recpEmailInpSpan"></span>
                                                <input type="text" id="cloneInp" style="border: 0px; width: 1px;" class="form-control">
                                                <i class='fas fa-edit' id="editEmail" style="margin-left: 3px; cursor: pointer;"></i>
                                                <i class='fas fa-times' id="delEmail" style="margin-left: 3px; cursor: pointer;"></i>
                                            </div>
                                            <input type="text" name="recpEmailInp" id="recpEmailInp" style="margin: 3px; border: 1px;" >
                                        </div>
                                        <button class="emailTreeBtn btn btn-secondary" type="button" data-event="recpEmailInp">주소록</button>
                                    </div>
                                    <!-- 원본 -->
                                    <!-- <div class="mb-3" >
                                        <span id="recptnEmailSpan"></span>
                                        <input type="text" id="recptnEmail" name="recptnEmail" class="form-control emailInput" required>
                                        <button class="emailTreeBtn" type="button" data-event="recptnEmail">주소록</button>
                                    </div> -->

                                    <!-- 참조 -->
                                    <div class="mb-3" id="refInp" >
                                        <div class="form-label">
                                            <span id="hiddenIconSpan" style="margin-right: 5px;"><i class='fas fa-chevron-down' id="hiddenRefBtn" style="cursor: pointer;"></i></span><label>참조</label>
                                        </div>
                                        <div class="form-control" id="refEmailList" >
                                            <div class="emailListDiv"  name="refEmailTemp" id="refEmailTemp">
                                                <span id="refEmailInpSpan"></span>
                                                <input type="text" id="cloneInp" style="border: 0px; width: 1px;" class="form-control">
                                                <i class='fas fa-edit' id="editEmail" style="margin-left: 3px; cursor: pointer;"></i>
                                                <i class='fas fa-times' id="delEmail" style="margin-left: 3px; cursor: pointer;"></i>
                                            </div>
                                            <input type="text" name="refEmailInp" id="refEmailInp" style="margin: 3px; border: 1px;" >
                                        </div>
                                        <button class="emailTreeBtn btn btn-secondary" type="button" data-event="refEmailInp">주소록</button>
                                    </div>
                                    <!-- 숨은 참조 -->
                                    <div class="mb-3" id="hiddenRefInp"  >
                                        <label class="form-label">숨은 참조</label>
                                        <div class="form-control" id="hiddenRefEmailList">
                                            <div class="emailListDiv" name="hiddenRefEmailTemp" id="hiddenRefEmailTemp">
                                                <span id="hiddenRefEmailInpSpan"></span>
                                                <input type="text" id="cloneInp" style="border: 0px; width: 1px;" class="form-control">
                                                <i class='fas fa-edit' id="editEmail" style="margin-left: 3px; cursor: pointer;"></i>
                                                <i class='fas fa-times' id="delEmail" style="margin-left: 3px; cursor: pointer;"></i>
                                            </div>
                                            <input type="text" name="hiddenRefEmailInp" id="hiddenRefEmailInp" style="margin: 3px; border: 0px;" >
                                        </div>
                                        <button class="emailTreeBtn btn btn-secondary" type="button" data-event="hiddenRefEmailInp">주소록</button>
                                    </div>
                                </div>
                                <!-- 조직도 -->
                                <div style="width: 40%; float: right; margin-left: 30px;" id="emailTree">
                                    <div id="searchBar">
                                        <c:import url="../organization/searchBar.jsp" />
                                    </div>
                                    <div id="orgTree" style=" display: block;">
                                        <c:import url="../organization/orgList.jsp" />
                                    </div>
                                    <input id="btnEvent" type="hidden" value="ss" />
                                    <button id="emailTreeClose" type="button">닫기</button>
                                </div>
                            </div>
                            <!-- 메일 제목 -->
                            <div class="mb-3" style="margin-top: 15px;">
                                <label class="form-label">제목</label> 
                                <input type="text" id="emailSj" name="emailSj" class="form-control" placeholder="제목을 입력해 주세요." required>
                            </div>
                            
                            
                            <!-- 작성자 번호 -->
                            <input type="hidden" name="emplNo" value="${myEmpInfo.emplNo}">
                            <!-- 게시글 내용 (CKEditor) -->
                            <div class="col-sm-12">
                                <label class="form-label">내용</label>
                                <div id="descriptionTemp"></div>
                                <textarea id="emailCn" name="emailCn" rows="3" cols="30" class="form-control" hidden></textarea>
                            </div><br>

                            <!-- 작성자 이름 -->
                            <div class="mb-3">
                                <input type="hidden" name="emplNo" class="form-control" value="${myEmpInfo.emplNo}" readonly>
                            </div>

                            <!-- 파일 업로드 -->
                            <file-upload
                                label="첨부파일"
                                name="uploadFile"
                                max-files="5"
                                contextPath="${pageContext.request.contextPath}"
                            ></file-upload>

                            <!-- 전송 버튼 -->
                            <button type="button" id="sendMail" class="btn btn-primary">전송</button>
                            <button type="button" id="toList" class="btn btn-secondary">목록</button>
						</div>
					</div>
				</div>
			</div>
		</section>
		</div>
	</section>
	<c:import url="../layout/footer.jsp" />
</main>
<c:import url="../layout/prescript.jsp" />

 
<script type="text/javascript">
	//ckeditor5
	//<div id="descriptionTemp"></div>
	//editor : CKEditor객체를 말함
	ClassicEditor.create(document.querySelector("#descriptionTemp"),{ckfinder:{uploadUrl:"/mail/upload"}})
				 .then(editor=>{window.editor=editor;})
				 .catch(err=>{console.error(err.stack);});

    $(document).ready(function(){
        // console.log("${myEmpInfo}")
        $('#hiddenRefInp').hide();
        $('#emailTree').hide();
        $('#trnsmitEmail').val("${myEmpInfo.email}")

        // <input type="hidden" id="modelEmplNm" value="${emplNm}">
        // <input type="hidden" id="modelEmail" value="${email}">
        if($('#modelEmail').length&&$('#modelEmplNm').length){
            let email = $('#modelEmail').val();
            let emplNm = $('#modelEmplNm').val();
            $('#modelEmail').remove();
            $('#recpEmailInp').val(email);
            $('#recpEmailInpSpan').text(emplNm);
            setTimeout(function() {
                $('#recpEmailInp').trigger('change');
            }, 50);
        }

        // ckeditor5 시작
        $(".ck-blurred").keydown(function(){
            console.log("str : ", window.editor.getData());
            $("#emailCn").val(window.editor.getData());
        })
        $(".ck-blurred").on("focusout",function(){
            $("#emailCn").val(window.editor.getData());
        })
        // ckeditor5 끝

        $('#sendMail').on('click', function() {
            if($('#recpEmail').get().length==0){
                alert('수신 이메일을 작성해주세요')
                return 
            }
            let mailForm = new FormData();

            let trnsmitEmail = $('#trnsmitEmail').val();
            mailForm.append('trnsmitEmail', trnsmitEmail);
            let emplNo = $('input[name="emplNo"]').val();
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

            console.log("mailForm : ", mailForm);
            
            $.ajax({
                url: "/mail/sendMail",
                type: 'post',
                data: mailForm,
                processData: false,  // FormData 처리 시 필요
                contentType: false,  // FormData 처리 시 필요
                success: function(resp) {
                    console.log(resp);
                    window.location.href=resp;
                },
                error: function(err) {
                    console.log(err);
                }
            });
        });

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
            if(email == myMail){
                alert('자신의 이메일을 수신이메일란에 작성할 수 없습니다.');
                $('#recptnEmail').val('');
                return 
            }
            if(email != '' && !(isValidEmail(email))){
                alert('알맞지 않는 형식입니다.');
                $('#recptnEmail').val('');
                return
            }
            if(email != '' && validateDupl(email).length!=0){
                alert('이미 작성한 이메일입니다.');
                console.log('이거 실행되면 안됨');
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
                alert('자신의 이메일을 수신이메일란에 작성할 수 없습니다.');
                $('#refEmailInp').val('');
                return 
            }
            if(email!='' && !(isValidEmail(email))){
                alert('알맞지 않는 형식입니다.');
                return
            }
            if(email!='' && validateDupl(email).length!=0){
                alert('이미 작성한 이메일입니다.');
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
                alert('자신의 이메일을 수신이메일란에 작성할 수 없습니다.');
                $('#hiddenRefEmailInp').val('');
                return 
            }
            if(email!='' && !(isValidEmail(email))){
                alert('알맞지 않는 형식입니다.');
                return
            }
            if(email!='' && validateDupl(email).length!=0){
                alert('이미 작성한 이메일입니다.');
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
                alert('자신의 이메일을 수신이메일란에 작성할 수 없습니다.');
                spanField.text(emplNmState);
                emailField.val(emailState);
                return;
            }
            if(emailState!='' && !(isValidEmail(email))){
                alert('알맞지 않는 형식입니다.');
                spanField.text(emplNmState);
                emailField.val(emailState);
                return;
            }
            if((emailState!='' && validateDupl(email).length!=0) && email != emailState){
                alert(' 수정 : 이미 작성한 이메일입니다.');
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
                            alert('이미 작성한 이메일입니다.');
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


        
        $('#toList').on('click',function(){
            console.log('toList 버튼 눌림.');
            window.location.href="/mail"
        })
    });
    // $(window).unload(function() {
    //     // 언로드시 임시저장 (적힌게 있다면 y/n으로 물어보고 y면 저장 아니면 날림)
    // })

</script>
</body>
</html>
