<%@ Language=VBScript %>
<!-- #include file="connection.asp" -->
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
                <td><!-- #include file="topadmin.asp" --></td>
              </tr>
              <tr>
                <td>

<body bgcolor="#FFFFFF">
<table width="80%" border="0" cellpadding="1" cellspacing="1" align="center">
  <tr> 
    <td> 
      <table width="75%" align="center" cellpadding="0" cellspacing="0">
        <tr bgcolor="#FFE898"> 
          <td height="19"> 
            <div align="center"><span class="tableCaption">Daily Sent Mails</span> </div>
          </td>
        </tr>
      </table>
    </td>
  </tr>
  <tr> 
    <td height="2">
      <table width="75%" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td><img src="images/linetopgreen1.gif" width="660" height="10"></td>
        </tr>
        <tr bgcolor="#009933"> 
          <td> 
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td align="left" width="1"><img src="images/pixelsline.gif" width="1" height="7"></td>
                <td bgcolor="#FFFFFF"> 
                  <table width="100%" border="0" bgcolor="#FFFFF8" cellpadding="0" cellspacing="0" background="images/backform.jpg">
                    <tr> 
                      <td>
                
                             <%  
today=date()
sdate=usrtosysdate(request("date"))
if sdate="" then
sdate=date()-1
end if
                  set rs=server.createobject("adodb.recordset")
                  stmt="select * from sentawb,agents where day(sentawb.date) = "&day(sdate)&" and month(sentawb.date)="&month(sdate)&" and year(sentawb.date)="&year(sdate)&" and agents.agentsid=sentawb.agentsid order by agents.description"
                  rs.open stmt,con,3,3
                 %>
                  <td align="center"></td>

<td align="center">

<table width="97%" border="1">
  <tr> 
    <td colspan="4"> 


<form name=sentmail action="dailysentawb.asp">
    <select name="date">
    <% for i=0 to 10 %> 
	<% if systousrdate(Cdate(today)-i)=systousrdate(today-1) then %>
	<option value="<%=systousrdate(Cdate(today)-i)%>" selected><%=systousrdate(Cdate(today)-i)%></option>
	<% else %>
    <option value="<%=systousrdate(Cdate(today)-i)%>"><%=systousrdate(cdate(today)-i)%></option>
	<% end if
	next %> 
    </select>
<input type="submit" value=" GO " name="submit" class="ud">
</form>
    </td>
  </tr>
<%  if rs.eof then %>
  <tr> 
    <td colspan="4"> 
<span class="WSRightBold"> You haven't Sent any AWB NO. on >>>> <%=formatdatetime(Cdate(sdate),1)%>. </span>
    </td>
  </tr>
<%
else
%>
  <tr> 
    <td colspan="4"> 
      <div align="left"><b>Total >> <%=rs.recordcount%> >>mails sent on >>>> <%=formatdatetime(Cdate(sdate),1)%>.</b></div>
    </td>
  </tr>
  <tr> 
    <td width="30%"> 
      <div align="left"><b>Agent</b></div>
    </td>
    <td width="30%"> 
      <div align="left"><b>Couriear</b></div>
    </td>
    <td width="20%"> 
      <div align="left"><b>AWB</b></div>
    </td>
    <td colspan="1"> 
      <div align="left"><b>Sent To</b></div>
    </td>
  </tr>
<% while not rs.eof %>
  <tr> 
    <td width="30%">
<%
agentsid=rs.fields("agentsid")
call writeIddescription("agents",agentsid)
%>
</td>
    <td width="30%"> 
      <div align="left"><%=rs.fields("remark")%></div>
    </td>
    <td width="20%"><%=rs.fields("awb")%>&nbsp;</td>
    <td colspan="1"><%=rs.fields("toemail")%>&nbsp;</td>
  </tr>
<%
rs.movenext
wend
end if
rs.close
%>
</table>



</td>
                          
                     </td>
                    </tr>
                  </table>
                </td>
                <td align="right" width="1"><img src="images/pixelsline.gif" width="1" height="7"></td>
              </tr>
            </table>
          </td>
        </tr>
        <tr> 
          <td><img src="images/linetopgreen2.gif" width="660" height="10"></td>
        </tr>
      </table>
    </td>
  </tr>
  <tr>
                <td><!-- #include file="empBottom.asp" --></td>
          
    </tr>

</table>
</body>
</html>
