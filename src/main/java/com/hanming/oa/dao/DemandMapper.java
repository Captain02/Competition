package com.hanming.oa.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.hanming.oa.model.Demand;
import com.hanming.oa.model.DemandDetailed;
import com.hanming.oa.model.DemandDisplay;

public interface DemandMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(Demand record);

    int insertSelective(Demand record);

    Demand selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Demand record);

    int updateByPrimaryKey(Demand record);
    
    List<DemandDisplay> list(@Param("state")String state, @Param("demandName")String demandName, @Param("projectId")Integer projectId);

	DemandDetailed detaileById(Integer demandId);
}