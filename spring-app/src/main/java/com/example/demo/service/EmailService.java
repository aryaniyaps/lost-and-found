package com.example.demo.service;

import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

@Service
public class EmailService {

    private final JavaMailSender mailSender;

    public EmailService(JavaMailSender mailSender) {
        this.mailSender = mailSender;
    }

    public void sendItemMatchNotification(String toEmail, String itemTitle, String itemType, String finderName) {
        SimpleMailMessage message = new SimpleMailMessage();
        message.setTo(toEmail);
        message.setSubject("Your " + itemType.toLowerCase() + " item has been found!");
        message.setText("Dear user,\n\n" +
                "Great news! Your " + itemType.toLowerCase() + " item '" + itemTitle
                + "' has been reported as found by " + finderName + ".\n\n" +
                "Please log in to your account to view the details and contact the finder.\n\n" +
                "Best regards,\n" +
                "Lost & Found Team");
        mailSender.send(message);
    }

    public void sendItemFoundNotification(String toEmail, String itemTitle, String itemType) {
        SimpleMailMessage message = new SimpleMailMessage();
        message.setTo(toEmail);
        message.setSubject("Item Found - " + itemTitle);
        message.setText("Dear user,\n\n" +
                "Your reported " + itemType.toLowerCase() + " item '" + itemTitle + "' has been found.\n\n" +
                "Please log in to your account to view the details.\n\n" +
                "Best regards,\n" +
                "Lost & Found Team");
        mailSender.send(message);
    }
}
