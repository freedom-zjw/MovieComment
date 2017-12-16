package com.group.bean;

import java.sql.ResultSet;

public class Moviedb {
	
	private DataBase db;
	
	public Moviedb() {
		db = new DataBase();
	}
	
	public ResultSet Search(String types, String content, String Chooes, int st, int cnt) throws Exception {
		
		String sql = "select * from movie where ";
		sql += "Type like '%" + types + "%' ";
		sql += "and name like '%" + content + "%' ";
		if (!Chooes.equals("unselect")) {
			if (Chooes.equals("hot")) sql += "order by hot desc, score desc ";
			else if (Chooes.equals("date")) sql += "order by ReleaseTime desc  ";
			else if (Chooes.equals("score")) sql += "order by score desc  ";
		}
		sql += "limit " +  st +", " + cnt;
		System.out.println(sql);
		ResultSet rs =db.select(sql);
		return rs;
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
