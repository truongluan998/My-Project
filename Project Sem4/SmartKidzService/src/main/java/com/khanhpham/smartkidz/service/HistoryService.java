package com.khanhpham.smartkidz.service;

import org.springframework.stereotype.Service;

import java.util.List;

import com.khanhpham.smartkidz.dto.HistoryDto;

@Service
public interface HistoryService {

    List<HistoryDto> findAll();

    List<HistoryDto> findByUserId(int id);

    HistoryDto findById(int id);

    HistoryDto create(HistoryDto dto);

    boolean update(HistoryDto dto);

    String getNameGame(int gameId);
}
