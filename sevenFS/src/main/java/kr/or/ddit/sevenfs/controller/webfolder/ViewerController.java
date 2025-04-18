package kr.or.ddit.sevenfs.controller.webfolder;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("/viewer")
public class ViewerController {

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
}
