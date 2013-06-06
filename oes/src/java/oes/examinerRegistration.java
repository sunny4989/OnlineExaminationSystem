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
public class examinerRegistration extends HttpServlet {
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
       session.removeAttribute("fb");
        session.setAttribute("fb","");
            String username=null;
            String password = null ;
            String confirmPassword=null;
            String name = null;
            String sex = null;
            String address = null;
            String mobile = null;
            String email = null;
            String security = null;
            response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
            response.setHeader("Pragma","no-cache"); //HTTP 1.0
            response.setDateHeader ("Expires", 0);
             try
                {
                 username = request.getParameter("username").trim();
                 password = request.getParameter("password").trim();
                 confirmPassword = request.getParameter("confirmPassword").trim();
                 
                 name = request.getParameter("name").trim();
                 sex = request.getParameter("sex").trim();
                 address = request.getParameter("address").trim();
                 mobile = request.getParameter("mobileNo").trim();
                 email = request.getParameter("emailId").trim();
                 security = request.getParameter("security").trim();
                 
                   
                }
                catch(Exception es)
                {
                     session.setAttribute("fb", es.toString());
                }
            if(password.equals(confirmPassword)==false)
                 {
                     //JOptionPane.showMessageDialog(null,password+confirmPassword);
                     rd=request.getRequestDispatcher("studentRegisteration.jsp");
                     session.setAttribute("fb","PASSWORD MISSMATCHED");
                     rd.forward(request, response);
                 }
                        
             if((username==null)||(password==null)||(name==null)||(sex==null)||(address==null)||(security==null))
                {
                    rd=request.getRequestDispatcher("studentRegisteration.jsp");
                     session.setAttribute("fb","Please fill all the required (*) data");
                     rd.forward(request, response);
                }
             try
                {
                Class.forName("com.mysql.jdbc.Driver");
                
                con = DriverManager.getConnection(constr, "root", "java");
                String query="select COUNT(iduser) as number from user where iduser='"+username+"'";
                st=con.createStatement();
                rs=st.executeQuery(query);
                if(rs.wasNull())
                {
                    rd=request.getRequestDispatcher("admin.jsp");
                    session.setAttribute("fb","Username is already taken. Please Change username.");
                    rd.forward(request, response); 
                }
                st.close();
                rs=null;
                
                pst = con.prepareStatement("insert into user values(?,?,?,?,?,?,?,'admin',?)");
                pst.setString(1,username);
                pst.setString(2,password);
                pst.setString(3,name);
                pst.setString(4,sex);
                pst.setString(5,address);
                pst.setString(6,mobile);
                pst.setString(7,email);
                pst.setString(8,security);
                int bool=pst.executeUpdate();
                JOptionPane.showMessageDialog(null,"cool");
                if(bool>0)
                    {
                         session.setAttribute("fb","Account has been created.");
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
