package kr.or.ddit.sevenfs.controller.setting;

import kr.or.ddit.sevenfs.service.organization.OrganizationService;
import kr.or.ddit.sevenfs.service.setting.SettingService;
import kr.or.ddit.sevenfs.vo.CommonCodeVO;
import kr.or.ddit.sevenfs.vo.organization.EmployeeVO;
import kr.or.ddit.sevenfs.vo.setting.SkillAuthVO;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Slf4j
@Controller
@RestController
@RequestMapping("/api")
public class AuthSettingController {
    @Autowired
    private OrganizationService organizationService;
    @Autowired
    private SettingService settingService;

    // 기능 권한 불러오기
    @GetMapping("/skill/getAuth")
    public Map<String, Object> getSkillAuth(String emplNo) {
        Map<String, Object> result = new HashMap<>();
        List<SkillAuthVO> skillAuth = settingService.getSkillAuth(emplNo);
        log.debug("skillAuth: {}", skillAuth);
        result.put("skillAuth", skillAuth);

        return result;
    }

    // 기능 권한 수정
    @PostMapping("/skill/update")
    public Map<String, Object> updateSkillAuth(String emplNo, SkillAuthVO skillAuthVO) {
        Map<String, Object> result = new HashMap<>();

        return  result;
    }


    // 상위 부서 목록 가져오기
    @GetMapping("/org/deptList")
    public Map<String, Object> deptList() {
        Map<String, Object> result = new HashMap<>();
        try {
            List<CommonCodeVO> commonCodeVOList = organizationService.upperDepList();
            List<EmployeeVO> employeeVOS = organizationService.empList();

            // 부서 정보 가져오기
            commonCodeVOList.stream()
                    .forEach((dept) -> {
                        List<CommonCodeVO> lowerDepList = organizationService.lowerDepList(dept.getCmmnCode());

                        // 부서 정보 반복
                        lowerDepList.stream()
                                .forEach(lowerDep -> {
                                    // 해당 부서에 맞는 사원 넣어주기
                                    List<EmployeeVO> list = new ArrayList<>();
                                    employeeVOS.stream()
                                            .forEach((emp) -> {
                                                if (emp.getDeptCode().equals(lowerDep.getCmmnCode())) {
                                                    list.add(emp);
                                                }
                                            });
                                    lowerDep.setEmployeeList(list);
                                });
                        dept.setLowerDeptList(lowerDepList);
                    });

            log.debug("commonCodeVOList {}", commonCodeVOList);
            result.put("deptList", commonCodeVOList);
            result.put("success", true);
        } catch (Exception e) {
            e.printStackTrace();
            result.put("success", false);
        }

        return  result;
    }

}
