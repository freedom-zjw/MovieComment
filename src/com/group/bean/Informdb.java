package com.group.bean;

import java.sql.ResultSet;

public class Informdb {
	
	private DataBase db;
	
	public  Informdb() {
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
}
