package com.khanhpham.smartkidz.dto;

import com.khanhpham.smartkidz.Utils.EnumU.Status;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class IconDto {

    public Integer id;

    public String url;

    public Status isActive;

}
