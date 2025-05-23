# 🧾 7FS Final Project - 그룹웨어 시스템


> 전자결재 중심의 그룹웨어 시스템  
> 사내 문서 기안 · 결재선 지정 · 연차 신청 · 결재 흐름 관리 등 통합 전자결재 기능을 제공합니다.

---

## 🗂 프로젝트 개요
- 🌐 프로젝트: 모든 회사가 적용될 수 있는 그룹웨어
- 👨‍👩‍👧‍👦 분류: 팀 프로젝트
- 📆 개발 기간: 2025.03.28 ~ 2025.04.25
- 👩‍💻 기획 및 제작: 허성진, 채성실, 백현명, 길준희, 박호산나, 유대현, 박현준 (7명)

- 🛠 개발 환경: Java 21, Spring Boot, Oracle DB, MyBatis, JSP, JavaScript

---

## 🔧 주요 기능

### ✅ 전자결재 기능
- 결재 문서 작성, 임시저장, 결재 제출
- 결재선 지정 (드래그 앤 드롭 방식)
- 결재 처리 (승인 / 반려 / 회수 / 재상신)
- 참조자 지정 및 열람 확인 기능
- 첨부파일 업로드 및 다운로드

### 🌴 연차신청 기능
- 연차 신청서 전자결재화
- 휴가 기간 중 공휴일 자동 제외
- 연차 승인 시 VACATION 테이블에 자동 반영

### 🔍 문서함 관리
- 상태별 문서함 (기안함 / 결재함 / 수신참조함 / 완료함 등)
- 조건 검색 (문서제목, 기안일자, 상태 등)

---

## 🖥 주요 화면

| 기능 | 이미지 |
|------|--------|
| 결재 문서 작성 | ![기안화면](./images/draft.png) |
| 결재선 지정 | ![결재선](./images/approval_line.png) |
| 연차 신청 | ![연차](./images/vacation.png) |
| 결재처리 화면 | ![결재처리](./images/approve.png) |

---

## ⚙️ 기술 스택

| 구분 | 내용 |
|------|------|
| Backend | Spring Boot, MyBatis, Lombok |
| Frontend | JSP, HTML/CSS, JavaScript, jQuery |
| DB | Oracle 11g |
| Version Control | Git, GitHub |
| Build Tool | Maven |

---

## 🗃 ERD 및 테이블

- **ATRZ**: 전자결재 문서 테이블  
- **ATRZ_LINE**: 결재선 정보  
- **DOCUM_HOLIDAY**: 휴가 신청 문서 상세  
- **VACATION**: 연차 관리  
- **EMPLOYEE**: 직원 정보  
- **COMMON_CODE / GROUP**: 코드 관리

![ERD](./images/erd.png)

---

## 🔁 결재 프로세스

1. 문서 기안  
2. 결재선 지정  
3. 결재 제출 → 순차 결재 진행  
4. 결재 완료 시 연차 등 반영  
5. 완료함으로 이동 및 열람 가능

---

## 📄 API 예시 (선택)

```http
POST /eapproval/submit
Content-Type: application/json

{
  "title": "연차신청서",
  "drafterId": "EMP001",
  "lines": [
    { "empId": "EMP002", "order": 1 },
    { "empId": "EMP003", "order": 2 }
  ],
  "vacation": {
    "startDate": "2025-06-01",
    "endDate": "2025-06-03"
  }
}
