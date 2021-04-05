package com.khanhpham.smartkidz.mapper;

import com.khanhpham.smartkidz.dto.ScoreDto;
import com.khanhpham.smartkidz.entity.Score;

public class ScoreMapper {

    public static ScoreDto toScoreDto(Score score) {
        ScoreDto sd = new ScoreDto();

        sd.setId(score.getId());
        sd.setScore(score.getScore());
        sd.setGameId(score.getGameId().getId());
        // sd.setUserId(score.getUserId().getId());
        return sd;
    }

    // public static Score fromScoreDto(ScoreDto scoreDto) {
    // Score s = new Score();

    // s.setId(scoreDto.getId());
    // s.setScore(scoreDto.getScore());
    // s.setGameId(scoreDto.getGameId());
    // // s.setUserId(UsersRepository);
    // return s;
    // }

}
