package kr.or.ddit.sevenfs.utils;

import lombok.Getter;
import org.springframework.stereotype.Component;

@Component
public class CommonCode {

    @Getter
    public enum GroupEnum {
        ATTEND("근태", "ATTEND"),
        POSITION("직급", "POSITION"),
        DEPARTMENT("부서", "DEPARTMENT"),
        GENDER("성별", "GENDER"),
        EMPL_STATUS("사원 상태", "EMPL_STATUS"),
        SKILL("기능", "SKILL"),
        SKILL_AUTHOR("기능 권한", "SKILL_AUTHOR");

        private final String label;
        private final String code;

        GroupEnum(String label, String code) {
            this.label = label;
            this.code = code;
        }

        // 코드에 맞는 label을 반환하는 메서드
        public String getLabelByCode(String code) {
            for (GroupEnum group : values()) {
                if (group.code.equals(code)) {
                    return group.label;
                }
            }

            return null;  // 코드가 일치하지 않으면 null 반환
        }
    }

    @Getter
    public enum AttendEnum {
        BAD("00", "근태불량"),
        WORK("10", "근무"),
        VACATION("20", "휴가"),
        BUSINESS("30", "출장"),
        LATE("01", "지각", "00"),
        ABSENT("02", "결근", "00"),
        EARLY_LEAVE("03", "조퇴", "00"),
        HALF_DAY("21", "반차", "20"),
        ANNUAL_LEAVE("22", "연차", "20"),
        OFFICIAL_LEAVE("23", "공가", "20"),
        SICK_LEAVE("24", "병가", "20"),
        OUT_WORK("32", "외근", "30"),
        OVERTIME("33", "연장근무", "30");

        private final String code;
        private final String label;
        private final String parentCode;

        AttendEnum(String code, String label) {
            this(code, label, null);
        }

        AttendEnum(String code, String label, String parentCode) {
            this.code = code;
            this.label = label;
            this.parentCode = parentCode;
        }

        // 코드에 맞는 label을 반환하는 메서드
        public String getLabelByCode(String code) {
            for (AttendEnum value : values()) {
                if (value.code.equals(code)) {
                    return value.label;
                }
            }

            return null;  // 코드가 일치하지 않으면 null 반환
        }
    }

    @Getter
    public enum DepartmentEnum {
        REPRESENTATIVE("00", "대표이사", null),
        HR("01", "인사부", null),
        MANAGEMENT_SUPPORT("02", "경영지원부", null),
        SALES("03", "영업부", null),
        PRODUCTION("04", "생산부", null),
        PURCHASING("05", "구매부", null),
        QUALITY("06", "품질부", null),
        DESIGN("07", "디자인부", null),
        RESEARCH("08", "연구소", null),
        FINANCE_MANAGEMENT_TEAM("20", "재무관리팀", "02"),
        DOMESTIC_SALES_TEAM("30", "국내영업팀", "03"),
        PRODUCTION_MANAGEMENT_TEAM("40", "생산관리팀", "04"),
        DOMESTIC_PURCHASING_TEAM("50", "내자구매팀", "05"),
        RAW_MATERIAL_MANAGEMENT_TEAM("60", "원료관리팀", "06"),
        PRODUCT_DESIGN_TEAM("70", "제품디자인팀", "07"),
        NEW_TECHNOLOGY_TEAM("80", "신기술팀", "08"),
        FINANCE_ACCOUNTING_TEAM("21", "재무회계팀", "20"),
        INTERNATIONAL_SALES_TEAM("31", "해외영업팀", "03"),
        INVENTORY_MANAGEMENT_TEAM("41", "재고관리팀", "04"),
        INTERNATIONAL_PURCHASING_TEAM("51", "외자구매팀", "05"),
        PRACTICAL_DEVELOPMENT_TEAM("81", "실용개발팀", "08"),
        MARKETING("32", "마케팅부", "03");

        private final String code;
        private final String label;
        private final String parentCode;

        DepartmentEnum(String code, String label, String parentCode) {
            this.code = code;
            this.label = label;
            this.parentCode = parentCode;
        }

        // 코드에 맞는 label을 반환하는 메서드
        public String getLabelByCode(String code) {
            for (DepartmentEnum value : values()) {
                if (value.code.equals(code)) {
                    return value.label;
                }
            }

            return null;  // 코드가 일치하지 않으면 null 반환
        }
    }

    @Getter
    public enum PositionEnum {
        INTERN("00", "인턴"),
        STAFF("01", "사원"),
        대리("02", "대리"),
        MANAGER("03", "과장"),
        SENIOR_MANAGER("04", "부장"),
        DIRECTOR("05", "이사"),
        EXECUTIVE_DIRECTOR("06", "상무"),
        VICE_PRESIDENT("07", "전무"),
        SENIOR_VICE_PRESIDENT("08", "부사장"),
        PRESIDENT("09", "사장");

        private final String code;
        private final String label;

        PositionEnum(String code, String label) {
            this.code = code;
            this.label = label;
        }

        // 코드에 맞는 label을 반환하는 메서드
        public String getLabelByCode(String code) {
            for (PositionEnum value : values()) {
                if (value.code.equals(code)) {
                    return value.label;
                }
            }

            return null;  // 코드가 일치하지 않으면 null 반환
        }
    }

    @Getter
    public enum GenderEnum {
        MALE("00", "남성"),
        FEMALE("01", "여성");

        private final String code;
        private final String label;

        GenderEnum(String code, String label) {
            this.code = code;
            this.label = label;
        }

        // 코드에 맞는 label을 반환하는 메서드
        public String getLabelByCode(String code) {
            for (GenderEnum value : values()) {
                if (value.code.equals(code)) {
                    return value.label;
                }
            }

            return null;  // 코드가 일치하지 않으면 null 반환
        }
    }

    @Getter
    public enum EmployeeStatusEnum {
        OFFLINE("00", "오프라인"),
        WORKING("01", "업무중"),
        AWAY("02", "자리비움"),
        DND("03", "방해금지");

        private final String code;
        private final String label;

        EmployeeStatusEnum(String code, String label) {
            this.code = code;
            this.label = label;
        }

        // 코드에 맞는 label을 반환하는 메서드
        public String getLabelByCode(String code) {
            for (EmployeeStatusEnum value : values()) {
                if (value.code.equals(code)) {
                    return value.label;
                }
            }

            return null;  // 코드가 일치하지 않으면 null 반환
        }
    }

    @Getter
    public enum SkillEnum {
        PROJECT("00", "프로젝트"),
        BOARD("01", "게시판"),
        E_APPROVAL("02", "전자결재"),
        DOCUMENTS("03", "문서함"),
        SCHEDULE("04", "일정"),
        EMAIL("05", "메일"),
        MESSENGER("06", "메신저"),
        NOTIFICATIONS("07", "알림"),
        STATISTICS("08", "통계");

        private final String code;
        private final String label;

        SkillEnum(String code, String label) {
            this.code = code;
            this.label = label;
        }

        // 코드에 맞는 label을 반환하는 메서드
        public String getLabelByCode(String code) {
            for (SkillEnum value : values()) {
                if (value.code.equals(code)) {
                    return value.label;
                }
            }

            return null;  // 코드가 일치하지 않으면 null 반환
        }
    }

    @Getter
    public enum SkillAuthorEnum {
        READ("00", "읽기"),
        WRITE("01", "쓰기"),
        EDIT("02", "수정"),
        DELETE("03", "삭제");

        private final String code;
        private final String label;

        SkillAuthorEnum(String code, String label) {
            this.code = code;
            this.label = label;
        }

        // 코드에 맞는 label을 반환하는 메서드
        public String getLabelByCode(String code) {
            for (SkillAuthorEnum value : values()) {
                if (value.code.equals(code)) {
                    return value.label;
                }
            }

            return null;  // 코드가 일치하지 않으면 null 반환
        }
    }

}
