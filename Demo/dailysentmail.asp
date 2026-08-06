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
                <td><!-- #include file="topadmin.asp" --></td> </tr> <tr> <td> <body bgcolor="#FFFFFF"> 
<table width="63%" border="0" cellpadding="1" cellspacing="1" align="center">
  <tr> 
    <td> 
      <table width="75%" align="center" cellpadding="0" cellspacing="0">
            <tr bgcolor="#FFFFFF"> 
              <td height="19"> 
                <div align="center"><img src="updateimg/Sent%20Daily%20Mails%20Heading.jpg" width="313" height="83"> 
                </div>
          </td>
        </tr>
      </table>
    </td>
  </tr>
  <tr> 
    <td height="2"> 
      <table width="82%" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td width="660"><img src="images/linetopgreen1.gif" width="660" height="10"></td>
        </tr>
        <tr bgcolor="#009933"> 
          <td width="660"> 
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td align="left" width="1"><img src="images/pixelsline.gif" width="1" height="7"></td>
                <td bgcolor="#FFFFFF"> 
                  <table width="100%" border="0" bgcolor="#FFFFF8" cellpadding="0" cellspacing="0" background="images/backform.jpg">
                    <tr> 
                      <td> <%  
today=date()
sdate=usrtosysdate(request("date"))
if sdate="" then
sdate=date()
end if
                  set rs=server.createobject("adodb.recordset")
                  stmt="select * from sentmails where day(date) = "&day(sdate)&" and month(date)="&month(sdate)&" and year(date)="&year(sdate)&" order by date"
                  rs.open stmt,con,3,3
                 %> 
                      <td align="center"></td>
                      <td align="center"> 
                        <table width="98%" border="1">
                          <tr> 
                            <td colspan="4"> 
                              <form name=sentmail action="dailysentmail.asp">
                                <select name="date">
                                  <option value="<%=systousrdate(today)%>" selected><%=systousrdate(today)%></option>
                                  <% for i=1 to 10 %> 
                                  <option value="<%=systousrdate(Cdate(today)-i)%>"><%=systousrdate(cdate(today)-i)%></option>
                                  <% next %> 
                                </select>
                                <input type="submit" value=" GO " name="submit" class="ud">
                              </form>
                            </td>
                          </tr>
                          <%  if rs.eof then %> 
                          <tr> 
                            <td colspan="4"> <span class="WSRightBold"> You haven't 
                              Sent any mail on >>>> <%=formatdatetime(Cdate(sdate),1)%>. 
                              </span> </td>
                          </tr>
                          <%
else
%> 
                          <tr> 
                            <td colspan="4"> 
                              <div align="left"><b>Total >> <%=rs.recordcount%> 
                                >>mails sent on >>>> <%=formatdatetime(Cdate(sdate),1)%>.</b></div>
                            </td>
                          </tr>
                          <tr> 
                            <td width="30%"> 
                              <div align="left"><b>Agent</b></div>
                            </td>
                            <td width="30%"> 
                              <div align="left"><b>Date Time</b></div>
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
                            <td width="30%"> <%
agentsid=rs.fields("agentsid")
call writeIddescription("agents",agentsid)
%> </td>
                            <td width="30%"> 
                              <div align="left"><%=systousrdate(rs.fields("date"))%> 
                                at <%=FormatDateTime(rs.fields("date"),3)%></div>
                            </td>
                            <td width="20%"><%=rs.fields("awb")%>&nbsp;</td>
                            <td colspan="1"><%=rs.fields("toemail")%></td>
                          </tr>
                          <%
rs.movenext
wend
end if
rs.close
%> 
                        </table>
                      </td>
                  </table>
                </td>
              </tr>
            </table>
          </td>
          <td align="right" width="10"><img src="images/pixelsline.gif" width="1" height="7"></td>
        </tr>
      </table>
    </td>
  </tr>
  <tr> 
    <td><img src="images/linetopgreen2.gif" width="660" height="10"></td>
  </tr>
</table>
    
  
  

</body>
</html>
