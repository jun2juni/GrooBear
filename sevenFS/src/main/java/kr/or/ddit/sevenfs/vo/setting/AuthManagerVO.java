package kr.or.ddit.sevenfs.vo.setting;

import lombok.Data;

import java.util.List;

@Data
public class AuthManagerVO {
    private List<SkillAuthVO> skillAuthVOList;
}
