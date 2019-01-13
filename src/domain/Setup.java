package domain;

import java.sql.ResultSet;
import java.sql.SQLException;

import database.db;

public class Setup {
	public static String[] getDeptName() {
		ResultSet re;
		try {
			re = db.select("deptName,deptID", "Department", "");
			re.last();
			String[] a=new String[re.getRow()];
			re.beforeFirst();
			for(int i=0;re.next();i++) {
				a[i]=re.getString("deptID")+" "+re.getString("deptName");
			}
			return a;
		} catch (SQLException e) {
			// TODO 自动生成的 catch 块
			e.printStackTrace();
		}
		return null;
	}
	
	public static String[] getDeptManager(){
		ResultSet re;
		try {
			re = db.select("staffName,staffID", "Staff", "staffPost='经理'");
			re.last();
			String[] a=new String[re.getRow()];
			re.beforeFirst();
			for(int i=0;re.next();i++) {
				a[i]=re.getString("staffID")+" "+re.getString("staffName");
			}
			return a;
		} catch (SQLException e) {
			// TODO 自动生成的 catch 块
			e.printStackTrace();
		}
		return null;
	}
	
	public static String[] getWorkday(){
		ResultSet re;
		try {
			re = db.select("workdayName,workdayID", "Workday", "");
			re.last();
			String[] a=new String[re.getRow()];
			re.beforeFirst();
			for(int i=0;re.next();i++) {
				a[i]=re.getString("workdayID")+" "+re.getString("workdayName");
			}
			return a;
		} catch (SQLException e) {
			// TODO 自动生成的 catch 块
			e.printStackTrace();
		}
		return null;
	}
	
	public static String[] getUserLevel(){
		ResultSet re;
		try {
			re = db.select("userLevelName,userLevelID", "userLevel", "");
			re.last();
			String[] a=new String[re.getRow()];
			re.beforeFirst();
			for(int i=0;re.next();i++) {
				a[i]=re.getString("userLevelID")+" "+re.getString("userLevelName");
			}
			return a;
		} catch (SQLException e) {
			// TODO 自动生成的 catch 块
			e.printStackTrace();
		}
		return null;
	}
	
	
	public static String[] getTaskType(){
		ResultSet re;
		try {
			re = db.select("taskTypeName,taskTypeID", "TaskType", "");
			re.last();
			String[] a=new String[re.getRow()];
			re.beforeFirst();
			for(int i=0;re.next();i++) {
				a[i]=re.getString("taskTypeID")+" "+re.getString("taskTypeName");
			}
			return a;
		} catch (SQLException e) {
			// TODO 自动生成的 catch 块
			e.printStackTrace();
		}
		return null;
	}
	
	public static String[] getTaskSource(){
		ResultSet re;
		try {
			re = db.select("TaskSourceName,taskSourceID", "TaskSource", "");
			re.last();
			String[] a=new String[re.getRow()];
			re.beforeFirst();
			for(int i=0;re.next();i++) {
				a[i]=re.getString("taskSourceID")+" "+re.getString("TaskSourceName");
			}
			return a;
		} catch (SQLException e) {
			// TODO 自动生成的 catch 块
			e.printStackTrace();
		}
		return null;
	}
	
	public static String[] getTaskLevel(){
		ResultSet re;
		try {
			re = db.select("taskLevelName,taskLevelID", "TaskLevel", "");
			re.last();
			String[] a=new String[re.getRow()];
			re.beforeFirst();
			for(int i=0;re.next();i++) {
				a[i]=re.getString("taskLevelID")+" "+re.getString("taskLevelName");
			}
			return a;
		} catch (SQLException e) {
			// TODO 自动生成的 catch 块
			e.printStackTrace();
		}
		return null;
	}
}
