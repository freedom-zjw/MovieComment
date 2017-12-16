package com.group.bean;

import java.sql.ResultSet;

public class Commentdb {
	
	private DataBase db;
	
	public Commentdb() {
		db = new DataBase();
	}
	
	public ResultSet queryByMid(String mid)throws Exception { 
		String sql = "select * from comments where mid=" +  mid + "order by commentTime desc";
		ResultSet rs =db.select(sql);
		return rs;
	}
	
	public String getComNumsByMid(int mid)throws Exception { 
		String sql = "select count(*) from comments where mid=" +  mid;
		ResultSet rs =db.select(sql);
		int cnt = 0;
		if (rs.next()) {
			cnt = rs.getInt(1);
		}
		rs.close();
		close();
		return String.valueOf(cnt);
	}
	
	public ResultSet getUserInfoComment(String uid, int st, int cnt)throws Exception { 
		String sql = "select "
				     + "comments.info as info, "
				     + "comments.commentTime as commentTime, "
				     + "comments.src as image_src, "
				     + "comments.mid as mid, "
				     + "movie.name as name "
					 + "from comments, movie  "
					 + "where comments.uid=" + uid + " "
					 + "and movie.mid=comments.mid "
					 + "order by commentTime desc "
					 + "limit " +  st +", " + cnt;
					 
		ResultSet rs =db.select(sql);
		return rs;
	}
	
	public void close()throws Exception  {
		db.Close();
	}

}
