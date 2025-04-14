//package kr.or.ddit.sevenfs.controller;
//
//import jakarta.servlet.RequestDispatcher;
//import jakarta.servlet.http.HttpServletRequest;
//import lombok.extern.slf4j.Slf4j;
//import org.springframework.boot.web.servlet.error.ErrorController;
//import org.springframework.http.HttpStatus;
//import org.springframework.http.ResponseEntity;
//import org.springframework.stereotype.Controller;
//import org.springframework.web.bind.annotation.RequestMapping;
//
//import java.util.HashMap;
//import java.util.Map;
//
//@Slf4j
//@Controller
//public class CustomErrorController implements ErrorController {
//
//    @RequestMapping("/error")
//    public Object handleError(HttpServletRequest request) {
//        Object status = request.getAttribute(RequestDispatcher.ERROR_STATUS_CODE);
//        String requestUri = (String) request.getAttribute(RequestDispatcher.ERROR_REQUEST_URI);
//        String contentType = request.getContentType(); // contentType으로도 구분 가능
//        String acceptHeader = request.getHeader("Accept");
//
//        log.debug("request uri: {}, accept: {}", requestUri, acceptHeader);
//
//        if (status != null) {
//            Integer statusCode = Integer.valueOf(status.toString());
//            HttpStatus httpStatus = HttpStatus.valueOf(statusCode);
//
//            // 1. API 요청 판단
//            boolean isApiRequest = requestUri != null && requestUri.startsWith("/api");
//            boolean isJsonRequest = acceptHeader != null && acceptHeader.contains("application/json");
//
//            if (isApiRequest || isJsonRequest) {
//                Map<String, Object> errorAttributes = new HashMap<>();
//                errorAttributes.put("status", httpStatus.value());
//                errorAttributes.put("error", httpStatus.getReasonPhrase());
//                errorAttributes.put("message", "API error occurred");
//                errorAttributes.put("path", requestUri);
//                return new ResponseEntity<>(errorAttributes, httpStatus);
//            }
//
//            // 2. 일반 웹 요청은 뷰 이름 반환
//            return "error/" + statusCode; // ex. error/404.jsp 또는 error/500.html
//        }
//
//        return "error"; // fallback
//    }
//
//}
//
