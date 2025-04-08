package kr.or.ddit.sevenfs.mapper.statistics;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

@Mapper
public interface DemoMapper {
    public List<Map<String, Object>> getDemo(@Param("started") String started,
                                             @Param("ended") String ended,
                                             @Param("dclzCodeList") String[] dclzCodeList);

}
