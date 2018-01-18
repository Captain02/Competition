package com.hanming.oa.dao;

import org.apache.ibatis.annotations.Param;

public interface DeployeMapper {

	void updataPersonNumberByDeployId(@Param("id") String id, @Param("num") Integer num);

}
