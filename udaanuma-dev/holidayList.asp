<%@ Language=VBScript %>
<!-- #include file="connection.asp" -->
<%
response.buffer= true

if session("priv")="" then
response.clear
response.redirect "default.asp?rsn=usb"
end if
%>
<html>
<head>
<title>www.udaanindia.com</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

</head>

<body bgcolor="#FFFFFF"  topmargin=0 leftmargin=0 marginwidth=0 marginheight=0 >
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td>
      <table width="100%" border="0" cellpadding="0" cellspacing="0">
        <tr valign="top" align="left">
          
          <td width="98%"> 
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr valign="top" align="left"> 
                
          <td>
          <%
      agentID=request("jn")
       %> 
          <% if session("priv")="adm" then %> <!-- include file="topAdmin.asp"--> 
      <%
elseif session("priv")="emp" then
%>
<!-- include file="top.asp"--> 
<% 
elseif session("priv")="agt" then
%>
<!-- #include file="topAgent.asp"-->
<% 
elseif session("priv")="guest" then
%>
          </td>
        </tr>
        <tr> 
          <td><img src="images/linecolor.gif" width="760" height="12"></td>
        </tr>
        <tr> 
          <td><img src="images/pixelb.gif" width="33" height="5"></td>
        </tr>
</table>
<% end if %>


</td>
              </tr>
              <tr>
                <td> <%

set rs=server.createobject("adodb.recordset")
month1=request("selmonth")
year1=request("selyear")
if month1<>"" and year1<>"" then
date1=month1&"/01/"&year1
else
date1=date()
end if
%>
<table width=780 border=0 align=center cellpadding=0 cellspacing=0><tr> 
    <td align=left valign=top background="images/bigtablebg.gif"> 
                  
        <table width="80%" border="0" cellpadding="1" cellspacing="1" align="center" >
          <tr> 
                      <td> <br>
                      
                        <table width="75%" align="center" cellpadding="0" cellspacing="0" bgcolor="#008432">
                          <tr> 
                            <td height="21" background="images/yellowbgband.gif" align="center"> <p class="lbltext">
                              HOLIDAY LIST FOR <%=monthName(month(date1))&", "&year(Date1)%></p>
                            </td>
                          </tr>
                        </table>
                      </td>
                    </tr>
                    
          <tr bgcolor="BD402C"> 
            <td> 
              <table width="75%" border="0" cellspacing="0" cellpadding="0" align="center">
            <tr> 
                            <td>&nbsp;</td>
                          </tr>
                          
            <tr> 
              <td> 
                              <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                <tr> 
                                  <td align="center" width="1"></td>
                                  <td> 
                                    
                      <table width="100%" border="0" cellpadding="0" cellspacing="0" background="images/backform.jpg">
                        <tr> 
                                        <td>
                                          
                                <table width="99%" border="0" align="CENTER" cellpadding="1" cellspacing="1">
                                  <tr bgcolor="#FBBD06"> 
                                              
                                    <td bgcolor="#FBBD06">
                                      <p class="dynamicheadingagent">Country</p>
                                    </td>
                                              <td><p class="dynamicheadingagent">Date</p></td>
                                              <td><p class="dynamicheadingagent">Reason</p></td>
                                            </tr>
                                            <%

                  stmt="select * from holidaylist where  month(holiday)="&month(date1)& " and year(holiday)="&year(date1)&" order by holiday"
if request("OrdByCtry")="yes" then
                  stmt="select holidaylist.countryid, holidaylist.holiday, holidaylist.description, embassy.description from holidaylist,embassy where  month(holidaylist.holiday)="&month(date1)& " and year(holidaylist.holiday)="&year(date1)&" and holidaylist.countryid=embassy.embassyid order by embassy.description, holidaylist.holiday"
end if
                  
                  rs.open stmt,con,2,3
                  IF not rs.eof then
                  while not  rs.eof
                              response.write"<tr><td><p class='dynamictext1'>"
                             Call writeIDDescription("Embassy",rs("countryid"))
		             response.write"</p></td><td nowrap><p class='dynamictext1'>"& formatDateTime(rs("holiday"),1)
		             response.write"</p></td><td><p class='dynamictext1'>"&  rs("description")
		             response.write"&nbsp;</p></td></tr>"
		  rs.movenext
		  wend            
		               
		               
		        else
		        response.write"<tr><td colspan =3 align=center><p class='dynamictext1'>NO HOLIDAYS FOR THIS MONTH</p></TD></TR>" 
		        end if
		
      
                  rs.close
%> 
                                            <form name=holiday action="holidayList.asp"><p class='dynamictext1'>
                                              <select name="selmonth" class="dropdown">
                                                <option value="01" 
  <%
  if month(date1)=1 then
  response.write " Selected"
  end if
  %>
  >January 
                                                <option value="02"
  <%
  if month(date1)=2 then
  response.write " Selected"
  end if
  %>
  >February 
                                                <option value="03"
  <%
  if month(date1)=3 then
  response.write " Selected"
  end if
  %>
  >March 
                                                <option value="04"
  <%
  if month(date1)=4 then
  response.write " Selected"
  end if
  %>
  >April 
                                                <option value="05"
  <%
  if month(date1)=5 then
  response.write " Selected"
  end if
  %>
  >May 
                                                <option value="06"
  <%
  if month(date1)=6 then
  response.write " Selected"
  end if
  %>
  >June 
                                                <option value="07"
  <%
  if month(date1)=7 then
  response.write " Selected"
  end if
  %>
  >July 
                                                <option value="08"
  <%
  if month(date1)=8 then
  response.write " Selected"
  end if
  %>
  >August 
                                                <option value="09"
  <%
  if month(date1)=9 then
  response.write " Selected"
  end if
  %>
  >September 
                                                <option value="10"
  <%
  if month(date1)=10 then
  response.write " Selected"
  end if
  %>
  >October 
                                                <option value="11"
  <%
  if month(date1)=11 then
  response.write " Selected"
  end if
  %>
  >November 
                                                <option value="12"
  <%
  if month(date1)=12 then
  response.write " Selected"
  end if
  %>
  >December 
                                              </select> 
                                               <input type="hidden" name="jn" value="<%=request("jn")%>"> 
                                               
                                              <input type="text" name="selyear" value="<%=year(date1)%>" size="4" class=inputbox>
                                              <input type="submit" value=" GO " name="submit" class="ud">
                                             
                                              <a href="holidayList.asp?OrdByCtry=yes&selmonth=<%=request("selmonth")%>&jn=<%=request("jn")%>&selyear=<%=request("selyear")%>">Order by Country</a>
											
										&nbsp;&nbsp;&nbsp;&nbsp;
										<a href="WeeklyOffList.asp?logon=Y&anp=34&cd=2345&seckey=xyz25g78md20422npr054416panftphjkslsktls&jn=<%=agentID%>&ses=k3456l7dj9javyemsn&company=udaan">Weekly Off List</a></p>
											
                                            </form> 
                                          </table>
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
                            
                  <td>&nbsp;</td>
                          </tr>
                        </table>
                      </td>
                    </tr>
                  </table>
                  </tr>
</td>
</table>

                
                
                
                </td>
              </tr>
            </table>
          </td>
        </tr>
      </table>
    </td>
  </tr>
  <tr>
                <td><!-- #include file="HomeBottom.asp" --></td>
          
    </tr>
</table>
</body>
</html>
