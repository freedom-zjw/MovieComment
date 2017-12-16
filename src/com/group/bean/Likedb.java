package com.group.bean;

import java.sql.ResultSet;

public class Likedb {

	private DataBase db;
	
	public  Likedb() {
		db = new DataBase();
	}
	
	public void close()throws Exception  {
		db.Close();
	}
	
	public ResultSet getUserInfoLike(String uid, int st, int cnt)throws Exception { 
		String sql = "select "
					 + "likes.lid as lid, "
				     + "movie.info as info, "
				     + "movie.src as image_src, "
				     + "movie.name as name, "
				     + "likes.mid as mid "
					 + "from likes, movie  "
					 + "where likes.uid=" + uid + " "
					 + "and movie.mid=likes.mid "
					 + "order by lid desc "
					 + "limit " +  st +", " + cnt;
					 
		ResultSet rs =db.select(sql);
		return rs;
	}
	
}
