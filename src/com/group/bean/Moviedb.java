package com.group.bean;

import java.sql.ResultSet;

public class Moviedb {
	
	private DataBase db;
	
	public Moviedb() {
		db = new DataBase();
	}
	
	public ResultSet getDisplay() throws Exception {
		String sql = "select * from movie order by ReleaseTime desc limit 0,4";
		ResultSet rs =db.select(sql);
		return rs;
	}
	
	public ResultSet getFeatured() throws Exception {
		String sql = "select * from movie order by hot desc, ReleaseTime desc limit 0,4";
		ResultSet rs =db.select(sql);
		return rs;
	}
	
	public ResultSet queryById(int mid) throws Exception {
		String sql = "select * from movie where mid=" + mid;
		ResultSet rs =db.select(sql);
		return rs;
	}
	
	public int getNumOfMovie() throws Exception {
		String sql = "select count(*) from movie";
		ResultSet rs =db.select(sql);
		int cnt = 0;
		if (rs.next()) {
			cnt = rs.getInt(1);
		}
		rs.close();
		close();
		return cnt;
	}
	
	public ResultSet getAll() throws Exception {
		String sql = "select * from movie order by mid";
		ResultSet rs =db.select(sql);
		return rs;
	}
	
	public void close()throws Exception  {
		db.Close();
	}
	
}