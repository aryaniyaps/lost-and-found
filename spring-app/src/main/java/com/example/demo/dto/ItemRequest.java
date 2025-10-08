package com.example.demo.dto;

import com.example.demo.entity.Item;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;

public class ItemRequest {
    @NotBlank
    private String title;

    private String description;

    @NotBlank
    private String category;

    @NotNull
    private Item.ItemType type;

    private String location;

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public String getCategory() { return category; }
    public void setCategory(String category) { this.category = category; }

    public Item.ItemType getType() { return type; }
    public void setType(Item.ItemType type) { this.type = type; }

    public String getLocation() { return location; }
    public void setLocation(String location) { this.location = location; }
}
