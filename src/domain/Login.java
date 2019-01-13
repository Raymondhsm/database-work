package domain;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.UUID;

import database.db;

public class Login {
	
	static int seq=0;
	static final int max=99999;

	public static String checkAccount(String account,String password) {
		ResultSet re=db.select("password", "LoginInfo", "account='"+account+"'");
		try {
			if(re.next()) {
				if(re.getString("password").equals(password)) {
				String skey=getSkey();
				SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				db.update("loginInfo", "skey='"+skey+"',skeyTime='"+ df.format(new Date()) +"'","account='"+account+"' and password='"+password+"'");
				return skey;
			}
			}else return "账号错误";
		} catch (SQLException e) {
			// TODO 自动生成的 catch 块
			e.printStackTrace();
		}
		return "密码错误";
	}
	
	public static boolean isAvaiableAccount(String account) {
		ResultSet re=db.select("password", "LoginInfo", "account='"+account+"'");
		try {
			if(!re.next())return true;
			else return false;
		} catch (SQLException e) {
			// TODO 自动生成的 catch 块
			e.printStackTrace();
		}
		return false;
	}
		
	public static String getSkey(){ 
		return UUID.randomUUID().toString().replace("-", ""); 
	} 
	
	public static String getStaffID(String skey) {
		ResultSet re=db.select("staffID,skeyTime", "LoginInfo", "skey='"+skey+"'");
		if(re==null)return null;
		try {
			re.next();
			Date dt1=re.getTimestamp("skeyTime");
			Date dt2=new Date();
			if(dt1.getTime()-dt2.getTime()>7200) return null;
			else return re.getString("staffID");
			
		} catch (SQLException e) {
			// TODO 自动生成的 catch 块
			e.printStackTrace();
		}
		return null;
	}
	
	public static String getStaffName(String skey) {
		String sID=getStaffID(skey);
		if(sID==null)return null;
		
		ResultSet re=db.select("staffName", "staff", "staffID='"+sID+"'");
		if(re==null)return null;
		try {
			re.next();
			return re.getString("staffName");
			
			
		} catch (SQLException e) {
			// TODO 自动生成的 catch 块
			e.printStackTrace();
		}
		return null;
	}
	
	public static String getDeptByStaffID(String staffID) {
		ResultSet re=db.select("deptID", "staff", "staffID='"+staffID+"'");
		if(re==null)return null;
		try {
			re.next();
			return re.getString("deptID");
			
		} catch (SQLException e) {
			// TODO 自动生成的 catch 块
			e.printStackTrace();
		}
		return null;
	}
	
	public static String getDeptByKey(String skey) {
		String staffID=getStaffID(skey);
		return getDeptByStaffID(staffID);
	}
	
	public static boolean isLoggedCheck(String skey) {
		String staffID=getStaffID(skey);
		ResultSet re=db.select("rizhishenhe", "staff natural join userLevel", "staffID='"+staffID+"'");
		
		try {
			if(re.next()) 
				return re.getBoolean(1);
		} catch (SQLException e) {
			// TODO 自动生成的 catch 块
			e.printStackTrace();
		}
		
		return false;
	}
	
	public static boolean isSetup(String skey) {
		String staffID=Login.getStaffID(skey);
		
		ResultSet re=db.select("jichushezhi", "staff natural join userLevel", "staffID="+staffID);
		
		try {
			if(re.next()) {
				return re.getBoolean(1);
			}
		} catch (SQLException e) {
			// TODO 自动生成的 catch 块
			e.printStackTrace();
		}
		return false;
	}
	
	public static boolean isCreateTask(String skey) {
		String staffID=Login.getStaffID(skey);
		
		ResultSet re=db.select("renwuchuangjian", "staff natural join userLevel", "staffID="+staffID);
		
		try {
			if(re.next()) {
				return re.getBoolean(1);
			}
		} catch (SQLException e) {
			// TODO 自动生成的 catch 块
			e.printStackTrace();
		}
		return false;
	}
	
}
