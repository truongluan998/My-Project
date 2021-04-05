package com.khanhpham.smartkidz.repository;

import java.util.List;

import com.khanhpham.smartkidz.entity.Topics;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface TopicsRepository extends JpaRepository<Topics, Integer> {
    List<Topics> findByNameLike(String name);

    @Query("Select t from Topics t where t.gameId.id = :gameId and t.isActive=true")
    List<Topics> findTopicByGameId(@Param("gameId") int gameId);

    @Query("Select t from Topics t where t.isActive = false")
    List<Topics> findTopicByInactive();

    @Query("Select t from Topics t where t.isActive = true")
    List<Topics> findAll();

}
