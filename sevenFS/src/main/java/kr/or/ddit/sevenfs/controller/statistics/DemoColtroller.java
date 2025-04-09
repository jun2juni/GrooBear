package kr.or.ddit.sevenfs.controller.statistics;

import kr.or.ddit.sevenfs.service.statistics.impl.DemoServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

@RequestMapping("/hm")
@RestController
public class DemoColtroller {
    @Autowired
    private DemoServiceImpl demoService;

    @GetMapping("/fighting")
    public Map<String, Object> fighting() {
        Map<String, Object> result = new HashMap<>();
        String[] header = {"임원진", "인사부"};
        String[] dclzArr = {"01", "02", "03"};
        List<Map<String, Object>> demo = demoService.getDemo("20240101", "20251231", header);
        result.put("demo", demo);
        return result;
    }
}
