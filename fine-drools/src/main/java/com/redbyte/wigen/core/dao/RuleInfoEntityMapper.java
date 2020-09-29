package com.redbyte.wigen.core.dao;

import com.redbyte.wigen.core.domain.entity.RuleInfoEntity;

public interface RuleInfoEntityMapper {
    int insert(RuleInfoEntity record);

    int insertSelective(RuleInfoEntity record);
}