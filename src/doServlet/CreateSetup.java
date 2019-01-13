package doServlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import database.db;

/**
 * Servlet implementation class CreateSetup
 */
@WebServlet("/CreateSetup")
public class CreateSetup extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CreateSetup() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest req, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		int type=Integer.valueOf(req.getParameter("type"));
		
		if(type==1)
			createDept(req.getParameter("name"),req.getParameter("manager"),req.getParameter("workday"),req.getParameter("remark"));
		else if(type==2)
			createLevel(req.getParameter("name"),req.getParameter("l1"),req.getParameter("l2"),req.getParameter("l3"),req.getParameter("l4"),req.getParameter("l5"),req.getParameter("l6"));
		else if(type==3)
			createWorkday(req.getParameter("name"));
		else if(type==4)
			createTaskType(req.getParameter("name"));
		else if(type==5)
			createTaskLevel(req.getParameter("name"),req.getParameter("level"));
		else if(type==6)
			createTaskSource(req.getParameter("name"));
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}
	
	private void createDept(String name,String manager,String workday,String remark) {
		db.insert("department", "deptName,deptIntroduction,managerID,workdayID", "'"+name+"','"+remark+"',"+manager+","+workday);
	}
	
	private void createLevel(String name,String l1,String l2,String l3,String l4,String l5,String l6) {
		db.insert("userlevel", "userLevelName,jichushezhi,shixiangguanli,renwuchuangjian,renwugengzong,rizhitianxie,rizhishenhe","'"+name+"','"+l1+"','"+l2+"','"+l3+"','"+l4+"','"+l5+"','"+l6+"'");
	}
	
	private void createWorkday(String name) {
		db.insert("workday", "workdayName", "'"+name+"'");
	}
	
	private void createTaskType(String name) {
		db.insert("taskType", "taskTypeName", "'"+name+"'");
	}
	
	private void createTaskLevel(String name,String level) {
		db.insert("taskLevel", "taskLevelName,taskLevel", "'"+name+"',"+level);
		
	}
	
	private void createTaskSource(String name) {
		db.insert("taskSource", "taskSourceName","'"+name+"'");
	}

}
