package com.hanming.oa.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

public interface DeployeMapper {

	void updataPersonNumberByDeployId(@Param("id") String id, @Param("num") Integer num);

	List<String> selectProcessKey();

	Integer selectNumByProcessDefinitionKey(String key);


}
