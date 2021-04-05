package com.khanhpham.smartkidz.service;

import java.util.List;

import com.khanhpham.smartkidz.dto.ScoreDto;

import org.springframework.stereotype.Service;

@Service
public interface ScoreService {

    List<ScoreDto> findAll();

    ScoreDto findById(int id);

    // boolean create(ScoreDto dto);

    // boolean update(ScoreDto dto);

    // boolean delete(int id);

}
