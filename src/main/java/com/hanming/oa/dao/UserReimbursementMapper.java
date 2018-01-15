package com.hanming.oa.dao;

import com.hanming.oa.model.UserReimbursement;

public interface UserReimbursementMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(UserReimbursement record);

    int insertSelective(UserReimbursement record);

    UserReimbursement selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(UserReimbursement record);

    int updateByPrimaryKey(UserReimbursement record);
}