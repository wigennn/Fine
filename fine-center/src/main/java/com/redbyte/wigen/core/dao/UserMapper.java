package com.redbyte.wigen.core.dao;

import com.redbyte.wigen.core.domain.entity.User;

public interface UserMapper {
    int insert(User record);

    int insertSelective(User record);
}