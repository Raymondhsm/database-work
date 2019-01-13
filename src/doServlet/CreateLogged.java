package doServlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import database.db;
import domain.Login;

/**
 * Servlet implementation class CreateLogged
 */
@WebServlet("/CreateLogged")
public class CreateLogged extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CreateLogged() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String taskID=req.getParameter("taskID");
		String workload=req.getParameter("workload");
		String rateOfProcess=req.getParameter("rateOfProcess");
		String needTime=req.getParameter("needTime");
		String remark=req.getParameter("remark");
		String skey=req.getParameter("skey");
		
		String staffID=Login.getStaffID(skey);
		
		if(remark.equals(""))
			db.insert("logged", "taskID,workload,rateOfProcess,needTime,loggedRemark,staffID", taskID+",'"+workload+"',"+rateOfProcess+",'"+needTime+"','"+remark+"',"+staffID);
		else 
			db.insert("logged", "taskID,workload,rateOfProcess,needTime,staffID", taskID+",'"+workload+"',"+rateOfProcess+",'"+needTime+"',"+staffID);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
