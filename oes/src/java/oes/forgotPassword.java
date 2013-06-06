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
public class forgotPassword extends HttpServlet {
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
            String security = null;
            String username = null;
           
             try
                {
                 password = request.getParameter("password").trim();
                 confirmPassword = request.getParameter("confirmPassword").trim();
                 security = request.getParameter("securityCode").trim();
                 username = request.getParameter("username").trim();
                }
                catch(Exception es)
                {
                     session.setAttribute("fb", es.toString());
                }
              //JOptionPane.showMessageDialog(null,"cool");
            if((password.equals(confirmPassword)==false)||(password==null))
                 {
                     
                    
                     //JOptionPane.showMessageDialog(null,password+confirmPassword);
                     
                         rd=request.getRequestDispatcher("forgotPWD.jsp");
                      session.setAttribute("fb","PASSWORD MISSMATCHED");
                     rd.forward(request, response);
                 }     
             try
                {
                Class.forName("com.mysql.jdbc.Driver");
                con = DriverManager.getConnection(constr, "root", "java");
                String query="select * from user where iduser='"+username +"'";
                st=con.createStatement();
                rs=st.executeQuery(query);
                if(!(rs.getString(9)==security))
                {
                      rd=request.getRequestDispatcher("forgotPWD.jsp");
                      session.setAttribute("fb","SECURITY CODE IS NOT CORRECT");
                     rd.forward(request, response);
                }
               
                st.close();
                rs=null;
                
                pst = con.prepareStatement("UPDATE user set password=? where iduser=?");
                pst.setString(1,password);
                pst.setString(2,username);
                int bool=pst.executeUpdate();
               
                if(bool>0)
                    {
                       // JOptionPane.showMessageDialog(null,"cool");
                        session.setAttribute("fb","PASSWORD HAS BEEN CHANGED. PLEASE LOGIN");
                        rd=request.getRequestDispatcher("index.jsp");
                        rd.forward(request, response);
                   }
                }
            catch(Exception ex)
                {
                 session.setAttribute("fb", "Problem accessing security realm. try later");
                rd=request.getRequestDispatcher("index.jsp");
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
