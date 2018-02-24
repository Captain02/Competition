package com.hanming.oa.dao;

import com.hanming.oa.model.Demand;
import com.hanming.oa.model.DemandWithBLOBs;

public interface DemandMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(DemandWithBLOBs record);

    int insertSelective(DemandWithBLOBs record);

    DemandWithBLOBs selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(DemandWithBLOBs record);

    int updateByPrimaryKeyWithBLOBs(DemandWithBLOBs record);

    int updateByPrimaryKey(Demand record);
}