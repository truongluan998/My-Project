package com.khanhpham.smartkidz.mapper;

import com.khanhpham.smartkidz.Utils.EnumU.Status;
import com.khanhpham.smartkidz.dto.TopicsDto;
import com.khanhpham.smartkidz.entity.Topics;

public class TopicsMapper {

    public static TopicsDto toTopicsDto(Topics topics) {
        TopicsDto td = new TopicsDto();
        td.setId(topics.getId());
        td.setName(topics.getName());
        td.setImage(topics.getImage());
        td.setIsActive(Status.find(topics.getIsActive()));
        td.setGameId(topics.getGameId());

        return td;
    }

    public static Topics fromTopicsDto(TopicsDto topicsDto) {
        Topics t = new Topics();
        t.setId(topicsDto.getId());
        t.setName(topicsDto.getName());
        t.setImage(topicsDto.getImage());
        t.setIsActive(topicsDto.getIsActive().value);
        t.setGameId(topicsDto.getGameId());

        return t;
    }

}
