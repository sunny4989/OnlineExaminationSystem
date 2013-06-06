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
public class addQuestion extends HttpServlet {
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
            HttpSession session= request.getSession();
            String question=null;
            String optionA = null ;
            String optionB=null;
            String optionC = null;
            String optionD = null;
            String questionLevel = null;
            String ans[] = null;
            String subject = null;
            String answer = "";
            response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
            response.setHeader("Pragma","no-cache"); //HTTP 1.0
            response.setDateHeader ("Expires", 0);
            
            session.removeAttribute("fb");
             session.setAttribute("fb","");
             try
                {
                 question = request.getParameter("question").trim();
                 optionA = request.getParameter("a").trim();
                 optionB = request.getParameter("b").trim();
                 optionC = request.getParameter("c").trim();
                 optionD = request.getParameter("d").trim();
                 questionLevel = request.getParameter("qestionLevel");
                 ans = request.getParameterValues("answer");
                // JOptionPane.showMessageDialog(null,answer+" "+questionLevel+" "+subject );
                 
                     for (int i = 0; i < ans.length; i++) 
                      {
                          answer=answer+ans[i];
                      }
                 subject = request.getParameter("subject").trim();
                }
             catch(Exception es)
                {
                     session.setAttribute("fb", es.toString());
                }
          
                // JOptionPane.showMessageDialog(null,answer+" "+questionLevel+" "+subject );       
             if((question==null)||(questionLevel==null)||(answer==null)||(optionA==null)||(optionB==null)||(optionC==null)||(optionD==null)||(subject==null))
                {
                    rd=request.getRequestDispatcher("admin.jsp");
                     session.setAttribute("fb","Please fill all the Data");
                     rd.forward(request, response);
                }
             try
                {
                Class.forName("com.mysql.jdbc.Driver");
                
                con = DriverManager.getConnection(constr, "root", "java");
                pst = con.prepareStatement("insert into question(question,a,b,c,d,ans,level,subject) values(?,?,?,?,?,?,?,?)");
                pst.setString(1,question);
                pst.setString(2,optionA);
                pst.setString(3,optionB);
                pst.setString(4,optionC);
                pst.setString(5,optionD);
                pst.setString(6,answer);
                pst.setString(7,questionLevel);
                pst.setString(8,subject);
                int bool=pst.executeUpdate();
               // JOptionPane.showMessageDialog(null,"cool");
                if(bool>0)
                    {
                         session.setAttribute("fb","Question Inserted.");
                
                 
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

    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>
}
