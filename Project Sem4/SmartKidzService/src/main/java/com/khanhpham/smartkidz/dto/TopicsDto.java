package com.khanhpham.smartkidz.dto;

import javax.validation.constraints.NotBlank;

import com.khanhpham.smartkidz.Utils.EnumU.Status;
import com.khanhpham.smartkidz.entity.Games;
//import com.rolandopalermo.util.JsonConverter;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class TopicsDto {

    private int id;

    @NotBlank(message = "Name topic cannot blank!")
    private String name;

    private String image;

    private Status isActive;

    private Games gameId;

}
