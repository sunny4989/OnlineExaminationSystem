/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package oes;


import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.Statement;
import java.sql.ResultSet;
import java.sql.DriverManager;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpSession;
import javax.swing.JOptionPane;

/**
 *
 * @author Definately
 */
public class Login extends HttpServlet {
    RequestDispatcher rd;
    Connection con ;
	PreparedStatement pst = null;
        Statement st;
	ResultSet rs = null;
 
        
//       private Connection getConnection() throws SQLException {
//		java.sql.Connection con;
//               
//		con = ConnectionFactory.getInstance().getConnection();
//		return con;
//	} 
  

    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
            PrintWriter out = response.getWriter();
            HttpSession session= request.getSession();
            String username = null;
            String password = null;
            response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
            response.setHeader("Pragma","no-cache"); //HTTP 1.0
            response.setDateHeader ("Expires", 0);
          //  session.removeAttribute("fb");
         //session.setAttribute("fb","");
        try
        {
         username = request.getParameter("USERNAME").trim();
         password = request.getParameter("PASSWORD").trim();
        }
        catch(Exception es)
        {
             session.setAttribute("fb", es.toString());
             request.setAttribute("fb", es.toString());
        }
         String constr = "jdbc:mysql://localhost:3306/oes";
        try
            {
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection(constr, "root", "java");
            st = con.createStatement();
            rs = st.executeQuery("select iduser,password,type from user ");
            while (rs.next())
                {
                if (rs.getString("password").equals(password) && rs.getString("iduser").equals(username))
                    {
                       
                        session.setAttribute("user",username);
                        if(rs.getString("type").equals("admin"))
                            {
                          
                            session.setAttribute("type" ,"admin");
                             session.setAttribute("fb"," WELCOME ");
                            rd=request.getRequestDispatcher("admin.jsp");
                          //  rd.forward(request, response);
                            
                           }
                        else
                            {
                                
                            session.setAttribute("type" ,"student");
                            session.setAttribute("fb", " WELCOME");
                            rd=request.getRequestDispatcher("student.jsp");
                          //  JOptionPane.showMessageDialog(null,"worss");
                            //rd.forward(request, response);
                            }
                         session.setAttribute("fb"," WELCOME ");
                    }
                else
                {
                   
            //        session.setAttribute("fb","INVALID AUTENTICATION");
                    rd= request.getRequestDispatcher("index.jsp");
                   //rd.forward(request, response);
                }
                }
            
                      }
    catch(Exception ex)
        {
         session.setAttribute("fb", "Problem accessing security realm.");
         rd = request.getRequestDispatcher("index.jsp");
         rd.forward(request, response);
         ex.printStackTrace();
        }
    finally
         {
         try
                 {
        	  st.close();
		  con.close();
                   rd.forward(request, response); 
                 }
	catch (Exception ignore) {
	}
 }
    
       
    }

    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>
}
