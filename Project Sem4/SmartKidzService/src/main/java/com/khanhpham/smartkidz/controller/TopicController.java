package com.khanhpham.smartkidz.controller;

import java.util.List;

import com.khanhpham.smartkidz.Utils.EnumU.Status;
import com.khanhpham.smartkidz.dto.GamesDto;
import com.khanhpham.smartkidz.dto.TopicsDto;
import com.khanhpham.smartkidz.service.FileStorageService;
import com.khanhpham.smartkidz.service.GamesService;
import com.khanhpham.smartkidz.service.TopicsService;

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
public class TopicController {

    @Autowired
    TopicsService service;

    @Autowired
    GamesService gameService;

    @Autowired
    FileStorageService fileStorageService;

    @GetMapping(value = "/topic/show")
    public String topicIndex(Model model) {

        List<TopicsDto> topics = service.findAll();

        model.addAttribute("topics", topics);
        model.addAttribute("status", "active");
        return "topicList";
    }

    @GetMapping(value = "/topic/showDeleted")
    public String topicIndexDeleted(Model model) {
        List<TopicsDto> topics = service.findInactive();
        model.addAttribute("topics", topics);
        model.addAttribute("status", "inactive");
        return "topicList";
    }

    @GetMapping(value = "/topic/create")
    public String displayCreate(Model model) {

        List<GamesDto> games = gameService.findAll();
        TopicsDto topic = new TopicsDto();
        model.addAttribute("games", games);
        model.addAttribute("topic", topic);
        return "topicCreate";
    }

    @PostMapping(value = "/topic/doCreate")
    public String topicCreate(@ModelAttribute("topic") TopicsDto topic, BindingResult result,
            @RequestParam("file") MultipartFile file) {

        if (!file.isEmpty()) {
            String fileName = fileStorageService.storeFile(file, null);
            String fileDownloadUri = ServletUriComponentsBuilder.fromCurrentContextPath().path("/downloadFile/")
                    .path(fileName).toUriString();

            topic.setImage(fileDownloadUri);
        }
        topic.setIsActive(Status.active);
        service.create(topic);
        return "redirect:/topic/show";
    }

    @GetMapping(value = "/topic/update/{id}")
    public String displayUpdate(Model model, @PathVariable("id") int id) {
        List<GamesDto> games = gameService.findAll();
        model.addAttribute("games", games);
        TopicsDto topic = service.findById(id);
        if (topic != null) {
            model.addAttribute("topic", topic);
        }
        return "topicUpdate";
    }

    @PostMapping(value = "/topic/doUpdate")
    public String topicUpdate(Model model, @ModelAttribute("topic") TopicsDto topic, BindingResult result,
            @RequestParam("file") MultipartFile file) {

        if (!file.isEmpty()) {
            String fileName = fileStorageService.storeFile(file, null);
            String fileDownloadUri = ServletUriComponentsBuilder.fromCurrentContextPath().path("/downloadFile/")
                    .path(fileName).toUriString();

            topic.setImage(fileDownloadUri);
        }
        service.update(topic);
        return "redirect:/topic/show";
    }

    @GetMapping(value = "/topic/delete/{id}")
    public String topicDelete(Model model, @PathVariable("id") int id) {
        TopicsDto topic = service.findById(id);
        topic.setIsActive(Status.inactive);
        service.update(topic);
        return "redirect:/topic/show";
    }

    @GetMapping(value = "/topic/enable/{id}")
    public String topicEnable(Model model, @PathVariable("id") int id) {
        TopicsDto topic = service.findById(id);
        topic.setIsActive(Status.active);
        service.update(topic);
        return "redirect:/topic/showDeleted";
    }

}