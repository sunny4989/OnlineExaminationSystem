/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package oes;

/**
 *
 * @author Definately
 */
public class temo {
    private String quest;
    private  String optionA ;
    private  String optionB ;
    private  String optionC ;
    private  String optionD ;
    private  String ans ;
    private String id;
    public temo(String str1,String str2,String str3,String str4,String str5,String str6,String str7)
   {
          setId(str1);
                   setQuest(str2);
                   
                   setOptionA(str3);
                   setOptionB(str4);
                   setOptionC(str5);
                   setOptionD(str6);
                  setAns(str7);
                  //set(i, element);
    }
    public void setId(String str)
    {
        this.id=str;
    }
    public void setQuest(String str)
    {
        this.quest=str;
    }
     public void setOptionA(String str)
    {
        this.optionA=str;
    }
      public void setOptionB(String str)
    {
        this.optionB=str;
    }
       public void setOptionC(String str)
    {
        this.optionC=str;
    }
        public void setOptionD(String str)
    {
        this.optionD=str;
    }
         public void setAns(String str)
    {
        this.ans=str;
    }
    
    public String getQuest()
    {
       return  this.quest;
    }
     public String getOptionA()
    {
       return  this.optionA;
    }
      public String getOptionB()
    {
       return  this.optionB;
    }
       public String getOptionC()
    {
       return  this.optionC;
    }
        public String getOptionD()
    {
       return  this.optionD;
    }
      public String getAns()
    {
       return  this.ans;
    }
        public String getId()
    {
       return  this.id;
    }
}
