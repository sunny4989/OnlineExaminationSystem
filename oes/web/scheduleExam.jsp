<%-- 
    Document   : scheduleExam
    Created on : Nov 16, 2011, 3:43:42 PM
    Author     : Definately
--%>

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
        <%
            RequestDispatcher rd;
            if (session.isNew() == true) {

                rd = request.getRequestDispatcher("index.jsp");
                rd.forward(request, response);
            }
            if (session.getAttribute("type") == "student") {
                rd = request.getRequestDispatcher("student.jsp");
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


                <div id="content_wrapper">
                    <div style="text-align: center"> 
                        <p>
                            <a href="admin.jsp" target="_self"><h1>HOME</h1></a>
                            <%
                                out.write("<center><strong>");
                                out.write("<font color=\"Red\">");
                                if (!(session.getAttribute("fb") == null)) {
                                    out.write(session.getAttribute("fb").toString());
                                }
                                out.write("</font>");
                                out.write("</strong></center>");
                            %> 

                        </p>

                    </div>
                    <form action="scheduleExam" method="post">    
                        <div id="content" style="padding-top:40px  ;vertical-align:auto !important"><p>Schedule A Exam:</p>
                            <p>Subject:
                                <label>
                                    <input type="radio" name="subjects" value="computer" id="subjects_0" checked="checked"/>
                                    programming language</label>

                                <label>
                                    <input type="radio" name="subjects" value="query" id="subjects_1" />
                                    Query language</label>

                                <label>
                                    <input type="radio" name="subjects" value="english" id="subjects_2" />
                                    English</label>

                                <label>
                                    <input type="radio" name="subjects" value="aptitude" id="subjects_3" />
                                    Aptitude</label>
                                <br />
                                Question Level:
                                <label>
                                    <input type="radio" name="level" value="easy" id="level_0" />
                                    Easy</label>

                                <label>
                                    <input type="radio" name="level" value="medium" id="level_1" checked="checked" />
                                    Medium</label>

                                <label>
                                    <input type="radio" name="level" value="hard" id="level_2" />
                                    Hard</label>
                                <br />
                                No. of Questions:  <input name="noq" type="text" />  <br />
                                Scheduled At:<br />
                                Date(yyyy-mm-dd): 
                                <input name="date" type="text" /><br/>
                                Time(HH:MM:SS):
                                <input name="time" type="text" /> <br/>
                                Time Limit(HH:MM:SS):<input name="Tlimit" type="text" />

                            </p>
                            <p>&nbsp;</p>
                            <input name="input" type="submit" style="padding-left:20px" value="Submit" />
                        </div> 

                </div> 
                </form>
                <div id="footer">Copyright © openGeeks <a href="#">@ SMVDU</a></div>

            </div> 

    </body>
</html>
