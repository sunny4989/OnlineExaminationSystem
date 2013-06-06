<%-- 
    Document   : timer
    Created on : Nov 28, 2011, 10:57:26 PM
    Author     : bandar
--%>


<!DOCTYPE html>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
 <html><head>  
 <script>  
 <!--  
 <%  
 String clock = request.getParameter( "clock" );  
 if( clock == null ) clock = "41110";  
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
 <body>  
 <form action="<%=request.getRequestURL()%>" name="forma"> 
     <input type="text" name="clock" value="<%=clock%>" style="border:0px solid white"> 
 Time remaining: <input type="text" name="hr" value="<%=hr%>" style="border:0px solid white;width:12px">  
 :  
 <input type="text" name="min" value="<%=min%>" style="border:0px solid white;width:13px">  
 : 
 <input type="text" name="sec" value="<%=sec%>" style="border:0px solid white;width:13px">  
   
 </form>  
 <script>  
 <!--  
 timer();  
//-->  
 </script>  
 </body></html> 