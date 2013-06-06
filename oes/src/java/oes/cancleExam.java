/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package oes;

import com.mysql.jdbc.Connection;
import com.mysql.jdbc.PreparedStatement;
import com.mysql.jdbc.Statement;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.DriverManager;
import java.sql.ResultSet;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Definately
 */
public class cancleExam extends HttpServlet {
        RequestDispatcher rd;
        Connection con ;
	PreparedStatement pst = null;
        Statement st;
	ResultSet rs = null;
        String constr = "jdbc:mysql://localhost:3306/oes";
        String submit=null;
        String examId=null;
   

    /** 
     * Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
            response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
            response.setHeader("Pragma","no-cache"); //HTTP 1.0
            response.setDateHeader ("Expires", 0);
            
         HttpSession session= request.getSession();
         session.removeAttribute("fb");
          session.setAttribute("fb","");
        try
                {
                 examId = request.getParameter("examId").trim();
                 submit = request.getParameter("submit");
                 
                }
             catch(Exception es)
                {
                     session.setAttribute("fb", es.toString());
                }
        if(submit!=null)
                       {
           
            try
                {
                Class.forName("com.mysql.jdbc.Driver");
                con = (Connection) DriverManager.getConnection(constr, "root", "java");
                pst = (PreparedStatement) con.prepareStatement("delete from schedule where examId =?");
                pst.setString(1,examId);
                if(pst.getMaxRows()==0)
                {
                    session.setAttribute("fb","Enter the ExamId correctly,Please Do not mash  with me");
                    rd = request.getRequestDispatcher("cancelExam.jsp");
                    rd.forward(request, response);
                    
                }
                int bool=pst.executeUpdate();
                if(bool>0)
                    {
                         session.setAttribute("fb","EXAM CANCELED.");
                    }
                }
            catch(Exception ex)
                {
                 session.setAttribute("fb", "Problem accessing security realm. Try later");
                 
                }
            finally
                 {
                 try
                         {
                              pst.close();
                              st.close();
                              con.close();
                         }
                catch (Exception ignore) {
                }
         }
               rd = request.getRequestDispatcher("admin.jsp");
                  rd.forward(request, response);
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
