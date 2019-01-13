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
 * Servlet implementation class CreateStaff
 */
@WebServlet("/CreateStaff")
public class CreateStaff extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CreateStaff() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest req, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String account=req.getParameter("account");
		String password=req.getParameter("password");
		String name=req.getParameter("name");
		String dept=req.getParameter("dept");
		String sex=req.getParameter("sex");
		
		if(!Login.isAvaiableAccount(account)) {
			PrintWriter out=response.getWriter();
			out.print(false);
			out.close();
		}else {
			
			int staffID=db.insert("staff", "staffName,staffSex,staffPost,deptID,userLevelID", "'"+name+"',"+sex+",'Ô±¹¤',"+dept+",4");
			db.insert("loginInfo", "account,password,staffID", "'"+account+"','"+password+"',"+staffID);
		}

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
