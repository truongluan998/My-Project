package com.khanhpham.smartkidz.service;

import java.util.ArrayList;
import java.util.List;

import com.khanhpham.smartkidz.entity.Users;
import com.khanhpham.smartkidz.repository.UsersRepository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

@Service
public class UserDetailsServiceImpl implements UserDetailsService {

    @Autowired
    private UsersRepository repo;

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        Users user = this.repo.findByUsername(username);

        if (user == null) {
            System.out.println(username + " not found!");
            throw new UsernameNotFoundException("User " + username + " not found!");
        }
        System.out.println("Found user");

        List<GrantedAuthority> grantList = new ArrayList<GrantedAuthority>();
        if (user.getIsAdmin()) {
            grantList.add(new SimpleGrantedAuthority("ROLE_ADMIN"));
        } else
            grantList.add(new SimpleGrantedAuthority("ROLE_USER"));

        UserDetails userDetails = (UserDetails) new User(user.getUsername(), user.getPassword(), grantList);

        return userDetails;
    }

}
