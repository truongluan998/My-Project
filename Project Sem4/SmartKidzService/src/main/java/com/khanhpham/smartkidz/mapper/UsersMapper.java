package com.khanhpham.smartkidz.mapper;

import java.util.ArrayList;
import java.util.Collection;

import com.khanhpham.smartkidz.Utils.EnumU.Gender;
import com.khanhpham.smartkidz.Utils.EnumU.Role;
import com.khanhpham.smartkidz.Utils.EnumU.Status;
import com.khanhpham.smartkidz.dto.ScoreDto;
import com.khanhpham.smartkidz.dto.UsersDto;
import com.khanhpham.smartkidz.entity.Score;
import com.khanhpham.smartkidz.entity.Users;

public class UsersMapper {

    public static UsersDto toUsersDto(Users users) {
        UsersDto ud = new UsersDto();
        ud.setId(users.getId());
        ud.setUsername(users.getUsername());
        ud.setPassword(users.getPassword());
        ud.setFullName(users.getFullname());
        ud.setGender(Gender.find(users.getGender()));
        ud.setIsAdmin(Role.find(users.getIsAdmin()));
        ud.setIsActive(Status.find(users.getIsActive()));
        ud.setPhoto(users.getPhoto());
        ud.setEmail(users.getEmail());
        if (users.getScoreCollection() != null)
            ud.setScoreCollection(mapping(users.getScoreCollection()));
        if (users.getLevelId() != null)
            ud.setLevelId(LevelsMapper.toLevelsDto(users.getLevelId()));

        return ud;
    }

    public static Users fromUsersDto(UsersDto users) {
        Users ud = new Users();
        ud.setId(users.getId());
        ud.setUsername(users.getUsername());
        ud.setPassword(users.getPassword());
        ud.setFullname(users.getFullName());
        ud.setGender(users.getGender().value);
        ud.setIsAdmin(users.getIsAdmin().value);
        ud.setIsActive(users.getIsActive().value);
        ud.setPhoto(users.getPhoto());
        ud.setEmail(users.getEmail());
        if (users.getLevelId() != null)
            ud.setLevelId(LevelsMapper.fromLevelsDto(users.getLevelId()));

        return ud;
    }

    public static Collection<ScoreDto> mapping(Collection<Score> scoreCollection) {
        Collection<ScoreDto> sCollection = new ArrayList<>();
        for (Score score : scoreCollection) {
            ScoreDto s = ScoreMapper.toScoreDto(score);
            sCollection.add(s);
        }
        return sCollection;
    }

}
