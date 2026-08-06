<%@ Language=VBScript %>
<%
response.buffer= true
%>
<!-- #include file="connection.asp" -->
<%
if request("form")="2" then
set rsd=server.createobject("ADODB.Recordset")
for each j in request.form.item("c")
rsd.open "select * from priwork where id='"&j&"'",con,2,3
if trim(rsd.fields("status"))="" then
rsd.fields("status")=request("uname")
rsd.update
end if
rsd.close
next
end if
if request("form")="3" then
edate=usrtosysdate(request("edate"))
sql="insert into priwork values('"&request("uname")&"','"&edate&"','"&FormatDateTime(now(),0)&"','"&request("work")&"','')"
con.execute(sql)
end if
%>
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

<body bgcolor="#FFFFFF"  topmargin=0 leftmargin=0 marginwidth=0 marginheight=0 onLoad="MM_preloadImages('images/profilen2.gif','images/updaten2.gif','images/registrationn2.gif','images/contactn2.gif','images/queriean2.gif','images/logout2.gif')" >
<table width="75%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td>
      <table width="75%" border="0" cellpadding="0" cellspacing="0">
        <tr valign="top" align="left">

          <td width="98%"> 
            <table width="75%" border="0" cellspacing="0" cellpadding="0">
              <tr valign="top" align="left"> 
                <td><!-- #include file="topadmin.asp" --></table></td>
              </tr>
              <tr>
                <td>


<table width="80%" border="0" cellpadding="1" cellspacing="1" align="center">
  <tr> 
        <td height="2"> 
          <table width="75%" align="center" cellpadding="0" cellspacing="0">
        <tr bgcolor="#FFE898"> 
          <td height="19"> 
                        <div align="center"><span class="tableCaption">Priority 
                          Works</span></div>
          </td>
        </tr>
      </table>
    </td>
  </tr>
  <tr> 
        <td height="276"> 
          <table width="75%" border="0" cellspacing="0" cellpadding="0" height="238">
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
sdate=date()
end if
                  set rs=server.createobject("adodb.recordset")
                  stmt="select * from priwork where day(date) = "&day(sdate)&" and month(date)="&month(sdate)&" and year(date)="&year(sdate)&""
                  rs.open stmt,con,3,3
                 %>
                  <td align="center"></td>
               
                          <td align="center"> 
                            <table width="97%" border="1">
                              <tr> 
                                <td colspan="4"> 
                                  <form name=form1 action="priwork.asp">
                                    <select name="date">
<% 
i=10
while i<>0 %> 
                                      <option value="<%=systousrdate(Cdate(today)+i)%>"><%=systousrdate(cdate(today)+i)%></option>
                                      <% 
i=i-1
wend  %> 
                                      <option value="<%=systousrdate(today)%>" selected><%=systousrdate(today)%></option>
                                      <% for i=1 to 10 %> 
                                      <option value="<%=systousrdate(Cdate(today)-i)%>"><%=systousrdate(cdate(today)-i)%></option>
                                      <% next %> 
                                    </select>
                                    <input type="submit" value=" GO " name="submit" class="ud">
                                    <input type="hidden" name="form" value="1">
                                  </form>
                                </td>
                              </tr>
                              <%  if rs.eof then %> 
                              <tr> 
                                <td colspan="4"> <span class="WSRightBold"> You 
                                  haven't any Priority work for >>>> <%=formatdatetime(Cdate(sdate),1)%>. 
                                  </span> </td>
                              </tr>
                              </table>
                            <%
else
%> 
                            <form method="post" action="priwork.asp" name="form2">
                                      <table width="97%" border="1">
                                        <tr> 
                                          <td colspan="4"><b>Total >> <%=rs.recordcount%> 
                                            >> works on priority for >>>> <%=formatdatetime(Cdate(sdate),1)%>. 
                                            <input type="hidden" name="uname" value="<%=session("uname")%>">
                                            <input type="hidden" name="form" value="2">
                                            </b></td>
                                        </tr>
                                        <tr> 
                                          <td width="16%"> 
                                            <div align="left"><b>Done</b></div>
                                          </td>
                                          <td width="72%" colspan="2"> 
                                            <div align="left"><b>Work</b></div>
                                          </td>
                                          <td colspan="1" width="12%"> 
                                            <div align="left"><b>Given by</b></div>
                                          </td>
                                        </tr>
                                        <% while not rs.eof %> 
                                        <tr> 
                                          <td width="16%"> 
                                            <input type="checkbox" name="c" value="<%=rs.fields("id")%>" <%if trim(rs.fields("status"))<>"" then %>checked <% end if %>>
                                            <%=rs.fields("status")%> </td>
                                          <td width="72%" colspan="2"><%=rs.fields("work")%>&nbsp;</td>
                                          <td colspan="1" width="12%"><%=rs.fields("givenby")%></td>
                                        </tr>
                                        <%
rs.movenext
wend
rs.close
%> 
                                        <tr> 
                                          <td width="16%" height="2"> 
                                            <input type="submit" name="Submit" value="Done">
                                          </td>
                                          <td width="72%" height="2" colspan="2">&nbsp;</td>
                                          <td colspan="1" width="12%" height="2">&nbsp;</td>
                                        </tr>
                                      </table>
                            </form>
                                    <% end if %> 
                                    
                            <form method="post" action="priwork.asp" name="form3">
                              <table width="97%" border="1">
                                        <tr> 
                                          <td width="20%"><b>Work for Date</b></td>
                                          <td width="80%">
                                            
                                    <select name="edate">
                                      <option value="<%=systousrdate(today)%>" selected><%=systousrdate(today)%></option>
                                              <% for i=1 to 10 %> 
                                              <option value="<%=systousrdate(Cdate(today)+i)%>"><%=systousrdate(cdate(today)+i)%></option>
                                              <% next %> 
                                            </select>
                                    <b> 
                                    <input type="hidden" name="uname" value="<%=session("uname")%>">
                                    <input type="hidden" name="form" value="3">
                                    </b> </td>
                                        </tr>
                                        <tr> 
                                          
                                  <td width="20%" height="37"><b>Work</b></td>
                                          
                                  <td width="80%" height="37"> 
                                    <textarea name="work" rows="4" cols="40"></textarea>
                                  </td>
                                        </tr>
                                        <tr> 
                                          <td width="20%">&nbsp;</td>
                                          <td width="80%">
                                    <input type="submit" name="Submit2" value="Add">
                                  </td>
                                        </tr>
                                      </table>
                                    </form>
                                  </td>
                          
                     </table></td>
                    </tr>
                  </table>
                </td>
                <td align="right" width="1"><img src="images/pixelsline.gif" width="1" height="7"></td>
              </tr>
            </table>
          </td>
        </tr>
        <tr> 
          
        <td height="2"><img src="images/linetopgreen2.gif" width="660" height="10"></td>
        </tr>
      </table>
    </td>
  </tr>
  <tr>
                <td><!-- #include file="empBottom.asp" --></td>
          
    </tr>

</table>

</table></body></html>
