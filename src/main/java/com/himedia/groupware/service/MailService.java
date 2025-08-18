package com.himedia.groupware.service;

import jakarta.mail.MessagingException;
import jakarta.mail.internet.MimeMessage;
import lombok.RequiredArgsConstructor;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
@RequiredArgsConstructor //
public class MailService {
    private final JavaMailSender JMSender;
    private static int number;
    public int sendMail(String email) {
        number = (int)(Math.random()*90000)+100000;

        MimeMessage message = JMSender.createMimeMessage();
        try {
            message.setFrom("shtndhks123@gmail.com");
            message.setRecipients(MimeMessage.RecipientType.TO, email);
            message.setSubject("이메일 인증");

            String body= "";
            body += "<h3>" + "요청하신 인증 번호입니다." + "</h3>";
            body += "<h1>" + number + "</h1>";
            body += "<h3>" + "감사합니다." + "</h3>";
            message.setText(body, "UTF-8", "html");
        }catch (MessagingException e){
            throw new RuntimeException(e);
        }
        JMSender.send(message);
        return number;
    }
}
