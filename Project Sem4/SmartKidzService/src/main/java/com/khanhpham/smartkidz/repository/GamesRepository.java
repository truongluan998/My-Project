package com.khanhpham.smartkidz.repository;

import java.util.List;

import com.khanhpham.smartkidz.entity.Games;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.jpa.repository.JpaRepository;

public interface GamesRepository extends JpaRepository<Games, Integer> {
    List<Games> findByNameLike(String name);

    List<Games> findByIsActive(Boolean isActive);

    @Query("Select g from Games g where g.isActive = false")
    List<Games> findGamesByInactive();

    @Query("Select g from Games g where g.isActive = true")
    List<Games> findAll();
}
