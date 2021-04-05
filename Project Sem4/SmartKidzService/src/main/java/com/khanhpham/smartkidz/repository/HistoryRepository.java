package com.khanhpham.smartkidz.repository;

import java.util.Date;
import java.util.List;

import com.khanhpham.smartkidz.entity.History;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface HistoryRepository extends JpaRepository<History, Integer> {
    List<History> findByUserId(int userId);

    @Query("Select h.gameId , Count(h.id) From History h where h.timestamp > :fromdate group by h.gameId")
    List<Object[]> gameReport(@Param("fromdate") Date previousDate);

    @Query("Select h.userId from History h group by h.userId order by h.score DESC")
    List<Object[]> getPosition();
}
