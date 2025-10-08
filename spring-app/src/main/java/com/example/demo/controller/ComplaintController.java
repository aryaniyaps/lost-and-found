package com.example.demo.controller;

import com.example.demo.dto.ComplaintRequest;
import com.example.demo.entity.Complaint;
import com.example.demo.service.ComplaintService;
import jakarta.validation.Valid;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/complaints")
public class ComplaintController {
    private final ComplaintService complaintService;

    public ComplaintController(ComplaintService complaintService) {
        this.complaintService = complaintService;
    }

    @PostMapping
    public ResponseEntity<Complaint> createComplaint(@Valid @RequestBody ComplaintRequest request, 
                                                     Authentication auth) {
        Complaint complaint = complaintService.createComplaint(auth.getName(), request.getSubject(), 
                request.getDescription(), request.getItemId());
        return ResponseEntity.ok(complaint);
    }

    @GetMapping
    public ResponseEntity<List<Complaint>> getAllComplaints() {
        return ResponseEntity.ok(complaintService.getAllComplaints());
    }

    @GetMapping("/{id}")
    public ResponseEntity<Complaint> getComplaint(@PathVariable Long id) {
        return ResponseEntity.ok(complaintService.getComplaintById(id));
    }

    @PostMapping("/{id}/resolve")
    public ResponseEntity<Complaint> resolveComplaint(@PathVariable Long id, 
                                                      @RequestBody Map<String, String> request) {
        Complaint complaint = complaintService.resolveComplaint(id, request.get("resolution"));
        return ResponseEntity.ok(complaint);
    }

    @PatchMapping("/{id}/status")
    public ResponseEntity<Complaint> updateStatus(@PathVariable Long id, 
                                                  @RequestBody Map<String, String> request) {
        Complaint.ComplaintStatus status = Complaint.ComplaintStatus.valueOf(request.get("status"));
        return ResponseEntity.ok(complaintService.updateComplaintStatus(id, status));
    }
}
