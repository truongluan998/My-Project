package com.khanhpham.smartkidz.controller;

import java.security.Principal;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.websocket.server.PathParam;

import com.khanhpham.smartkidz.Utils.WebUtils;
import com.khanhpham.smartkidz.Utils.EnumU.Role;
import com.khanhpham.smartkidz.dto.GamesDto;
import com.khanhpham.smartkidz.dto.LevelsDto;
import com.khanhpham.smartkidz.dto.ReportDto;
import com.khanhpham.smartkidz.dto.ReportPieDto;
import com.khanhpham.smartkidz.dto.TopicsDto;
import com.khanhpham.smartkidz.dto.UsersDto;
import com.khanhpham.smartkidz.repository.HistoryRepository;
import com.khanhpham.smartkidz.repository.UsersRepository;
import com.khanhpham.smartkidz.service.GamesService;
import com.khanhpham.smartkidz.service.HistoryService;
import com.khanhpham.smartkidz.service.LevelsService;
import com.khanhpham.smartkidz.service.TopicsService;
import com.khanhpham.smartkidz.service.UserService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class HomeController {

    @Autowired
    UsersRepository repo;

    @Autowired
    UserService service;

    @Autowired
    GamesService gameService;

    @Autowired
    TopicsService topicService;

    @Autowired
    LevelsService levelService;

    @Autowired
    HistoryService historyService;

    @Autowired
    HistoryRepository hisRepo;

    @RequestMapping(value = "/login", method = RequestMethod.GET)
    public String loginPage(Model model) {

        return "login";
    }

    @GetMapping("/logoutAdmin")
    public String logoutAdmin(HttpServletRequest request, HttpServletResponse response) {

        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        if (auth != null) {
            new SecurityContextLogoutHandler().logout(request, response, auth);
        }
        return "redirect:/login";
    }

    @GetMapping("/index")
    public String index(Model model, @PathParam("previousDate") Date previousDate) {
        List<UsersDto> users = service.findByAdmin(Role.user.value);
        List<GamesDto> games = gameService.findAll();
        List<TopicsDto> topics = topicService.findAll();
        List<LevelsDto> levels = levelService.findAll();
        model.addAttribute("users", users);
        model.addAttribute("games", games);
        model.addAttribute("topics", topics);
        model.addAttribute("levels", levels);

        Calendar cal = Calendar.getInstance();
        cal.add(Calendar.DATE, -7);
        previousDate = cal.getTime();

        List<Object[]> listUser = repo.userReport(previousDate);
        List<ReportDto> rpu = new ArrayList<>();
        for (Object[] ob : listUser) {
            ReportDto dto = new ReportDto();
            dto.setDateU((Date) ob[0]);
            dto.setAmountU((Long) ob[1]);
            rpu.add(dto);
        }
        model.addAttribute("listU", rpu);

        List<Object[]> listGame = hisRepo.gameReport(previousDate);
        List<ReportPieDto> rpg = new ArrayList<>();
        for (Object[] ob : listGame) {
            ReportPieDto dto = new ReportPieDto();
            dto.setLabel(historyService.getNameGame((Integer) ob[0]));
            dto.setY((Long) ob[1]);
            rpg.add(dto);
        }
        model.addAttribute("listG", rpg);
        return "index";
    }

    @GetMapping("/")
    public String index2() {
        return "redirect:/index";
    }

    @RequestMapping(value = "/403", method = RequestMethod.GET)
    public String accessDenied(Model model, Principal principal) {

        if (principal != null) {
            User loginedUser = (User) ((Authentication) principal).getPrincipal();

            String userInfo = WebUtils.toString(loginedUser);

            model.addAttribute("userInfo", userInfo);

            String message = "Hi " + principal.getName() + "<br> You do not have permission to access this page!";
            model.addAttribute("message", message);

        }

        return "403Page";
    }

}
