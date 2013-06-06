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
<style type="text/css">
#slider #menu_wrapper form table tr th div div strong {
	color: #FFFFFF;
	font-size: 18px;
}
</style>
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
</head>
<body>
	
    <div id="slider">
    	
        <div id="header_wrapper">
            <div id="header">
                <a href="#home"><img src="images/templatemo_logo.png" alt="Wall Shelf" /></a>
            </div>
		</div>
        
        <div id="menu_wrapper">
         
          <form action="studentRegistration" method="post">              
		<div id="content_wrapper">
                     <div> <%
	out.write("<center><strong>");
	out.write("<font color=\"Red\">");
    if(!(session.getAttribute("fb")==null))
        out.write(session.getAttribute("fb").toString());
        out.write("</font>");
	out.write("</strong></center>");
%>
    </div>
        <div id="content" style=";vertical-align:auto !important";>
        
         <table width="61%" align="center">
  <tr>
    <th scope="row"><div>
      <div><strong>Sign Up</strong></div>
      <div><strong>It's free and always will be.</strong></div>
    </div></th>
    
  </tr>
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
      <tr>
    <th align="right" scope="row">SECURITY CODE :</th>
    <td><input name="security" type="text" class="input_field" id="security" /></td>
  </tr>
  <tr>
    <th colspan="2" scope="row"><input name="studentRegister" type="submit" class="btn_more" id="studentRegister" value="Submit" /></th>
  </tr>
</table>

        </div> 
        
</div> 
        </form>
        <div id="footer">Copyright © openGeeks <a href="#">@ SMVDU</a></div>
    
   </div>
        </div>

</body>
</html>
