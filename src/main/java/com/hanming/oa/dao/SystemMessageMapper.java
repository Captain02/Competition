package com.hanming.oa.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.hanming.oa.model.SystemMessage;
import com.hanming.oa.model.SystemMessageDisplay;

public interface SystemMessageMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(SystemMessage record);

    int insertSelective(SystemMessage record);

    SystemMessage selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(SystemMessage record);

    int updateByPrimaryKey(SystemMessage record);

	List<SystemMessageDisplay> list(@Param("type")String type, @Param("state")String state, @Param("myId")Integer myId);
}