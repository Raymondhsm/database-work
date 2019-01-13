package domain;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DateFormat;
import java.util.Date;

import database.db;

public class logged {
	//type=1返回待审核的日志，type=2返回已审核日志
	public static String[][] getLoggedforCheck(String skey,int type){
		return getLoggedforCheck(skey,type,"");
	}
	
	public static String[][] getLoggedforCheck(String skey,int type,String key){
		//String staffID=Login.getStaffID(skey);
		
		String select="loggedID,taskName,staffName,workload,rateOfProcess,loggedRemark,needTime,writeTime,comment,result";
		String from="logged natural join task natural join staff";
		String where="";
		
		if(type==1)where="result=0";
		else where="result!=0";
		
		if(!key.equals(""))where+=" and taskName REGEXP '"+key+"'";
		
		ResultSet re;
		try {
			re = db.select(select, from, where);//记得做好登录之后要改
			re.last();
			String[][] a=new String[re.getRow()][10];
			re.beforeFirst();
			for(int i=0;re.next();i++) {
				for(int j=0;j<10;j++)
				a[i][j]=re.getString(j+1);
			}
			return a;
		} catch (SQLException e) {
			// TODO 自动生成的 catch 块
			e.printStackTrace();
		}
		return null;
	}
	
	//查询待写日志
	public static String[][] getLoggedforWrite(String skey){
		return getLoggedforWrite(skey,"");
		
	}
	
	//返回搜索的待写日志
	public static String[][] getLoggedforWrite(String skey,String key){
		String staffID=Login.getStaffID(skey);
		
		Date now = new Date(); 
		DateFormat d1 = DateFormat.getDateInstance(); //默认语言（汉语）下的默认风格（MEDIUM风格，比如：2008-6-16 20:54:53）
		String date = d1.format(now);
		
		ResultSet re;
		
		String whereStmt="taskID not in (select taskID from logged where staffID='"+staffID+"' and date(writeTime)='"+date+"') and deptID in (select deptID from staff where staffID='"+staffID+"') and date(endTime)>='"+date+"'";
		if(!key.equals(""))whereStmt+=" and taskName REGEXP '"+key+"'";
		
		re=db.select("distinct task.taskID,taskName","task natural join taskAssign", whereStmt);
		
		try {
			re.last();
			String[][] a;
			a = new String[re.getRow()][2];
			re.beforeFirst();
			for(int i=0;re.next();i++) {
				for(int j=0;j<2;j++)
				a[i][j]=re.getString(j+1);
			}
			return a;
		} catch (SQLException e) {
			// TODO 自动生成的 catch 块
			e.printStackTrace();
		}
		
		return null;
		
	}
	
	
	//返回已填写日志
	public static String[][] getLoggedWriten(String skey){
		return getLoggedWriten(skey,"");
	}
	
	
	//返回已填写的搜索日志
	public static String[][] getLoggedWriten(String skey,String key){
		String staffID=Login.getStaffID(skey);

		ResultSet re;
		String select="distinct loggedID,taskName,workload,rateOfProcess,date(needTime),date(writeTime),loggedRemark,comment,result";
		String whereStmt="staffID='"+staffID+"'";
		if(!key.equals(""))whereStmt+=" and taskName REGEXP '"+key+"'";
		
		re=db.select(select,"logged natural join task", whereStmt);
		
		try {
			re.last();
			String[][] a;
			a = new String[re.getRow()][9];
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
	
	public static String[][] getNeedLogged(String skey){
		Date now = new Date(); 
		DateFormat d1 = DateFormat.getDateInstance(); //默认语言（汉语）下的默认风格（MEDIUM风格，比如：2008-6-16 20:54:53）
		String date = d1.format(now);
		
		ResultSet re;
		
		String whereStmt="(taskID,deptID) not in (select taskID,deptID from logged natural join staff where date(writeTime)='"+date+"') and date(endTime)>='"+date+"' order by taskID";
		
		re=db.select("distinct taskID,taskName,deptID,deptName","task natural join taskAssign natural join department", whereStmt);
		
		try {
			re.last();
			String[][] a;
			a = new String[re.getRow()][4];
			re.beforeFirst();
			for(int i=0;re.next();i++) {
				for(int j=0;j<4;j++)
				a[i][j]=re.getString(j+1);
			}
			return a;
		} catch (SQLException e) {
			// TODO 自动生成的 catch 块
			e.printStackTrace();
		}
		
		return null;
		
	}
	
	public static boolean isNeedLogged(String taskID,String deptID) {
		ResultSet re;
		Date now = new Date(); 
		DateFormat d1 = DateFormat.getDateInstance(); //默认语言（汉语）下的默认风格（MEDIUM风格，比如：2008-6-16 20:54:53）
		String date = d1.format(now);
		
		re=db.select("*", "needLogged", "taskID="+taskID+" and deptWhoseAcceptID="+deptID+" and date(pushTime)='"+date+"'");
		
		try {
			if(re.next())return true;
		} catch (SQLException e) {
			// TODO 自动生成的 catch 块
			e.printStackTrace();
		}
		return false;
	}
	
	public static String[] getMyNeedLogged(String skey){
		ResultSet re;
		Date now = new Date(); 
		DateFormat d1 = DateFormat.getDateInstance(); //默认语言（汉语）下的默认风格（MEDIUM风格，比如：2008-6-16 20:54:53）
		String date = d1.format(now);

		String deptID=Login.getDeptByKey(skey);
		
		re=db.select("taskName", "needLogged natural join task", "date(pushTime)='"+date+"' and deptWhoseAcceptID="+deptID);
		
		try {
			
			re.last();
			String[] a;
			a = new String[re.getRow()];
			re.beforeFirst();
			for(int i=0;re.next();i++) 
				a[i]=re.getString(1);
			return a;
		} catch (SQLException e) {
			// TODO 自动生成的 catch 块
			e.printStackTrace();
		}
		
		return null;
	}
}
