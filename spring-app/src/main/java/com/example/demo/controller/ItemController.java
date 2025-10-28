package com.example.demo.controller;

import com.example.demo.dto.ItemRequest;
import com.example.demo.entity.Item;
import com.example.demo.service.FileStorageService;
import com.example.demo.service.ItemService;
import jakarta.validation.Valid;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/items")
public class ItemController {
    private final ItemService itemService;
    private final FileStorageService fileStorageService;

    public ItemController(ItemService itemService, FileStorageService fileStorageService) {
        this.itemService = itemService;
        this.fileStorageService = fileStorageService;
    }

    @PostMapping
    public ResponseEntity<Item> createItem(@Valid @RequestBody ItemRequest request, Authentication auth) {
        if (auth == null) {
            return ResponseEntity.status(401).build();
        }
        Item item = itemService.createItem(auth.getName(), request.getTitle(), request.getDescription(),
                request.getCategory(), request.getType(), request.getLocation(), null);
        return ResponseEntity.ok(item);
    }

    @PostMapping(consumes = "multipart/form-data")
    public ResponseEntity<Item> createItemWithImage(
            @RequestParam String title,
            @RequestParam(required = false) String description,
            @RequestParam String category,
            @RequestParam Item.ItemType type,
            @RequestParam(required = false) String location,
            @RequestParam(required = false) MultipartFile imageFile,
            Authentication auth) {
        if (auth == null) {
            return ResponseEntity.status(401).build();
        }
        String imageUrl = null;
        if (imageFile != null && !imageFile.isEmpty()) {
            imageUrl = fileStorageService.storeFile(imageFile);
        }
        Item item = itemService.createItem(auth.getName(), title, description, category, type, location, imageUrl);
        return ResponseEntity.ok(item);
    }

    @GetMapping
    public ResponseEntity<List<Item>> getAllItems(@RequestParam(required = false) Item.ItemType type) {
        List<Item> items = type != null ? itemService.getItemsByType(type) : itemService.getAllItems();
        return ResponseEntity.ok(items);
    }

    @GetMapping("/{id}")
    public ResponseEntity<Item> getItem(@PathVariable Long id) {
        return ResponseEntity.ok(itemService.getItemById(id));
    }

    @PatchMapping("/{id}/status")
    public ResponseEntity<Item> updateStatus(@PathVariable Long id, @RequestBody Map<String, String> request) {
        Item.ItemStatus status = Item.ItemStatus.valueOf(request.get("status"));
        return ResponseEntity.ok(itemService.updateItemStatus(id, status));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<?> deleteItem(@PathVariable Long id) {
        itemService.deleteItem(id);
        return ResponseEntity.ok(Map.of("message", "Item deleted"));
    }

    @GetMapping("/search")
    public ResponseEntity<List<Item>> searchItems(@RequestParam String q) {
        return ResponseEntity.ok(itemService.searchItems(q));
    }

    @GetMapping("/filter")
    public ResponseEntity<List<Item>> filterItems(@RequestParam String category) {
        return ResponseEntity.ok(itemService.filterByCategory(category));
    }

    @GetMapping("/{id}/matches")
    public ResponseEntity<List<Item>> findMatches(@PathVariable Long id) {
        return ResponseEntity.ok(itemService.findMatches(id));
    }
}
