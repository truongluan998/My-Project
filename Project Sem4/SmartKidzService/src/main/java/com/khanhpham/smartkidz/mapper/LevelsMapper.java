package com.khanhpham.smartkidz.mapper;

import com.khanhpham.smartkidz.Utils.EnumU.Status;
import com.khanhpham.smartkidz.dto.LevelsDto;
import com.khanhpham.smartkidz.entity.Levels;

public class LevelsMapper {

    public static LevelsDto toLevelsDto(Levels levels) {
        LevelsDto ld = new LevelsDto();
        ld.setId(levels.getId());
        ld.setName(levels.getName());
        ld.setRequiredLevelScore(levels.getRequiredLevelScore());
        ld.setIcon(levels.getIcon());
        ld.setIsActive(Status.find(levels.getIsActive()));

        return ld;
    }

    public static Levels fromLevelsDto(LevelsDto LevelsDto) {
        Levels l = new Levels();
        l.setId(LevelsDto.getId());
        l.setName(LevelsDto.getName());
        l.setRequiredLevelScore(LevelsDto.getRequiredLevelScore());
        l.setIcon(LevelsDto.getIcon());
        l.setIsActive(LevelsDto.getIsActive().value);

        return l;
    }
}
