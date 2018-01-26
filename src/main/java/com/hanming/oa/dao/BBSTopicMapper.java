package com.hanming.oa.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.hanming.oa.model.BBSDetailedTopic;
import com.hanming.oa.model.BBSDisplayTopic;
import com.hanming.oa.model.BBSTopic;
import com.hanming.oa.model.Comments;

public interface BBSTopicMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(BBSTopic record);

    int insertSelective(BBSTopic record);

    BBSTopic selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(BBSTopic record);

    int updateByPrimaryKey(BBSTopic record);

	List<BBSDisplayTopic> selectDisplayTopic(@Param("labelId") Integer labelId,@Param("isByMyId") Integer isByMyId);

	BBSDetailedTopic selectBBSDetailedTopic(Integer i);
	
	List<Comments> getCommentsByTopicId(Integer i);

}