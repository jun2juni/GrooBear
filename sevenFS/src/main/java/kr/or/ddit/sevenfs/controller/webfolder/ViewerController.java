package kr.or.ddit.sevenfs.controller.webfolder;

import kr.or.ddit.sevenfs.utils.FileReaderUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.io.IOException;
import java.util.Base64;
import java.util.Collections;
import java.util.List;

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

    @GetMapping("/pdf/image")
    @ResponseBody
    public ResponseEntity<List<String>> getPdfImage(@RequestParam String pdfPath) {
        List<byte[]> pages = fileReaderUtil.readPdfAll(pdfPath);
        List<String> base64Images = pages.stream()
                .map(bytes -> Base64.getEncoder().encodeToString(bytes))
                .toList();

        return ResponseEntity.ok()
                .contentType(MediaType.APPLICATION_JSON)
                .body(base64Images);

    }


    @GetMapping("/text")
    public String text(@RequestParam String text, Model model) {
        String s = fileReaderUtil.readFile(text, 100);
        log.debug("string {}", s);
        model.addAttribute("text", s);

        return "viewer/text";
    }

    @GetMapping("/zip")
    public String zip(@RequestParam String zip, Model model) {
        String s = fileReaderUtil.readFile(zip, 100);
        log.debug("string {}", s);
        model.addAttribute("zip", s);

        return "viewer/zip";
    }
}
