package kr.or.ddit.sevenfs.mapper.setting;

import kr.or.ddit.sevenfs.vo.setting.SkillAuthVO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface SettingMapper {
    void insertSkillAuth(String emplNo);

    List<SkillAuthVO> getSkillAuth(String emplNo);
}
