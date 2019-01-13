package database;

import java.sql.*;

public class db {
	public static final String URL = "jdbc:mysql://localhost:3306/WorkGether";
    public static final String USER = "root";
    public static final String PASSWORD = "hsm69283719";
    private static Connection conn = null;
    static{
        try {
            //1.加载驱动程序
            Class.forName("com.mysql.jdbc.Driver");
            //2. 获得数据库连接
            conn = DriverManager.getConnection(URL, USER, PASSWORD);
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public static Connection getConnection(){
        return conn;
    }
    
    public static ResultSet select(String attribute,String table,String condition) {
    	String statement="";
    	if(condition.equals("")) statement="select "+attribute+" from "+table;
    	else statement="select "+attribute+" from "+table+" where "+condition;
    	System.out.println(statement);
    	Statement stmt;
		try {
			stmt = conn.createStatement();
	        ResultSet rs = stmt.executeQuery(statement);
	        return rs;
		} catch (SQLException e) {
			// TODO 自动生成的 catch 块
			e.printStackTrace();
		}
		return null;
    }
    
    public static void update(String table,String attribute,String condition) {
    	String statement="";
    	statement="update "+table+" set "+attribute+" where "+condition;
    	System.out.println(statement);
    	Statement stmt;
		try {
			stmt = conn.createStatement();
	        stmt.executeUpdate(statement);
		} catch (SQLException e) {
			// TODO 自动生成的 catch 块
			e.printStackTrace();
		}
    }
    
    public static int insert(String table,String attribute,String value) {
    	String statement="insert into "+table+" ("+attribute+") values ("+value+")";
    	System.out.println(statement);
    	
    	Statement stmt;
    	try {
			stmt = conn.createStatement();
	        stmt.executeUpdate(statement,stmt.RETURN_GENERATED_KEYS);
	        ResultSet re=stmt.getGeneratedKeys();
	        if(re.next())return re.getInt(1);
		} catch (SQLException e) {
			// TODO 自动生成的 catch 块
			e.printStackTrace();
		}
    	return -1;
    }
    
    public static void delete(String table,String whereStmt) {
    	String statement="delete from "+table+" where "+whereStmt;
    	
    	System.out.println(statement);
    	
    	Statement stmt;
    	try {
			stmt = conn.createStatement();
	        stmt.executeUpdate(statement);
		} catch (SQLException e) {
			// TODO 自动生成的 catch 块
			e.printStackTrace();
		}
    }
}
