package com.khanhpham.smartkidz.controller;

import java.util.List;

import javax.validation.Valid;

import com.khanhpham.smartkidz.Utils.EnumU.Status;
import com.khanhpham.smartkidz.dto.DifficultiesDto;
import com.khanhpham.smartkidz.dto.GamesDto;
import com.khanhpham.smartkidz.service.DifficultiesService;
import com.khanhpham.smartkidz.service.GamesService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.Errors;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

@Controller
public class DifficultiesController {

    @Autowired
    DifficultiesService service;

    @Autowired
    GamesService gameService;

    @GetMapping(value = "/difficulties/show")
    public String difficultiesIndex(Model model) {
        List<DifficultiesDto> difficulties = service.findAll();
        model.addAttribute("difficulties", difficulties);
        model.addAttribute("status", "active");
        return "difficultiesList";
    }

    @GetMapping(value = "/difficulties/showDeleted")
    public String difficultiesIndexDeleted(Model model) {
        List<DifficultiesDto> difficulties = service.findByInactive();
        model.addAttribute("difficulties", difficulties);
        model.addAttribute("status", "inactive");
        return "difficultiesList";
    }

    @GetMapping(value = "/difficulties/create")
    public String displayCreate(Model model) {
        List<GamesDto> games = gameService.findAll();
        DifficultiesDto difficulties = new DifficultiesDto();
        model.addAttribute("games", games);
        model.addAttribute("difficulties", difficulties);
        return "difficultiesCreate";
    }

    @PostMapping(value = "/difficulties/doCreate")
    public String difficultiesCreate(Model model, @ModelAttribute("difficulties") DifficultiesDto difficulties,
            BindingResult result) {
        difficulties.setIsActive(Status.active);
        service.create(difficulties);
        return "redirect:/difficulties/show";
    }

    @GetMapping(value = "/difficulties/update/{id}")
    public String displayUpdate(Model model, @PathVariable("id") int id) {
        DifficultiesDto difficulties = service.findById(id);
        List<GamesDto> games = gameService.findAll();
        model.addAttribute("games", games);
        if (difficulties != null) {
            model.addAttribute("difficulties", difficulties);
        }
        return "difficultiesUpdate";
    }

    @PostMapping(value = "/difficulties/doUpdate")
    public String difficultiesUpdate(Model model, @Valid @ModelAttribute("difficulties") DifficultiesDto difficulties,
            BindingResult result, Errors errors) {
        if (null != errors && errors.getErrorCount() > 0) {
            return "difficultiesUpdate";
        } else {
            service.update(difficulties);
            return "redirect:/difficulties/show";
        }
    }

    @GetMapping(value = "/difficulties/delete/{id}")
    public String diffiDelete(Model model, @PathVariable("id") int id) {
        DifficultiesDto diff = service.findById(id);
        diff.setIsActive(Status.inactive);
        service.update(diff);
        return "redirect:/difficulties/show";
    }

    @GetMapping(value = "/difficulties/enable/{id}")
    public String diffiEnable(Model model, @PathVariable("id") int id) {
        DifficultiesDto diff = service.findById(id);
        diff.setIsActive(Status.active);
        service.update(diff);
        return "redirect:/difficulties/showDeleted";
    }

}