package com.khanhpham.smartkidz.serviceimplement;

import java.util.ArrayList;
import java.util.List;

import com.khanhpham.smartkidz.dto.TopicsDto;
import com.khanhpham.smartkidz.entity.Topics;
import com.khanhpham.smartkidz.mapper.TopicsMapper;
import com.khanhpham.smartkidz.repository.TopicsRepository;
import com.khanhpham.smartkidz.service.TopicsService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class TopicsServiceImpliment implements TopicsService {
    @Autowired
    TopicsRepository repo;

    @Override
    public List<TopicsDto> findAll() {
        List<TopicsDto> results = new ArrayList<>();
        for (Topics t : repo.findAll()) {
            results.add(TopicsMapper.toTopicsDto(t));
        }
        return results;
    }

    @Override
    public List<TopicsDto> findInactive() {
        List<TopicsDto> results = new ArrayList<>();
        for (Topics t : repo.findTopicByInactive()) {
            results.add(TopicsMapper.toTopicsDto(t));
        }
        return results;
    }

    @Override
    public TopicsDto findById(int id) {
        TopicsDto result = null;
        try {
            Topics t = repo.findById(id).orElse(null);
            if (t != null) {
                result = TopicsMapper.toTopicsDto(t);
            }
        } catch (Exception e) {
            e.getMessage();
        }
        return result;
    }

    @Override
    public boolean create(TopicsDto dto) {
        Topics t = TopicsMapper.fromTopicsDto(dto);
        return repo.save(t) != null;
    }

    @Override
    public boolean update(TopicsDto dto) {
        Topics t = TopicsMapper.fromTopicsDto(dto);
        t.setCreatedAt(repo.findById(dto.getId()).get().getCreatedAt());
        return repo.save(t) != null;
    }

    @Override
    public List<TopicsDto> searchByName(String name) {
        List<TopicsDto> results = new ArrayList<>();
        for (Topics t : repo.findByNameLike(name)) {
            results.add(TopicsMapper.toTopicsDto(t));
        }
        return results;
    }

    @Override
    public List<TopicsDto> findByGameId(int gameId) {
        List<TopicsDto> result = new ArrayList<>();
        for (Topics t : repo.findTopicByGameId(gameId)) {
            result.add(TopicsMapper.toTopicsDto(t));
        }
        return result;
    }

}
