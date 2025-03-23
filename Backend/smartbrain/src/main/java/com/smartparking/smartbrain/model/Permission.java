package com.smartparking.smartbrain.model;

import java.util.Set;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.ManyToMany;
import jakarta.persistence.Table;
import jakarta.validation.constraints.NotNull;
import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.experimental.FieldDefaults;

@Entity
@Getter
@Setter
@Builder
@NoArgsConstructor
@Table(name = "permissions")
@AllArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
public class Permission {
    @Id
    @NotNull(message = "Permission name cannot be null")
    String permissionName;
    String description;

    // Relationship with Role ManytoMany - Permissions can have many roles
    @ManyToMany(mappedBy = "permissions")
    Set<Role> roles;
}
