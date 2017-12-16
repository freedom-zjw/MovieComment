package com.group.bean;

import java.sql.ResultSet;

public class Informdb {
	
	private DataBase db;
	
	public Informdb() {
		db = new DataBase();
	}
	
	public void close()throws Exception  {
		db.Close();
	}
	
	public ResultSet queryByUid(String uid, int st, int cnt)throws Exception { 
		String sql = "select * from information where uid=" +  uid + " order by inforTime desc limit "
				     + st + ", " + cnt;
		ResultSet rs =db.select(sql);
		return rs;
	}
	
	public void insertDelete(String cid, String uid, String title, String info)throws Exception  {
		String sql0 = "select comments.commentTime as commentTime, "
				      + "comments.info as info, "
				      + "movie.Type as Type,"
				      + "movie.name as name "
				      + "from comments, movie "
				      + "where comments.cid=" + cid + " "
				      + "and movie.mid=comments.mid";
		ResultSet rs = db.select(sql0);
		if (rs.next()) {
			info = "您于 " + rs.getString("commentTime") + " 对 " + rs.getString("Type")
			       + " <<" + rs.getString("name") + ">> 的评论内容: \"" + rs.getString("info") 
			       + "\" " + info;
			rs.close();
			close();
		}
		String sql = "insert into information(uid, info, inforTime, title)values( "
				    + uid + ", "
				    + "'" + info +"', "
				    + "NOW(), "
				    + "'" + title +"') ";
		db.insert(sql);		
	}
	

	public void insertReportUser(String cid, String uid, String title, String info)throws Exception  {
		String sql0 = "select comments.commentTime as commentTime, "
				      + "comments.info as info, "
				      + "movie.Type as Type,"
				      + "movie.name as name "
				      + "from comments, movie "
				      + "where comments.cid=" + cid + " "
				      + "and movie.mid=comments.mid";
		ResultSet rs = db.select(sql0);
		if (rs.next()) {
			info = "您于 " + rs.getString("commentTime") + " 对 " + rs.getString("Type")
			       + " <<" + rs.getString("name") + ">> 的评论内容: \"" + rs.getString("info") 
			       + "\" " + info;
			rs.close();
			close();
		}
		String sql = "insert into information(uid, info, inforTime, title)values( "
				    + uid + ", "
				    + "'" + info +"', "
				    + "NOW(), "
				    + "'" + title +"') ";
		db.insert(sql);		
	}
	

	public void insertInformAdmin(String cid, String uid, String title, String info)throws Exception  {
		String sql0 = "select comments.commentTime as commentTime, "
				      + "comments.info as info, "
				      + "User.account as account, "
				      + "User.name as name, "
				      + "movie.Type as Type, "
				      + "movie.name as name "
				      + "from comments, movie, User "
				      + "where comments.cid=" + cid + " "
				      + "and movie.mid=comments.mid "
				      + "and User.uid=comments.uid";
		ResultSet rs = db.select(sql0);
		if (rs.next()) {
			info = "用户 " + rs.getString("account") + ": " + rs.getString("name") + " 于 "  
				   + rs.getString("commentTime") + " 对 " + rs.getString("Type")
			       + " <<" + rs.getString("name") + ">> 的评论内容: \"" + rs.getString("info") 
			       + "\" " + info + " cid是 " + cid;
			rs.close();
			close();
		}
		String sql = "insert into information(uid, info, inforTime, title)values( "
				    + uid + ", "
				    + "'" + info +"', "
				    + "NOW(), "
				    + "'" + title +"') ";
		db.insert(sql);		
	}
}
