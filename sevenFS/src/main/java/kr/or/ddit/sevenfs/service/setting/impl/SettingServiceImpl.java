package kr.or.ddit.sevenfs.service.setting.impl;

import kr.or.ddit.sevenfs.mapper.setting.SettingMapper;
import kr.or.ddit.sevenfs.service.setting.SettingService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class SettingServiceImpl implements SettingService {
    @Autowired
    private SettingMapper settingMapper;

    @Override
    public void insetSkillAuth(String emplNo) {
        settingMapper.insertSkillAuth(emplNo);
    }
}
