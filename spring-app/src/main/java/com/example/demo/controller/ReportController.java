package com.example.demo.controller;

import com.example.demo.entity.Report;
import com.example.demo.service.FileStorageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.Resource;
import org.springframework.core.io.UrlResource;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.nio.file.Path;
import java.nio.file.Paths;

@Controller
@RequestMapping("/reports")
public class ReportController {
    @Autowired
    private FileStorageService fileStorageService;

    @Value("${file.upload-dir}")
    private String uploadDir;

    // ...existing code...

    @PostMapping("/submit")
    public String submitReport(@ModelAttribute Report report,
            @RequestParam(required = false) MultipartFile image) {
        if (image != null && !image.isEmpty()) {
            String fileName = fileStorageService.storeFile(image);
            report.setImagePath(fileName);
        }
        // ...existing save logic...
        return "redirect:/reports";
    }

    @GetMapping("/images/{filename:.+}")
    @ResponseBody
    public ResponseEntity<Resource> serveImage(@PathVariable String filename) {
        try {
            Path filePath = Paths.get(uploadDir).resolve(filename).normalize();
            Resource resource = new UrlResource(filePath.toUri());

            if (resource.exists()) {
                return ResponseEntity.ok()
                        .contentType(MediaType.IMAGE_JPEG)
                        .body(resource);
            }
            return ResponseEntity.notFound().build();
        } catch (Exception e) {
            return ResponseEntity.internalServerError().build();
        }
    }
}