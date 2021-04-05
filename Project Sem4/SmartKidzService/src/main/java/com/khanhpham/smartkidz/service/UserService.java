package com.khanhpham.smartkidz.service;

import java.util.List;

import com.khanhpham.smartkidz.dto.UsersDto;

import org.springframework.stereotype.Service;

@Service
public interface UserService {

    List<UsersDto> findAll();

    List<UsersDto> findByAdmin(boolean isAdmin);

    List<UsersDto> findByAdminInactive(boolean isAdmin);

    UsersDto findById(int id);

    UsersDto create(UsersDto dto);

    UsersDto update(UsersDto dto);

    UsersDto findByProfile(String username);

    boolean checkPassword(String checkPass, int id);

}
