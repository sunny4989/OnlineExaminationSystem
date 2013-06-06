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
import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpSession;
import javax.swing.JOptionPane;

/**
 *
 * @author Definately
 */
public class updateAccount extends HttpServlet {
    
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
            String password = null ;
            String confirmPassword=null;
            String mobile = null;
            String email = null;
            String username =session.getAttribute("user").toString();
             try
                {
                 password = request.getParameter("password").trim();
                 confirmPassword = request.getParameter("confirmPassword").trim();
                 mobile = request.getParameter("mobileNo").trim();
                 email = request.getParameter("emailId").trim();
                }
                catch(Exception es)
                {
                     session.setAttribute("fb", es.toString());
                }
              //JOptionPane.showMessageDialog(null,"cool");
            if(password.equals(confirmPassword)==false)
                 {
                     
                     session.setAttribute("fb","PASSWORD MISSMATCHED");
                     //JOptionPane.showMessageDialog(null,password+confirmPassword);
                     if(session.getAttribute("user")=="admin")
                     {
                         rd=request.getRequestDispatcher("admin.jsp");
                     }
                     else
                         rd=request.getRequestDispatcher("student.jsp");
                     
                     rd.forward(request, response);
                 }     
             try
                {
                Class.forName("com.mysql.jdbc.Driver");
                con = DriverManager.getConnection(constr, "root", "java");
                String query="select * from user where iduser='"+username +"'";
                st=con.createStatement();
                rs=st.executeQuery(query);
                if(password==null)
                   password= rs.getString("password");
                if(mobile==null)
                    mobile=rs.getString("mobileNo");
                if(email==null)
                    email=rs.getString("emailId");
                st.close();
                rs=null;
                
                pst = con.prepareStatement("UPDATE user set password=?, mobileNo=?,emailId=? where iduser=?");
                pst.setString(1,password);
                pst.setString(2,mobile);
                pst.setString(3,email);
                pst.setString(4,username);
                int bool=pst.executeUpdate();
                session.setAttribute("fb","Done.");
                if(bool>0)
                    {
                      //  JOptionPane.showMessageDialog(null,"cool");
                        session.setAttribute("fb","Done.");
                        if(session.getAttribute("user")=="admin")
                         {
                             rd=request.getRequestDispatcher("admin.jsp");
                         }
                         else
                             rd=request.getRequestDispatcher("student.jsp");

                         rd.forward(request, response);
                   }
                }
            catch(Exception ex)
                {
                 session.setAttribute("fb", "Problem accessing security realm. try later");
                     if(session.getAttribute("user")=="admin")
                         {
                             rd=request.getRequestDispatcher("admin.jsp");
                         }
                         else
                             rd=request.getRequestDispatcher("student.jsp");

                         rd.forward(request, response);
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
