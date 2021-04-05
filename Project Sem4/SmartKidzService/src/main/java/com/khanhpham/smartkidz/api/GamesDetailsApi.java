package com.khanhpham.smartkidz.api;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import com.khanhpham.smartkidz.entity.GameDetails;
import com.khanhpham.smartkidz.repository.GamesDetailsRepository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/v1/gameDetails")
class GamesDetailsApi {

    @Autowired
    GamesDetailsRepository repository;

    @GetMapping
    public ResponseEntity<List<GameDetails>> getAll() {
        try {
            List<GameDetails> items = new ArrayList<GameDetails>();

            repository.findAll().forEach(items::add);

            if (items.isEmpty())
                return new ResponseEntity<>(HttpStatus.NO_CONTENT);

            return new ResponseEntity<>(items, HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<>(null, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @GetMapping("{id}")
    public ResponseEntity<GameDetails> getById(@PathVariable("id") Integer id) {
        Optional<GameDetails> existingItemOptional = repository.findById(id);

        if (existingItemOptional.isPresent()) {
            return new ResponseEntity<>(existingItemOptional.get(), HttpStatus.OK);
        } else {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }

    @GetMapping("plays")
    public ResponseEntity<List<GameDetails>> getGamePlays(@RequestParam int gameId, @RequestParam int topicId,
            @RequestParam int difficultyId) {
        try {
            List<GameDetails> items = new ArrayList<GameDetails>();

            repository.findByGameIdAndTopicIdAndDiff(gameId, topicId, difficultyId).forEach(items::add);

            if (items.isEmpty())
                return new ResponseEntity<>(HttpStatus.NO_CONTENT);

            return new ResponseEntity<>(items, HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<>(null, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

}
