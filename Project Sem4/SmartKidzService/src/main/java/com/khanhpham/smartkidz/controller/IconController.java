package com.khanhpham.smartkidz.controller;

import java.util.List;

import com.khanhpham.smartkidz.Utils.EnumU.Status;
import com.khanhpham.smartkidz.dto.IconDto;
import com.khanhpham.smartkidz.service.FileStorageService;
import com.khanhpham.smartkidz.service.IconService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

@Controller
public class IconController {

    @Autowired
    IconService service;

    @Autowired
    FileStorageService fileStorageService;

    @GetMapping(value = "/icon/show")
    public String iconIndex(Model model) {
        List<IconDto> icon = service.findAll();
        model.addAttribute("icons", icon);
        model.addAttribute("status", "active");
        return "iconList";
    }

    @GetMapping(value = "/icon/showDeleted")
    public String iconIndexDeleted(Model model) {
        List<IconDto> icon = service.findByInactive();
        model.addAttribute("icons", icon);
        model.addAttribute("status", "inactive");
        return "iconList";
    }

    @GetMapping(value = "/icon/create")
    public String displayCreate(Model model) {

        IconDto icon = new IconDto();
        model.addAttribute("icon", icon);
        return "iconCreate";
    }

    @PostMapping(value = "/icon/doCreate")
    public String iconCreate(@ModelAttribute("icon") IconDto icon, @RequestParam("file") MultipartFile file,
            BindingResult resut) {
        if (!file.isEmpty()) {
            String fileName = fileStorageService.storeFile(file, null);
            String fileDownloadUri = ServletUriComponentsBuilder.fromCurrentContextPath().path("/downloadFile/")
                    .path(fileName).toUriString();

            icon.setUrl(fileDownloadUri);
        }
        icon.setIsActive(Status.active);
        service.create(icon);
        return "redirect:/icon/show";
    }

    @GetMapping(value = "/icon/update/{id}")
    public String displayUpdate(Model model, @PathVariable("id") int id) {
        IconDto icon = service.findById(id);
        if (icon != null) {
            model.addAttribute("icon", icon);
        }
        return "iconUpdate";
    }

    @PostMapping(value = "/icon/doUpdate")
    public String iconUpdate(Model model, @ModelAttribute("icon") IconDto icon,
            @RequestParam("file") MultipartFile file, BindingResult result) {
        if (!file.isEmpty()) {
            String fileName = fileStorageService.storeFile(file, null);
            String fileDownloadUri = ServletUriComponentsBuilder.fromCurrentContextPath().path("/downloadFile/")
                    .path(fileName).toUriString();

            icon.setUrl(fileDownloadUri);
        }
        service.update(icon);
        return "redirect:/icon/show";
    }

    @GetMapping(value = "/icon/delete/{id}")
    public String iconDelete(Model model, @PathVariable("id") int id) {
        IconDto icon = service.findById(id);
        icon.setIsActive(Status.inactive);
        service.update(icon);
        return "redirect:/icon/show";
    }

    @GetMapping(value = "/icon/enable/{id}")
    public String iconEnable(Model model, @PathVariable("id") int id) {
        IconDto icon = service.findById(id);
        icon.setIsActive(Status.active);
        service.update(icon);
        return "redirect:/icon/show";
    }

}
