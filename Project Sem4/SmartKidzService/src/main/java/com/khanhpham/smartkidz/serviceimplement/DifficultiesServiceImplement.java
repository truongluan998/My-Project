package com.khanhpham.smartkidz.serviceimplement;

import java.util.ArrayList;
import java.util.List;

import com.khanhpham.smartkidz.dto.DifficultiesDto;
import com.khanhpham.smartkidz.entity.Difficulties;
import com.khanhpham.smartkidz.mapper.DifficultiesMapper;
import com.khanhpham.smartkidz.repository.DifficultiesRepository;
import com.khanhpham.smartkidz.service.DifficultiesService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class DifficultiesServiceImplement implements DifficultiesService {

    @Autowired
    DifficultiesRepository repo;

    @Override
    public List<DifficultiesDto> findAll() {
        List<DifficultiesDto> results = new ArrayList<>();
        for (Difficulties d : repo.findAll()) {
            results.add(DifficultiesMapper.toDifficultiesDto(d));
        }
        return results;
    }

    @Override
    public List<DifficultiesDto> findByInactive() {
        List<DifficultiesDto> results = new ArrayList<>();
        for (Difficulties d : repo.findDifficultyByInactive()) {
            results.add(DifficultiesMapper.toDifficultiesDto(d));
        }
        return results;
    }

    @Override
    public DifficultiesDto findById(int id) {
        DifficultiesDto result = null;
        try {
            Difficulties d = repo.findById(id).orElse(null);
            result = DifficultiesMapper.toDifficultiesDto(d);
        } catch (Exception e) {
            e.getMessage();
        }
        return result;
    }

    @Override
    public boolean create(DifficultiesDto dto) {
        Difficulties d = DifficultiesMapper.fromDifficultiesDto(dto);
        return repo.save(d) != null;
    }

    @Override
    public boolean update(DifficultiesDto dto) {
        Difficulties d = DifficultiesMapper.fromDifficultiesDto(dto);
        return repo.save(d) != null;
    }

    @Override
    public List<DifficultiesDto> searchByName(String name) {
        List<DifficultiesDto> results = new ArrayList<>();
        for (Difficulties d : repo.findByNameLike(name)) {
            results.add(DifficultiesMapper.toDifficultiesDto(d));
        }
        return results;
    }

}
