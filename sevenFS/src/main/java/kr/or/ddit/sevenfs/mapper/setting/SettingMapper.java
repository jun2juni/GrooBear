package kr.or.ddit.sevenfs.mapper.setting;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface SettingMapper {

    void insertSkillAuth(String emplNo);
}
