package com.himedia.groupware.controller;

import com.himedia.groupware.dto.UserDto;
import com.himedia.groupware.service.MailService;
import com.himedia.groupware.service.SseEmitterManager;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.server.ResponseStatusException;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;

@RestController
public class SseController {
    @Autowired
    SseEmitterManager emitterManager;
    @Autowired
    MailService ms;
    // 로그인 상태를 구독시키는 클래스
    @GetMapping("/sse/subscribe")
    public SseEmitter subscribe(HttpSession session) {
        UserDto loginUser = (UserDto) session.getAttribute("loginUser");
        if (loginUser == null) {
            System.out.println("로그인 안 됨");
            throw new ResponseStatusException(HttpStatus.UNAUTHORIZED, "로그인 필요");
        }

        // 실시간 통신을 위한 emitter 생성
        int userId = loginUser.getId();
        SseEmitter emitter = emitterManager.createEmitter(userId);

        // 오프라인 수신된 메일 확인
        int unnotifiedCount = ms.countUnnotified(userId);
        if (unnotifiedCount > 0) { // 해당 메일이 있을 경우 알림 메서드 호출 후 모든 notified를 true(1)로 설정
            emitterManager.sendUnnotified(userId, unnotifiedCount);
            ms.clearUnnotified(userId);
        }

        return emitter;
    }

}