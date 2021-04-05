package com.khanhpham.smartkidz.mapper;

import com.khanhpham.smartkidz.Utils.EnumU.Status;
import com.khanhpham.smartkidz.dto.IconDto;
import com.khanhpham.smartkidz.entity.Icon;

public class IconMapper {

    public static IconDto toIconDto(Icon icon) {
        IconDto id = new IconDto();
        id.setId(icon.getId());
        id.setUrl(icon.getUrl());
        id.setIsActive(Status.find(icon.getIsActive()));

        return id;
    }

    public static Icon fromIconDto(IconDto i) {
        Icon fi = new Icon();
        fi.setId(i.getId());
        fi.setUrl(i.getUrl());
        fi.setIsActive(i.getIsActive().value);
        return fi;
    }

}
