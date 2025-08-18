package com.himedia.groupware.service;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.stereotype.Service;

@Service
public class EmailService {
    @Autowired
    private JavaMailSender javaMailSender;
    @Autowired
    private JavaMailSenderImpl mailSender;

    public void sendEmail(String email, String content) {
        SimpleMailMessage message = new SimpleMailMessage();
        message.setTo("받는 사람 주소");
        message.setReplyTo(email);  // 보내는 사람
        message.setText(content);
        message.setSubject(email);

        mailSender.send(message);
    }
}
