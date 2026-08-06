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
<script language="javascript">

function chKm()
{
  document.hotel.extrakms.value=document.hotel.standeredkms.value-document.hotel.actualkms.value;
}
function chHr()
{
document.hotel.extrahours.value=document.hotel.standeredhours.value-document.hotel.actualhours.value;
}
function totalv()
{
  if (document.hotel.extraamount.value == '')
    document.hotel.extraamount.value =0;
  if (document.hotel.noofday.value == '')
    document.hotel.noofday.value =0;
  if (document.hotel.ratesperday.value == '')
    document.hotel.ratesperday.value =0;
    
   document.hotel.total.value=parseFloat(document.hotel.extraamount.value)+parseFloat(document.hotel.ratesperday.value*document.hotel.noofday.value);
}

function checkAll()
{
stdkms=document.hotel.standeredkms.value
stdhrs=document.hotel.standeredhours.value
actualkms=document.hotel.actualkms.value
actualhrs=document.hotel.actualhours.value
extrakms=document.hotel.extrakms.value
extrahrs=document.hotel.extrahours.value
extraamount=document.hotel.extraamount.value
noofdays=document.hotel.noofday.value
rates=document.hotel.ratesperday.value

flag=0

msg=""
if (isNaN(stdkms)) 
{
msg=msg+"PLEASE ENTER A VALID NUMBER IN THE ENTRIES OF STANDERED KMS.\n"
flag=1
}

if (isNaN(stdhrs)) 
{
msg=msg+"PLEASE ENTER A VALID NUMBER IN THE ENTRIES OF STANDERED HOURS.\n"
flag=1
}
if (isNaN(actualkms)) 
{
msg=msg+"PLEASE ENTER A VALID NUMBER IN THE ENTRIES OF ACTUAL KMS.\n"
flag=1
}
if (isNaN(actualhrs)) 
{
msg=msg+"PLEASE ENTER A VALID NUMBER IN THE ENTRIES OF ACTUAL HOURS.\n"
flag=1
}
if (isNaN(extrakms)) 
{
msg=msg+"PLEASE ENTER A VALID NUMBER IN THE ENTRIES OF EXTRA KMS.\n"
flag=1
}
if (isNaN(extrahrs)) 
{
msg=msg+"PLEASE ENTER A VALID NUMBER IN THE ENTRIES OF EXTRA HOURS.\n"
flag=1
}
if (isNaN(extraamount)) 
{
msg=msg+"PLEASE ENTER A VALID NUMBER IN THE ENTRIES OF EXTRA AMOUNT.\n"
flag=1
}
if (isNaN(noofdays))
{
msg=msg+"PLEASE ENTER A VALID NUMBER IN THE ENTRIES OF DAYS.\n"
flag=1
}
if (isNaN(rates))
{
msg=msg+"PLEASE ENTER A VALID NUMBER IN THE ENTRIES OF RATES.\n"
flag=1
}


if (flag==1)
{
alert(msg)
return false;
}

}

</SCRIPT>

<html>
<head>
<title>www.udaanindia.com</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

</head>

<body bgcolor="#FFFFFF"  topmargin=0 leftmargin=0 marginwidth=0 marginheight=0 >
<table width="75%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td>
      <table width="75%" border="0" cellpadding="0" cellspacing="0">
        <tr valign="top" align="left">
          
          <td width="98%"> 
            <table width="75%" border="0" cellspacing="0" cellpadding="0">
              <tr valign="top" align="left"> 
                <td><!-- #include file="top.asp" --></td>
              </tr></table>
             
                
<table width="100%" border="0" cellspacing="0" cellpadding="0" name="hotels" align="center">
<tr><td><font face="Arial, Helvetica, sans-serif" size="2" color="#0000FF"><b> <% 
                   if request("msgID")="1" then 
                   response.write " The information regarding "&ucase(request("pname"))&" added successfully."
                   End if
                   
                   %></b></font><td><tr>
<tr><TD align=center><STRONG><FONT color=mediumblue face=Arial size=4>CABS INFORMATION</FONT></STRONG></TD></tr></table>

        <table width="84%" border="1" cellspacing="0" cellpadding="0" name="hotels" align="center">
          <form action="cabsrecord.asp" method="post" name="hotel" onsubmit="return checkAll()">
            <%
          refno=cdbl(request("refno"))
          agentid=cint(request("agent"))
          
          dim coolness
          coolness="ac"
          function checked(firstval,secondval)
          if firstval=secondval then
            checked="checked"
            end if
            end function
          
             dim travelling
          travelling="kms"
          function checked1(firstval,secondval)
          if firstval=secondval then
            checked1="checked"
            end if
            end function
          
          
          set rs=server.createobject("adodb.recordset")
          stmt="select * from paxcab where refno="& refno
          rs.open stmt,con
          if not rs.eof then         
        

'hotelname=rs.fields("hotelname")
name=rs.fields("name")
orderedby=rs.fields("orderedby")
cabowner=rs.fields("cabowner")
vehicalno=rs.fields("cabno")
vehical=rs.fields("vehical")
ac=rs.fields("ac")
if rs.fields("sdate") <> "" then
sdate=SysToUsrDate(rs.fields("sdate"))

end if
if rs.fields("enddate") <> "" then
enddate=SysToUsrDate(rs.fields("enddate"))
end if
from=rs.fields("startfrom")
dest=rs.fields("dest")
mode=rs.fields("mode")

stdkm=rs.fields("standeredkm")
stdhour=rs.fields("standeredhour")
actualhour=rs.fields("actualhour")
actualkm=rs.fields("actualkm")
extrakm=rs.fields("extrakm")
extrahour=rs.fields("extrahour")
extrainf=rs.fields("extrainfo")
extraamount=rs.fields("extraamount")

noofday=rs.fields("noofday")
total=rs.fields("total")
end if
%> 
            <tr> 
              <td align="left"><font face="Arial, Helvetica, sans-serif" size="2" color="#0000FF"><b> 
                <input type="hidden" name="refno2" value="<%= request("refno")%>" >
                <input type="hidden" name="agentid" value="<%= agentid%>" >
                <input type="hidden" name="cmd" value="<%= request("cmd")%>" >
<input type="hidden" name="page" value="<%= request("page")%>" >  
                </b>PASSENGER NAME</font></td>
              <td align="left"> <font face="Arial, Helvetica, sans-serif" size="2" color="#0000FF"> 
                
              <% if request("msgID")="1" then %>
                  <input type="text" name="name" size="20" value="<%=request("pname")%>">
				<% else %>
                   <input type="text" name="name" size="20" value="<%=request("N")%>">
                <% End if %>    

                
                </font></td>
              <td align="left"><font face="Arial, Helvetica, sans-serif" size="2" color="#0000FF">REFERED 
                BY </font></td>
              <td align="left"><font face="Arial, Helvetica, sans-serif" size="2" color="#0000FF"> 
                <input type="text" name="orderedby"   value="<%=orderedby %>" size="20" >
                </font> </td>
            </tr>
            <tr> 
              <td align="left"><font face="Arial, Helvetica, sans-serif" size="2" color="#0000FF">CAB 
                OWNER </font></td>
              <td align="left"><font face="Arial, Helvetica, sans-serif" size="2" color="#0000FF"> 
                <input type="text" name="cabowner"   value="<%=cabowner %>" size="20" >
                </font></td>
              <td align="left"><font face="Arial, Helvetica, sans-serif" size="2" color="#0000FF">VEHICAL 
                NO.</font></td>
              <td align="left"> <font face="Arial, Helvetica, sans-serif" size="2" color="#0000FF"> 
                <input type="text" name="vehicalno"  value="<%=vehicalno %>" size="20"  colspan="2">
                </font></td>
            </tr>
            <tr> 
              <td align="left" height="19"><font face="Arial, Helvetica, sans-serif" size="2" color="#0000FF">VEHICLE 
                TYPE </font></td>
              <td align="left" height="19"><font face="Arial, Helvetica, sans-serif" size="2" color="#0000FF"> 
                <select name="vehical">
                  <option value="AMB/NON A/C" selected>AMB/NON A/C</option>
                  <option value="AMB A/C">AMB A/C</option>
                  <option value="MARUTI VAN NON A/C">MARUTI VAN NON A/C</option>
                  <option value="INDICA NON A/C">INDICA NON A/C</option>
                  <option value="INDICA A/C">INDICA A/C</option>
                  <option value="SUMO A/C">SUMO A/C</option>
                  <option value="ESTEEM">ESTEEM</option>
                  <option value="SIENNA">SIENNA</option>
                  <option value="CIELO">CIELO</option>
                  <option value="SAFARI">SAFARI</option>
                  <option value="QUALIS">QUALIS</option>
                  <option value="TEMPO TRAVELLER NON A/C">TEMPO TRAVELLER NON 
                  A/C</option>
                  <option value="TEMPO TRAVELLER A/C">TEMPO TRAVELLER A/C</option>
                  <option value="LANCER">LANCER</option>
                  <option value="FORD A/C">FORD A/C</option>
                </select>
                </font></td>
              <td align="left" height="19"><font face="Arial, Helvetica, sans-serif" size="2" color="#0000FF">AC/NON-AC</font> 
              </td>
              <td align="left" height="19"><font face="Arial, Helvetica, sans-serif" size="2" color="#0000FF"> 
                <input type="radio" name="ac" value="ac"<%=checked(coolness,"ac")%>
                  <% coolness="ac"
                if ac="ac" then
             response.write checked(coolness,"ac")
                end if %> >
                AC 
                <input type="radio" name="ac" value="nonac"
                <% coolness="nonac"
                if ac="nonac" then
             response.write checked(coolness,"nonac")
                end if %> >
                NON-AC</font></td>
            </tr>
            <tr> 
              <td align="left"><font face="Arial, Helvetica, sans-serif" size="2" color="#0000FF">START 
                DATE</font></td>
              <td align="left"> <font face="Arial, Helvetica, sans-serif" size="2" color="#0000FF"> 
                <input type="text" name="sdate"  value="<%=sdate %>" size="20" >
                </font></td>
              <td align="left"><font face="Arial, Helvetica, sans-serif" size="2" color="#0000FF">END 
                DATE</font></td>
              <td align="left"> <font face="Arial, Helvetica, sans-serif" size="2" color="#0000FF"> 
                <input type="text" name="enddate" value="<%=enddate %>" size=="10" >
                </font></td>
            </tr>
            <tr> 
              <td align="left"><font face="Arial, Helvetica, sans-serif" size="2" color="#0000FF"> 
                STARTING FROM</font></td>
              <td align="left"> <font face="Arial, Helvetica, sans-serif" size="2" color="#0000FF"> 
                <input type="text" name="from" value="<%=from%>" size="20" >
                </font></td>
              <td align="left"><font face="Arial, Helvetica, sans-serif" size="2" color="#0000FF">DESTINATION</font></td>
              <td align="left"> <font face="Arial, Helvetica, sans-serif" size="2" color="#0000FF"> 
                <input type="text" name="dest" value="<%=dest %>" size="20" >
                </font></td>
            </tr>
            <tr> 
              <td align="left"><font face="Arial, Helvetica, sans-serif" size="2" color="#0000FF">MODE 
                OF HIRE</font></td>
              <td align="left"> <font face="Arial, Helvetica, sans-serif" size="2" color="#0000FF"> 
                <input type="radio" name="mode" value="km"<%=checked(travelling,"kms")%>
                  <% travelling="kms"
                if mode="kms" then
             response.write checked1(travelling,"kms")
                end if %> >
                KMS </font></td>
              <td align="left"> <font face="Arial, Helvetica, sans-serif" size="2" color="#0000FF"> 
                <input type="radio" name="mode" value="daily"
                <% travelling="daily"
                if mode="daily" then
             response.write checked1(travelling,"daily")
                end if %> >
                DAILY BASIS</font></td>
              <td align="left"> <font face="Arial, Helvetica, sans-serif" size="2" color="#0000FF"> 
                <input type="radio" name="mode" value="others"
                <% travelling="others"
                if mode="others" then
             response.write checked1(travelling,"others")
                end if %> >
                OTHERS</font></td>
            </tr>
            <tr> 
              <td align=><font face="Arial, Helvetica, sans-serif" size="2" color="#0000FF">
              STANDERED KMS</font></td>
              <td align="left"> <font face="Arial, Helvetica, sans-serif" size="2" color="#0000FF"> 
                <input type="text" name="standeredkms" size="20" value="<%=stdkm %>" onchange="chKm()">
                </font></td>
              <td align=><font face="Arial, Helvetica, sans-serif" size="2" color="#0000FF">STANDERED 
                HOURS </font></td>
              <td align="left"><font face="Arial, Helvetica, sans-serif" size="2" color="#0000FF"> 
                <input type="text" name="standeredhours" value="<%=stdhour%>"onchange="chHr()">
                </font></td>
            </tr>
            <tr> 
              <td colspan="" align="left"><font face="Arial, Helvetica, sans-serif" size="2" color="#0000FF"> 
                ACTUAL KMS </font></td>
              <td align="left"> 
                <input type="text" name="actualkms" value="<%=actualkm%>" onchange="chKm()">
              </td>
              <td colspan="" align="left"><font face="Arial, Helvetica, sans-serif" size="2" color="#0000FF"> 
                ACTUAL HOURS </font></td>
              <td align="left"> 
                <input type="text" name="actualhours" value="<%=actualhour%>" onchange="chHr()">
              </td>
            </tr>
            <tr> 
              <td colspan="" align="left"><font face="Arial, Helvetica, sans-serif" size="2" color="#0000FF"> 
                EXTRA KMS</font></td>
              <td align="left"> 
                <input type="text" name="extrakms" value="<%=extrakm%>" readonly>
              </td>
              <td colspan="" align="left"><font face="Arial, Helvetica, sans-serif" size="2" color="#0000FF"> 
                EXTRA HOURS</font></td>
              <td align="left"> 
                <input type="text" name="extrahours" value="<%=extrahour%>">
              </td>
            </tr>
            <tr> 
              <td colspan="" align="left"><font face="Arial, Helvetica, sans-serif" size="2" color="#0000FF">
              EXTRA INFORMATION
                </font></td>
              <td align="left">
                <input type="text" name="extrainf" value="<%=extrainf%>">
              </td>
              <td colspan="" align="left"><font face="Arial, Helvetica, sans-serif" size="2" color="#0000FF">EXTRA 
                AMOUNT</font></td>
              <td align="left"><font face="Arial, Helvetica, sans-serif" size="2" color="#0000FF">
                <input type="text" name="extraamount" value="<%=extraamount%>" onchange="totalv()">
                </font></td>
            </tr>
            <tr> 
              <td colspan="" align="left"><font face="Arial, Helvetica, sans-serif" size="2" color="#0000FF">RATES 
                PER DAY</font></td>
              <td align="left"><font face="Arial, Helvetica, sans-serif" size="2" color="#0000FF">
                <input type="text" name="ratesperday" value="<%=ratesperday %>"  size="20"  colspan="2" onchange="totalv()">
                </font></td>
              <td colspan="" align="left"><font face="Arial, Helvetica, sans-serif" size="2" color="#0000FF">NOS. 
                OF DAYS </font></td>
              <td align="left"><font face="Arial, Helvetica, sans-serif" size="2" color="#0000FF">
                <input type="text" name="noofday" value="<%=noofday %>"  size="20"  colspan="2" onchange="totalv()">
                </font></td>
            </tr>
            <tr> 
              <td colspan="" align="left">&nbsp;</td>
              <td align="left"> <font face="Arial, Helvetica, sans-serif" size="2" color="#0000FF"> 
                </font></td>
              <td colspan="" align="left"><font face="Arial, Helvetica, sans-serif" size="2" color="#0000FF">TOTAL 
                </font></td>
              <td align="left"> <font face="Arial, Helvetica, sans-serif" size="2" color="#0000FF"> 
                <input type="text" name="total" value="<%=total %>" size="20" >
                <input type="hidden" name="oldtotal" value="<%=total %>"  >
                </font></td>
            </tr>
            <tr> 
              <input type="hidden" name="refno" value="<%= request("refno") %>"  colspan="2">
              <td  colspan="6" ALIGN="right"> 
                <div align="center"> 
<% if session("priv")="adm" then %>
                  <input type="submit" name="submit" value="SUBMIT"size="20">
<% end if %>
                  <input type="submit" name="submit" value="RESET"size="20">
                  <input type="submit" name="submit" value="CANCLE"size="20">
                </div>
              </td>
            </tr>
            
            <% 
            rs.close()
            %> 
          </form>
          
        </table>
        <TABLE WIDTH=100%><tr>
                <td ><!-- #include file="empBottom.asp" --></td>
          
    </tr></TABLE>
        
</body>
</html>

  
    
    
    
    
    
    
  
  
  
  