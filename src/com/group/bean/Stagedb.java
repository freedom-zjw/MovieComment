package com.group.bean;

import java.sql.ResultSet;

public class Stagedb {
	private DataBase db;
	
	public  Stagedb() {
		db = new DataBase();
	}
	
	public void close()throws Exception  {
		db.Close();
	}
	
	public ResultSet queryByMid(String mid)throws Exception { 
		String sql = "select * from stagephoto where mid=" +  mid;
		ResultSet rs =db.select(sql);
		return rs;
	}
}
