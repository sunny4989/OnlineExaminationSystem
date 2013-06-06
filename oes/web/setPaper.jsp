<%-- 
    Document   : setPaper
    Created on : Nov 28, 2011, 4:17:11 PM
    Author     : Definately
--%>

<%@page import="java.util.LinkedList"%>
<%@page import="oes.temo"%>
<%@page import="oes.temp"%>
<%@page import="javax.swing.JOptionPane"%>
<%@page import="javax.security.auth.Subject"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.ArrayList"%>
<%@page import="oes.temo"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    </head>
    <body>
        
        <%!
        LinkedList<temo> questionSet=null;
        RequestDispatcher rd;
        Connection con ;
        PreparedStatement pst;
        Statement st;
        ResultSet rs = null;
        String constr = "jdbc:mysql://localhost:3306/oes";
        String limit;
         String level;
         String subject;
         int TNOQ;  
         int i=0;
        %>
        
        <%
         String bool=null;
         
                //questionSet = new LinkedList<temo>();
          try
                {
        bool= application.getAttribute("setpaper").toString();
         if(bool.equals("false"))       
               {
            
                Class.forName("com.mysql.jdbc.Driver");
                con = DriverManager.getConnection(constr, "root", "java");
               st = con.createStatement();
               rs = st.executeQuery("select * from schedule where date = CURDATE() and  time < CURTIME() and tLimit <(time-CURTIME())");
              // out.print("select * from schedule where date = CURDATE() and  time < CURTIME();");           
          //    JOptionPane.showMessageDialog(null, "hello");
               if(rs.next())
               {
                   limit= rs.getTime(4).toString();
                   level = rs.getString(5);
                   subject = rs.getString(6);
                   TNOQ = rs.getInt(7);
                   
                    session.setAttribute("examId", rs.getString(1));
                   application.setAttribute("timeLimit", rs.getString(4));
                   application.setAttribute("startTime", rs.getString(3));
                  
               }
              //JOptionPane.showMessageDialog(null, "hello");
               st=null;
              //  out.print("ilu");
               st= con.createStatement();
               //out.print("ilu");
               st.executeUpdate("Create view paper as select * from question where level='"+level+"' and subject='"+subject+"' order by RAND()");
             bool="true";  
            // JOptionPane.showMessageDialog(null, "hello");
             }
          // JOptionPane.showMessageDialog(null, "hello");
                 }
             catch(Exception ex)
                  { session.setAttribute("fb", ex.toString());
                  }
             finally
                                         {
                 application.setAttribute("setpaper",bool);
              
                rd=request.getRequestDispatcher("test.jsp");
               rd.forward(request, response);
             }
  
   
             
               // out.print("select * from question where level='"+level+"' and subject='"+subject+"'order by RAND()");
               //JOptionPane.showMessageDialog(null,rs.last());
        //while(rs.next()) 
          //  {
                //  out.print(rs.getString(1));
                  // out.print(rs.getRow());
                 //  JOptionPane.showMessageDialog(null,"");
                // JOptionPane.showMessageDialog(null, "hello");
              //     questionSet.add(new temo(rs.getString(1),rs.getString(2),rs.getString(3),rs.getString(4),rs.getString(5),rs.getString(6),rs.getString(7)));
                 //ob.setquestion();
                
              ///     i++;
              //    if(i>TNOQ)
             //      break;
                  
             //  }
                 //JOptionPane.showMessageDialog(null, "hello");
               // JOptionPane.showMessageDialog(null, "hello");
              //   application.setAttribute("QuestionSet", questionSet);
              //      application.setAttribute("TNOQ", TNOQ);
             //   }
               // catch(Exception ex)
               //  {
                //    session.setAttribute("fb", ex.toString());
               //  }
             //  finally
             //     {
                  
              //   rd=request.getRequestDispatcher("test.jsp");
               ///    rd.forward(request, response);
                //       con.close();
                  //     rs.close();
                 //   st.close();
                    //        }
       
        %>
       
    </body>
</html>
