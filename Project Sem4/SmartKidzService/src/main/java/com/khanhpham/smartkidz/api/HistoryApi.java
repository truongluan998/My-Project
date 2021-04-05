package com.khanhpham.smartkidz.api;

import java.util.ArrayList;
import java.util.List;

import com.khanhpham.smartkidz.dto.HistoryDto;
import com.khanhpham.smartkidz.dto.LevelsDto;
import com.khanhpham.smartkidz.dto.ScoreDto;
import com.khanhpham.smartkidz.dto.UsersDto;
import com.khanhpham.smartkidz.entity.Games;
import com.khanhpham.smartkidz.entity.Score;
import com.khanhpham.smartkidz.entity.Users;
import com.khanhpham.smartkidz.repository.ScoreRepository;
import com.khanhpham.smartkidz.service.HistoryService;
import com.khanhpham.smartkidz.service.LevelsService;
import com.khanhpham.smartkidz.service.UserService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/v1/histories")
public class HistoryApi {

    @Autowired
    HistoryService historyService;

    @Autowired
    ScoreRepository scoreRepo;

    @Autowired
    UserService userService;

    @Autowired
    LevelsService levelService;

    @GetMapping
    public ResponseEntity<List<HistoryDto>> getHistory(@RequestParam int userId) {
        try {
            List<HistoryDto> items = new ArrayList<HistoryDto>();

            historyService.findByUserId(userId).forEach(items::add);

            if (items.isEmpty())
                return new ResponseEntity<>(HttpStatus.NO_CONTENT);

            return new ResponseEntity<>(items, HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<>(null, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @PostMapping
    public ResponseEntity<UsersDto> createHistory(@RequestBody HistoryDto history) {
        try {
            HistoryDto savedItem = historyService.create(history);
            Score score = scoreRepo.findByGameAndUser(savedItem.getGameId(), savedItem.getUserId());
            if (score != null) {
                score.setScore(score.getScore() + savedItem.getScore());
                scoreRepo.save(score);
            } else {

                score = new Score();
                Games g = new Games();
                g.setId(savedItem.getGameId());
                Users u = new Users();
                u.setId(savedItem.getUserId());
                score.setGameId(g);
                score.setUserId(u);
                score.setScore(savedItem.getScore());
                scoreRepo.save(score);
            }
            UsersDto user = userService.findById(savedItem.getUserId());
            int scoreTotal = 0;
            for (ScoreDto item : user.getScoreCollection()) {
                scoreTotal += item.getScore();
            }
            for (LevelsDto levelsDto : levelService.findAll()) {
                if (scoreTotal > levelsDto.getRequiredLevelScore()) {
                    if (user.getLevelId().getRequiredLevelScore() < levelsDto.getRequiredLevelScore()) {
                        user.setLevelId(levelsDto);
                        user = userService.update(user);
                    }
                }
            }

            return new ResponseEntity<>(user, HttpStatus.CREATED);
        } catch (Exception e) {
            return new ResponseEntity<>(null, HttpStatus.EXPECTATION_FAILED);
        }
    }

}
