<%-- 
    Document   : deleteQuestion
    Created on : Nov 17, 2011, 6:41:41 PM
    Author     : Definately
--%>

<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" %>
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
response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
            response.setHeader("Pragma","no-cache"); //HTTP 1.0
            response.setDateHeader ("Expires", 0);
%>
 <%!
                               RequestDispatcher rd;
                                Connection con ;
                                PreparedStatement pst = null;
                                Statement st;
                                ResultSet rs = null;
                                String constr = "jdbc:mysql://localhost:3306/oes";
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
       
        
                       
            <div id="content_wrapper"  style="overflow:auto ">
 <div style="text-align: center"> <%
                            out.write("<center><strong>");
                            out.write("<font color=\"Red\">");
                        if(!(session.getAttribute("fb")==null))
                            out.write(session.getAttribute("fb").toString());
                            out.write("</font>");
                            out.write("</strong></center>");
                            %>
                          </div>              <div id="content"  >
                           <form action="deleteQuestion" method="post">
                           <p>
                           Enter Question Id to be Deleted:
                           <input name="questionId" type="text" />
                            </p>
                           <input name="" type="submit" value="Submit" />
                           </form>
                             
                             
                              
                              <div style="overflow:auto"> <table>
                                          <tr> <p>  
     <td>QUESTION ID</td>   
     <td>QUESTION</td></p> 
   </tr>
                                  <%
                                
             
             try
                {
                Class.forName("com.mysql.jdbc.Driver");
                
                con = DriverManager.getConnection(constr, "root", "java");
                pst = con.prepareStatement("select * from question ");
                rs=pst.executeQuery();
                 
                while(rs.next())
                        {
   %>                 
   <tr>
     <td><%= rs.getString(1) %></td>   
     <td><%= rs.getString(2) %></td>
   </tr>

     <%         //JOptionPane.showMessageDialog(null,rs.getString(1));                   
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
                              rd = request.getRequestDispatcher("deleteQuestion.jsp");
                              rd.forward(request, response);
                         }
                catch (Exception ignore) {
                }
         }
               
                                  %>
                                      </table>
                              </div>
              </div> 
            </div> 
        
        </div>
        </div>
        <div id="footer">Copyright © openGeeks <a href="#">@ SMVDU</a></div>
      

</body>
</html>
