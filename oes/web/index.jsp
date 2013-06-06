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

<script src="js/jquery-1.2.6.js" type="text/javascript"></script>
<script src="js/jquery.scrollTo-1.3.3.js" type="text/javascript"></script>
<script src="js/jquery.localscroll-1.2.5.js" type="text/javascript" charset="utf-8"></script>
<script src="js/jquery.serialScroll-1.2.1.js" type="text/javascript" charset="utf-8"></script>
<script src="js/coda-slider.js" type="text/javascript" charset="utf-8"></script>
<script src="js/jquery.easing.1.3.js" type="text/javascript" charset="utf-8"></script>

</head>
<body>
    
    <div id="slider">
    	
        <div id="header_wrapper">
            <div id="header">
                <a href="#home"><img src="images/templatemo_logo.png" alt="Wall Shelf" /></a>
            </div>
		</div>
        
        <div id="menu_wrapper">
            <div id="menu">
                <ul class="navigation">
                    <li><a href="#home" class="selected">Home<span class="ui_icon home"></span></a></li>
                    <li><a href="#">About<span class="ui_icon aboutus"></span></a></li>
                    <li><a href="#"><span class="ui_icon help"></span>HELP</a></li>
                    <li></li>
                    <li><a href="#">Contact<span class="ui_icon contactus"></span></a></li>
                   
                </ul>
            </div>
		</div>
                        
		<div id="content_wrapper">
        <div id="content">
        
            <div class="scroll">
                <div class="scrollContainer">
                
                    <div class="panel" id="home">
                        <div style="text-align: center"> <%
	out.write("<center><strong>");
	out.write("<font color=\"Red\">");
    if(!(session.getAttribute("fb")==null))
        out.write(session.getAttribute("fb").toString());
        out.write("</font>");
	out.write("</strong></center>");
%>
<%!
RequestDispatcher rd;
%>
<%
if(session.isNew()==false)
       {    
           
            if(session.getAttribute("type")=="admin")
                           {
                rd=request.getRequestDispatcher("admin.jsp");
                rd.forward(request, response);
                               }
            else if(session.getAttribute("type")=="student")
                               {
              rd=request.getRequestDispatcher("student.jsp");  
              rd.forward(request, response);
                           }
       }
               
%>
<%
if(session.isNew()==false)
       {    
           
            if(session.getAttribute("type")=="admin")
                           {
                rd=request.getRequestDispatcher("admin.jsp");
                rd.forward(request, response);
                               }
            else if(session.getAttribute("type")=="student")
                               {
              rd=request.getRequestDispatcher("student.jsp");  
              rd.forward(request, response);
                           }
       }
%>
    </div>
                    	<div class="col_550 float_l"  >
                            <h1>Online Examination System</h1>    
                            
                            <p><em>Online examination system is a product can be used for multiple choice questions .</em></p>
                            <p>This product can be used by universities and companies to take online exam.it is a open source product made by open geeks at smvdu.</p>
                            <div class="cleaner_h30" style="overflow:auto; height:170px; overflow-style:auto">
                            <h2>Latest Exam Schedule</h2>
                            <img src="images/templatemo_image_01.jpg" alt="image 01" class="image_wrapper image_fl" />
                            <p>
                            <%!
                     
                            Connection con ;
                            PreparedStatement pst = null;
                            Statement st;
                            ResultSet rs = null;
                            String constr = "jdbc:mysql://localhost:3306/oes";
							%>
                                                        <table>
                                                            <tr>
                                                                <p>
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
                        String query="select date,time,subject from schedule where CURDATE()<schedule.date order by date,time;";
                        st=con.createStatement();
                        rs=st.executeQuery(query);
                        
                       while(rs.next())
                            {
                           %>
                           <tr ><strong>
                              
                               <td><%= rs.getString(1)%></td>
                               <td><%= rs.getString(2)%></td>
                               <td><%= rs.getString(3)%></td>
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
                        
                        <div class="col_300 float_r">

                            <h2>Please Login</h2><form action="Login" method="post">
                            <p class="input_field" id="USERNAME">USERNAME :
                              <input type="text" name="USERNAME" id="USERNAME" />
                            </p>
                          <p class="input_field">PASSWORD :
                              <input name="PASSWORD" type="password" class="input_field" id="PASSWORD" />
                            </p>
                            <p class="input_field"><em> </em>
                              <input name="SIGNIN" type="submit" class="submit_button" id="SIGNIN" value="Sign in" />
                               </form>
                              <a href="forgotPWD.jsp" target="_self">forgot password </a></p>
                            <p class="input_field">
                            <a href="studentRegisteration.jsp" target="_self">CREATE AN ACCOUNT </a></p>
                            </p>
                           
                        </div>
                    </div> <!-- end of home -->
                    
                    <div class="panel" id="aboutus">
                        <h1>About Us</h1>
                       <p><em>Online examination system is a product can be used for multiple choice questions .</em></p>
                        <p>This product can be used by universities and companies to take online exam.it is a open source product made by open geeks at smvdu.</p>
                      <p>&nbsp;	</p>
                        <div class="cleaner_h30">
                          <p>This project is made by :</p>
                          <p >1<strong style="color:#FFFFFF">.Ranjan jha</strong>(2008ecs10) <br />
                          2<strong style="color:#FFFFFF">.Amarjeet kumar</strong>(2008ecs13)<br />
                          3.<span class="col_300"><strong style="color:#FFFFFF">Tushar singhal</strong></span>(2008ecs14) </p>
<p>under the guidance of<strong style="color:#FFFFFF"> Mr. Deo Prakash</strong>  (Assistant Proffesor ,SMVDU)</p>
                          <p>&nbsp;</p>
                        </div>
                     
                    </div>
                    
                    <div class="panel" id="help">
                    	<div class="col_380 float_l"></div>
                        <div class="col_380 float_r"></div>
                    </div>
                
                    
                    <div class="panel" id="contactus">
                    	<h1>Contact Us</h1>
          
                        
                        <div class="cleaner_h10"></div>
                                                
                        <div class="col_380 float_l">
                            <div id="contact_form">
                                <form method="post" name="contact" action="#">
                                    <label for="author">Name:</label> <input type="text" id="author" name="author" class="required input_field" />
                                    <label for="email">Email:</label> <input type="text" id="email" name="email" class="validate-email required input_field" />
                                    <label for="text">Message:</label> <textarea id="text" name="text" rows="0" cols="0" class="required"></textarea>
                                    <br />
                                    
                                    <input type="submit" class="submit_button" name="submit" id="submit" value="Send" onclick="alert('MESSAGE SEND')" />
                                    <input type="reset" class="submit_button" name="reset" id="reset" value="Reset" />
                            	</form>
                            </div>
						</div>
                        
                      <div class="col_380 float_r">
                        <h4>Mailing Address</h4>
                        <p>Room no.:H-207, <br />Vindyanchal Hostel ,<br />
                        SMVDU,Katra <br />j&k 182320
                        <br />Tel: 9797601194<br />
                                               </p>
</div>
                	</div>
                    
                </div>
            </div>
            
            <!-- end of scroll -->
        
        </div> <!-- end of content -->
        </div> <!-- end of content_wrapper -->
        <div id="footer">
       	Copyright © openGeeks <a href="#">@ SMVDU</a></div>
    
    </div> <!-- end of slider -->

</body>
</html>
