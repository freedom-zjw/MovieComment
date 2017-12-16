package com.group.bean;

import java.sql.ResultSet;

public class Commentdb {
	
	private DataBase db;
	
	public Commentdb() {
		db = new DataBase();
	}
	
	public ResultSet queryByMid(String mid, int st, int cnt)throws Exception { 
		String sql = "select "
					+ "comments.cid as cid, "
					+ "comments.mid as mid, "
					+ "comments.uid as uid,"
			     	+ "comments.info as info, "
			     	+ "comments.commentTime as commentTime, "
			     	+ "comments.comment_src as src, "
			     	+ "comments.score as score, "
			     	+ "User.name as name, "
			     	+ "User.account as account, "
			     	+ "User.uid as userid, "
			     	+ "User.Image_src as user_src "
			     	+ "from comments, User  "
			     	+ "where comments.mid=" + mid + " "
			     	+ "and User.uid=comments.uid "
			     	+ "order by commentTime desc "
			     	+ "limit " +  st +", " + cnt;
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
