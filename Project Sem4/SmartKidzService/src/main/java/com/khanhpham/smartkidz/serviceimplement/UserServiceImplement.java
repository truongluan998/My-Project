package com.khanhpham.smartkidz.serviceimplement;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import com.khanhpham.smartkidz.dto.UsersDto;
import com.khanhpham.smartkidz.entity.Users;
import com.khanhpham.smartkidz.mapper.UsersMapper;
import com.khanhpham.smartkidz.repository.LevelsRepository;
import com.khanhpham.smartkidz.repository.UsersRepository;
import com.khanhpham.smartkidz.service.UserService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class UserServiceImplement implements UserService {
    @Autowired
    UsersRepository repo;

    @Autowired
    LevelsRepository levelRepo;

    @Autowired
    BCryptPasswordEncoder passwordEncoder;

    @Override
    public List<UsersDto> findAll() {
        List<UsersDto> results = new ArrayList<>();
        for (Users u : repo.findAll()) {
            results.add(UsersMapper.toUsersDto(u));
        }
        return results;
    }

    @Override
    public List<UsersDto> findByAdmin(boolean isAdmin) {
        List<UsersDto> results = new ArrayList<>();
        for (Users u : repo.findByIsAdmin(isAdmin)) {
            results.add(UsersMapper.toUsersDto(u));
        }
        return results;
    }

    @Override
    public List<UsersDto> findByAdminInactive(boolean isAdmin) {
        List<UsersDto> results = new ArrayList<>();
        for (Users u : repo.findByIsAdminInactive(isAdmin)) {
            results.add(UsersMapper.toUsersDto(u));
        }
        return results;
    }

    @Override
    public UsersDto findById(int id) {
        UsersDto result = null;
        try {
            Optional<Users> u = repo.findById(id);
            if (u.isPresent()) {
                result = UsersMapper.toUsersDto(u.get());
            }
        } catch (Exception e) {
            e.getMessage();
        }
        return result;
    }

    @Override
    public UsersDto create(UsersDto dto) {
        Users check = repo.findByUsername(dto.getUsername());
        if (check != null) {
            return null;
        }
        Users u = UsersMapper.fromUsersDto(dto);
        if (u.getLevelId() == null) {
            u.setLevelId(levelRepo.findById(1).orElse(null));
        }
        return UsersMapper.toUsersDto(repo.save(u));
    }

    @Override
    public UsersDto update(UsersDto dto) {
        Users u = UsersMapper.fromUsersDto(dto);
        u.setCreatedAt(repo.findById(dto.getId()).get().getCreatedAt());
        if (u.getLevelId() == null) {
            u.setLevelId(levelRepo.findById(1).orElse(null));
        }
        return UsersMapper.toUsersDto(repo.save(u));
    }

    @Override
    public UsersDto findByProfile(String username) {
        UsersDto result = null;
        Users u = repo.findByProfile(username);
        if (u != null) {
            result = UsersMapper.toUsersDto(u);
        }
        return result;

    }

    @Override
    public boolean checkPassword(String checkPass, int id) {

        Optional<Users> u = repo.findById(id);
        if (u != null) {
            Users user = u.get();
            if (user.getPassword() == checkPass) {
                return true;
            }
        }
        return false;
    }

}
