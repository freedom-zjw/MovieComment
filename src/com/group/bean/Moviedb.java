package com.group.bean;

import java.sql.ResultSet;

public class Moviedb {
	
	public ResultSet getDisplay() throws Exception {
		DataBase db = new DataBase();
		String sql = "select * from movie order by ReleaseTime desc limit 0,4";
		ResultSet rs =db.select(sql);
		return rs;
	}
	
	public ResultSet getFeatured() throws Exception {
		DataBase db = new DataBase();
		String sql = "select * from movie order by hot desc, ReleaseTime desc limit 0,4";
		ResultSet rs =db.select(sql);
		return rs;
	}
	
	public ResultSet queryById(int mid) throws Exception {
		DataBase db = new DataBase();
		String sql = "select * from movie where mid=" + mid;
		ResultSet rs =db.select(sql);
		return rs;
	}
}
