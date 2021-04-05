package com.khanhpham.smartkidz.api;

import java.util.HashMap;
import java.util.List;

import com.khanhpham.smartkidz.Utils.EnumU.Gender;
import com.khanhpham.smartkidz.Utils.EnumU.Role;
import com.khanhpham.smartkidz.Utils.EnumU.Status;
import com.khanhpham.smartkidz.dto.UsersDto;
import com.khanhpham.smartkidz.entity.Icon;
import com.khanhpham.smartkidz.repository.HistoryRepository;
import com.khanhpham.smartkidz.repository.IconRepository;
import com.khanhpham.smartkidz.repository.LevelsRepository;
import com.khanhpham.smartkidz.repository.ScoreRepository;
import com.khanhpham.smartkidz.service.UserService;

import org.apache.commons.collections4.BidiMap;
import org.apache.commons.collections4.bidimap.DualHashBidiMap;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping(value = "/api/v1/users")
class UsersApi {

    @Autowired
    UserService service;

    @Autowired
    HistoryRepository historyRepo;

    @Autowired
    ScoreRepository scoreRepo;

    @Autowired
    LevelsRepository levelRepo;

    @Autowired
    IconRepository iconRepo;

    @Autowired
    BCryptPasswordEncoder passwordencoder;

    @GetMapping
    public ResponseEntity<List<UsersDto>> getAll() {
        try {
            List<UsersDto> items = service.findAll();

            if (items.isEmpty())
                return new ResponseEntity<>(HttpStatus.NO_CONTENT);

            return new ResponseEntity<>(items, HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<>(null, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @GetMapping(value = "{id}")
    public ResponseEntity<UsersDto> getById(@PathVariable("id") Integer id) {
        UsersDto existingItemOptional = service.findById(id);

        if (existingItemOptional != null) {
            return new ResponseEntity<>(existingItemOptional, HttpStatus.OK);
        } else {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }

    @GetMapping(value = "position/{id}")
    public ResponseEntity<HashMap<Integer, UsersDto>> getPosition(@PathVariable("id") Integer id) {
        try {
            List<Object[]> listUser = historyRepo.getPosition();
            HashMap<Integer, UsersDto> userList = new HashMap<Integer, UsersDto>();
            BidiMap<Integer, Integer> map = new DualHashBidiMap<>();
            int position = 0;
            for (Object[] ob : listUser) {
                position++;
                map.put(position, (int) ob[0]);
            }
            if (!map.containsKey(id)) {
                map.put(map.size() + 1, id);
            }
            int from = 4;
            if (map.getKey(id) > 7) {
                from = map.getKey(id) - 3;
            }

            for (int i = 1; i <= 3; i++) {
                if (map.containsKey(i)) {
                    userList.put(i, service.findById(map.get(i)));
                }
            }
            for (int i = from; i < from + 6; i++) {
                if (map.containsKey(i)) {
                    userList.put(i, service.findById(map.get(i)));
                }
            }
            if (!userList.isEmpty()) {
                return new ResponseEntity<>(userList, HttpStatus.OK);
            } else {
                return new ResponseEntity<>(HttpStatus.NO_CONTENT);
            }
        } catch (Exception e) {
            return new ResponseEntity<>(null, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @PostMapping(value = "create")
    public ResponseEntity<UsersDto> create(@RequestBody UsersDto item) {
        UsersDto checkUser = service.findByProfile(item.getUsername());
        if (checkUser != null) {
            if (item.getFullName() != null || item.getPhoto() != null) {
                checkUser.setUsername(item.getUsername());
                if (item.getPassword() != null)
                    checkUser.setPassword(passwordencoder.encode(item.getPassword()));
                checkUser.setFullName(item.getFullName());
                if (!item.getPhoto().isEmpty())
                    checkUser.setPhoto(item.getPhoto());
                checkUser.setEmail(item.getEmail());
                checkUser.setGender(item.getGender());
                return new ResponseEntity<>(service.update(checkUser), HttpStatus.OK);
            } else {
                return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
            }
        }
        try {
            if (item.getGender() == null) {
                item.setGender(Gender.female);
            }
            if (item.getIsActive() == null)
                item.setIsActive(Status.active);
            if (item.getIsAdmin() == null) {
                item.setIsAdmin(Role.user);
            }
            UsersDto savedItem = service.create(item);
            return new ResponseEntity<>(savedItem, HttpStatus.CREATED);
        } catch (Exception e) {
            return new ResponseEntity<>(null, HttpStatus.EXPECTATION_FAILED);
        }
    }

    @PutMapping(value = "{id}")
    public ResponseEntity<UsersDto> update(@PathVariable("id") Integer id, @RequestBody UsersDto item) {
        UsersDto existingItemOptional = service.findById(id);
        if (existingItemOptional != null) {
            return new ResponseEntity<>(service.update(existingItemOptional), HttpStatus.OK);
        } else {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }

    @DeleteMapping(value = "{id}")
    public ResponseEntity<HttpStatus> delete(@PathVariable("id") Integer id) {
        try {
            UsersDto existingItemOptional = service.findById(id);

            if (existingItemOptional != null) {
                existingItemOptional.setIsActive(Status.inactive);
                service.update(existingItemOptional);
                return new ResponseEntity<>(HttpStatus.OK);
            } else {
                return new ResponseEntity<>(HttpStatus.NOT_FOUND);
            }
        } catch (Exception e) {
            return new ResponseEntity<>(HttpStatus.EXPECTATION_FAILED);
        }
    }

    @GetMapping("/icon")
    public ResponseEntity<List<Icon>> getIcon() {
        try {
            List<Icon> items = iconRepo.findAll();

            if (items.isEmpty())
                return new ResponseEntity<>(HttpStatus.NO_CONTENT);

            return new ResponseEntity<>(items, HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<>(null, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    // @PostMapping("/score")
    // public ResponseEntity<UsersDto> updateScore(@RequestBody Score score) {
    // try {
    // Score s = scoreRepo.save(score);
    // UsersDto u = service.findById(s.getUserId().getId());
    // return new ResponseEntity<>(u, HttpStatus.OK);
    // } catch (Exception e) {
    // return new ResponseEntity<>(HttpStatus.EXPECTATION_FAILED);
    // }
    // }

    // @GetMapping("/api/v1/users/level/{id}")
    // public ResponseEntity<Levels> getLevelById(@PathVariable("id") Integer id) {
    // Optional<Levels> existingItemOptional = levelRepo.findById(id);

    // if (existingItemOptional.isPresent()) {
    // return new ResponseEntity<>(existingItemOptional.get(), HttpStatus.OK);
    // } else {
    // return new ResponseEntity<>(HttpStatus.NOT_FOUND);
    // }
    // }
}