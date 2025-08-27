package com.himedia.groupware.service;

import jakarta.annotation.PreDestroy;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;

import java.io.IOException;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

// 실시간 알림을 위한 SSE Emitter 관리 클래스
@Component
public class SseEmitterManager {
    private final Map<Integer, SseEmitter> emitters = new ConcurrentHashMap<>();

    public SseEmitter createEmitter(Integer clientId) {
        SseEmitter emitter = new SseEmitter(30*60*1000L); // 타임아웃 없음(30분 연결)
        emitters.put(clientId, emitter); // 접속 아이디를 emitter에 넣고 연결

        emitter.onCompletion(() -> emitters.remove(clientId));
        emitter.onTimeout(() -> emitters.remove(clientId));
        emitter.onError((e) -> emitters.remove(clientId));

        return emitter;
    }
    // 호출 시 클라이언트에 emitter에 알림 이벤트 명령
    public void sendToClient(Integer clientId, Object data) {
        SseEmitter emitter = emitters.get(clientId);
        if (emitter != null) {
            try {
                emitter.send(SseEmitter.event().name("mail").data(data));
            } catch (IOException e) {
                emitters.remove(clientId);
                System.out.println("이벤트 전송 오류, emitter 제거");
            }
        } else {
            System.out.println("해당 clientId의 emitter 없음");
        }
    }

    @PreDestroy
    public void closeAllEmitters() {
        for (SseEmitter emitter : emitters.values()) {
            try {
                emitter.complete();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        emitters.clear();
    }
}