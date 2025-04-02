package kr.or.ddit.sevenfs.controller.bbs;

import org.springframework.stereotype.Component;

import lombok.Getter;

@Getter
@Component
public class BeanController {
	private String uploadFolder = "C:\\SJupload\\";// || //는 웹 경로, \\는 윈도우 경로 ||
}
