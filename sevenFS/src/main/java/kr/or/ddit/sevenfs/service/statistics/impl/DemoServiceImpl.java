package kr.or.ddit.sevenfs.service.statistics.impl;

import kr.or.ddit.sevenfs.mapper.statistics.DemoMapper;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

@Slf4j
@Service
public class DemoServiceImpl {
    @Autowired
    private DemoMapper demoMapper;

    public List<Map<String, Object>> getDemo(String started, String ended, String[] dclzCodeList) {
        List<Map<String, Object>> rawList = demoMapper.getDemo(started, ended, dclzCodeList);
        log.debug("rawList: {}", rawList);


        return rawList;
    }
}
