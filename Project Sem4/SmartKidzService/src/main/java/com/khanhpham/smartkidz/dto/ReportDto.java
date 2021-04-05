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
public class ReportDto {

    private Date DateU;
    private Long AmountU;

    private String NameG;
}
