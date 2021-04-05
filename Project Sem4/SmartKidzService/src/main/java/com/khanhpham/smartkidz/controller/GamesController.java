package com.khanhpham.smartkidz.controller;

import java.util.List;

import javax.validation.Valid;

import com.khanhpham.smartkidz.Utils.EnumU.Status;
import com.khanhpham.smartkidz.dto.GamesDto;
import com.khanhpham.smartkidz.service.FileStorageService;
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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

@Controller
public class GamesController {

    @Autowired
    GamesService service;

    @Autowired
    private FileStorageService fileStorageService;

    @GetMapping(value = "/game/show")
    public String gameIndex(Model model) {
        List<GamesDto> games = service.findAll();
        model.addAttribute("games", games);
        model.addAttribute("status", "active");
        return "gameList";
    }

    @GetMapping(value = "/game/showDeleted")
    public String gameIndexDeleted(Model model) {
        List<GamesDto> games = service.findByInactive();
        model.addAttribute("games", games);
        model.addAttribute("status", "inactive");
        return "gameList";
    }

    @GetMapping(value = "/game/create")
    public String displayCreate(Model model) {
        GamesDto game = new GamesDto();
        model.addAttribute("game", game);
        return "gameCreate";
    }

    @PostMapping(value = "/game/doCreate")
    public String gameCreate(Model model, @Valid @ModelAttribute("game") GamesDto game, BindingResult result,
            @RequestParam("imageFile") MultipartFile imageFile, @RequestParam("musicFile") MultipartFile musicFile,
            Errors errors) {
        if (null != errors && errors.getErrorCount() > 0) {
            return "gameCreate";
        } else {
            if (!imageFile.isEmpty()) {
                String imageFileName = fileStorageService.storeFile(imageFile, null);
                String imageFileUri = ServletUriComponentsBuilder.fromCurrentContextPath().path("/downloadFile/")
                        .path(imageFileName).toUriString();
                game.setImage(imageFileUri);
            }
            if (!musicFile.isEmpty()) {
                String musicFileName = fileStorageService.storeFile(musicFile, null);
                String musicFileUri = ServletUriComponentsBuilder.fromCurrentContextPath().path("/downloadFile/")
                        .path(musicFileName).toUriString();
                game.setBgm(musicFileUri);
            }
        }
        game.setIsActive(Status.active);
        service.create(game);
        return "redirect:/game/show";
    }

    @GetMapping(value = "/game/update/{id}")
    public String displayUpdate(Model model, @PathVariable("id") int id) {
        GamesDto game = service.findById(id);
        if (game != null) {
            model.addAttribute("game", game);
        }
        return "gameUpdate";
    }

    @PostMapping(value = "/game/doUpdate")
    public String topicUpdate(Model model, @Valid @ModelAttribute("game") GamesDto game, BindingResult result,
            @RequestParam("imageFile") MultipartFile imageFile, @RequestParam("musicFile") MultipartFile musicFile,
            Errors errors) {
        if (null != errors && errors.getErrorCount() > 0) {
            return "gameUpdate";
        } else {
            if (!imageFile.isEmpty()) {

                String imageFileName = fileStorageService.storeFile(imageFile, null);
                String imageFileUri = ServletUriComponentsBuilder.fromCurrentContextPath().path("/downloadFile/")
                        .path(imageFileName).toUriString();
                game.setImage(imageFileUri);
                System.out.println(imageFileUri);
            }
            if (!musicFile.isEmpty()) {

                String musicFileName = fileStorageService.storeFile(musicFile, null);
                String musicFileUri = ServletUriComponentsBuilder.fromCurrentContextPath().path("/downloadFile/")
                        .path(musicFileName).toUriString();
                game.setBgm(musicFileUri);
            }
            service.update(game);
            return "redirect:/game/show";
        }
    }

    @GetMapping(value = "/game/delete/{id}")
    public String gameDelete(Model model, @PathVariable("id") int id) {
        GamesDto game = service.findById(id);
        game.setIsActive(Status.inactive);
        service.update(game);
        return "redirect:/game/show";
    }

    @GetMapping(value = "/game/enable/{id}")
    public String gameEnable(Model model, @PathVariable("id") int id) {
        GamesDto game = service.findById(id);
        game.setIsActive(Status.active);
        service.update(game);
        return "redirect:/game/showDeleted";
    }
}