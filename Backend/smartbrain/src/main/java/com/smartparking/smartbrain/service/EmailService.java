// package com.smartparking.smartbrain.service;

<<<<<<< HEAD
// import org.springframework.beans.factory.annotation.Autowired;
// import org.springframework.mail.javamail.JavaMailSender;
// import org.springframework.mail.javamail.MimeMessageHelper;
// import org.springframework.stereotype.Service;
// import org.thymeleaf.TemplateEngine;
// import org.thymeleaf.context.Context;

// import jakarta.mail.MessagingException;
// import jakarta.mail.internet.MimeMessage;

// import java.util.Map;

// @Service
// public class EmailService {

//     @Autowired
//     private JavaMailSender mailSender;

//     @Autowired
//     private TemplateEngine templateEngine;

//     public void sendResetPasswordEmail(String to, Map<String, Object> variables) throws MessagingException {
//         Context context = new Context();
//         context.setVariables(variables);
//         String htmlContent = templateEngine.process("reset-password", context);

//         MimeMessage message = mailSender.createMimeMessage();
//         MimeMessageHelper helper = new MimeMessageHelper(message, true);
//         helper.setTo(to);
//         helper.setSubject("Reset Your Password");
//         helper.setText(htmlContent, true);
//         mailSender.send(message);
//     }
// }
=======
import java.util.Map;

import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;
import org.thymeleaf.TemplateEngine;
import org.thymeleaf.context.Context;

import jakarta.mail.MessagingException;
import jakarta.mail.internet.MimeMessage;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;

@Service
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class EmailService {

	JavaMailSender mailSender;
	TemplateEngine templateEngine;

	public void sendResetPasswordEmail(String to, Map<String, Object> variables) throws MessagingException {
		Context context = new Context();
		context.setVariables(variables);
		String htmlContent = templateEngine.process("reset-password", context);

		MimeMessage message = mailSender.createMimeMessage();
		MimeMessageHelper helper = new MimeMessageHelper(message, true);
		helper.setTo(to);
		helper.setSubject("Reset Your Password");
		helper.setText(htmlContent, true);
		mailSender.send(message);
	}
}
>>>>>>> main
