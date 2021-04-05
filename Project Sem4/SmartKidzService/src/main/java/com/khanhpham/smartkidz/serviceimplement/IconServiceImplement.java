package com.khanhpham.smartkidz.serviceimplement;

import java.util.ArrayList;
import java.util.List;

import com.khanhpham.smartkidz.dto.IconDto;
import com.khanhpham.smartkidz.entity.Icon;
import com.khanhpham.smartkidz.mapper.IconMapper;
import com.khanhpham.smartkidz.repository.IconRepository;
import com.khanhpham.smartkidz.service.IconService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class IconServiceImplement implements IconService {

    @Autowired
    IconRepository repo;

    @Override
    public List<IconDto> findAll() {
        List<IconDto> result = new ArrayList<>();
        for (Icon i : repo.findAll()) {
            result.add(IconMapper.toIconDto(i));
        }
        return result;
    }

    @Override
    public List<IconDto> findByInactive() {
        List<IconDto> result = new ArrayList<>();
        for (Icon i : repo.findIconByInactive()) {
            result.add(IconMapper.toIconDto(i));
        }
        return result;
    }

    @Override
    public IconDto findById(int id) {
        IconDto result = null;
        try {
            Icon i = repo.findById(id).orElse(null);
            if (i != null) {
                result = IconMapper.toIconDto(i);
            }
        } catch (Exception e) {
            e.getMessage();
        }
        return result;
    }

    @Override
    public boolean create(IconDto dto) {

        Icon t = IconMapper.fromIconDto(dto);
        return repo.save(t) != null;

    }

    @Override
    public boolean update(IconDto dto) {
        Icon i = IconMapper.fromIconDto(dto);
        return repo.save(i) != null;
    }

}
