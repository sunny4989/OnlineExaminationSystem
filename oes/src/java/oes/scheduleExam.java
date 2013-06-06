/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package oes;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.Statement;
import java.sql.ResultSet;
import java.sql.DriverManager;
import java.text.DateFormat;
import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpSession;
import javax.swing.JOptionPane;

/**
 *
 * @author Definately
 */
public class scheduleExam extends HttpServlet {
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
            String subjects=null;
            String level = null ;
            String noq=null;
            String date = null;
            String time= null;
            String Tlimit = null;
            int boo=0;
            response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
            response.setHeader("Pragma","no-cache"); //HTTP 1.0
            response.setDateHeader ("Expires", 0);
            session.removeAttribute("fb");
             session.setAttribute("fb","");
            try
                {
                
                 subjects = request.getParameter("subjects").trim();
                 level = request.getParameter("level").trim();
                 noq = request.getParameter("noq").trim();
                 date = request.getParameter("date").trim();
                 time = request.getParameter("time").trim();
                 Tlimit = request.getParameter("Tlimit").trim();
                 DateFormat df;
                // String dateStr = df.format("YYYY-MM-DD");
                 
                }
                catch(Exception es)
                {
                     session.setAttribute("fb", es.toString());
                }
            int num =Integer.parseInt(noq); 
             if(num<=0)
                {
                    rd=request.getRequestDispatcher("scheduleExam.jsp");
                     session.setAttribute("fb","Please fill all the required (*) data");
                     rd.forward(request, response);
                }
            
             try
                {
                Class.forName("com.mysql.jdbc.Driver");
                boo=0;
                con = DriverManager.getConnection(constr, "root", "java");
                pst = con.prepareStatement("select COUNT(questionId)  FROM question Where subject='"+subjects+"' and level='"+level+"' ");
                //pst.setString(1,subjects);
                //pst.setString(2,level);
                ResultSet rst;
                rst = pst.executeQuery();
                if(rst.next())
                {
                    System.out.println("Hello World : "+rst.getInt(1)); 
                    boo=rst.getInt(1);
                }
                
                if(boo<num)
                {
                    rd=request.getRequestDispatcher("scheduleExam.jsp");
                 session.setAttribute("fb","INSUFFICIENT QUESTION PRESENT IN DATABASE INSERT "+(num-boo)+"QUESTION MORE FIRST");
                 rd.forward(request, response);
                }
                pst.close();
                String query = "insert into schedule(date,time,tLimit,level,subject,NOQ)  values("
                        +"'"+date+"',"+"'"+time+"',"+"'"+Tlimit+"',"+"'"+level+"',"+"'"+subjects+"',"+noq+")";
                    System.out.println(query);
                st = con.createStatement();
                boolean bool = st.execute(query);
                    System.out.println("Hello World" +boo);
                if(bool)
                    {
                         session.setAttribute("fb","Scheduled Exam has been created.");
                    }
                else
                {
                    session.setAttribute("fb","Do NOT TEST ME");
                }
                }
            catch(Exception ex)
                {
                 session.setAttribute("fb", "Problem accessing security realm. Try later");
                 ex.printStackTrace();
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
               rd = request.getRequestDispatcher("scheduleExam.jsp");
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
