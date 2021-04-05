package com.khanhpham.smartkidz.serviceimplement;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import com.khanhpham.smartkidz.dto.GamesDto;
import com.khanhpham.smartkidz.entity.Games;
import com.khanhpham.smartkidz.mapper.GamesMapper;
import com.khanhpham.smartkidz.repository.GamesRepository;
import com.khanhpham.smartkidz.service.GamesService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class GamesServiceImplement implements GamesService {
    @Autowired
    GamesRepository repo;

    @Override
    public List<GamesDto> findAll() {
        List<GamesDto> results = new ArrayList<>();
        for (Games g : repo.findAll()) {
            results.add(GamesMapper.toGamesDto(g));
        }
        return results;
    }

    @Override
    public List<GamesDto> findByInactive() {
        List<GamesDto> results = new ArrayList<>();
        for (Games g : repo.findGamesByInactive()) {
            results.add(GamesMapper.toGamesDto(g));
        }
        return results;
    }

    @Override
    public GamesDto findById(int id) {
        GamesDto result = null;
        try {
            Games g = repo.findById(id).orElse(null);
            if (g != null) {
                result = GamesMapper.toGamesDto(g);
            }
        } catch (Exception e) {
            e.getMessage();
        }
        return result;
    }

    @Override
    public boolean create(GamesDto dto) {
        Games g = GamesMapper.fromGamesDto(dto);
        return repo.save(g) != null;
    }

    @Override
    public boolean update(GamesDto dto) {
        Games g = GamesMapper.fromGamesDto(dto);
        Optional<Games> old = repo.findById(dto.getId());
        if (old.isPresent()) {
            Games updateGame = old.get();
            updateGame.setName(g.getName());
            updateGame.setDescription(g.getDescription());
            updateGame.setBgm(g.getBgm());
            updateGame.setIsActive(g.getIsActive());
            updateGame.setImage(g.getImage());
        }
        return repo.save(g) != null;
    }

    @Override
    public List<GamesDto> searchByName(String name) {
        List<GamesDto> results = new ArrayList<>();
        for (Games g : repo.findByNameLike(name)) {
            results.add(GamesMapper.toGamesDto(g));
        }
        return results;
    }

}
