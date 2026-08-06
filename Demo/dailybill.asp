<%@ Language=VBScript %>
<%
response.buffer= true
%>
<!-- #include file="connection.asp" -->
<%
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
                <td>
<% if session("priv")="adm" then
%> 
<!-- #include file="topadmin.asp"-->           
<%
else
%>
<!-- #include file="top.asp"--> 
<% 
end if
%>
</td>
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
            <div align="center"><span class="tableCaption">Daily Generated Bills</span> 
            </div>
          </td>
        </tr>
      </table>
    </td>
  </tr>
  <tr> 
    <td height="2">
      <table width="75%" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td><img src="images/linetopgreen1.gif" width="753 height="10"></td>
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
sdate=date()
end if
                  set rs=server.createobject("adodb.recordset")
				  set rss=server.createobject("adodb.recordset")

				  set rst=server.createobject("adodb.recordset")
                  stmtt="select sum(grandtotal) from invoice where day(invoicedate) = "&day(sdate)&" and month(invoicedate)="&month(sdate)&" and year(invoicedate)="&year(sdate)
                  rst.open stmtt,con,3,3

				if request("usb")="yes" then
                  stmt="select * from invoice where day(invoicedate) = "&day(sdate)&" and month(invoicedate)="&month(sdate)&" and year(invoicedate)="&year(sdate)&" order by refno desc"
				else
                  stmt="select * from invoice where day(invoicedate) = "&day(sdate)&" and month(invoicedate)="&month(sdate)&" and year(invoicedate)="&year(sdate)&" order by invoiceno desc"
				end if
                  rs.open stmt,con,3,3

                 %>
                  <td align="center"></td>
               
<td align="center">

<table width="97%" border="1">
  <tr> 
    <td colspan="8"> 


<form name=dailybill action="dailybill.asp">
<select name="date">
<option value="<%=systousrdate(today)%>" selected><%=systousrdate(today)%></option> 
<% for i=1 to 610 %>
<option value="<%=systousrdate(Cdate(today)-i)%>"><%=systousrdate(cdate(today)-i)%></option>
<% next %>
</select>
<input type="submit" value=" GO " name="submit" class="ud">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="dailybill.asp?date=<%=request("date")%>&usb=yes">Ref No# Wise</a>
</form>
    </td>
  </tr>
<%  if rs.eof then %>
  <tr> 
    <td colspan="8"> 
<span class="WSRightBold"> You haven't Generated any Bill on >>>> <%=formatdatetime(Cdate(sdate),1)%>. </span>
    </td>
  </tr>
<%
else
startfrom=rs.fields("invoiceno")
rs.movelast
endtill=rs.fields("invoiceno")
rs.movefirst
%>
  <tr> 
    <td colspan="8"> 
      <div align="left"><b>Total <%=rst.fields(0)%>>> <%=rs.recordcount%> >>Bills Generated on >>>> <%=formatdatetime(Cdate(sdate),1)%>.</b></div>
    </td>
  </tr>
  <tr> 
    <td colspan="8"> 
      <div align="left"><b>Start From Invoice No. >> <%=endtill%> >> To >> <%=startfrom %>.</b></div>
    </td>
  </tr>
  <tr> 
    <td width="10%"> 
      <div align="left"><b>Invoice No.</b></div>
    </td>
    <td width="10%"> 
      <div align="left"><b>Ref No.</b></div>
    </td>
    <td width="10%"> 
      <div align="left"><b>Agent Name</b></div>
    </td>
        <td width="6%"> 
      <div align="left"><b>Type</b></div>
    </td>
    <td width="6%"> 
      <div align="left"><b>Status</b></div>
    </td>
    <td width="6%"> 
      <div align="left"><b>Amount</b></div>
    </td>
    <td colspan="2"> 
      <div align="left"><b>Remark</b></div>
    </td>
  </tr>
<% while not rs.eof 
 refno=rs.fields("refno")
 stmts="select status,agent from mainentry where refno='"&refno&"'"
 rss.open stmts,con,3,3
status=rss.fields("status")
agent=rss.Fields("agent")
rss.close
%>
  <tr> 
    <td width="10%"><font face="Arial, Helvetica, sans-serif" size="2">
    <a href="encloser.asp?refno=<%=rs.fields("refno")%>&cmd=Billed"><%=rs.fields("invoiceno")%></a>
    </font> </td>
    <td width="10%"> 
    <font face="Arial, Helvetica, sans-serif" size="2">
  <div align="left">
<% if session("priv")="adm" then %>
<a href="refnoTotaldetailsubTest.asp?refno=<%=rs.fields("refno")%>&cmd=Billed">
<% end if %>
<%=rs.fields("refno")%>
<% if session("priv")="adm" then %>
</a>
<% end if %>
</div>
    </font> </td>
    <td width="10%" nowrap > 
    <font face="Arial, Helvetica, sans-serif" size="2">
      <div align="left"><%
      Agentname=getDescriptionForID("agents",agent)
Agentname=left (Agentname,20)
response.write Agentname %></div>
    </font> </td>
    
    <td width="6%">
    <font face="Arial, Helvetica, sans-serif" size="2">
<% if session("priv")="adm" then %>
<a href="editbill.asp?refno=<%=rs.fields("refno")%>&cmd=Billed">
<% end if  %>
<%=rs.fields("invtype") %>
<% if session("priv")="adm" then %>
</a>
<% end if  %>
</font> </td>
    <td width="6%"> 
    
      <div align="left">
      <font face="Arial, Helvetica, sans-serif" size="2">
<a href="refnoTotaldetailsub.asp?refno=<%=rs.fields("refno")%>&cmd=Billed">
      <%
call writeIDDescription("status",status)
%></a> </font> </div>
    </td>
    <td width="6%"> 
      <div align="left"><font face="Arial, Helvetica, sans-serif" size="2">
      <b><%=rs.fields("grandtotal")%>/-</b></font> </div>
    </td>
   <td colspan="2"><font face="Arial, Helvetica, sans-serif" size="2"> <%=rs.fields("remark")%> </font></td>
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
          <td><img src="images/linetopgreen2.gif" width="753" height="10"></td>
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
