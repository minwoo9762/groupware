package com.himedia.groupware.service;

import org.springframework.stereotype.Component;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;

import java.io.IOException;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

// 실시간 알림을 위한 SSE Emitter 관리 클래스
@Component
public class SseEmitterManager {
    private final Map<Integer, SseEmitter> emitters = new ConcurrentHashMap<>();
    // emitter 생성
    public SseEmitter createEmitter(Integer clientId) {
        // 해당 클라이언트 ID의 emitter가 존재할 경우 종료 및 삭제(중복 및 에러 방지)
        SseEmitter previous = emitters.remove(clientId);
        if (previous != null) {
            try {
                previous.complete();
            } catch (Exception ignored) {}
        }

        SseEmitter emitter = new SseEmitter(30*60*1000L); // 타임아웃(30분 연결)
        emitters.put(clientId, emitter); // 접속 아이디를 emitter에 넣고 연결

        // emitter를 종료, 삭제하는 조건
        emitter.onCompletion(() -> emitters.remove(clientId)); // 작업 만료 시
        emitter.onTimeout(() -> { // 타임아웃 시
            emitter.complete();
            emitters.remove(clientId);
        });
        emitter.onError((e) -> { // 에러 발생 시
            emitter.complete();
            emitters.remove(clientId);
        });

        return emitter;
    }
    // 호출 시 클라이언트에 emitter에 메일 수신 알림 이벤트를 명령하는 메서드
    public boolean setNotification(Integer clientId, Object data) {
        SseEmitter emitter = emitters.get(clientId); // 접속 아이디가 연결된 emitter 불러오기
        boolean result = false;
        if (emitter != null) { // 해당 유저가 접속 중일 경우
            try { // mail이라는 이름의 이벤트를 받아온 data와 함께 전달
                emitter.send(SseEmitter.event().name("mail").data(data));
                result = true;
            } catch (IOException e) {
                emitters.remove(clientId);
                System.out.println("이벤트 전송 오류, emitter 제거");
            }
        }
        return result;
    }

    // 로그인 시 오프라인에서 수신받은 메시지 알림 이벤트를 명령하는 메서드
    public void sendUnnotified(int clientId, int count) {
        SseEmitter emitter = emitters.get(clientId);
        try { // unnotified-mail 이벤트를 count와 함께 전달
            emitter.send(SseEmitter.event().name("unnotified-mail").data(count));
        } catch (IOException e) {
            emitters.remove(clientId);
            System.out.println("이벤트 전송 오류, emitter 제거");
        }
    }
}