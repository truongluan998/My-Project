package com.khanhpham.smartkidz.controller;

import java.util.List;

import javax.validation.Valid;

import com.khanhpham.smartkidz.Utils.EnumU.Role;
import com.khanhpham.smartkidz.Utils.EnumU.Status;
import com.khanhpham.smartkidz.dto.UsersDto;
import com.khanhpham.smartkidz.service.FileStorageService;
import com.khanhpham.smartkidz.service.UserService;

import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.security.core.Authentication;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
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
public class UsersController {

    @Autowired
    private UserService service;

    @Autowired
    BCryptPasswordEncoder passwordencoder;

    @Autowired
    private FileStorageService fileStorageService;

    @GetMapping(value = "/admin")
    public String adminIndex(Model model) {
        List<UsersDto> admins = service.findByAdmin(Role.admin.value);
        model.addAttribute("admins", admins);
        model.addAttribute("status", "active");
        return "adminList";
    }

    @GetMapping(value = "/adminDeleted")
    public String adminIndexInactive(Model model) {
        List<UsersDto> admins = service.findByAdminInactive(Role.admin.value);
        model.addAttribute("admins", admins);
        model.addAttribute("status", "inactive");
        return "adminList";
    }

    @GetMapping(value = "/user")
    public String userIndex(Model model) {
        List<UsersDto> users = service.findByAdmin(Role.user.value);
        model.addAttribute("users", users);
        model.addAttribute("status", "active");
        return "userList";
    }

    @GetMapping(value = "/userDeleted")
    public String userIndexInactive(Model model) {
        List<UsersDto> users = service.findByAdminInactive(Role.user.value);
        model.addAttribute("users", users);
        model.addAttribute("status", "inactive");
        return "userList";
    }

    @GetMapping(value = "/admin/create")
    public String displayCreate(Model model) {
        UsersDto admin = new UsersDto();
        model.addAttribute("admin", admin);
        return "adminCreate";
    }

    @GetMapping(value = "/user/create")
    public String displayUserCreate(Model model) {
        UsersDto user = new UsersDto();
        model.addAttribute("user", user);
        return "userCreate";
    }

    @PostMapping(value = "/admin/doCreate")
    public String create(Model model, @Valid @ModelAttribute("admin") UsersDto admin, BindingResult result,
            @RequestParam("file") MultipartFile file, Errors errors) {
        if (null != errors && errors.getErrorCount() > 0) {
            return "adminCreate";
        } else {
            if (!file.isEmpty()) {
                String fileName = fileStorageService.storeFile(file, admin.getUsername());
                String fileDownloadUri = ServletUriComponentsBuilder.fromCurrentContextPath().path("/downloadFile/")
                        .path(fileName).toUriString();

                admin.setPhoto(fileDownloadUri);
            }
            admin.setIsAdmin(Role.admin);
            admin.setPassword(passwordencoder.encode(admin.getPassword()));
            admin.setIsActive(Status.active);
            if (service.create(admin) != null) {
                return "redirect:/admin";
            } else {
                model.addAttribute("admin", admin);
                model.addAttribute("errorMessage", "Duplicated Username! Create again");
                return "adminCreate";
            }
        }
    }

    @PostMapping(value = "/user/doCreate")
    public String createUser(Model model, @Valid @ModelAttribute("user") UsersDto user, BindingResult result,
            @RequestParam("file") MultipartFile file, Errors errors) {
        if (null != errors && errors.getErrorCount() > 0) {
            return "userCreate";
        } else {
            if (!file.isEmpty()) {
                String fileName = fileStorageService.storeFile(file, user.getUsername());
                String fileDownloadUri = ServletUriComponentsBuilder.fromCurrentContextPath().path("/downloadFile/")
                        .path(fileName).toUriString();

                user.setPhoto(fileDownloadUri);
            }
            user.setIsAdmin(Role.user);
            user.setPassword(passwordencoder.encode(user.getPassword()));
            user.setIsActive(Status.active);
            if (service.create(user) != null) {
                return "redirect:/user";
            } else {
                model.addAttribute("user", user);
                model.addAttribute("errorMessage", "Duplicated Username! Create again");
                return "userCreate";
            }
        }
    }

    @GetMapping(value = "/admin/update/{id}")
    public String displayUpdate(Model model, @PathVariable("id") int id) {
        UsersDto admin = service.findById(id);
        if (admin != null) {
            model.addAttribute("admin", admin);
        }
        return "adminUpdate";
    }

    @PostMapping(value = "/admin/doUpdate")
    public String update(@Valid @ModelAttribute("admin") UsersDto admin, BindingResult result,
            @RequestParam("file") MultipartFile file, Errors errors) {
        if (null != errors && errors.getErrorCount() > 0) {
            return "adminUpdate";
        } else {
            if (!file.isEmpty()) {
                String fileName = fileStorageService.storeFile(file, admin.getUsername());
                String fileDownloadUri = ServletUriComponentsBuilder.fromCurrentContextPath().path("/downloadFile/")
                        .path(fileName).toUriString();

                admin.setPhoto(fileDownloadUri);
            }
            admin.setIsAdmin(Role.admin);
            // user.setPassword(passwordencoder.encode(user.getPassword()));
            service.update(admin);
            return "redirect:/admin";
        }
    }

    @GetMapping(value = "/user/update/{id}")
    public String displayUserUpdate(Model model, @PathVariable("id") int id) {
        UsersDto user = service.findById(id);
        if (user != null) {
            model.addAttribute("user", user);
        }
        return "userUpdate";
    }

    @PostMapping(value = "/user/doUpdate")
    public String updateUser(@Valid @ModelAttribute("user") UsersDto user, BindingResult result,
            @RequestParam("file") MultipartFile file, Errors errors) {
        if (null != errors && errors.getErrorCount() > 0) {
            return "userUpdate";
        } else {
            if (!file.isEmpty()) {
                String fileName = fileStorageService.storeFile(file, user.getUsername());
                String fileDownloadUri = ServletUriComponentsBuilder.fromCurrentContextPath().path("/downloadFile/")
                        .path(fileName).toUriString();

                user.setPhoto(fileDownloadUri);
            }
            user.setIsAdmin(Role.user);
            // user.setPassword(passwordencoder.encode(user.getPassword()));
            service.update(user);
            return "redirect:/user";
        }
    }

    @GetMapping("/profile/update/{username}")
    public String displayUpdateProfile(Model model, @PathVariable(name = "username") String username) {
        UsersDto admin = service.findByProfile(username);

        if (admin != null) {
            model.addAttribute("admin", admin);
            model.addAttribute("username", username);

        }
        return "profile";
    }

    @PostMapping(value = "/profile/doUpdate")
    public String updateProfile(@Valid Model model, @ModelAttribute("admin") UsersDto admin, BindingResult result,
            @RequestParam("file") MultipartFile file, @RequestParam("oldPassword") String oldPassword,
            @RequestParam("newPassword") String newPassword, Errors errors, Authentication authentication) {

        UsersDto users = service.findById(admin.getId());

        if (passwordencoder.matches(oldPassword, users.getPassword())) {
            if (null != errors && errors.getErrorCount() > 0) {
                return "profile";
            } else {
                if (!file.isEmpty()) {
                    String fileName = fileStorageService.storeFile(file, admin.getUsername());
                    String fileDownloadUri = ServletUriComponentsBuilder.fromCurrentContextPath().path("/downloadFile/")
                            .path(fileName).toUriString();

                    admin.setPhoto(fileDownloadUri);
                }
                admin.setPassword(passwordencoder.encode(newPassword));

                admin.setIsAdmin(Role.admin);
                // user.setPassword(passwordencoder.encode(user.getPassword()));
                service.update(admin);
                return "redirect:/admin";
            }
        }
        model.addAttribute("admin", admin);
        model.addAttribute("errorMessage", "Invalid Password ");
        return "profile";
    }

    @GetMapping(value = "/admin/delete/{id}")
    public String adminDelete(Model model, @PathVariable("id") int id) {
        UsersDto admins = service.findById(id);
        admins.setIsActive(Status.inactive);
        service.update(admins);
        return "redirect:/admin";
    }

    @GetMapping(value = "/admin/enable/{id}")
    public String adminEnable(Model model, @PathVariable("id") int id) {
        UsersDto admins = service.findById(id);
        admins.setIsActive(Status.active);
        service.update(admins);
        return "redirect:/adminDeleted";
    }

    @GetMapping(value = "/user/delete/{id}")
    public String userDelete(Model model, @PathVariable("id") int id) {
        UsersDto users = service.findById(id);
        users.setIsActive(Status.inactive);
        service.update(users);
        return "redirect:/user";
    }

    @GetMapping(value = "/user/enable/{id}")
    public String userEnable(Model model, @PathVariable("id") int id) {
        UsersDto users = service.findById(id);
        users.setIsActive(Status.active);
        service.update(users);
        return "redirect:/userDeleted";
    }

    @GetMapping(value = "/admin/reset/{id}")
    public String adminReset(Model model, @PathVariable("id") int id) {
        UsersDto admins = service.findById(id);
        admins.setPassword(passwordencoder.encode("123123"));
        service.update(admins);
        return "redirect:/admin";
    }

    @GetMapping(value = "/user/reset/{id}")
    public String userReset(Model model, @PathVariable("id") int id) {
        UsersDto users = service.findById(id);
        users.setPassword(passwordencoder.encode("123123"));
        service.update(users);
        return "redirect:/user";
    }
}
