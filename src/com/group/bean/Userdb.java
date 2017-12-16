package com.group.bean;

import java.sql.ResultSet;

public class Userdb {
	
	private DataBase db;
	
	public Userdb() {
		db = new DataBase();
	}
	
	public ResultSet queryById(int uid)throws Exception { 
		String sql = "select * from User where uid=" +  uid;
		ResultSet rs =db.select(sql);
		return rs;
	}
	
	public ResultSet queryByAccount(String account)throws Exception { 
		String sql = "select * from User where account='" +  account + "'";
		ResultSet rs =db.select(sql);
		return rs;
	}
	
	public void insert(String sql)throws Exception{
		db.insert(sql);
	}
	
	public void update(String sql)throws Exception{
		db.update(sql);
	}
	
	public void close()throws Exception  {
		db.Close();
	}
}
