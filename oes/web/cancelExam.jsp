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
<%!
                            RequestDispatcher rd;
                            Connection con ;
                            PreparedStatement pst = null;
                            Statement st;
                            ResultSet rs = null;
                            String constr = "jdbc:mysql://localhost:3306/oes";
							%>

<%
response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
            response.setHeader("Pragma","no-cache"); //HTTP 1.0
            response.setDateHeader ("Expires", 0);
%>
  <%
if(session.isNew()==true)
       { 
       rd=request.getRequestDispatcher("index.jsp");  
              rd.forward(request, response);
        }      
   if(session.getAttribute("type")=="student")
                               {
              rd=request.getRequestDispatcher("student.jsp");  
              rd.forward(request, response);
                           }
 

%>

</head>
<body>
	
    <div id="slider">
    	
        <div id="header_wrapper">
            <div id="header">
                <a href="#home"><img src="images/templatemo_logo.png" alt="Wall Shelf" /></a>
            </div>
		</div>
        
        <div id="menu_wrapper" style="overflow:auto ">
             <div style="text-align: center">
                                      <a href="admin.jsp" target="_self"><h1 >HOME</h1></a>   <%
                            out.write("<center><strong>");
                            out.write("<font color=\"Red\">");
                        if(!(session.getAttribute("fb")==null))
                            out.write(session.getAttribute("fb").toString());
                            out.write("</font>");
                            out.write("</strong></center>");
                            %>
</div>
                   
            <div id="content_wrapper">
              <div id="content" style="padding-top:40px  ;vertical-align:auto !important";>
              <form action="" method="post"><p>   
                      ENTER EXAMID TO BE CANCELED :</p> <input name="examId" type="text" /><br />
             <input name="examId" type="submit" />
              </form>
               <div class="col_550 float_l" style="overflow:auto">
                            <h1>Current Exam schedule :</h1> 
                            <p>
                            
                                                        <table>
                                                            <tr><p>
                                <td>EXAMID</td>
                               <td>DATE</td>
                               <td>TIME</td>
                               <td>SUBJECTS</td>
                                                                </p>
                           </tr>
                                                                <%
                    try
                        {
                        Class.forName("com.mysql.jdbc.Driver");

                        con = DriverManager.getConnection(constr, "root", "java");
                        String query="select examId,date,time,subject from schedule where CURDATE()<schedule.date order by date,time;";
                        st=con.createStatement();
                        rs=st.executeQuery(query);
                        
                       while(rs.next())
                            {
                           %>
                           <tr ><strong>
                               <td><%= rs.getString(1)%></td>
                               <td><%= rs.getString(2)%></td>
                               <td><%= rs.getString(3)%></td>
                               <td><%= rs.getString(4)%></td>
                               </strong>
                           </tr>
                           <%
                                
                            }
                        }
                    catch(Exception ex)
                        {
                         session.setAttribute("fb", "Problem accessing security realm. try later");
                         rd = request.getRequestDispatcher("studentRegisteration.jsp");
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
                                                        %>
                                                        </table>
                            </p>
                        </div>
              </div> 
            </div> 
       
        </div>
        </div>
        <div id="footer">Copyright © openGeeks <a href="#">@ SMVDU</a></div>
      

</body>
</html>
