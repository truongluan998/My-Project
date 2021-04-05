package com.khanhpham.smartkidz.service;

import java.util.List;

import com.khanhpham.smartkidz.dto.IconDto;

import org.springframework.stereotype.Service;

@Service
public interface IconService {

    List<IconDto> findAll();

    List<IconDto> findByInactive();

    IconDto findById(int id);

    boolean create(IconDto dto);

    boolean update(IconDto dto);

}
