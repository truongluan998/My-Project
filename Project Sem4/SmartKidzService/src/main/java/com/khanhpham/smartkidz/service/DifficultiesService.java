package com.khanhpham.smartkidz.service;

import java.util.List;

import com.khanhpham.smartkidz.dto.DifficultiesDto;

import org.springframework.stereotype.Service;

@Service
public interface DifficultiesService {

    List<DifficultiesDto> findAll();

    List<DifficultiesDto> findByInactive();

    DifficultiesDto findById(int id);

    boolean create(DifficultiesDto dto);

    boolean update(DifficultiesDto dto);

    List<DifficultiesDto> searchByName(String name);
}
