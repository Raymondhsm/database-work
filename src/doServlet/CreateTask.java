package doServlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import database.db;
import domain.Login;

/**
 * Servlet implementation class CreateTask
 */
@WebServlet("/CreateTask")
public class CreateTask extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CreateTask() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String id=req.getParameter("id");
		String oldtaskID="";
		if(id.equals("update")) oldtaskID=req.getParameter("taskID");
		String name=req.getParameter("name");
		String endTime=req.getParameter("endTime");
		String source=req.getParameter("source");
		String type=req.getParameter("type");
		String level=req.getParameter("level");
		String remark=req.getParameter("remark");
		String skey=req.getParameter("skey");
		String assign=req.getParameter("assign");
		
		String staffID=Login.getStaffID(skey);
		
		String attribute="taskName,endTime,status,taskRemark,taskLevelID,tasktypeID,taskSourceID,createStaffID";
		String value="'"+name+"','"+endTime+"',1,'"+remark+"',"+level+","+type+","+source+","+staffID;
		
		if(id.equals("create")) {
		int taskID=db.insert("task", attribute, value);
		
		String as[]=assign.split(",");
		for(int i=0;i<as.length;i++) 
			db.insert("taskAssign", "taskID,deptID", taskID+","+as[i]);
		
		}else {
			db.update("task", "taskName='"+name+"',endTime='"+endTime+"',taskRemark='"+remark+"',taskLevelID='"+level+"',tasktypeID='"+type+"',taskSourceID='"+source+"'", "taskID="+oldtaskID);
		}
		PrintWriter out=res.getWriter();
		out.println("任务创建成功");
		out.close();
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
