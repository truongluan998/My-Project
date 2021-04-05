package com.khanhpham.smartkidz.serviceimplement;

import java.util.ArrayList;
import java.util.List;

import com.khanhpham.smartkidz.dto.HistoryDto;
import com.khanhpham.smartkidz.entity.History;
import com.khanhpham.smartkidz.repository.GamesRepository;
import com.khanhpham.smartkidz.repository.HistoryRepository;
import com.khanhpham.smartkidz.service.HistoryService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class HistoryServiceImplement implements HistoryService {

    @Autowired
    HistoryRepository repo;

    @Autowired
    GamesRepository gameRepo;

    @Override
    public List<HistoryDto> findAll() {
        List<HistoryDto> results = new ArrayList<>();
        for (History h : repo.findAll()) {
            results.add(toHistoryDto(h));
        }
        return results;
    }

    @Override
    public HistoryDto findById(int id) {
        HistoryDto result = null;
        try {
            History h = repo.findById(id).orElse(null);
            if (h != null) {
                result = toHistoryDto(h);
            }
        } catch (Exception e) {
            e.getMessage();
        }
        return result;
    }

    @Override
    public HistoryDto create(HistoryDto dto) {
        History h = fromHistoryDto(dto);
        return toHistoryDto(repo.save(h));
    }

    @Override
    public boolean update(HistoryDto dto) {
        History h = fromHistoryDto(dto);
        return repo.save(h) != null;
    }

    @Override
    public List<HistoryDto> findByUserId(int id) {
        List<HistoryDto> results = new ArrayList<>();
        for (History h : repo.findByUserId(id)) {
            results.add(toHistoryDto(h));
        }
        return results;
    }

    private HistoryDto toHistoryDto(History history) {
        HistoryDto hd = new HistoryDto();
        hd.setId(history.getId());
        hd.setScore(history.getScore());
        hd.setTimestamp(history.getTimestamp());
        hd.setUserId(history.getUserId());
        hd.setGameId(history.getGameId());
        hd.setGameName(getNameGame(history.getGameId()));

        return hd;
    }

    private History fromHistoryDto(HistoryDto historyDto) {
        History h = new History();
        h.setId(historyDto.getId());
        h.setScore(historyDto.getScore());
        h.setTimestamp(historyDto.getTimestamp());
        h.setUserId(historyDto.getUserId());
        h.setGameId(historyDto.getGameId());

        return h;
    }

    @Override
    public String getNameGame(int gameId) {
        return gameRepo.findById(gameId).get().getName();
    }

}
