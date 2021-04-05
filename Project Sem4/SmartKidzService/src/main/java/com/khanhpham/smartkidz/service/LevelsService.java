package com.khanhpham.smartkidz.service;

import java.util.List;

import com.khanhpham.smartkidz.dto.LevelsDto;

import org.springframework.stereotype.Service;

@Service
public interface LevelsService {

    List<LevelsDto> findAll();

    LevelsDto findById(int id);

    boolean create(LevelsDto dto);

    boolean update(LevelsDto dto);

    List<LevelsDto> searchByName(String name);

    List<LevelsDto> findByInactive();
}
