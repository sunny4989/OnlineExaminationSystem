/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package oes;

import java.util.Calendar;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.StringTokenizer;
import javax.swing.JOptionPane;
/**
 *
 * @author Definately
 */
public class Check_Date {
     public boolean check(String Date , String time)
     {
        Calendar cal = new GregorianCalendar();
        int month = cal.get(Calendar.MONTH);
        int year = cal.get(Calendar.YEAR);
        int day = cal.get(Calendar.DAY_OF_MONTH);
        month++;
        System.out.println("Current date : " + day + "/" + (month + 1) + "/" + year);
        Calendar currentDate = Calendar.getInstance();
        SimpleDateFormat formatter_hour= new SimpleDateFormat("HH");
        SimpleDateFormat formatter_minute = new SimpleDateFormat("mm");
        SimpleDateFormat formatter_second= new SimpleDateFormat("ss");
        String t_hour = formatter_hour.format(currentDate.getTime());
        String t_minute = formatter_minute.format(currentDate.getTime());
        String t_second = formatter_second.format(currentDate.getTime());
        System.out.println("Now the date is :=>  " + t_hour + t_minute + t_second );
        int hour = Integer.parseInt(t_hour);
        int minute = Integer.parseInt(t_minute);
        int second = Integer.parseInt(t_second);
        System.out.println(hour +" " + minute+" "+ second );
         StringTokenizer st = new StringTokenizer(Date, "-");
         String str[] = new String[3];
         int i = 0; 
         while( st.hasMoreTokens())
                 {
                     str[i] = st.nextToken();
                     i++;
                 }
         StringTokenizer st2 = new StringTokenizer(time, ":");
         String str2[] = new String[3];
          i = 0; 
         while( st2.hasMoreTokens())
                 {
                     str2[i] = st2.nextToken();
                     i++;
                 }
         
       //  System.out.println(str[0]+" "+str[1]+" "+str[2]+ " "+str2[0]_);/*
         int d_year = Integer.parseInt(str[0]);
         int d_month =Integer.parseInt(str[1]);
         int d_day = Integer.parseInt(str[2]);
         int time_h = Integer.parseInt(str2[0]);
         int time_m = Integer.parseInt(str2[1]);
         System.out.println(time_h +" "+ hour + " "+time_m+" "+minute);
       
         if( (day == d_day) && ( month == d_month ) && ( year == d_year) )
         {
             if( (time_h <= hour )&& (time_m <= minute ))
             {
                 return true;
                // JOptionPane.showMessageDialog(null, "BONGO U R SUCCEDDED");
             }
             else
         {
             return false;
             //JOptionPane.showMessageDialog(null,"time is yet to be arrived ");
         }
         }
         else
         {
             return false;
           //JOptionPane.showMessageDialog(null, " Date is yet to be arrived ");   
         }
  
      }
  
   static  public int convertTime( String time )
     {
         Calendar currentDate = Calendar.getInstance();
         SimpleDateFormat formatter_hour= new SimpleDateFormat("HH");
        SimpleDateFormat formatter_minute = new SimpleDateFormat("mm");
        SimpleDateFormat formatter_second= new SimpleDateFormat("ss");
        String t_hour = formatter_hour.format(currentDate.getTime());
        String t_minute = formatter_minute.format(currentDate.getTime());
        String t_second = formatter_second.format(currentDate.getTime());
        System.out.println("Now the date is :=>  " + t_hour + t_minute + t_second );
        int hour = Integer.parseInt(t_hour);
        int minute = Integer.parseInt(t_minute);
        int second = Integer.parseInt(t_second);
        System.out.println(hour +" " + minute+" "+ second );
        int seconds = hour * 3600 + minute * 60 + second;
        return seconds;
     }
    // public static void main(String args[])
    // {
         //System.out.println(new Check_Date().check("2011-12-13","23:55:00"));
    //     System.out.println(new Check_Date().convertTime("1:55:10"));
   //  }
}
