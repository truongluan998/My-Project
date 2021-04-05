package com.khanhpham.smartkidz.serviceimplement;

import java.util.ArrayList;
import java.util.List;

import com.khanhpham.smartkidz.dto.LevelsDto;
import com.khanhpham.smartkidz.entity.Levels;
import com.khanhpham.smartkidz.mapper.LevelsMapper;
import com.khanhpham.smartkidz.repository.LevelsRepository;
import com.khanhpham.smartkidz.service.LevelsService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class LevelsServiceImplement implements LevelsService {

    @Autowired
    LevelsRepository repo;

    @Override
    public List<LevelsDto> findAll() {
        List<LevelsDto> results = new ArrayList<>();
        for (Levels l : repo.findAll()) {
            results.add(LevelsMapper.toLevelsDto(l));
        }
        return results;
    }

    @Override
    public List<LevelsDto> findByInactive() {
        List<LevelsDto> results = new ArrayList<>();
        for (Levels l : repo.findLevelByInactive()) {
            results.add(LevelsMapper.toLevelsDto(l));
        }
        return results;
    }

    @Override
    public LevelsDto findById(int id) {
        LevelsDto result = null;
        try {
            Levels l = repo.findById(id).orElse(null);
            if (l != null) {
                result = LevelsMapper.toLevelsDto(l);
            }
        } catch (Exception e) {
            e.getMessage();
        }
        return result;
    }

    @Override
    public boolean create(LevelsDto dto) {
        Levels l = LevelsMapper.fromLevelsDto(dto);
        return repo.save(l) != null;
    }

    @Override
    public boolean update(LevelsDto dto) {
        Levels l = LevelsMapper.fromLevelsDto(dto);
        l.setCreatedAt(repo.findById(dto.getId()).get().getCreatedAt());
        return repo.save(l) != null;
    }

    @Override
    public List<LevelsDto> searchByName(String name) {
        List<LevelsDto> results = new ArrayList<>();
        for (Levels l : repo.findByNameLike(name)) {
            results.add(LevelsMapper.toLevelsDto(l));
        }
        return results;
    }

}
