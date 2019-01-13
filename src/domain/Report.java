package domain;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;

import database.db;

public class Report {
	
	public static int[][] getPersonReport(String sDate,String eDate){		
		int e[][]=new int[4][];
		e[0]=getPersonLoggedNumber(sDate,eDate);
		e[1]=getPersonTaskNumber(sDate,eDate);
		e[2]=getPersonNLoggedNumber(sDate,eDate);
		e[3]=getPersonLoggedTotal(sDate,eDate);
		return e;
	}
	
	public static int[][] getDeptReport(String sDate,String eDate){		
		int e[][]=new int[4][];
		e[0]=getDeptLoggedNumber(sDate,eDate);
		e[1]=getDeptTaskNumber(sDate,eDate);
		e[2]=getDeptNLoggedNumber(sDate,eDate);
		e[3]=getDeptLoggedTotal(sDate,eDate);
		return e;
	}
	
	public static String[] getStaffName() {
		ResultSet re=db.select("staffName", "staff order by staffID", "");
		String a[]=null;
		if(re==null)return null;
		try {
			re.last();
			a=new String[re.getRow()];
			re.beforeFirst();
			for(int i=0;re.next();i++)
				a[i]=re.getString("staffName");
			
		} catch (SQLException e) {
			// TODO 自动生成的 catch 块
			e.printStackTrace();
		}
		return a;
	}
	
	public static String[] getDeptName() {
		ResultSet re=db.select("deptName", "department order by deptID", "");
		String a[]=null;
		if(re==null)return null;
		try {
			re.last();
			a=new String[re.getRow()];
			re.beforeFirst();
			for(int i=0;re.next();i++)
				a[i]=re.getString("deptName");
			
		} catch (SQLException e) {
			// TODO 自动生成的 catch 块
			e.printStackTrace();
		}
		return a;
	}
	
	public static int[] getPersonLoggedNumber(String sDate,String eDate) {
		int a[];
		ResultSet re = db.select("a.staffID,count(loggedID)", "staff a left join (select * from Logged where date(writeTime)>='"+sDate+"' and date(writeTime)<='"+eDate+"') b on a.staffID=b.staffID group by staffID;","");

		try {
			re.last();
			a=new int[re.getRow()];
			re.beforeFirst();
			for(int i=0;re.next();i++) {
				a[i]=re.getInt(2);
			}
			return a;
		} catch (SQLException e) {
			// TODO 自动生成的 catch 块
			e.printStackTrace();
		}
		return null;
	}
	
	public static int[] getDeptLoggedNumber(String sDate,String eDate) {
		int a[];
		ResultSet re = db.select("c.deptID,count(loggedID)", "department c left join staff a on c.deptID=a.deptID left join (select * from Logged where date(writeTime)>='"+sDate+"' and date(writeTime)<='"+eDate+"') b  on a.staffID=b.staffID group by deptID;","");

		try {
			re.last();
			a=new int[re.getRow()];
			re.beforeFirst();
			for(int i=0;re.next();i++) {
				a[i]=re.getInt(2);
			}
			return a;
		} catch (SQLException e) {
			// TODO 自动生成的 catch 块
			e.printStackTrace();
		}
		return null;
	}
	
	public static int[] getDeptTaskNumber(String sDate,String eDate) {
		int a[];
		ResultSet re = db.select("a.deptID,count(b.taskID)", "department a left join taskAssign b on a.deptID=b.deptID left join (select * from task where date(createTime)<='"+eDate+"' and date(endTime)>='"+sDate+"') c on b.taskID=c.taskID group by deptID","");

		try {
			re.last();
			a=new int[re.getRow()];
			re.beforeFirst();
			for(int i=0;re.next();i++) {
				a[i]=re.getInt(2);
			}
			return a;
		} catch (SQLException e) {
			// TODO 自动生成的 catch 块
			e.printStackTrace();
		}
		return null;
	}
	
	public static int[] getPersonTaskNumber(String sDate,String eDate) {
		int a[];
		ResultSet re = db.select("staffID,count(b.taskID)", "staff a left join taskAssign b on a.deptID=b.deptID left join (select * from task where date(createTime)<='"+eDate+"' and date(endTime)>='"+sDate+"') c on b.taskID=c.taskID group by staffID","");

		try {
			re.last();
			a=new int[re.getRow()];
			re.beforeFirst();
			for(int i=0;re.next();i++) {
				a[i]=re.getInt(2);
			}
			return a;
		} catch (SQLException e) {
			// TODO 自动生成的 catch 块
			e.printStackTrace();
		}
		return null;
	}
	
	public static int[] getDeptNLoggedNumber(String sDate,String eDate) {
		int a[];
		ResultSet re = db.select("a.deptID,count(needLoggedID)", "department a left join (select * from NeedLogged where date(pushTime)>='"+sDate+"' and date(pushTime)<='"+eDate+"') b on a.deptID=b.deptWhoseAcceptID group by deptID","");

		try {
			re.last();
			a=new int[re.getRow()];
			re.beforeFirst();
			for(int i=0;re.next();i++) {
				a[i]=re.getInt(2);
			}
			return a;
		} catch (SQLException e) {
			// TODO 自动生成的 catch 块
			e.printStackTrace();
		}
		return null;
	}
	
	public static int[] getPersonNLoggedNumber(String sDate,String eDate) {
		int a[];
		ResultSet re = db.select("staffID,count(needLoggedID)", "staff a left join (select * from NeedLogged where date(pushTime)>='"+sDate+"' and date(pushTime)<='"+eDate+"') b on a.deptID=b.deptWhoseAcceptID group by staffID","");

		try {
			re.last();
			a=new int[re.getRow()];
			re.beforeFirst();
			for(int i=0;re.next();i++) {
				a[i]=re.getInt(2);
			}
			return a;
		} catch (SQLException e) {
			// TODO 自动生成的 catch 块
			e.printStackTrace();
		}
		return null;
	}
	
	public static int[] getPersonLoggedTotal(String sDate,String eDate) {
		ResultSet resid=db.select("staffID", "staff order by staffID", "");
		Date sdate;
		Date edate;
		String staffID="";
		ResultSet retask;
		int a[]=null;
		
		try {
			sdate = new SimpleDateFormat("yyyy-MM-dd").parse(sDate);
			edate = new SimpleDateFormat("yyyy-MM-dd").parse(eDate); 

			resid.last();
			a=new int[resid.getRow()];
			resid.beforeFirst();
			for(int i=0;resid.next();i++) {
				staffID=resid.getString(1);
				retask=db.select("createTime,endTime", "task natural join taskAssign natural join staff", "staffID="+staffID);
				int count=0;
				
				for(int j=0;retask.next();j++) {
					Date cdate=retask.getDate("createTime");
					Date ldate=retask.getDate("endTime");
					
					Date smallDate=cdate.after(sdate)?cdate:sdate;
					Date bigDate=ldate.after(edate)?edate:ldate;
					
					int day = (int) ((bigDate.getTime() - smallDate.getTime()) / (1000 * 60 * 60 * 24)); 
					
					if(day>=0)count+=day;
				}
				a[i]=count;
			}
		} catch (Exception e) {
			// TODO 自动生成的 catch 块
			e.printStackTrace();
		}
		return a;
	}
	
	public static int[] getDeptLoggedTotal(String sDate,String eDate) {
		
		Date sdate;
		Date edate;
		String staffID="";
		String deptID="";
		ResultSet retask;
		int a[]=null;
		
		try {
			sdate = new SimpleDateFormat("yyyy-MM-dd").parse(sDate);
			edate = new SimpleDateFormat("yyyy-MM-dd").parse(eDate); 
			
			
			ResultSet redept=db.select("deptID", "department order by deptID", "");
			redept.last();
			a=new int[redept.getRow()];
			redept.beforeFirst();
			for(int k=0;redept.next();k++) {
				int count=0;
				deptID=redept.getString(1);
				ResultSet resid=db.select("staffID", "staff", "deptID="+deptID);
				for(;resid.next();) {
					staffID=resid.getString(1);
					retask=db.select("createTime,endTime", "task natural join taskAssign natural join staff", "staffID="+staffID);
				
					for(;retask.next();) {
						Date cdate=retask.getDate("createTime");
						Date ldate=retask.getDate("endTime");
					
						Date smallDate=cdate.after(sdate)?cdate:sdate;
						Date bigDate=ldate.after(edate)?edate:ldate;
					
						int day = (int) ((bigDate.getTime() - smallDate.getTime()) / (1000 * 60 * 60 * 24)); 

						if(day>=0)count+=day;
					}
				
				}
				a[k]=count;
			}
		} catch (Exception e) {
			// TODO 自动生成的 catch 块
			e.printStackTrace();
		}
		return a;
	}
}
