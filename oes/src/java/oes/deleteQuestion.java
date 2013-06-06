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
 * @author Definately
 */
public class deleteQuestion extends HttpServlet {
        RequestDispatcher rd;
        Connection con ;
	PreparedStatement pst = null;
        Statement st;
	ResultSet rs = null;
        String constr = "jdbc:mysql://localhost:3306/oes";
   
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
            String questionId=null;
            try
                {
                 questionId = request.getParameter("questionId").trim();
                 
                }
             catch(Exception es)
                {
                     session.setAttribute("fb", es.toString());
                }
             if((questionId==null))
                {
                    rd=request.getRequestDispatcher("deleteQuestion.jsp");
                     session.setAttribute("fb","Please Enter the question Id to cancel");
                     rd.forward(request, response);
                }
             try
                {
                Class.forName("com.mysql.jdbc.Driver");
                
                con = DriverManager.getConnection(constr, "root", "java");
                pst = con.prepareStatement("delete from question where questionId =?");
                pst.setString(1,questionId);
                int bool=pst.executeUpdate();
                // JOptionPane.showMessageDialog(null,"cool");
                if(pst.getMaxRows()==0)
                {
                    session.setAttribute("fb","Enter the corrent Question Id,Please Do not mash  with me");
                }
                if(bool>0)
                    {
                         
                         session.setAttribute("fb","Question Deleted.");
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
               rd = request.getRequestDispatcher("deleteQuestion.jsp");
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
