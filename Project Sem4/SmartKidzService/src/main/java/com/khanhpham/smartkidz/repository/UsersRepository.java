package com.khanhpham.smartkidz.repository;

import java.util.Date;
import java.util.List;

import com.khanhpham.smartkidz.entity.Users;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface UsersRepository extends JpaRepository<Users, Integer> {

    @Query("Select u from Users u where u.username=:username")
    Users findByProfile(@Param("username") String username);

    Users findByUsername(@Param("username") String username);

    @Query(value = "Select * from users u where u.is_admin = :isAdmin and u.is_active= true", nativeQuery = true)
    List<Users> findByIsAdmin(@Param("isAdmin") boolean isAdmin);

    @Query(value = "Select * from users u where u.is_admin = :isAdmin and u.is_active= false", nativeQuery = true)
    List<Users> findByIsAdminInactive(@Param("isAdmin") boolean isAdmin);

    @Query("Select cast(u.createdAt as date) as DateU, Count(u.id) as AmountU From Users u where  u.createdAt > :fromdate group by cast(u.createdAt as date)")
    List<Object[]> userReport(@Param("fromdate") Date previousDate);

}
