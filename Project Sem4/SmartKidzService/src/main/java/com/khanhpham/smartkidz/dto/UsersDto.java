package com.khanhpham.smartkidz.dto;

import java.util.Collection;

import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

import com.khanhpham.smartkidz.Utils.EnumU.Gender;
import com.khanhpham.smartkidz.Utils.EnumU.Role;
import com.khanhpham.smartkidz.Utils.EnumU.Status;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Data
public class UsersDto {

    private int id;

    @NotNull
    @Size(min = 2, max = 10, message = "length should be in between 2 to 10")
    private String username;

    private String password;

    private String fullName;

    private Gender gender;

    private String email;

    private Role isAdmin;

    private Status isActive;

    private String photo;

    private Collection<ScoreDto> scoreCollection;

    private LevelsDto levelId;

}
