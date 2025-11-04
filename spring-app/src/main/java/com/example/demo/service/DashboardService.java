package com.example.demo.service;

import com.example.demo.entity.Complaint;
import com.example.demo.entity.Item;
import com.example.demo.entity.User;
import com.example.demo.repository.ComplaintRepository;
import com.example.demo.repository.ItemRepository;
import com.example.demo.repository.UserRepository;
import org.springframework.stereotype.Service;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Service
public class DashboardService {
    private final ItemRepository itemRepository;
    private final ComplaintRepository complaintRepository;
    private final UserRepository userRepository;

    public DashboardService(ItemRepository itemRepository, ComplaintRepository complaintRepository,
            UserRepository userRepository) {
        this.itemRepository = itemRepository;
        this.complaintRepository = complaintRepository;
        this.userRepository = userRepository;
    }

    public Map<String, Object> getUserStats(String email) {
        User user = userRepository.findByEmail(email).orElseThrow(() -> new RuntimeException("User not found"));
        Map<String, Object> stats = new HashMap<>();
        stats.put("totalItems", itemRepository.countByUserId(user.getId()));
        stats.put("activeItems", itemRepository.countByUserIdAndStatus(user.getId(), Item.ItemStatus.ACTIVE));
        stats.put("claimedItems", itemRepository.countByUserIdAndStatus(user.getId(), Item.ItemStatus.CLAIMED));
        stats.put("totalComplaints", complaintRepository.countByUserId(user.getId()));
        stats.put("openComplaints",
                complaintRepository.countByUserIdAndStatus(user.getId(), Complaint.ComplaintStatus.OPEN));
        // Build a lightweight recent items list (avoid serializing full JPA entities
        // with relations)
        List<Map<String, Object>> recentItems = itemRepository.findByUserId(user.getId()).stream()
                .limit(5)
                .map(i -> {
                    Map<String, Object> m = new HashMap<>();
                    m.put("id", i.getId());
                    m.put("title", i.getTitle());
                    m.put("type", i.getType() != null ? i.getType().name() : null);
                    m.put("category", i.getCategory());
                    return m;
                })
                .collect(Collectors.toList());
        stats.put("recentItems", recentItems);
        return stats;
    }
}
