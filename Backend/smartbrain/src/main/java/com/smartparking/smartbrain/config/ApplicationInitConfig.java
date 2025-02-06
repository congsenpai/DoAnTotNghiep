package com.smartparking.smartbrain.config;
import java.sql.Timestamp;
import java.util.HashSet;

import org.springframework.boot.ApplicationRunner;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.crypto.password.PasswordEncoder;

import com.smartparking.smartbrain.enums.Roles;
import com.smartparking.smartbrain.model.User;
import com.smartparking.smartbrain.repository.UserRepository;

import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;

@Configuration
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
@Slf4j
public class ApplicationInitConfig {
    PasswordEncoder passwordEncoder;
    
    @Bean
        ApplicationRunner applicationRunner(UserRepository userReponsitory) {
            return args -> {
                log.info("Checking if user exists...");
                boolean checking = userReponsitory.existsByUsername("admin1");
                System.err.println(checking);
                log.warn("checking");
                if (checking == false) {
                    log.info("No user found with username: admin1. Creating default user.");
                    var roles = new HashSet<String>();
                    roles.add(Roles.ADMIN.name());

                    User user = User.builder()
                        .username("admin1")
                        .password(passwordEncoder.encode("admin1"))
                        .role(roles)
                        .firstName("Admin")
                        .lastName("User")
                        .email("admin@example.com")
                        .phone("1234567890")
                        .address("123 Admin St.")
                        .avatar("default-avatar.png")
                        .createdDate(new Timestamp(System.currentTimeMillis()))  // Thời gian tạo
                        .updatedDate(new Timestamp(System.currentTimeMillis()))  // Thời gian cập nhật
                        .status(true)  // Trạng thái người dùng
                        .build();
                    userReponsitory.save(user);
                    log.warn("A default user has been created");
                } else {
                    log.info("User with username 'admin1' already exists.");
                }
            };
        }

}
