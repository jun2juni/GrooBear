package kr.or.ddit.sevenfs.service.setting;

import kr.or.ddit.sevenfs.vo.setting.SkillAuthVO;

import java.util.List;

public interface SettingService {
    // 권한 부여
    public void insetSkillAuth(String emplNo);

    // 권한 불러오기
    public List<SkillAuthVO> getSkillAuth(String emplNo);

    // 권한 수정
}
