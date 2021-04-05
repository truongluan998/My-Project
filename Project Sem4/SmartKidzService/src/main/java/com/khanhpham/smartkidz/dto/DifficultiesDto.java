package com.khanhpham.smartkidz.dto;

import javax.validation.constraints.NotBlank;

import com.khanhpham.smartkidz.Utils.EnumU.Status;
import com.khanhpham.smartkidz.entity.Games;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class DifficultiesDto {

    private int id;

    @NotBlank(message = "Name difficulty cannot blank!")
    private String name;

    private int requiredScore;

    private int timeLimit;

    private int totalTimePlay;

    private int totalQuestion;

    private Status isActive;

    private Games gameId;

}
