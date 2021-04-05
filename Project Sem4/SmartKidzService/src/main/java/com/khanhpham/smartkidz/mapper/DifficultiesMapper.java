package com.khanhpham.smartkidz.mapper;

import com.khanhpham.smartkidz.Utils.EnumU.Status;
import com.khanhpham.smartkidz.dto.DifficultiesDto;
import com.khanhpham.smartkidz.entity.Difficulties;

public class DifficultiesMapper {

    public static DifficultiesDto toDifficultiesDto(Difficulties difficulties) {
        DifficultiesDto tdd = new DifficultiesDto();
        tdd.setId(difficulties.getId());
        tdd.setName(difficulties.getName());
        tdd.setRequiredScore(difficulties.getRequiredScore());
        tdd.setTimeLimit(difficulties.getTimeLimit());
        tdd.setTotalTimePlay(difficulties.getTotalTimePlay());
        tdd.setTotalQuestion(difficulties.getTotalQuestion());
        tdd.setIsActive(Status.find(difficulties.getIsActive()));
        tdd.setGameId(difficulties.getGameId());
        return tdd;
    }

    public static Difficulties fromDifficultiesDto(DifficultiesDto d) {
        Difficulties tdd = new Difficulties();
        tdd.setId(d.getId());
        tdd.setName(d.getName());
        tdd.setRequiredScore(d.getRequiredScore());
        tdd.setTimeLimit(d.getTimeLimit());
        tdd.setTotalTimePlay(d.getTotalTimePlay());
        tdd.setTotalQuestion(d.getTotalQuestion());
        tdd.setIsActive(d.getIsActive().value);
        tdd.setGameId(d.getGameId());

        return tdd;
    }

}
