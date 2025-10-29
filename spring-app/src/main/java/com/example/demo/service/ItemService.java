package com.example.demo.service;

import com.example.demo.entity.Item;
import com.example.demo.entity.User;
import com.example.demo.repository.ItemRepository;
import com.example.demo.repository.UserRepository;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class ItemService {
    private final ItemRepository itemRepository;
    private final UserRepository userRepository;

    public ItemService(ItemRepository itemRepository, UserRepository userRepository) {
        this.itemRepository = itemRepository;
        this.userRepository = userRepository;
    }

    public Item createItem(String email, String title, String description, String category,
            Item.ItemType type, String location, String imageUrl) {
        User user = userRepository.findByEmail(email)
                .orElseThrow(() -> new RuntimeException("User not found"));
        Item item = new Item();
        item.setTitle(title);
        item.setDescription(description);
        item.setCategory(category);
        item.setType(type);
        item.setLocation(location);
        item.setImageUrl(imageUrl);
        item.setStatus(Item.ItemStatus.ACTIVE);
        item.setUser(user);
        return itemRepository.save(item);
    }

    public List<Item> getAllItems() {
        return itemRepository.findByStatus(Item.ItemStatus.ACTIVE);
    }

    public List<Item> getItemsByType(Item.ItemType type) {
        return itemRepository.findByType(type).stream()
                .filter(item -> item.getStatus() == Item.ItemStatus.ACTIVE)
                .toList();
    }

    public Item getItemById(Long id) {
        return itemRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Item not found"));
    }

    public Item updateItemStatus(Long id, Item.ItemStatus status, String userEmail) {
        Item item = getItemById(id);
        if (!item.getUser().getEmail().equals(userEmail)) {
            throw new RuntimeException("Only the owner can update the item status");
        }
        item.setStatus(status);
        return itemRepository.save(item);
    }

    public void deleteItem(Long id) {
        itemRepository.deleteById(id);
    }

    public List<Item> searchItems(String query) {
        return itemRepository.searchItems(query);
    }

    public List<Item> filterByCategory(String category) {
        return itemRepository.findByCategory(category);
    }

    public List<Item> findMatches(Long itemId) {
        Item item = getItemById(itemId);
        Item.ItemType oppositeType = item.getType() == Item.ItemType.LOST ? Item.ItemType.FOUND : Item.ItemType.LOST;
        return itemRepository.findPotentialMatches(oppositeType, item.getCategory(), item.getTitle());
    }
}
