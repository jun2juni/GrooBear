package kr.or.ddit.sevenfs.controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.http.HttpServletRequest;
import lombok.extern.slf4j.Slf4j;
import org.springframework.boot.web.servlet.error.ErrorController;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.HashMap;
import java.util.Map;

@Slf4j
@Controller
public class CustomErrorController implements ErrorController {

    @RequestMapping("/error")
    public Object handleError(HttpServletRequest request) {
        Object status = request.getAttribute(RequestDispatcher.ERROR_STATUS_CODE);
        String requestUri = (String) request.getAttribute(RequestDispatcher.ERROR_REQUEST_URI);
        log.debug("request uri: {}", requestUri);

        if (status != null) {
            Integer statusCode = Integer.valueOf(status.toString());
            HttpStatus httpStatus = HttpStatus.valueOf(statusCode);

            if (requestUri != null && requestUri.startsWith("/api")) {
                // API 요청에 대한 에러 응답
                Map<String, Object> errorAttributes = new HashMap<>();
                errorAttributes.put("status", httpStatus.value());
                errorAttributes.put("error", httpStatus.getReasonPhrase());
                errorAttributes.put("message", "API error occurred");
                errorAttributes.put("path", requestUri);
                return new ResponseEntity<>(errorAttributes, httpStatus);
            } else {
                // 웹 페이지 요청에 대한 에러 페이지 반환
                return "error/" + statusCode; // ex. error/404.jsp 또는 error/500.html
            }
        }

        return "error"; // 기본 에러 페이지
    }


}

