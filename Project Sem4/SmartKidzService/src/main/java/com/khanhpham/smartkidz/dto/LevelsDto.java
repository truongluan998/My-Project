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
public class LevelsDto {

    private int id;

    @NotBlank(message = "Cannot blank!")
    private String name;

    private int requiredLevelScore;

    private String icon;

    private Status isActive;

}
