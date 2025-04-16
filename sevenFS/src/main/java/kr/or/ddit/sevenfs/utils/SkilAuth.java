package kr.or.ddit.sevenfs.utils;

import kr.or.ddit.sevenfs.vo.organization.EmployeeVO;
import org.springframework.stereotype.Component;

@Component
public class SkilAuth {
    public static void main(String[] args) {
                checkWrite(new EmployeeVO(), CommonCode.SkillEnum.BOARD);
    }

    public static boolean checkWrite(EmployeeVO employeeVO, CommonCode.SkillEnum skillEnum) {

        return false;
    }
}
