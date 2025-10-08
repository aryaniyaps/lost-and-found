package com.example.demo.service;

import com.example.demo.entity.Comment;
import com.example.demo.entity.Item;
import com.example.demo.entity.User;
import com.example.demo.repository.CommentRepository;
import com.example.demo.repository.ItemRepository;
import com.example.demo.repository.UserRepository;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class CommentService {
    private final CommentRepository commentRepository;
    private final ItemRepository itemRepository;
    private final UserRepository userRepository;

    public CommentService(CommentRepository commentRepository, ItemRepository itemRepository, UserRepository userRepository) {
        this.commentRepository = commentRepository;
        this.itemRepository = itemRepository;
        this.userRepository = userRepository;
    }

    public Comment addComment(String email, Long itemId, String content) {
        User user = userRepository.findByEmail(email).orElseThrow(() -> new RuntimeException("User not found"));
        Item item = itemRepository.findById(itemId).orElseThrow(() -> new RuntimeException("Item not found"));
        Comment comment = new Comment();
        comment.setContent(content);
        comment.setItem(item);
        comment.setUser(user);
        return commentRepository.save(comment);
    }

    public List<Comment> getCommentsByItem(Long itemId) {
        return commentRepository.findByItemIdOrderByCreatedAtDesc(itemId);
    }
}
