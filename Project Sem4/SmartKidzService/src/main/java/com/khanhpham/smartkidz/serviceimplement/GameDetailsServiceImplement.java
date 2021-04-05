package com.khanhpham.smartkidz.serviceimplement;

import java.util.ArrayList;
import java.util.List;

import com.khanhpham.smartkidz.dto.GamesDetailDto;
import com.khanhpham.smartkidz.entity.GameDetails;
import com.khanhpham.smartkidz.mapper.GameDetailsMapper;
import com.khanhpham.smartkidz.repository.GamesDetailsRepository;
import com.khanhpham.smartkidz.service.GameDetailsService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class GameDetailsServiceImplement implements GameDetailsService {

    @Autowired
    GamesDetailsRepository repo;

    @Override
    public List<GamesDetailDto> findAll() {
        List<GamesDetailDto> results = new ArrayList<>();
        for (GameDetails g : repo.findAll()) {
            results.add(GameDetailsMapper.toGameDetailsDto(g));
        }
        return results;
    }

    @Override
    public List<GamesDetailDto> findByInactive() {
        List<GamesDetailDto> results = new ArrayList<>();
        for (GameDetails g : repo.findGameByInactive()) {
            results.add(GameDetailsMapper.toGameDetailsDto(g));
        }
        return results;
    }

    @Override
    public GamesDetailDto findById(int id) {
        GamesDetailDto result = null;
        try {
            GameDetails g = repo.findById(id).orElse(null);
            if (g != null) {
                result = GameDetailsMapper.toGameDetailsDto(g);
            }
        } catch (Exception e) {
            e.getMessage();
        }
        return result;
    }

    @Override
    public boolean create(GamesDetailDto dto) {
        GameDetails g = GameDetailsMapper.fromGameDetailsDto(dto);
        return repo.save(g) != null;
    }

    @Override
    public boolean update(GamesDetailDto dto) {
        GameDetails g = GameDetailsMapper.fromGameDetailsDto(dto);
        g.setCreatedAt(repo.findById(dto.getId()).get().getCreatedAt());

        return repo.save(g) != null;
    }

    @Override
    public List<GamesDetailDto> findByGameIdAndTopicId(int gameId, int topicId) {
        List<GamesDetailDto> result = new ArrayList<>();
        for (GameDetails g : repo.findByGameIdAndTopicId(gameId, topicId)) {
            result.add(GameDetailsMapper.toGameDetailsDto(g));
        }
        return result;
    }

    @Override
    public List<GamesDetailDto> findByGameIdAndTopicIdInactive(int gameId, int topicId) {
        List<GamesDetailDto> result = new ArrayList<>();
        for (GameDetails g : repo.findByGameIdAndTopicIdInactive(gameId, topicId)) {
            result.add(GameDetailsMapper.toGameDetailsDto(g));
        }
        return result;
    }

    @Override
    public List<GamesDetailDto> findByGameId(int gameId) {
        List<GamesDetailDto> result = new ArrayList<>();
        for (GameDetails g : repo.findByGameId(gameId)) {
            result.add(GameDetailsMapper.toGameDetailsDto(g));
        }
        return result;
    }

    @Override
    public List<GamesDetailDto> findByGameIdInactive(int gameId) {
        List<GamesDetailDto> result = new ArrayList<>();
        for (GameDetails g : repo.findByGameIdInactive(gameId)) {
            result.add(GameDetailsMapper.toGameDetailsDto(g));
        }
        return result;
    }
}
