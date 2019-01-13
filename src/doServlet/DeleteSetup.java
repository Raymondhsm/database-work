package doServlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import database.db;

/**
 * Servlet implementation class DeleteSetup
 */
@WebServlet("/DeleteSetup")
public class DeleteSetup extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DeleteSetup() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest req, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		int type=Integer.valueOf(req.getParameter("type"));
		String ID=req.getParameter("ID");
		String table,stmt;
		
		
		if(type==1) {
			table="department";
			stmt="deptID="+ID;
		}
		else if(type==2) {
			table="userLevel";
			stmt="userLevelID="+ID;
		}
		else if(type==3) {
			table="workday";
			stmt="workdayID="+ID;
		}
		else if(type==4) {
			table="taskType";
			stmt="taskTypeID="+ID;
		}
		else if(type==5) {
			table="taskLevel";
			stmt="taskLevelID="+ID;
		}
		else{
			table="taskSource";
			stmt="TaskSourceID="+ID;
		}
		
		db.delete(table, stmt);
			
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
