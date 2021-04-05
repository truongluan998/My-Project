package com.khanhpham.smartkidz.service;

import java.util.List;

import com.khanhpham.smartkidz.dto.TopicsDto;

import org.springframework.stereotype.Service;

@Service
public interface TopicsService {

    List<TopicsDto> findAll();

    List<TopicsDto> findInactive();

    TopicsDto findById(int id);

    boolean create(TopicsDto dto);

    boolean update(TopicsDto dto);

    List<TopicsDto> searchByName(String name);

    List<TopicsDto> findByGameId(int gameId);

}
