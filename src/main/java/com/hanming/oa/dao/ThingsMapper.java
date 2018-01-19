package com.hanming.oa.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.hanming.oa.model.Things;
import com.hanming.oa.model.ThingsAndExaminationTime;
import com.hanming.oa.model.UserThingsByThingsId;

public interface ThingsMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(Things record);

    int insertSelective(Things record);

    Things selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Things record);

    int updateByPrimaryKey(Things record);
    
    List<Things> listLikeStateType(@Param("state") String state, @Param("name") String name);

	UserThingsByThingsId selectUserThingsByThingsId(Integer thingsId);

	Things selectThingsByProcessInstanceIdLikeStateName(@Param("processInstanceId")String processInstanceId, @Param("state")String state, @Param("name")String name);

	List<Things> selectListThingsByProcessInstanceId(List<String> listProcessinstanceid);

	List<Things> selectCreatByMeLikeStateName(@Param("userId")Integer userId, @Param("state")String state, @Param("name")String name);

	List<ThingsAndExaminationTime> selectExaminationByMeLikeStateName(@Param("username") String username, @Param("state") String state, @Param("name") String name);

	List<ThingsAndExaminationTime> selectCompleteByMeLikeStateName(@Param("username") String username, @Param("state") String state, @Param("name") String name);

}