package com.group.bean;

import java.sql.ResultSet;

public class Commentdb {
	
	private DataBase db;
	
	public Commentdb() {
		db = new DataBase();
	}
	
	public ResultSet queryByMid(int mid)throws Exception { 
		db = new DataBase();
		String sql = "select * from comments where mid=" +  mid;
		ResultSet rs =db.select(sql);
		return rs;
	}
	
	public String getComNumsByMid(int mid)throws Exception { 
		db = new DataBase();
		String sql = "select count(*) from comments where mid=" +  mid;
		ResultSet rs =db.select(sql);
		int cnt = 0;
		if (rs.next()) {
			cnt = rs.getInt(1);
		}
		return String.valueOf(cnt);
	}
	
	public void close()throws Exception  {
		db.Close();
	}

}
