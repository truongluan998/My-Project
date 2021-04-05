package com.khanhpham.smartkidz.service;

import java.util.List;

import com.khanhpham.smartkidz.dto.GamesDetailDto;

import org.springframework.stereotype.Service;

@Service
public interface GameDetailsService {

    List<GamesDetailDto> findAll();

    List<GamesDetailDto> findByInactive();

    GamesDetailDto findById(int id);

    boolean create(GamesDetailDto dto);

    boolean update(GamesDetailDto dto);

    List<GamesDetailDto> findByGameIdAndTopicId(int gameId, int topicId);

    List<GamesDetailDto> findByGameIdAndTopicIdInactive(int gameId, int topicId);

    List<GamesDetailDto> findByGameId(int gameId);

    List<GamesDetailDto> findByGameIdInactive(int gameId);

}
