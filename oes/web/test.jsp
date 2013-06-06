<%@page import="oes.Check_Date"%>
<%@page import="javax.swing.JOptionPane"%>
<%@page import="oes.temo"%>
<%@page import="java.util.LinkedList"%>
<%@page import="java.util.Scanner"%>
<%@page import="java.util.StringTokenizer"%>
<%@page import="java.util.Random"%>
<%@page import="java.util.HashMap"%>

<%@page import="java.util.ArrayList,java.util.Random"%>
<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <title>OpenGeek-OES</title>
        <meta name="keywords" content="wall shelf, free css templates, one page, full site, CSS, HTML" />
        <meta name="description" content="Wall Shelf is a free CSS template provided by templatemo.com" />
        <link href="templatemo_style.css" rel="stylesheet" type="text/css" />
        <link rel="stylesheet" href="css/coda-slider.css" type="text/css" media="screen" title="no title" charset="utf-8" />
        <%
            response.setHeader("Cache-Control", "no-cache"); //HTTP 1.1
            response.setHeader("Pragma", "no-cache"); //HTTP 1.0
            response.setDateHeader("Expires", 0);
        %>
    </head>
    <body>
        <div id="slider">
            <div id="header_wrapper">
                <div id="header">
                    <a href="#home"><img src="images/templatemo_logo.png" alt="Wall Shelf" /></a>
<script>  
 <!--  
 <%  
 String clock = request.getParameter( "clock" );  
 if( clock == null ) clock = "4111";  
 %>  
  <%!
int hr,min,sec;
  %>
 var timeout = <%=clock%>;  
 var cloc,hr,min,sec;
 function timer()  
 {  
 if( --timeout > 0 )  
 {  
 document.forma.clock.value = timeout;
 
 hr=timeout /(60*60);
 hr=parseInt(hr);
 min=(timeout-hr*60*60)/60;
 min=parseInt(min);
 sec=timeout-hr*60*60-min*60;
 hr=parseInt(hr);
 document.forma.hr.value = hr;
 document.forma.min.value = min;
 document.forma.sec.value = parseInt(sec);
 window.setTimeout( "timer()", 1000 );  
 }  
 else  
 {  
 document.forma.clock.value = "Time over";  
 ///disable submit-button etc  
 }  
 }  
 //--> 

 
 </script>   
 <form action="<%=request.getRequestURL()%>" name="forma" style="font-size: larger"> 
     <input   type="hidden" name="clock" value="<%=clock%>" style="border:0px solid white"/> 
 Time remaining: <input type="text" name="hr" value="<%=hr%>" style="border:0px solid white;width:12px"/>  
 :  
 <input type="text" name="min" value="<%=min%>" style="border:0px solid white;width:13px"/>  
 : 
 <input type="text" name="sec" value="<%=sec%>" style="border:0px solid white;width:13px"/>  
</form>  
 <script>  
 <!--  
 timer();  
//-->  
 </script> </div>
  
            </div>
           <div id="menu_wrapper">
                    <div>
                        <%
                    out.write("<center><strong>");
                    out.write("<font color=\"Red\">");
                    if (!(session.getAttribute("fb") == null)) {
                        out.write(session.getAttribute("fb").toString());
                    }
                    out.write("</font>");
                    out.write("</strong></center>");
                    %>
                </div>
                <%!              
              RequestDispatcher rd;
             Connection con ;
	     PreparedStatement pst = null;
             Statement st;
	     ResultSet rs = null;
              String constr = "jdbc:mysql://localhost:3306/oes";
              int i=0;
                %>
                    
                  <form action="result.jsp" method="post">                         
                 <div id="content_wrapper" style="overflow:auto;padding-left: 300px;"> 
                      <p> rule and regulation:
                          <br />
                         1. It is the responsibility of the student make himself aware of the dates, location & times of
examination.<br />
2.Students shall be present at the examination Centre 15 minutes before the scheduled time.<br/>
3.Books, bags or any other unauthorized material should be away from the students desk in the
examination centre.<br />
4.Please do not press back or refresh button during the exam
                                       <br/> </p> 
                   
                <%
  try
            {
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection(constr, "root","java");
            st = con.createStatement();
            rs = st.executeQuery("select * from paper order by RAND()");
              while (rs.next())
                {
                  %>
                  <hr />
                  <%=++i%> <%=rs.getString(2)%> <br />
                   <%
                    if(rs.getString(7).length()>1)
                                               {
                   %>
                   
                                  <!--  Left Column -->
                                 
                                    <p>
                                       
                                        <input name="<%=rs.getString(1)%>" type="checkbox" value="A" /><%=rs.getString(3)%><br />
                                         <input name="<%=rs.getString(1)%>" type="checkbox" value="B" /><%=rs.getString(4)%><br />
                                          <input name="<%=rs.getString(1)%>" type="checkbox" value="C" /><%=rs.getString(5)%><br />
                                           <input name="<%=rs.getString(1)%>" type="checkbox" value="D" /><%=rs.getString(6)%><br />
                                        <%
                                          }
                                          else
                                            { 
                                        %>
                                        <input name="<%=rs.getString(1)%>" type="radio" value="A" /><%=rs.getString(3)%><br />
                                         <input name="<%=rs.getString(1)%>" type="radio" value="B" /><%=rs.getString(4)%><br />
                                          <input name="<%=rs.getString(1)%>" type="radio" value="C" /><%=rs.getString(5)%><br />
                                           <input name="<%=rs.getString(1)%>" type="radio" value="D" /><%=rs.getString(6)%><br />
                                       
                                        <%
                                           }
                                       }                
                        }
 catch(Exception ex)
                 {
     session.setAttribute("fb", ex.toString());
                    }
                                        %>
                                        
                                    </p>
                                           
                             </div>                   
                                <div style="float:left;margin-left:10px;width:250px;padding-left: 900px">
                                    <input name="finish" type="submit" value="FINISH MY EXAM" style="height:40px;width:230px;"/>
                                </div> 
                                         </form> 
                            </div>
                       
                       
             
          </div> 
            <div id="footer">Copyright © openGeeks <a href="#">@ SMVDU</a></div>

    </body>
</html>
