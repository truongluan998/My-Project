package com.khanhpham.smartkidz.repository;

import java.util.List;

import com.khanhpham.smartkidz.entity.Icon;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.jpa.repository.JpaRepository;

public interface IconRepository extends JpaRepository<Icon, Integer> {
    @Query("Select i from Icon i where i.isActive = false")
    List<Icon> findIconByInactive();

    @Query("Select i from Icon i where i.isActive = true")
    List<Icon> findAll();
}
