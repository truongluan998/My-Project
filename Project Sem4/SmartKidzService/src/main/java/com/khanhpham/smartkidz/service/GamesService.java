package com.khanhpham.smartkidz.service;

import java.util.List;

import com.khanhpham.smartkidz.dto.GamesDto;

import org.springframework.stereotype.Service;

@Service
public interface GamesService {

    List<GamesDto> findAll();

    List<GamesDto> findByInactive();

    GamesDto findById(int id);

    boolean create(GamesDto dto);

    boolean update(GamesDto dto);

    List<GamesDto> searchByName(String name);
}
