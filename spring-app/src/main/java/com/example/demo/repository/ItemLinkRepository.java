package com.example.demo.repository;

import com.example.demo.entity.ItemLink;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface ItemLinkRepository extends JpaRepository<ItemLink, Long> {
    List<ItemLink> findByLostItemId(Long lostItemId);

    List<ItemLink> findByFoundItemId(Long foundItemId);
}
