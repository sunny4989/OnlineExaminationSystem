/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package oes;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.Statement;
import java.sql.ResultSet;
import java.sql.DriverManager;
import java.util.logging.Level;
import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpSession;
import javax.swing.JOptionPane;
/**
 *
 * @author Ranjan
 */
public class cancel_exam_stu extends HttpServlet {
        RequestDispatcher rd;
        Connection con ;
	PreparedStatement pst = null;
        Statement st;
	ResultSet rs = null;
        String constr = "jdbc:mysql://localhost:3306/oes";
   
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
   
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
       HttpSession session= request.getSession();
       session.removeAttribute("fb");
        session.setAttribute("fb","");
            String examid=null;
            String username=session.getAttribute("user").toString();
            try
                {
                 examid = request.getParameter("cancel_id").trim();
                 
                }
             catch(Exception es)
                {
                     session.setAttribute("fb", es.toString());
                }
             if((examid==null))
                {
                    rd=request.getRequestDispatcher("student.jsp");
                     session.setAttribute("fb","Please Enter the right exam Id to cancel");
                     rd.forward(request, response);
                }
             try
                {
                Class.forName("com.mysql.jdbc.Driver");
                
                con = DriverManager.getConnection(constr, "root", "java");
                pst = con.prepareStatement("delete from exam_student where examid =? and iduser=?");
                pst.setString(1,examid);
                pst.setString(2, username);
                int bool=pst.executeUpdate();
                // JOptionPane.showMessageDialog(null,"cool");
                if(bool>0)
                    {
                         session.setAttribute("fb","YOUR EXAM IS CANCELED.");
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
               rd = request.getRequestDispatcher("student.jsp");
                  rd.forward(request, response);
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
