package com.khanhpham.smartkidz.repository;

import java.util.List;

import com.khanhpham.smartkidz.entity.Difficulties;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.data.jpa.repository.JpaRepository;

public interface DifficultiesRepository extends JpaRepository<Difficulties, Integer> {
    List<Difficulties> findByNameLike(String name);

    @Query("Select d from Difficulties d where d.isActive = false")
    List<Difficulties> findDifficultyByInactive();

    @Query("Select d from Difficulties d where d.isActive = true")
    List<Difficulties> findAll();

    @Query("Select d from Difficulties d where d.gameId.id=:gameId and d.isActive=true")
    List<Difficulties> findByGameIdAndIsActive(@Param("gameId") int gameId);

}
