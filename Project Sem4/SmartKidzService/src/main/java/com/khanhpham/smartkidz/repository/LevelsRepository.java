package com.khanhpham.smartkidz.repository;

import java.util.List;

import com.khanhpham.smartkidz.entity.Levels;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.jpa.repository.JpaRepository;

public interface LevelsRepository extends JpaRepository<Levels, Integer> {
    List<Levels> findByNameLike(String name);

    @Query("Select l from Levels l where l.isActive = false")
    List<Levels> findLevelByInactive();

    @Query("Select l from Levels l where l.isActive = true Order by l.requiredLevelScore")
    List<Levels> findAll();
}
