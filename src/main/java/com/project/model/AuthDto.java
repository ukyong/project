package com.project.model;

public class AuthDto {
	private String userId;
	private String auth;
	
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getAuth() {
		return auth;
	}
	public void setAuth(String auth) {
		this.auth = auth;
	}
	@Override
	public String toString() {
		return "AuthDto [userId=" + userId + ", auth=" + auth + "]";
	}
	
	
}
