package com.project.mapper;

import com.project.model.UserDto;

public interface MemberMapper {
	public UserDto read(String userid);
}
