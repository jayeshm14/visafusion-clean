<%@ Language=VBScript %>
<!-- #include file="connection.asp" -->
<% response.buffer=true 
if session("uname")="" then
response.clear
response.redirect "relogin.asp?rsn=V"
end if
if session("priv")="" then
response.clear
response.redirect "relogin.asp?rsn=V"
end if

%>
<html>
<head>
<title>www.udaanindia.com</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script language="javascript">
<!--

function checkAll()
{
getrooms1=document.hotel.rooms.value
getdays1=document.hotel.days.value
gettariff1=document.hotel.tariff.value
getmisc1=document.hotel.misc.value
transp1=document.hotel.transp.value
flag=0
msg=""
if (isNaN(getrooms1)) 
{
msg=msg+"PLEASE ENTER A VALID NUMBER IN THE ENTRIES OF ROOMS.\n"
flag=1
}

if (isNaN(getdays1))
{
msg=msg+"PLEASE ENTER A VALID NUMBER IN THE ENTRIES OF DAYS.\n"
flag=1
}
if (isNaN(gettariff1))
{
msg=msg+"PLEASE ENTER A VALID NUMBER IN THE ENTRIES OF TARIFFS.\n"
flag=1
}
if (isNaN(getmisc1))
{
msg=msg+"PLEASE ENTER A VALID NUMBER IN THE ENTRIES OF MISC.\n"
flag=1
}
if (isNaN(transp1))
{
msg=msg+"PLEASE ENTER A VALID NUMBER IN THE ENTRIES OF TRANSPORTATION.\n"
flag=1
}

if (flag==1)
{
alert(msg)
return false;
}

}
-->
</SCRIPT>

</head>

<body bgcolor="#FFFFFF"  topmargin=0 leftmargin=0 marginwidth=0 marginheight=0 >
<table width="75%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td>
      <table width="75%" border="0" cellpadding="0" cellspacing="0">
        <tr valign="top" align="center">
         
          <td width="98%"> 
            <table width="75%" border="0" cellspacing="0" cellpadding="0">
              <tr valign="top" align="left"> 
                <td><!-- #include file="top.asp" --></td>
              </tr>
			</table>
             
                
<table width="100%" border="0" cellspacing="0" cellpadding="0"  align="center">
	<tr><td>
		<%
         if request("msgID")="1" then 
                   response.write "<font color='#0000FF' size='2' face='Arial, Helvetica, sans-serif'><b> The information regarding "&ucase(request("pname"))&" added successfully.</b></font>"
                   End if
                 
         	 %>  
          </td></tr>
<tr><td align="center"><STRONG><FONT color=mediumblue face=Arial size=4>HOTEL INFORMATION</FONT></STRONG></td></tr></table>

         <%
          agentid=request("agent")
          refno=cdbl(request("refno"))
          set rs=server.createobject("adodb.recordset")
          stmt="select * from paxhotel where refno="& refno
          rs.open stmt,con
          if not rs.eof then         
        

hotelname=rs.fields("hotelname")

days=rs.fields("nosofdays")
tariff=rs.fields("tariff")
transportation=rs.fields("transportation")
misc=rs.fields("misccharges")
total=rs.fields("total")
arrivalt=rs.fields("arrivaltime")
arrivald=SysToUsrDate(rs.fields("arrivaldate"))
departuret=rs.fields("departtime")
departured=SysToUsrDate(rs.fields("departdate"))
flightdetail=rs.fields("flightdetail")
flightstatus=rs.fields("flightstatus")
noofrooms=rs.fields("noofrooms")

end if

%>
   <form action="hotelSubmit.asp" method="post" name="hotel" onsubmit="return checkAll()">
        <table width="80%" border="1" cellspacing="0" cellpadding="0"  align="center">
 <tr> 
              <td align="left">

           <input type="hidden" name="refno" value="<%= refno%>" >
           <input type="hidden" name="agentid" value="<%= agentid%>" >
           <input type="hidden" name="cmd" value="<%= request("cmd")%>" >
<input type="hidden" name="page" value="<%= request("page")%>" >  
           <font color="#0000FF" size="2" face="Arial, Helvetica, sans-serif"><b>
              PAX NAME</b></font></TD>
              <td align="left"> <font color="#0000FF" size="2" face="Arial, Helvetica, sans-serif"><b> 
                <% if request("msgID")="1" then %>
                   <input type="text" name="name" size="20" value="<%=request("pname")%>">
               <%    else  %>
                   <input type="text" name="name" size="20" value="<%=request("N")%>">
               <%    End if   %>
                </b></font></td>
              <td align="left"><font color="#0000FF" size="2" face="Arial, Helvetica, sans-serif"><b>Hotel Name</b></font></TD>
              <td align="left"><font color="#0000FF" size="2" face="Arial, Helvetica, sans-serif"><b><select size=1  name="hotelname" >
                                              <%
Call LoadListBox("hotel",0)
                 %></b></font></td>
            </tr>
            
              
            <tr> 
              <td colspan="2" align="left"><font color="#0000FF" size="2" face="Arial, Helvetica, sans-serif" color=#C35068><b><font size=2 face='arial' color=#C35068>
              ARRIVAL/DEPARTURE INFORMATION</font></b></font></td>
              <td colspan="" align="left"><font color="#0000FF" size="2" face="Arial, Helvetica, sans-serif"><b></b></font></td>
              <td align="left"><font color="#0000FF" size="2" face="Arial, Helvetica, sans-serif"><b></b></font></td>
            </tr>
            <tr> 
              <td colspan="" align="left"><font color="#0000FF" size="2" face="Arial, Helvetica, sans-serif"><b>
              ARRIVAL DATE</b></font></td>
              <td align="left"> <font color="#0000FF" size="2" face="Arial, Helvetica, sans-serif"><b> 
                <input type="text" name="arrivaldate" value="<%=arrivald%>" size="10" >
                </b></font></td>
              <td colspan="" align="left"><font color="#0000FF" size="2" face="Arial, Helvetica, sans-serif"><b> 
                ARRIVAL TIME :</b></font></td>
              <td align="left"> <font color="#0000FF" size="2" face="Arial, Helvetica, sans-serif"><b> 
                <input type="text" name="arrivalt" size="10" value="<%=arrivalt%>"  colspan="2">
                </b></font></td>
            </tr>
            <tr> 
              <td colspan="" align="left"><font color="#0000FF" size="2" face="Arial, Helvetica, sans-serif"><b>
              DEPARTURE DATE</b></font></td>
              <td align="left"> <font color="#0000FF" size="2" face="Arial, Helvetica, sans-serif"><b> 
                <input type="text" name="depdate" value="<%=departured%>" size="10" >
                </b></font></td>
              <td colspan="" align="left"><font color="#0000FF" size="2" face="Arial, Helvetica, sans-serif"><b> 
                DEPARTURE TIME :</b></font></td>
              <td align="left"> <font color="#0000FF" size="2" face="Arial, Helvetica, sans-serif"><b> 
                <input type="text" name="deptime" value="<%=departuret%>" size="10"  colspan="2">
                </b></font></td>
            </tr>
           
            <tr> 
              <td colspan="" align="left"><font color="#0000FF" size="2" face="Arial, Helvetica, sans-serif"><b>
              FLIGHT DETAILS</b></font></td>

              <td align="left" colspan="3"> <font color="#0000FF" size="2" face="Arial, Helvetica, sans-serif"><b> 
                <input type="text" name="flightdetail" value="<%=flightdetail%>" size="70" >
                </b></font></td></tr>
              <tr><td colspan="" align="left"><font color="#0000FF" size="2" face="Arial, Helvetica, sans-serif"><b>
              FLIGHT STATUS</b></font></TD>
              <td align="left" colspan="3"> <font color="#0000FF" size="2" face="Arial, Helvetica, sans-serif"><b> 
                <input type="text" name="flightstatus" value="<%=flightstatus%>" size="30" >
                </b></font></td>
            </tr>
            <tr> 
              <td align="left"><font color="#0000FF" size="2" face="Arial, Helvetica, sans-serif" color="#C35068"><b><font size=2 face='arial' color=#C35068>Charges</font></b></font></td>
              <td align="left"><font color="#0000FF" size="2" face="Arial, Helvetica, sans-serif"><b></b></font></td>
              <td align="left"><font color="#0000FF" size="2" face="Arial, Helvetica, sans-serif"><b></b></font></td>
              <td align="left"><font color="#0000FF" size="2" face="Arial, Helvetica, sans-serif"><b></b></font></td>
            </tr>
            
             <tr> 
              <td colspan="" align="left"><font color="#0000FF" size="2" face="Arial, Helvetica, sans-serif"><b>
              NUMBER OF ROOMS</b></font></td>
              <td align="left"> <font color="#0000FF" size="2" face="Arial, Helvetica, sans-serif"><b> 
                <input type="text" name="rooms" value="<%=noofrooms%>"    size="10" >
                </b></font></td>
              <td align="left"><font color="#0000FF" size="2" face="Arial, Helvetica, sans-serif"><b>
              NO.OF DAYS</b></font></td>
              <td align="left"> <font color="#0000FF" size="2" face="Arial, Helvetica, sans-serif"><b> 
                <input type="text" name="days" value="<%=days%>"  size="10" >
                </b></font></td>
            </tr>
            <tr> 
              <td align="left"><font color="#0000FF" size="2" face="Arial, Helvetica, sans-serif"><b>TARIFF/DAY</b></font></td>
              <td align="left"> <font color="#0000FF" size="2" face="Arial, Helvetica, sans-serif"><b> 
                <input type="text" name="tariff"  value="<%=tariff%>"  onblur="add2Total()" size="10" >
                </b></font></td>
                
              <td align="left"><font color="#0000FF" size="2" face="Arial, Helvetica, sans-serif"><b>ROOM CHARGES</b></font></td>
              <td align="left"> <font color="#0000FF" size="2" face="Arial, Helvetica, sans-serif"><b> 
                <input type="text" name="roomtotal"  value="<%= noofrooms*days*tariff %>" onblur="add2Total()" size="10" readonly >
                </b></font></td>
            </tr>
            <tr> 
            <td align="left"><font color="#0000FF" size="2" face="Arial, Helvetica, sans-serif"><b>TRANSPORTATION</b></font></td>
              <td align="left"> <font color="#0000FF" size="2" face="Arial, Helvetica, sans-serif"><b> 
                <input type="text" name="transp"  value="<%=transportation%>" onblur="add2Total()" size="10" >
                </b></font></td>
              <td align="left"><font color="#0000FF" size="2" face="Arial, Helvetica, sans-serif"><b>&nbsp;</b></font></td>
              <td align="left"> <font color="#0000FF" size="2" face="Arial, Helvetica, sans-serif"><b> 
                &nbsp;
                </b></font></td>
              
            </tr>
            <tr> 
              <td align="left"><font color="#0000FF" size="2" face="Arial, Helvetica, sans-serif"><b>MISC 
                CHARGES</b></font></td>
              <td align="left""left"> <font color="#0000FF" size="2" face="Arial, Helvetica, sans-serif"><b> 
                <input type="text" name="misc" value="<%=misc%>" onblur="add2Total()" size="10" >
                </b></font></td>
              <script language="javascript">
				function add2Total()
				{
				
				var roomtotal=parseFloat(document.hotel.roomtotal.value);
				if (isNaN(roomtotal)) 
				{
				roomtotal=0;
				}
				var rooms=parseFloat(document.hotel.rooms.value);
				if (isNaN(rooms)) 
				{
				rooms=0;
				}
				var days=parseFloat(document.hotel.days.value);
				if (isNaN(days)) 
				{
				days=0;
				}
				
				
				var tariff=parseFloat(document.hotel.tariff.value);
				if (isNaN(tariff)) 
				{
				tariff=0;
				}
				
				
				var misc=parseFloat(document.hotel.misc.value);
				if (isNaN(misc)) 
				{
				misc=0;
				}
				var transp=parseFloat(document.hotel.transp.value);
				if (isNaN(transp)) 
				{
				transp=0;
				}
							
				document.hotel.roomtotal.value= eval(days*rooms*tariff);
				document.hotel.total.value= eval(misc+transp+roomtotal);
				
				}    
		</script>
              
              
              
              <td align=><font color="#0000FF" size="2" face="Arial, Helvetica, sans-serif"><b>TOTAL</b></font></td>
              <td align="left"> <font color="#0000FF" size="2" face="Arial, Helvetica, sans-serif"><b> 
                <input type="text" name="total" value="<%=total%>" size="10" readonly>
                <input type="hidden" name="oldtotal" value="<%=total%>" >
                </b></font></td>
            </tr>
            <tr> 
              
              <td  colspan="6" ALIGN="right"> 
                <div align="center"><font face="Arial, Helvetica, sans-serif"> 
<% if session("priv")="adm" then %>
                  <input type="submit" name="submit" value="SUBMIT"size="10">
<% end if %>
                  <input type="submit" name="submit" value="RESET"size="10">
                  <input type="submit" name="submit" value="CANCLE"size="10">
                  </font></div>
              </td>
            </tr>

          <tr>
                <td></td>
          
    </tr>
        </table>
          </form>
</td></tr></table>
<!-- #include file="empBottom.asp" -->
</body>
</html>
 
    
    
    
    
    
    
  
  
  
  