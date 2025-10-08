package com.example.demo.dto;

import jakarta.validation.constraints.NotBlank;

public class ComplaintRequest {
    @NotBlank
    private String subject;

    @NotBlank
    private String description;

    private Long itemId;

    public String getSubject() { return subject; }
    public void setSubject(String subject) { this.subject = subject; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public Long getItemId() { return itemId; }
    public void setItemId(Long itemId) { this.itemId = itemId; }
}
