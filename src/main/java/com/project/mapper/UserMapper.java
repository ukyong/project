package com.project.mapper;


import java.util.List;

import com.project.model.UserDto;

public interface UserMapper {
	public UserDto select(String id);
	public int insert(UserDto user);
	public int delete(String id);
	public int update(UserDto user);
	public void deleteAll();
	public List<UserDto> seleteAll();
	public int idCheck(String id);
	public UserDto read(String userId);
	public int insertUserAuth(String userId);
}
