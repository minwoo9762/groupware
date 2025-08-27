package com.himedia.groupware.controller;

import com.himedia.groupware.dto.UserDto;
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

    @GetMapping("/sse/subscribe")
    public SseEmitter subscribe(HttpSession session) {
        UserDto loginUser = (UserDto) session.getAttribute("loginUser");
        if (loginUser == null) {
            System.out.println("로그인 안 됨");
            throw new ResponseStatusException(HttpStatus.UNAUTHORIZED, "로그인 필요");
        }
        return emitterManager.createEmitter(loginUser.getId());
    }

}