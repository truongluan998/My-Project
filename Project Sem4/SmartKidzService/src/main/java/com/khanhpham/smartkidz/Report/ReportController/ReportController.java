package com.khanhpham.smartkidz.Report.ReportController;

import java.util.ArrayList;
import java.util.List;

import com.khanhpham.smartkidz.Report.BuildExcel.ExcelReportAdmin;
import com.khanhpham.smartkidz.Report.BuildExcel.ExcelReportDifficulty;
import com.khanhpham.smartkidz.Report.BuildExcel.ExcelReportGame;
import com.khanhpham.smartkidz.Report.BuildExcel.ExcelReportGameDetail;
import com.khanhpham.smartkidz.Report.BuildExcel.ExcelReportIcon;
import com.khanhpham.smartkidz.Report.BuildExcel.ExcelReportTopic;
import com.khanhpham.smartkidz.Report.BuildExcel.ExcelReportUser;
import com.khanhpham.smartkidz.Report.BuildExcel.ExcelRepotLevel;
import com.khanhpham.smartkidz.Utils.EnumU.Role;
import com.khanhpham.smartkidz.dto.DifficultiesDto;
import com.khanhpham.smartkidz.dto.GamesDetailDto;
import com.khanhpham.smartkidz.dto.GamesDto;
import com.khanhpham.smartkidz.dto.IconDto;
import com.khanhpham.smartkidz.dto.LevelsDto;
import com.khanhpham.smartkidz.dto.TopicsDto;
import com.khanhpham.smartkidz.dto.UsersDto;
import com.khanhpham.smartkidz.service.DifficultiesService;
import com.khanhpham.smartkidz.service.GameDetailsService;
import com.khanhpham.smartkidz.service.GamesService;
import com.khanhpham.smartkidz.service.IconService;
import com.khanhpham.smartkidz.service.LevelsService;
import com.khanhpham.smartkidz.service.TopicsService;
import com.khanhpham.smartkidz.service.UserService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class ReportController {

    @Autowired
    LevelsService lvService;

    @Autowired
    TopicsService tpService;

    @Autowired
    DifficultiesService diffService;

    @Autowired
    GamesService gameService;

    @Autowired
    GameDetailsService gameDetailsService;

    @Autowired
    UserService userService;

    @Autowired
    IconService iconService;

    @GetMapping(value = "/report/level")
    public ModelAndView getExcelLv() {
        List<LevelsDto> lvList = new ArrayList<>();
        lvList = lvService.findAll();
        return new ModelAndView(new ExcelRepotLevel(), "lvList", lvList);
    }

    @GetMapping(value = "/report/topic")
    public ModelAndView getExcelTopic() {
        List<TopicsDto> topicList = new ArrayList<>();
        topicList = tpService.findAll();
        return new ModelAndView(new ExcelReportTopic(), "topicList", topicList);
    }

    @GetMapping(value = "/report/diff")
    public ModelAndView getExcelDiff() {
        List<DifficultiesDto> diffList = new ArrayList<>();
        diffList = diffService.findAll();
        return new ModelAndView(new ExcelReportDifficulty(), "diffList", diffList);
    }

    @GetMapping(value = "/report/game")
    public ModelAndView getExcelGame() {
        List<GamesDto> gameList = new ArrayList<>();
        gameList = gameService.findAll();
        return new ModelAndView(new ExcelReportGame(), "gameList", gameList);
    }

    @GetMapping(value = "/report/gameDetails")
    public ModelAndView getExcelGameDetais() {
        List<GamesDetailDto> gameDetailsList = new ArrayList<>();
        gameDetailsList = gameDetailsService.findAll();
        return new ModelAndView(new ExcelReportGameDetail(), "gameDetailsList", gameDetailsList);
    }

    @GetMapping(value = "/report/users")
    public ModelAndView getExcelUsers() {
        List<UsersDto> userList = new ArrayList<>();
        userList = userService.findByAdmin(Role.user.value);
        return new ModelAndView(new ExcelReportUser(), "userList", userList);
    }

    @GetMapping(value = "/report/admins")
    public ModelAndView getExcelAdmin() {
        List<UsersDto> adminList = new ArrayList<>();
        adminList = userService.findByAdmin(Role.admin.value);
        return new ModelAndView(new ExcelReportAdmin(), "adminList", adminList);
    }

    @GetMapping(value = "/report/icon")
    public ModelAndView getExcelIcon() {
        List<IconDto> iconList = new ArrayList<>();
        iconList = iconService.findAll();
        return new ModelAndView(new ExcelReportIcon(), "iconList", iconList);
    }

}
