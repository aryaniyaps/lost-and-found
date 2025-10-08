package com.example.demo.controller;

import com.example.demo.dto.CommentRequest;
import com.example.demo.entity.Comment;
import com.example.demo.service.CommentService;
import jakarta.validation.Valid;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;
import java.util.List;

@RestController
@RequestMapping("/api/items/{itemId}/comments")
public class CommentController {
    private final CommentService commentService;

    public CommentController(CommentService commentService) {
        this.commentService = commentService;
    }

    @PostMapping
    public ResponseEntity<Comment> addComment(@PathVariable Long itemId, @Valid @RequestBody CommentRequest request, Authentication auth) {
        return ResponseEntity.ok(commentService.addComment(auth.getName(), itemId, request.getContent()));
    }

    @GetMapping
    public ResponseEntity<List<Comment>> getComments(@PathVariable Long itemId) {
        return ResponseEntity.ok(commentService.getCommentsByItem(itemId));
    }
}
