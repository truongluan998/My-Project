package com.khanhpham.smartkidz.mapper;

import com.khanhpham.smartkidz.Utils.EnumU.Status;
import com.khanhpham.smartkidz.dto.GamesDto;
import com.khanhpham.smartkidz.entity.Games;

public class GamesMapper {

    public static GamesDto toGamesDto(Games games) {
        GamesDto gd = new GamesDto();
        gd.setId(games.getId());
        gd.setName(games.getName());
        gd.setImage(games.getImage());
        gd.setBgm(games.getBgm());
        gd.setIsActive(Status.find(games.getIsActive()));
        gd.setDescription(games.getDescription());

        return gd;
    }

    public static Games fromGamesDto(GamesDto gamesDto) {
        Games g = new Games();
        g.setId(gamesDto.getId());
        g.setName(gamesDto.getName());
        g.setImage(gamesDto.getImage());
        g.setBgm(gamesDto.getBgm());
        g.setIsActive(gamesDto.getIsActive().value);
        g.setDescription(gamesDto.getDescription());

        return g;
    }
}
