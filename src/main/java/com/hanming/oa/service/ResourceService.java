package com.hanming.oa.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hanming.oa.dao.ResourceMapper;
import com.hanming.oa.model.Resource;

@Service
public class ResourceService {

	@Autowired
	ResourceMapper resourceMapper;
	
	public int deleteByPrimaryKey(Integer id) {
		int i = resourceMapper.deleteByPrimaryKey(id);
		return i;
	}

	public int insert(Resource record) {
		int i = resourceMapper.insert(record);
		return i;
	}

	public int insertSelective(Resource record) {
		int i = resourceMapper.insertSelective(record);
		return i;
	}

	public Resource selectByPrimaryKey(Integer id) {
		Resource resource = resourceMapper.selectByPrimaryKey(id);
		return resource;
	}

	public int updateByPrimaryKeySelective(Resource record) {
		int i = resourceMapper.updateByPrimaryKeySelective(record);
		return i;
	}

	public int updateByPrimaryKey(Resource record) {
		int i = resourceMapper.updateByPrimaryKey(record);
		return i;
	}

	public List<Resource> list() {
		List<Resource> list = resourceMapper.list();
		return list;
	}
	
	public List<Resource> listLikeName(String name) {
		List<Resource> list = resourceMapper.listLikeName(name);
		return list;
	}

	public int selectRoleByResourceId(Integer id) {
		int i = resourceMapper.selectRoleByResourceId(id);
		return i;
	}

}
