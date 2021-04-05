package com.khanhpham.smartkidz.controller;

import java.util.List;

import javax.validation.Valid;

import com.khanhpham.smartkidz.Utils.EnumU.Status;
import com.khanhpham.smartkidz.dto.LevelsDto;
import com.khanhpham.smartkidz.service.FileStorageService;
import com.khanhpham.smartkidz.service.LevelsService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.Errors;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

@Controller
public class LevelsController {
    @Autowired
    LevelsService service;

    @Autowired
    FileStorageService fileStorageService;

    @GetMapping(value = "/level/show")
    public String topicIndex(Model model) {
        List<LevelsDto> levels = service.findAll();
        model.addAttribute("levels", levels);
        model.addAttribute("status", "active");
        return "levelList";
    }

    @GetMapping(value = "/level/showDeleted")
    public String topicIndexDeleted(Model model) {
        List<LevelsDto> levels = service.findByInactive();
        model.addAttribute("levels", levels);
        model.addAttribute("status", "inactive");
        return "levelList";
    }

    @GetMapping(value = "/level/create")
    public String displayCreate(Model model) {
        LevelsDto level = new LevelsDto();
        model.addAttribute("level", level);
        return "levelCreate";
    }

    @PostMapping(value = "/level/doCreate")
    public String levelsCreate(Model model, @Valid @ModelAttribute("level") LevelsDto level, BindingResult result,
            @RequestParam("file") MultipartFile file, Errors errors) {
        if (null != errors && errors.getErrorCount() > 0) {
            return "levelCreate";
        } else {
            if (!file.isEmpty()) {
                String fileName = fileStorageService.storeFile(file, null);
                String fileDownloadUri = ServletUriComponentsBuilder.fromCurrentContextPath().path("/downloadFile/")
                        .path(fileName).toUriString();

                level.setIcon(fileDownloadUri);
            }
            level.setIsActive(Status.active);
            model.addAttribute("level", level);
            service.create(level);
            return "redirect:/level/show";
        }
    }

    @GetMapping(value = "/level/update/{id}")
    public String displayUpdate(Model model, @PathVariable("id") int id) {
        LevelsDto level = service.findById(id);
        if (level != null) {
            model.addAttribute("level", level);
        }
        return "levelUpdate";
    }

    @PostMapping(value = "/level/doUpdate")
    public String levelUpdate(Model model, @Valid @ModelAttribute("level") LevelsDto level, BindingResult result,
            @RequestParam("file") MultipartFile file, Errors errors) {
        if (null != errors && errors.getErrorCount() > 0) {
            return "levelUpdate";
        } else {
            if (!file.isEmpty()) {
                String fileName = fileStorageService.storeFile(file, null);
                String fileDownloadUri = ServletUriComponentsBuilder.fromCurrentContextPath().path("/downloadFile/")
                        .path(fileName).toUriString();
                level.setIcon(fileDownloadUri);
            }
            service.update(level);
            return "redirect:/level/show";
        }
    }

    @GetMapping(value = "/level/delete/{id}")
    public String levelsDelete(Model model, @PathVariable("id") int id) {
        LevelsDto level = service.findById(id);
        level.setIsActive(Status.inactive);
        service.update(level);
        return "redirect:/level/show";
    }

    @GetMapping(value = "/level/enable/{id}")
    public String levelEnable(Model model, @PathVariable("id") int id) {
        LevelsDto level = service.findById(id);
        level.setIsActive(Status.active);
        service.update(level);
        return "redirect:/level/showDeleted";
    }
}