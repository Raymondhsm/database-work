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
 * Servlet implementation class ChangeLike
 */
@WebServlet("/ChangeLike")
public class ChangeLike extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ChangeLike() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String taskID=req.getParameter("taskID");
		String skey=req.getParameter("skey");
		String type=req.getParameter("type");
		
		String staffID=Login.getStaffID(skey);
		if(type.equals("like")) 
			db.insert("taskFollow", "taskID,staffID", taskID+","+staffID);
		else 
			db.delete("taskFollow", "taskID='"+taskID+"' and staffID='"+staffID+"'");
		
		PrintWriter out = resp.getWriter();
		out.println("true");
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
