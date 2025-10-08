package com.example.demo.dto;

import jakarta.validation.constraints.NotBlank;

public class CommentRequest {
    @NotBlank
    private String content;

    public String getContent() { return content; }
    public void setContent(String content) { this.content = content; }
}
