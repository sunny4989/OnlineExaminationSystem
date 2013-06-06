<%-- 
    Document   : student
    Created on : Nov 15, 2011, 4:20:59 PM
    Author     : Definately
--%>

<%@page import="javax.swing.JOptionPane"%>
<%@page import="oes.Check_Date"%>
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
                             boolean boo;
							%>
                                                            <%
if(session.isNew()==true)
       {    
              rd=request.getRequestDispatcher("index.jsp");
                rd.forward(request, response);
      
       }
%>
<%
String logout = request.getParameter("logout");
if(logout!=null)
       {
            
            session.invalidate();
            response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
            response.setHeader("Pragma","no-cache"); //HTTP 1.0
            response.setDateHeader ("Expires", 0);
            rd= request.getRequestDispatcher("index.jsp");
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
        
        <div id="menu_wrapper">
            <div id="menu">
                <ul class="navigation">
                    <li><a href="#home" class="selected">Home</a></li>
                    <li><a href="#"><span class="ui_icon aboutus"></span>Account </a></li>
                    <li><a href="#"><span class="ui_icon question"></span>Register</a></li>
                    <li><a href="#"><span class="ui_icon cancel"></span>Cancel</a></li>
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
                      <div class="col_550 float_l" style="overflow: auto">
                            <h1>Current Exam schedule :</h1>   
                            <table>
                                          <tr> <p>  
                                                   
                                                  <td>DATE</td>
                                                  <td>time</td>
                                                  <td>subject</td>
                                              </p> 
   </tr>
                                  <%
                                
             String username = session.getAttribute("user").toString();
                try
                {
                Class.forName("com.mysql.jdbc.Driver");
                
                con = DriverManager.getConnection(constr, "root", "java");
                pst = con.prepareStatement("select schedule.date,schedule.time,schedule.subject,schedule.tLimit,schedule.examId from schedule where schedule.examId in (select examId from  exam_student where iduser='"+username+"')and date>=CURDATE()   order by date,time; ");
                rs=pst.executeQuery();     
              //application.setAttribute("StartTime", rs.getString(3));
              Check_Date cd = new Check_Date();
              if(rs.next())
                                   {
                 boo = cd.check(rs.getString(1).toString(), rs.getString(2).toString());
                 //   System.out.println("Hello World "+rs.getString(1)+rs.getString(2)+boo); 
                      session.setAttribute("examId", rs.getString(5));
                   application.setAttribute("timeLimit", rs.getString(4));
                   application.setAttribute("startTime", rs.getString(2));
                    
                    if(boo)
             {
%>  
                          <form id="startExam" name="form1" method="post" action="setPaper.jsp">
                              <p> Click to start Exam:</p><input name="startExam" type="submit" value="START" />
                            </form> 
<%                         
             }
                    }
              pst=null;
              pst = con.prepareStatement("select schedule.date,schedule.time,schedule.subject,schedule.tLimit from schedule where schedule.examId in (select examId from  exam_student where iduser='"+username+"') order by date,time; ");
                rs=pst.executeQuery();
                   while(rs.next())
                        {
   %>                 
   <tr>
       <td><%= rs.getString(1)%></td>   
     <td><%= rs.getString(2) %></td>
     <td><%= rs.getString(3) %></td>     
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
                                rs=null;
                              pst =null;
                              st=null;
                              con.close();
                              
                         }
                catch (Exception ignore) {
                }
         }
               
                                  %>
                                      </table>
                                    
                      </div>
                        
                                      <div class="col_300 float_r" style="overflow: auto">
                                          <h1>Past Exam Results:</h1>
                         
                            <table>
                                          <tr> <p>  
                                                   
                                                  <td>DATE</td>
                                                  <td>time</td>
                                                  <td>RESULT</td>
                                              </p> 
   </tr>
                                  <%
                                
           
             try
                {
                Class.forName("com.mysql.jdbc.Driver");
                
                con = DriverManager.getConnection(constr, "root", "java");
                pst = con.prepareStatement("select schedule.date,schedule.subject,status from schedule,exam_student where schedule.examId = exam_student.examId  and iduser='"+username+"')order by date ");
                rs=pst.executeQuery();
                 
                while(rs.next())
                        {
   %>                 
   <tr>
     <td><%= rs.getString(1) %></td>   
     <td><%= rs.getString(2) %></td>
     <td><%= rs.getString(3) %></td>
     
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
                                rs=null;
                              pst =null;
                              st=null;
                              con.close();
                              
                         }
                catch (Exception ignore) {
                }
         }
               
                                  %>
                                      </table>
                          <p><br>
                         <a href="#help" class="navigation"><span class="ui_icon help"></span></a></p>
                        </div>
                    </div> 
                    
                     <div class="panel" id="aboutus">
                         <h1>&nbsp;</h1>
                          <div class="cleaner_h30">
                              <p style="font-size:24px">Account Setting :</p>
                                  <form action="updateAccount" method="post">
                                     <table width="61%" align="center">
                                        <tr>
                                          <th width="54%" align="right" scope="row">*PASSWORD :&nbsp;</th>
                                          <td width="46%"><input name="password" type="text" class="input_field" id="password" /></td>
                                        </tr>
                                        <tr>
                                          <th align="right" scope="row">*CONFIRM PASSWORD :</th>
                                          <td><input name="confirmpPssword" type="password" class="input_field" id="confirmPassword" /></td>
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
                
                  <div class="panel" id="question" style="overflow:auto;padding-left: 200px;" >
                    <p><table>
                    <td>
                    <th>
                            <h1>Current Exam schedule :</h1> 
                            <p>
                            
                                                        <table>
                                                            <tr>
                               <td>EXAM ID</td>
                               <td>DATE</td>
                               <td>TIME</td>
                               <td>SUBJECTS</td>
                               
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
                               <td><%= rs.getString(4) %></td>
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
                                      pst =null;
                                      st= null;
                                      con.close();
                                 }
                        catch (Exception ignore) {
                        }
                 }
                                                        %>
                                                        </table>
                            </p>
                        <th>
                        <td>
                        <form action="addExam_stu" method="post">

                      
<div class="col_380 float_r"style="width: auto" >
                        <h1>Enter the  examId for which you want to be enrolled :<br />
                            
                          <input type="text" name="addExam" id="cancel_id" />
                        </h1>
                       
                <label for="cancel_id"></label>
                          <input type="submit" name="addExam" id="add" value="ADD" />
                        </form>
                        </td>
                        </table>
                        
                  </div>
                
                    
                         <div class="panel" id="cancel" style="overflow:auto;width: auto" >
                    <p><table>
                    <td>
                    <th>
                            <h1>Current Exam schedule :</h1> 
                            <p>
                            
                                                        <table>
                                                            <tr>
                               <td>EXAM ID</td>
                               <td>DATE</td>
                               <td>TIME</td>
                               <td>SUBJECTS</td>
                               
                           </tr>    
                                                                <%
                    try
                        {
                        Class.forName("com.mysql.jdbc.Driver");

                        con = DriverManager.getConnection(constr, "root", "java");
                        String query="select exam_student.examId,schedule.date,schedule.time,schedule.subject from schedule,exam_student where CURDATE()<schedule.date and exam_student.examId = schedule.examId and iduser='"+username+"'order by date,time;";
                        st=con.createStatement();
                        rs=st.executeQuery(query);
                        
                       while(rs.next())
                            {
                           %>
                           <tr ><strong>
                               
                               <td><%= rs.getString(1)%></td>
                               <td><%= rs.getString(2)%></td>
                               <td><%= rs.getString(3)%></td>
                               <td><%= rs.getString(4) %></td>
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
                        <th>
                        <td>
                      <form action="cancel_exam_stu" method="post">
                      
                          <div class="col_380 float_r" style="width: auto;overflow: auto" >
                        <h1>Enter examId to Delete:<br />
                          <input type="text" name="cancel_id" id="cancel_id" />
                        </h1>
                       <input type="submit" name="cancel" id="cancel" value="CANCEL" />
                        </form>
                       
                        </td>
                        </table>
                        
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
