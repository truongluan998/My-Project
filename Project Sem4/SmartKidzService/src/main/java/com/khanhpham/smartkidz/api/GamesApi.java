package com.khanhpham.smartkidz.api;

import java.util.ArrayList;
import java.util.List;
import java.util.Random;

import com.khanhpham.smartkidz.dto.GamesDetailDto;
import com.khanhpham.smartkidz.entity.Difficulties;
import com.khanhpham.smartkidz.entity.GameDetails;
import com.khanhpham.smartkidz.entity.Games;
import com.khanhpham.smartkidz.mapper.GameDetailsMapper;
import com.khanhpham.smartkidz.repository.DifficultiesRepository;
import com.khanhpham.smartkidz.repository.GamesDetailsRepository;
import com.khanhpham.smartkidz.repository.GamesRepository;
import com.khanhpham.smartkidz.repository.TopicsRepository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/v1/games")
class GamesApi {

    @Autowired
    GamesRepository repository;

    @Autowired
    GamesDetailsRepository detailRepo;

    @Autowired
    DifficultiesRepository diffRepo;

    @Autowired
    TopicsRepository topicRepo;

    @GetMapping
    public ResponseEntity<List<Games>> getAll() {
        try {
            List<Games> items = new ArrayList<Games>();

            // repository.findAll().forEach(items::add);
            for (Games games : repository.findByIsActive(true)) {

                games.setTopicsCollection(topicRepo.findTopicByGameId(games.getId()));
                games.setDifficultiesCollection(diffRepo.findByGameIdAndIsActive(games.getId()));
                games.setScoreCollection(null);
                items.add(games);
            }
            if (items.isEmpty())
                return new ResponseEntity<>(HttpStatus.NO_CONTENT);

            return new ResponseEntity<>(items, HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<>(null, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    // @GetMapping("{id}")
    // public ResponseEntity<Games> getById(@PathVariable("id") Integer id) {
    // Optional<Games> existingItemOptional = repository.findById(id);

    // if (existingItemOptional.isPresent()) {
    // return new ResponseEntity<>(existingItemOptional.get(), HttpStatus.OK);
    // } else {
    // return new ResponseEntity<>(HttpStatus.NOT_FOUND);
    // }
    // }

    @GetMapping("details/{gameId}/{topicId}/{difficultyId}")
    public ResponseEntity<List<GamesDetailDto>> getGames(@PathVariable("gameId") Integer gameId,
            @PathVariable("topicId") Integer topicId, @PathVariable("difficultyId") Integer difficultyId) {
        try {
            List<GamesDetailDto> items = new ArrayList<GamesDetailDto>();

            // repository.findAll().forEach(items::add);

            if (items.isEmpty())
                return new ResponseEntity<>(HttpStatus.NO_CONTENT);

            return new ResponseEntity<>(items, HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<>(null, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @GetMapping("plays")
    public ResponseEntity<List<GamesDetailDto>> getGamePlays(@RequestParam int gameId, @RequestParam int topicId,
            @RequestParam int difficultyId) {
        try {
            List<GamesDetailDto> items = new ArrayList<GamesDetailDto>();

            Difficulties diff = diffRepo.findById(difficultyId).orElse(null);
            Pageable limit = PageRequest.of(0, diff.getTotalQuestion());
            Pageable option = PageRequest.of(0, 5);
            if (diff != null) {
                for (GameDetails gameDetail : detailRepo.findByGameIdAndTopicIdLimited(gameId, topicId, limit)) {
                    GamesDetailDto dto = GameDetailsMapper.toGameDetailsDto(gameDetail);
                    String ca = dto.getCorrectAnswer();
                    String search = "%" + dto.getQuestion().substring(dto.getQuestion().lastIndexOf(" ")) + "%";
                    List<String> options = detailRepo.findAnswers(search, option);
                    options.remove(ca);
                    if (options.size() < 4) {
                        options.addAll(detailRepo.findAnswersByStartLetter("%" + ca.substring(0, 1) + "%", option));
                    }
                    options.remove(ca);
                    options.remove(ca);
                    if (options.size() < 4) {
                        options.addAll(detailRepo.findAnswersByStartLetter("%%", option));
                    }
                    options.remove(ca);
                    Random rand = new Random();
                    options.add(rand.nextInt(4), ca);
                    dto.setAnswerOne(options.get(0));
                    dto.setAnswerTwo(options.get(1));
                    dto.setAnswerThree(options.get(2));
                    dto.setAnswerFour(options.get(3));
                    items.add(dto);
                }
            }

            if (items.isEmpty())
                return new ResponseEntity<>(HttpStatus.NO_CONTENT);

            return new ResponseEntity<>(items, HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<>(null, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

}
