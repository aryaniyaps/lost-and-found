package com.example.demo.service;

import com.example.demo.entity.Complaint;
import com.example.demo.entity.Item;
import com.example.demo.entity.User;
import com.example.demo.repository.ComplaintRepository;
import com.example.demo.repository.ItemRepository;
import com.example.demo.repository.UserRepository;
import org.springframework.stereotype.Service;
import java.time.LocalDateTime;
import java.util.List;

@Service
public class ComplaintService {
    private final ComplaintRepository complaintRepository;
    private final UserRepository userRepository;
    private final ItemRepository itemRepository;

    public ComplaintService(ComplaintRepository complaintRepository, UserRepository userRepository, 
                           ItemRepository itemRepository) {
        this.complaintRepository = complaintRepository;
        this.userRepository = userRepository;
        this.itemRepository = itemRepository;
    }

    public Complaint createComplaint(String email, String subject, String description, Long itemId) {
        User user = userRepository.findByEmail(email)
                .orElseThrow(() -> new RuntimeException("User not found"));
        
        Complaint complaint = new Complaint();
        complaint.setSubject(subject);
        complaint.setDescription(description);
        complaint.setUser(user);
        
        if (itemId != null) {
            Item item = itemRepository.findById(itemId)
                    .orElseThrow(() -> new RuntimeException("Item not found"));
            complaint.setItem(item);
        }
        
        return complaintRepository.save(complaint);
    }

    public List<Complaint> getAllComplaints() {
        return complaintRepository.findAll();
    }

    public Complaint getComplaintById(Long id) {
        return complaintRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Complaint not found"));
    }

    public Complaint resolveComplaint(Long id, String resolution) {
        Complaint complaint = getComplaintById(id);
        complaint.setStatus(Complaint.ComplaintStatus.RESOLVED);
        complaint.setResolution(resolution);
        complaint.setResolvedAt(LocalDateTime.now());
        return complaintRepository.save(complaint);
    }

    public Complaint updateComplaintStatus(Long id, Complaint.ComplaintStatus status) {
        Complaint complaint = getComplaintById(id);
        complaint.setStatus(status);
        return complaintRepository.save(complaint);
    }
}
