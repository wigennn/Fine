package com.redbyte.wigen.core.dao;

import com.redbyte.wigen.core.domain.entity.RuleInfoEntity;
import org.springframework.stereotype.Repository;

@Repository
public interface RuleInfoEntityMapper {
    int insert(RuleInfoEntity record);

    int insertSelective(RuleInfoEntity record);
}