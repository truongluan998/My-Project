package com.khanhpham.smartkidz.repository;

import com.khanhpham.smartkidz.entity.Score;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface ScoreRepository extends JpaRepository<Score, Integer> {

    @Query("Select s from Score s where s.gameId.id = :gameId and s.userId.id = :userId")
    Score findByGameAndUser(@Param("gameId") int gameId, @Param("userId") int userId);
}
