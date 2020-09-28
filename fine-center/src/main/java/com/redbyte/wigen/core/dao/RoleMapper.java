package com.redbyte.wigen.core.dao;

import com.redbyte.wigen.core.domain.entity.Role;

public interface RoleMapper {
    int insert(Role record);

    int insertSelective(Role record);
}