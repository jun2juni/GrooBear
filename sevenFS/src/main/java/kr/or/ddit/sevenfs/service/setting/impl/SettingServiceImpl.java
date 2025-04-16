package kr.or.ddit.sevenfs.service.setting.impl;

import kr.or.ddit.sevenfs.mapper.setting.SettingMapper;
import kr.or.ddit.sevenfs.service.setting.SettingService;
import kr.or.ddit.sevenfs.vo.setting.SkillAuthVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class SettingServiceImpl implements SettingService {
    @Autowired
    private SettingMapper settingMapper;

    @Override
    public void insetSkillAuth(String emplNo) {
        settingMapper.insertSkillAuth(emplNo);
    }

    @Override
    public List<SkillAuthVO> getSkillAuth(String emplNo) {
        return settingMapper.getSkillAuth(emplNo);
    }
}
