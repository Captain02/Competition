package com.hanming.oa.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.hanming.oa.model.Reimbursement;
import com.hanming.oa.model.ReimbursementAndExaminationTime;
import com.hanming.oa.model.UserReimbursementByReimbursementId;

public interface ReimbursementMapper {
	int deleteByPrimaryKey(Integer id);

	int insert(Reimbursement record);

	int insertSelective(Reimbursement record);

	Reimbursement selectByPrimaryKey(Integer id);

	int updateByPrimaryKeySelective(Reimbursement record);

	int updateByPrimaryKey(Reimbursement record);

	List<Reimbursement> listLikeStateType(@Param("state") String state, @Param("type") String type);

	List<Map<String, Float>> dataAnalysisByMonth(String date);

	Reimbursement selectReimbursementByProcessInstanceIdLikeStateType(@Param("processInstanceId") String processInstanceId, @Param("state") String state,@Param("type") String type);

	UserReimbursementByReimbursementId selectReimbursementByReimbursementId(@Param("reimbursementId") Integer reimbursementId);

	List<Reimbursement> selectCreatByMeLikeStateType(@Param("userId") Integer userId, @Param("state") String state, @Param("type") String type);

	List<ReimbursementAndExaminationTime> selectExaminationByMeLikeStateType(@Param("username") String username, @Param("state") String state, @Param("type") String type);

	List<ReimbursementAndExaminationTime> selectCompleteByMeLikeStateType(@Param("username") String username, @Param("state") String state, @Param("type") String type);

	List<Reimbursement> selectListReimbursementByProcessInstanceId(List<String> listProcessinstanceid);

	void deleteReimbursementServiceByProcessInstanceId(List<String> processInstanceId);
}