<%@ Language=VBScript %>
<!-- #include file="connection.asp" -->
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
                
          <td> <% if session("priv")="adm" then %> <!-- #include file="topAdmin.asp"--> 
                    
      <%
elseif session("priv")="emp" then
%>
<!-- #include file="top.asp"--> 
<% 
elseif session("priv")="agt" then
%>
<!-- #include file="topAgent.asp"-->
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
%><form name=holiday method=post action="holidayDelete.asp"><br>
                  <table width="80%" border="0" cellpadding="1" cellspacing="1" align="center" >
                    <tr> 
                      <td> 
                      
                        <table width="75%" align="center" cellpadding="0" cellspacing="0" bgcolor="#008432">
                          <tr bgcolor="#FFE898"> 
                            <td height="19" COLSPAN=4> 
                              <div align="center"> <td  ALIGN="CENTER"><B>HOLIDAY LIST FOR <%=monthName(month(date1))&", "&year(Date1)%></B></TD></div>
                               
                            </td>
                          </tr>
                        </table>
                      </td>
                    </tr>
                    <tr> 
                      <td>
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
                                          <table width="90%" border="0" align="CENTER" cellpadding="1" cellspacing="1">
                                            <tr bgcolor="#FFF5D7"> 
                                              <td><b>Date</b></td>
                                              <td><b>Country</b></td>
                                              <td><b>Reason</b></td>
                                            </tr>
                                            <%



del=request("delete")
if del="Delete" then

total=cint(request("counter"))
for i=1 to total
if request("item"&i)<>"" then
con.execute("delete from holidaylist where holiday='"&request("date"&i)&"' and countryid="&request("country"&i))
end if
next

end if 

counter=0

                  stmt="select * from holidaylist where month(holiday)="&month(date1)& " and year(holiday)="&year(date1)&" order by holiday"
                  
                  rs.open stmt,con,2,3
                  IF not rs.eof then
                  while not  rs.eof
                  counter=counter+1
                              response.write"<tr><td><input type=""checkbox"" name=item"&counter&" value="&counter&" ></td><td>"
                              response.write "<input type=""hidden"" name=country"&counter&" value="&rs("countryid")&" >"
                             Call writeIDDescription("Embassy",rs("countryid"))
		             response.write"</td><td>"& formatDateTime(rs("holiday"),1)
		             response.write "<input type=""hidden"" name=date"&counter&" value="&rs("holiday")&" >"
		             response.write"</td><td>"&  rs("description")
		             response.write"</td></tr>"
		  rs.movenext
		  wend            
		     response.write "<input type=""hidden"" name=counter value="&counter&" >"          
		               
		        else
		        response.write"<tr><td colspan =4 align=center><span class='WSRightBold'>NO HOLIDAYS FOR THIS MONTH</span></TD></TR>" 
		        end if
		
      
                  rs.close
%>
                                            
                                              <select name="selmonth">
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
                                              <input TYPE="text" NAME="selyear" VALUE="<%=year(date1)%>" size="6">
						<input type="submit" value="GO" class="ud">
						<input type="submit" name=delete value="Delete" class="ud">
                                              
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
                            <td><img src="images/linetopgreen2.gif" width="660" height="10"></td>
                          </tr>
                        </table>
                      </td>
                    </tr>
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
                <td><!-- #include file="empBottom.asp" --></td>
          
    </tr>
</table>
</body>
</html>
