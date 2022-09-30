package com.project.service;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.project.mapper.UserMapper;
import com.project.model.UserDto;

@Service
public class UserService {
	
	@Autowired
	UserMapper mapper;
	
	public int idCheck(String userId) {
		
		return mapper.idCheck(userId);
	}
	public UserDto getUser(String id) {
		return mapper.select(id);
	}
	@Transactional
	public int insertUser(UserDto dto){
		mapper.insert(dto);
		return mapper.insertUserAuth(dto.getUserId());
		
	}
	public int updateUser(UserDto dto) {
		return mapper.update(dto);
	}

	public List<UserDto> getUserList(){
		return mapper.seleteAll();
	}

	
}