package com.smartparking.smartbrain.config;
import java.time.Instant;
import java.util.HashSet;
import java.util.Set;

import org.springframework.boot.ApplicationRunner;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.crypto.password.PasswordEncoder;

import com.smartparking.smartbrain.model.Role;
import com.smartparking.smartbrain.model.User;
import com.smartparking.smartbrain.repository.RoleRepository;
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
        ApplicationRunner applicationRunner(UserRepository userReponsitory, RoleRepository roleRepository) {
            return args -> {
                log.info("Checking if user exists...");
                boolean checking = userReponsitory.existsByUsername("admin1");
                System.err.println(checking);
                log.warn("checking");
                if (checking == false) {
                    log.info("No user found with username: admin1. Creating default user.");
                    Role role = Role.builder()
                        .roleName("ADMIN")
                        .description("ADMIN ROLE")
                        .build();
                    Set<Role> roles = new HashSet<>();
                    roles.add(role);
                    roleRepository.save(role);
                    User user = User.builder()
                        .username("admin1")
                        .password(passwordEncoder.encode("admin1"))
                        .roles(roles)
                        .firstName("Admin")
                        .lastName("User")
                        .email("admin@example.com")
                        .phone("1234567890")
                        .homeAddress("123 Admin St.")
                        .companyAddress("123 Admin St.")
                        .avatar("default-avatar.png")
                        .createdAt(Instant.now()) // Thời gian tạo
                        .updatedAt(Instant.now())  // Thời gian cập nhật
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
