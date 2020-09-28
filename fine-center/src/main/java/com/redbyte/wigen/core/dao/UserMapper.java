package com.redbyte.wigen.core.dao;

import com.redbyte.wigen.core.domain.entity.User;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface UserMapper {

    int verifyUser(User user);

    void registerUser(User user);

    @Insert("select count(1) from user where user_name=#{userName} or phone=#{userName}")
    int isDuplicateUserName(@Param("userName") String userName);
}