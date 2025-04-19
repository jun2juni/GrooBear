package kr.or.ddit.sevenfs.controller.webfolder;

import kr.or.ddit.sevenfs.utils.FileReaderUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Slf4j
@Controller
@RequestMapping("/viewer")
public class ViewerController {
    @Autowired
    private FileReaderUtil fileReaderUtil;

    @GetMapping("/image")
    public String image(@RequestParam String image, Model model) {
        model.addAttribute("image", image);

        return "viewer/image";
    }

    @GetMapping("/pdf")
    public String pdf(@RequestParam String pdf, Model model) {
        model.addAttribute("pdf", pdf);

        return "viewer/pdf";
    }

    @GetMapping("/text")
    public String text(@RequestParam String text, Model model) {
        String s = fileReaderUtil.readFile(text, 100);
        log.debug("string {}", s);
        model.addAttribute("text", s);

        return "viewer/text";
    }
}
