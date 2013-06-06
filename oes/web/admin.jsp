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

<script src="js/jquery-1.2.6.js" type="text/javascript"></script>
<script src="js/jquery.scrollTo-1.3.3.js" type="text/javascript"></script>
<script src="js/jquery.localscroll-1.2.5.js" type="text/javascript" charset="utf-8"></script>
<script src="js/jquery.serialScroll-1.2.1.js" type="text/javascript" charset="utf-8"></script>
<script src="js/coda-slider.js" type="text/javascript" charset="utf-8"></script>
<script src="js/jquery.easing.1.3.js" type="text/javascript" charset="utf-8"></script>

<style type="text/css">
#slider #content_wrapper #content .scroll .scrollContainer #home .col_300.float_r a {
	font-size: 18px;
}
#slider #content_wrapper #content .scroll .scrollContainer #home .col_300.float_r a {
	color: #FFC;
}
</style>
<%!
                            RequestDispatcher rd;
                            Connection con ;
                            PreparedStatement pst = null;
                            Statement st;
                            ResultSet rs = null;
                            String constr = "jdbc:mysql://localhost:3306/oes";
				JspWriter out ;			
                            %>
                            <%
                             response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
            response.setHeader("Pragma","no-cache"); //HTTP 1.0
            response.setDateHeader ("Expires", 0);

                            %>


</head>
<body>
    <p>
      <%
String logout = request.getParameter("logout");
if(logout!=null)
       {
            
            session.invalidate();
            rd= request.getRequestDispatcher("index.jsp");
            rd.forward(request, response);
        }
 
%>
      <%--
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
       }

--%>
</p>
     <div id="slider">
    	
        <div id="header_wrapper">
            <div id="header">
                <a href="#home"><img src="images/templatemo_logo.png" alt="Wall Shelf" /></a>
            </div>
		</div>
        
        <div id="menu_wrapper">
            <div id="menu">
                <ul class="navigation">
                    <li><a href="#home" class="selected">Schedule</a></li>
                    <li><a href="#"><span class="ui_icon aboutus"></span>Account </a></li>
                    <li><a href="#"><span class="ui_icon question"></span>Question</a></li>
                    
                    <li><a href="#"><span class="ui_icon contactus">Add User</span></a></li>
                   <li><form action="" method="post">
                    
                     <input name="logout" type="submit" value="logout" class="myButton"/>
                    </form>
                   
                    </li>
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
                          </div>
                          <div class="col_550 float_l" style="overflow:auto">
                            <h1>Current Exam schedule :</h1> 
                            <p>
                            
                                                        <table>
                                                            <tr>
                              
                               <td>DATE</td>
                               <td>TIME</td>
                               <td>SUBJECTS</td>
                               
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
                        
                        <div class="col_300 float_r">
                        <a href="scheduleExam.jsp">Schedule new exam :</a><br>
                       
                        <a href="cancelExam.jsp">Cancel Schedules exam :</a> </div>
                    </div> 
                    
                     <div class="panel" id="aboutus">
                         <h1>&nbsp;</h1>
                          <div class="cleaner_h30">
                              <p>Account Setting :</p>
                                  <form action="updateAccount" method="post">
                                     <table width="61%" align="center">
                                        <tr>
                                          <th width="54%" align="right" scope="row">*PASSWORD :&nbsp;</th>
                                          <td width="46%"><input name="password" type="password" class="input_field" id="password" /></td>
                                        </tr>
                                        <tr>
                                          <th align="right" scope="row">*CONFIRM PASSWORD :</th>
                                          <td><input name="confirmPassword" type="password" class="input_field" id="confirmPassword" /></td>
                                        </tr>
                                        <tr>
                                          <th align="right" scope="row">MOBILE NO. :</th>
                                          <td><input name="mobileNo" type="text" class="input_field" id="mobileNo" /></td>
                                        </tr>
                                        <tr>
                                          <th align="right" scope="row">EMAIL ID :</th>
                                          <td><input name="emailId" type="text" class="input_field" id="emailId" /></td>
                                        </tr>
                                        <tr>
                                          <th colspan="2" scope="row"><input name="studentRegister" type="submit" class="btn_more" id="studentRegister" value="Submit" /></th>
                                        </tr>
                                    </table>
                                  </form>
                          </div> 
                  
                    </div> 
                
                     <div class="panel" id="question">
                     ADD QUESTIONS:
                   	   <form action="addQuestion" method="post"><p>
                               <textarea name="question" cols="80" rows="4"></textarea><br/>
                                        options:<br />
                                        A.><textarea name="a" cols="40" rows="2" id="a"></textarea>
                                        B.><textarea name="b" cols="40" rows="2" id="b"></textarea><br/>
                                        C.><textarea name="c" cols="40" rows="2" id="c"></textarea>
                                        D.><textarea name="d" cols="40" rows="2" id="d"></textarea><br/>
                                        Answer :<input name="answer" type="checkbox" value="A"/>A
                                        <input name="answer" type="checkbox" value="B" />B
                                        <input name="answer" type="checkbox" value="C" />C
                                        <input name="answer" type="checkbox" value="D" />D<br />
                                    
                                    question level:
                         <label>
                                        <input type="radio" name="qestionLevel" value="easy" id="qestionLevel_0" />
                                        Easy</label>
                         <label>
                           <input type="radio" name="qestionLevel" value="medium" id="qestionLevel_1"  checked="checked"/>
                         Medium</label>
                                  
                                      <label>
                                        <input type="radio" name="qestionLevel" value="hard" id="qestionLevel_2" />
                                        Hard</label>
                                    <br />
                                 
                     
                                                     
                SUBJECTS:                                            <label>
                                                            <input type="radio" name="subject" value="computer" id="subject_0" checked="checked" />
                                                            Programming Language</label>
                                                     <label>
                                               <input type="radio" name="subject" value="query" id="subject_1" />
                                                            Query Language</label>
<label>
                                                            <input type="radio" name="subject" value="english" id="subject_2" />
                                                            English</label>
<label>
                  <input type="radio" name="subject" value="aptitude" id="subject_3" />
                                                            Aptitude</label>
                                                          <br />
                                                       
                                   <input name="addQuestion" type="submit" value="Submit" />
                         </p>
                       </form>
                         
                     <a href="deleteQuestion.jsp" target="_new"  >Whann remove Any Previous Question</a>
                    </div>
                
                    
                    <div class="panel" id="contactus" style="overflow:auto ">
                    	<h1><strong>ADD NEW EXAMINER :</strong></h1>
                              <form action="examinerRegistration" method="post">              
                              <div id="content_wrapper">
                              <div id="content" style=";vertical-align:auto !important";>
                                  <table width="61%" align="center">
                                    <tr>
                                      <th width="54%" align="right" scope="row">*USERNAME :</th>
                                      <td width="46%"><label for="username"></label>
                                        <input name="username" type="text" class="input_field" id="username" /></td>
                                    </tr>
                                    <tr>
                                      <th align="right" scope="row">*PASSWORD :&nbsp;</th>
                                      <td><input name="password" type="password" class="input_field" id="password" /></td>
                                    </tr>
                                    <tr>
                                      <th align="right" scope="row">*CONFIRM PASSWORD :</th>
                                      <td><input name="confirmPassword" type="password" class="input_field" id="confirmPassword" /></td>
                                    </tr>
                                    <tr>
                                      <th align="right" scope="row">*NAME :&nbsp;</th>
                                      <td><input name="name" type="text" class="input_field" id="name" /></td>
                                    </tr>
                                    <tr>
                                      <th align="right" scope="row">*SEX :&nbsp;</th>
                                      <td><input name="sex" type="text" class="input_field" id="sex" maxlength="7" /></td>
                                    </tr>
                                    <tr>
                                      <th height="65" align="right" scope="row">*ADDRESS :</th>
                                      <td><textarea name="address" class="input_field" id="address"></textarea></td>
                                    </tr>
                                    <tr>
                                      <th align="right" scope="row">MOBILE NO. :</th>
                                      <td><input name="mobileNo" type="text" class="input_field" id="mobileNo" /></td>
                                    </tr>
                                    <tr>
                                      <th align="right" scope="row">EMAIL ID :</th>
                                      <td><input name="emailId" type="text" class="input_field" id="emailId" /></td>
                                    </tr>
                                    <tr>
                                    <th align="right" scope="row">*SECURITY CODE :</th>
                                    <td><input name="security" type="text" class="input_field" id="security" /></td>
                                    </tr>
                                    <tr>
                                      <th colspan="2" scope="row"><input name="studentRegister" type="submit" class="btn_more" id="studentRegister" value="Submit" /></th>
                                    </tr>
                                  </table>
                              </div> 
                              </div> 
                              </form>
                    
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
