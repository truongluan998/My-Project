package com.khanhpham.smartkidz.dto;

import javax.validation.constraints.NotBlank;

import com.khanhpham.smartkidz.Utils.EnumU.Status;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class GamesDetailDto {

    private int id;

    private String question;

    private String image;

    @NotBlank(message = "Correct Answer cannot blank!")
    private String correctAnswer;

    private Status isActive;

    private int gameId;

    private int difficultyId;

    private int points;

    private Integer topicId;

    private String answerOne;

    private String answerTwo;

    private String answerThree;

    private String answerFour;
}
