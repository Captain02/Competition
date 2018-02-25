package com.hanming.oa.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.hanming.oa.model.Versions;

public interface VersionsMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(Versions record);

    int insertSelective(Versions record);

    Versions selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Versions record);

    int updateByPrimaryKeyWithBLOBs(Versions record);

    int updateByPrimaryKey(Versions record);
    
    List<Versions> list(@Param("versionName")String versionName,@Param("projectId")Integer projectId);

    Versions detailedById(Integer id);
}