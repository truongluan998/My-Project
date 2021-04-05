package com.khanhpham.smartkidz.controller;

import java.util.ArrayList;
import java.util.List;

import com.khanhpham.smartkidz.Utils.EnumU.Status;
import com.khanhpham.smartkidz.dto.DifficultiesDto;
import com.khanhpham.smartkidz.dto.GamesDetailDto;
import com.khanhpham.smartkidz.dto.GamesDto;
import com.khanhpham.smartkidz.dto.TopicsDto;
import com.khanhpham.smartkidz.service.DifficultiesService;
import com.khanhpham.smartkidz.service.FileStorageService;
import com.khanhpham.smartkidz.service.GameDetailsService;
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

import groovy.util.logging.Slf4j;

@Controller
@Slf4j
public class GameDetailsController {

    @Autowired
    GameDetailsService service;

    @Autowired
    GamesService gameService;

    @Autowired
    DifficultiesService diffService;

    @Autowired
    TopicsService topicService;

    @Autowired
    FileStorageService fileStorageService;

    @GetMapping(value = "/gameDetails/show")
    public String gameDetailsIndex(Model model,
            @RequestParam(value = "gameId", defaultValue = "All Games") String gameId,
            @RequestParam(value = "topicId", defaultValue = "All Topics") String topicId) {

        List<GamesDetailDto> gameDetail = new ArrayList<GamesDetailDto>();
        List<TopicsDto> topic = new ArrayList<>();
        if (gameId.equals("All Games")) {
            gameDetail = service.findAll();
            topic = topicService.findAll();
        } else {
            topic = topicService.findByGameId(Integer.parseInt(gameId));
            model.addAttribute("gId", Integer.parseInt(gameId));
            if (topicId.equals("All Topics")) {
                gameDetail = service.findByGameId(Integer.parseInt(gameId));
            } else {
                model.addAttribute("tId", Integer.parseInt(topicId));
                gameDetail = service.findByGameIdAndTopicId(Integer.parseInt(gameId), Integer.parseInt(topicId));
            }
        }
        List<GamesDto> games = gameService.findAll();
        model.addAttribute("status", "active");
        model.addAttribute("topics", topic);
        model.addAttribute("games", games);
        model.addAttribute("gameDetails", gameDetail);
        return "gameDetailsList";
    }

    @GetMapping(value = "/gameDetails/showDeleted")
    public String gameDetailsIndexDeleted(Model model,
            @RequestParam(value = "gameId", defaultValue = "none") String gameId,
            @RequestParam(value = "topicId", defaultValue = "none") String topicId) {

        List<GamesDetailDto> gameDetail = new ArrayList<GamesDetailDto>();
        List<TopicsDto> topic = new ArrayList<>();

        if (gameId.equals("none")) {
            gameDetail = service.findByInactive();
            topic = topicService.findAll();
        } else {
            topic = topicService.findByGameId(Integer.parseInt(gameId));
            model.addAttribute("gId", Integer.parseInt(gameId));
            if (topicId.equals("none")) {
                gameDetail = service.findByGameIdInactive(Integer.parseInt(gameId));
            } else {
                model.addAttribute("tId", Integer.parseInt(topicId));
                gameDetail = service.findByGameIdAndTopicIdInactive(Integer.parseInt(gameId),
                        Integer.parseInt(topicId));
            }
        }
        List<GamesDto> games = gameService.findAll();
        model.addAttribute("status", "inactive");
        model.addAttribute("topics", topic);
        model.addAttribute("games", games);
        model.addAttribute("gameDetails", gameDetail);
        return "gameDetailsList";
    }

    @GetMapping(value = "/gameDetails/create")
    public String displayCreate(Model model) {
        List<GamesDto> games = gameService.findAll();
        List<TopicsDto> topic = topicService.findAll();
        List<DifficultiesDto> diff = diffService.findAll();
        model.addAttribute("topics", topic);
        model.addAttribute("games", games);
        model.addAttribute("diff", diff);
        GamesDetailDto gameDetails = new GamesDetailDto();
        model.addAttribute("gameDetails", gameDetails);
        return "gameDetailsCreate";
    }

    @GetMapping(value = "/gameDetails/create/option")
    public String getdata(Model model) {
        List<GamesDto> games = gameService.findAll();
        List<TopicsDto> topic = topicService.findAll();
        List<DifficultiesDto> diff = diffService.findAll();
        model.addAttribute("topics", topic);
        model.addAttribute("games", games);
        model.addAttribute("diff", diff);
        GamesDetailDto gameDetails = new GamesDetailDto();
        model.addAttribute("gameDetails", gameDetails);
        return "option";
    }

    @PostMapping(value = "/gameDetails/doCreate")
    public String createGameDetails(Model model, @ModelAttribute("gameDetails") GamesDetailDto details,
            BindingResult result, @RequestParam("file") MultipartFile file) {

        if (!file.isEmpty()) {
            String fileName = fileStorageService.storeFile(file, null);
            String fileDownloadUri = ServletUriComponentsBuilder.fromCurrentContextPath().path("/downloadFile/")
                    .path(fileName).toUriString();

            details.setImage(fileDownloadUri);
        }
        details.setIsActive(Status.active);
        service.create(details);
        return "redirect:/gameDetails/show";

    }

    @GetMapping(value = "/gameDetails/update/{id}")
    public String displayUpdate(Model model, @PathVariable("id") int id) {
        GamesDetailDto gameDetails = service.findById(id);
        List<TopicsDto> topic = topicService.findAll();
        List<GamesDto> games = gameService.findAll();
        List<DifficultiesDto> diff = diffService.findAll();
        model.addAttribute("topics", topic);
        model.addAttribute("games", games);
        model.addAttribute("diff", diff);
        if (gameDetails != null) {
            model.addAttribute("gameDetails", gameDetails);
        }
        return "gameDetailsUpdate";
    }

    @PostMapping(value = "/gameDetails/doUpdate")
    public String gameDetailsUpdate(Model model, @ModelAttribute("gameDetails") GamesDetailDto gameDetails,
            BindingResult result, @RequestParam("file") MultipartFile file) {

        if (!file.isEmpty()) {
            String fileName = fileStorageService.storeFile(file, null);
            String fileDownloadUri = ServletUriComponentsBuilder.fromCurrentContextPath().path("/downloadFile/")
                    .path(fileName).toUriString();

            gameDetails.setImage(fileDownloadUri);
        }
        service.update(gameDetails);
        return "redirect:/gameDetails/show";
    }

    @GetMapping(value = "/gameDetails/delete/{id}")
    public String gameDetailsDelete(Model model, @PathVariable("id") int id) {
        GamesDetailDto details = service.findById(id);
        details.setIsActive(Status.inactive);
        service.update(details);
        return "redirect:/gameDetails/show";
    }

    @GetMapping(value = "/gameDetails/enable/{id}")
    public String gameDetailsEnable(Model model, @PathVariable("id") int id) {
        GamesDetailDto details = service.findById(id);
        details.setIsActive(Status.active);
        service.update(details);
        return "redirect:/gameDetails/showDeleted";
    }

}