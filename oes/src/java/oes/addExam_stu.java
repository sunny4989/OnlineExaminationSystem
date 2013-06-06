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
public class addExam_stu extends HttpServlet {
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
         String username = session.getAttribute("user").toString();
            int question=0;
            response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
            response.setHeader("Pragma","no-cache"); //HTTP 1.0
            response.setDateHeader ("Expires", 0);
            session.removeAttribute("fb");
             session.setAttribute("fb","");
             try
                {
                 question = Integer.parseInt(request.getParameter("addExam").trim());
                 
                }
             catch(Exception es)
                {
                     session.setAttribute("fb", es.toString());
                }
          
          try
                {
                Class.forName("com.mysql.jdbc.Driver");
                con = DriverManager.getConnection(constr, "root", "java");
                String query="select examId from schedule where CURDATE()<schedule.date and examId= '"+question+"';";
                
                //JOptionPane.showMessageDialog(null,query);
                st= con.createStatement();
                rs = st.executeQuery(query);
                int boo = rs.getRow();
                //JOptionPane.showMessageDialog(null,boo);
                System.out.println(boo);
                if(boo==0)
                {
                  request.setAttribute("fb", "examId is not correct");
                  rd = request.getRequestDispatcher("student.jsp");
                  
                }
                //JOptionPane.showMessageDialog(null,"cool");
                pst = con.prepareStatement("insert into exam_student(examId,iduser,status) values(?,?,null)");
                pst.setInt(1,question);
                pst.setString(2,username);
                //JOptionPane.showMessageDialog(null,"cool");
                System.out.println("hello world");
                boolean bool=pst.execute();
                //JOptionPane.showMessageDialog(null,"cool");
                if(bool)
                    {
                         session.setAttribute("fb","EXAM is Scheduled for you.BEST OF LUCK.");
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
                              rd.forward(request, response);
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
