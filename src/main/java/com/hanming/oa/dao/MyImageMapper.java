package com.hanming.oa.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.hanming.oa.model.MyImage;
import com.hanming.oa.model.MyImageDispaly;

public interface MyImageMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(MyImage record);

    int insertSelective(MyImage record);

    MyImage selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(MyImage record);

    int updateByPrimaryKey(MyImage record);

	List<MyImageDispaly> selectList(@Param("isByMy")Integer isByMy);

	void deleByTopicId(@Param("topicId")Integer topicId);
}