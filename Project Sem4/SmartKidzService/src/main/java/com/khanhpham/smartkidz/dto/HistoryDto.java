package com.khanhpham.smartkidz.dto;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class HistoryDto {

    private int id;

    private int score;

    private Date timestamp;

    private int userId;

    private int gameId;

    private String gameName;
}
