<%-- 
    Document   : result
    Created on : Nov 29, 2011, 7:51:31 PM
    Author     : Definately
--%>

<%@page import="javax.swing.JOptionPane"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Enumeration"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>OpenGeeks-OES</title>
    </head>
    <body>
        <%!
         RequestDispatcher rd;
        Connection con ;
	PreparedStatement pst = null;
        Statement st;
	ResultSet rs = null;
         String query = null;
        String constr = "jdbc:mysql://localhost:3306/oes";
         String examId1=null;
          String username =null;
        %>
        <%
      //  ArrayList<question> questionSet = (ArrayList<question>)application.getAttribute("QuestionSet"); 
       // int TNOQ = Integer.parseInt(application.getAttribute("TNOQ").toString());
     
        String answer=""; 
        int correct=0;
        int incorrect=0;
     try
     {  
         
        // JOptionPane.showMessageDialog(null,examId1);
         username = session.getAttribute("user").toString();
        // JOptionPane.showMessageDialog(null,examId1);
           examId1 = session.getAttribute("examId").toString();
         //JOptionPane.showMessageDialog(null,examId1);
       //con = DriverManager.getConnection(constr, "root", "java");
          //              String query="select examId from schedule where CURDATE()<schedule.date and CURTIME()>time order by date,time;";
           //             st=con.createStatement();
          //              rs=st.executeQuery(query);
            //            if(rs.next())
            //                {
           ///                 examId1=rs.getString(1);
            //            }
        Enumeration param = request.getParameterNames();
         Class.forName("com.mysql.jdbc.Driver");
         con = DriverManager.getConnection(constr, "root", "java");
     while(param.hasMoreElements())
     {
       String paramName = (String)param.nextElement();
         String[] paramValues = request.getParameterValues(paramName);
         for (int i = 0; i < paramValues.length; i++) 
                      {
                          answer=answer+paramValues[i];
                      }
        
          
            st = con.createStatement();
            rs = st.executeQuery("select questionId,ans from paper");
            while (rs.next())
               {
                if(rs.getString(1).equals(paramName))
                                       {
                    if(rs.getString(2).equals(answer))
                                 correct++;                                
                    else 
                    incorrect++;                                                 
                    }
            }
           }
        rs=null;
        st=null;
        
         }
     catch(Exception we)
                         {
     session.setAttribute("fb",we.toString() );
     }
        try
                {
              //  Class.forName("com.mysql.jdbc.Driver");
               if(correct>=incorrect)
                                     {
                   session.setAttribute("fb","Congurats,you have Pass the Exam");
                   query  = "Update exam_student set status='pass' where examId="+examId1+" and iduser = '"+username+"'";
              
                   }
              else
                                   {
                    session.setAttribute("fb","Sorry, to tell u that u failed in exam.Better Luck next Time");
                  query = "Update exam_student set status='fail' where examId="+examId1+" and iduser = '"+username+"'";;
                   
                     }
              //  con = DriverManager.getConnection(constr, "root", "java");
                pst = con.prepareStatement(query);
                 JOptionPane.showMessageDialog(null,query);
                int bool=pst.executeUpdate();
               // JOptionPane.showMessageDialog(null,"cool");
                if(bool>0)
                    {
                         session.setAttribute("fb","Congurats,you have Pass the Exam");
                   }
                }
            catch(Exception ex)
                {
                 session.setAttribute("fb", "Problem accessing security realm. Try later");
                 
                }
            finally
                 {
                 
                              pst.close();
                              
                              con.close();
                 
         }
               rd = request.getRequestDispatcher("student.jsp");
                  rd.forward(request, response);
        %>
      
    </body>
</html>
