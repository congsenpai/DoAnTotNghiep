package com.smartparking.smartbrain.model;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import jakarta.persistence.*;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;

import lombok.AllArgsConstructor;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@Entity
@Table(name = "users")
@ToString
@EqualsAndHashCode
@AllArgsConstructor
@NoArgsConstructor
public class User {

    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    private String userId;

    @Column(unique = true, nullable = false)
    @NotNull(message = "Username cannot be null")
    @Size(min = 3, max = 50, message = "Username must be between 3 and 50 characters")
    private String username;

    @Column(nullable = false)
    @NotNull(message = "Password cannot be null")
    @Size(min = 8, message = "Password must be at least 8 characters long")
    private String password;

    @Column(nullable = false)
    @NotNull(message = "First name cannot be null")
    private String firstName;

    @Column(nullable = false)
    @NotNull(message = "Last name cannot be null")
    private String lastName;

    @Column(unique = true, nullable = false)
    @Email(message = "Email should be valid")
    @NotNull(message = "Email cannot be null")
    private String email;

    private String phone;
    private String address;

    @Column(nullable = false)
    @NotNull(message = "Role cannot be null")
    private String role;

    @Column(nullable = false)
    private Boolean status = true;

    private String avatar;

    @Column(nullable = false, updatable = false)
    private Timestamp createdDate;

    private Timestamp updatedDate;

    // Relationship with Wallet
    @OneToMany(mappedBy = "user", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<Wallet> wallets = new ArrayList<>();
    @OneToMany(mappedBy = "user", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<Transaction> transactions = new ArrayList<>();
    // Lifecycle Hooks for Timestamps
    @PrePersist
    protected void onCreate() {
        this.createdDate = new Timestamp(System.currentTimeMillis());
    }

    @PreUpdate
    protected void onUpdate() {
        this.updatedDate = new Timestamp(System.currentTimeMillis());
    }
}
