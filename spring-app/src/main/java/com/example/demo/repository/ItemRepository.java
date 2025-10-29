package com.example.demo.repository;

import com.example.demo.entity.Item;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import java.util.List;

public interface ItemRepository extends JpaRepository<Item, Long> {
    List<Item> findByType(Item.ItemType type);

    List<Item> findByUserId(Long userId);

    List<Item> findByStatus(Item.ItemStatus status);

    @Query("SELECT i FROM Item i WHERE LOWER(i.category) = LOWER(:category) AND i.status = 'ACTIVE'")
    List<Item> findByCategory(@Param("category") String category);

    @Query("SELECT i FROM Item i WHERE (LOWER(i.title) LIKE LOWER(CONCAT('%', :query, '%')) OR LOWER(i.description) LIKE LOWER(CONCAT('%', :query, '%'))) AND i.status = 'ACTIVE'")
    List<Item> searchItems(@Param("query") String query);

    @Query("SELECT i FROM Item i WHERE i.type = :type AND LOWER(i.category) = LOWER(:category) AND (LOWER(i.title) LIKE LOWER(CONCAT('%', :keyword, '%')) OR LOWER(i.description) LIKE LOWER(CONCAT('%', :keyword, '%'))) AND i.status = 'ACTIVE'")
    List<Item> findPotentialMatches(@Param("type") Item.ItemType type, @Param("category") String category,
            @Param("keyword") String keyword);

    long countByUserId(Long userId);

    long countByUserIdAndStatus(Long userId, Item.ItemStatus status);
}
