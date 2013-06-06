<%-- 
    Document   : forgotPWD
    Created on : Nov 14, 2011, 5:51:44 PM
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
if(session.isNew()==false)
       {    
          RequestDispatcher rd;
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
<head>
<body>
	
    <div id="slider">
    	
        <div id="header_wrapper">
            <div id="header">
                <a href="#home"><img src="images/templatemo_logo.png" alt="Wall Shelf" /></a>
            </div>
		</div>
        
        <div id="menu_wrapper" style="overflow:auto ">
         
              
             <div id="content_wrapper">
              <div id="content" style="padding-top:40px  ;vertical-align:auto !important";>
               <div style="text-align: center"> <%
                            out.write("<center><strong>");
                            out.write("<font color=\"Red\">");
                        if(!(session.getAttribute("fb")==null))
                            out.write(session.getAttribute("fb").toString());
                            out.write("</font>");
                            out.write("</strong></center>");
                            %>
                          </div>
                          
               <table width="58%" align="center"><p>
  <tr>
    <th align="right" scope="row">&nbsp;
    <form action="" method="post">              
            <div id="content_wrapper">
              <p>
              USERNAME :
              <input name="username" type="text" /><br/>
              SEQURITY CODE :
              <input name="securityCode" type="text" /><br/>
              NEW PASSWORD :
              <input name="password" type="password" />
              <br/>CONFIRM PASSWORD :
              <input name="confirmPasword" type="password" /><br />
              <input name="submit" type="submit" value="Submit" />
               </form>
    </th>
  </tr></p>
</table>
        
             </div> 
            </div> 
                   

              
    </div> 
      </div> 
       
</div>
    
        <div id="footer">Copyright © openGeeks <a href="#">@ SMVDU</a></div>
      

</body>
</html>
