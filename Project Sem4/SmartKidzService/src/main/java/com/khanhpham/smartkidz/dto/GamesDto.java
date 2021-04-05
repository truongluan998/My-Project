package com.khanhpham.smartkidz.dto;

import javax.validation.constraints.NotBlank;

import com.khanhpham.smartkidz.Utils.EnumU.Status;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class GamesDto {

    private int id;

    @NotBlank(message = "Name game cannot blank!")
    private String name;

    private String image;

    private String bgm;

    private Status isActive;

    private String description;

}
