package com.khanhpham.smartkidz.serviceimplement;

import java.util.ArrayList;
import java.util.List;

import com.khanhpham.smartkidz.dto.ScoreDto;
import com.khanhpham.smartkidz.entity.Score;
import com.khanhpham.smartkidz.mapper.ScoreMapper;
import com.khanhpham.smartkidz.repository.ScoreRepository;
import com.khanhpham.smartkidz.service.ScoreService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class ScoreServiceImplement implements ScoreService {

    @Autowired
    ScoreRepository repo;

    @Override
    public List<ScoreDto> findAll() {
        List<ScoreDto> results = new ArrayList<>();
        for (Score s : repo.findAll()) {
            results.add(ScoreMapper.toScoreDto(s));
        }
        return results;
    }

    @Override
    public ScoreDto findById(int id) {
        ScoreDto result = null;
        try {
            Score s = repo.findById(id).orElse(null);
            if (s != null) {
                result = ScoreMapper.toScoreDto(s);
            }
        } catch (Exception e) {
            e.getMessage();
        }
        return result;
    }

    // @Override
    // public boolean create(ScoreDto dto) {
    // Score s = ScoreMapper.fromScoreDto(dto);
    // return repo.save(s) != null;
    // }

    // @Override
    // public boolean update(ScoreDto dto) {
    // Score s = ScoreMapper.fromScoreDto(dto);
    // return repo.save(s) != null;
    // }

    // @Override
    // public boolean delete(int id) {
    // Score s = repo.findById(id).orElse(null);
    // if (s != null) {
    // repo.delete(s);
    // return true;
    // }
    // return false;
    // }

}
