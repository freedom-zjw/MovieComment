package com.group.bean;

import java.sql.ResultSet;

public class Userdb {
	
	private DataBase db;
	
	public Userdb() {
		db = new DataBase();
	}
	
	public ResultSet queryById(int uid)throws Exception { 
		db = new DataBase();
		String sql = "select * from User where uid=" +  uid;
		ResultSet rs =db.select(sql);
		return rs;
	}
	
	public ResultSet queryByAccount(String account)throws Exception { 
		db = new DataBase();
		String sql = "select * from User where account='" +  account + "'";
		ResultSet rs =db.select(sql);
		return rs;
	}
	
	public void insert(String sql)throws Exception{
		db = new DataBase();
		db.insert(sql);
	}
	
	public void update(String sql)throws Exception{
		db = new DataBase();
		db.update(sql);
	}
	
	public void close()throws Exception  {
		db.Close();
	}
}
