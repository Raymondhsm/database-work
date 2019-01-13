package domain;

import java.sql.ResultSet;
import java.sql.SQLException;

import database.db;

public class task {
	public static String[][] getTask(String whereStmt){
		ResultSet re;
		try {
			String select="task.taskID,taskName,createTime,endTime,status,taskRemark,taskLevelName,taskTypeName,taskSourceName";
			String from="task natural join taskType natural join taskLevel natural join taskSource";

			re = db.select(select, from, whereStmt);//记得做好登录之后要改
			re.last();
			String[][] a=new String[re.getRow()][9];
			re.beforeFirst();
			for(int i=0;re.next();i++) {
				for(int j=0;j<9;j++)
				a[i][j]=re.getString(j+1);
			}
			return a;
		} catch (SQLException e) {
			// TODO 自动生成的 catch 块
			e.printStackTrace();
		}
		return null;
	}
	
	
	public static String[][] getPartInTask(String skey){
		String deptID=Login.getDeptByKey(skey);
		
		if(deptID==null)return null;
		
		String whereStmt="task.taskID in (select taskID from taskAssign where deptID='"+deptID+"')";
		
		return getTask(whereStmt);
	}
	
	public static String[][] getLikeTask(String skey){
		String staffID=Login.getStaffID(skey);
		if(staffID==null)return null;
		
		String whereStmt="task.taskID in (select taskID from taskFollow where staffID='"+staffID+"')";
		
		return getTask(whereStmt);
		
	}
	
	public static String[][] getPublishTask(String skey){
		String staffID=Login.getStaffID(skey);
		
		if(staffID==null)return null;
		
		String whereStmt="createStaffID='"+staffID+"'";
		
		return getTask(whereStmt);
	}
	
	public static boolean isFollow(String taskID,String skey){
		String staffID=Login.getStaffID(skey);
		
		if(staffID==null)return false;
		
		ResultSet re;
		String select="*";
		String from="taskFollow";
		String whereStmt="taskID='"+taskID+"' and staffID='"+staffID+"'";

		re = db.select(select, from, whereStmt);//记得做好登录之后要改
		
		try {
			if(re.next())return true;
			else return false;
		} catch (SQLException e) {
			// TODO 自动生成的 catch 块
			e.printStackTrace();
		}
		return false;
	}
	
	public static String[][] getSearchTask(String key){
		return task.getTask("taskName REGEXP '"+key+"'");
	}
	
	public static boolean isTaskAssign(String taskID,String deptID) {
		ResultSet re;
		re=db.select("*", "taskAssign", "taskID="+taskID+" and deptID="+deptID);
		
		try {
			if(re.next())return true;
			else return false;
		} catch (SQLException e) {
			// TODO 自动生成的 catch 块
			e.printStackTrace();
		}
		return false;
	}
	
}
