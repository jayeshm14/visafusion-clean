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
            <div align="center"><span class="tableCaption">Agent Information</span> </div>
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
                agent=request("agent")
set rs=server.createobject("adodb.recordset")
stmt="select * from agents where agentsID="&cint(agent)

rs.open stmt,con,2,3

if rs.eof then
%>
<tr><td align="center">
<%
response.write " Data not Found"
%>
</td></tr>
<%
else
%>

  
   <TR>
    <TD>&nbsp;&nbsp;&nbsp;<FONT color=red face="arial">AGENT NAME</FONT></TD>
        <TD><FONT color=red face=""><%= ucase(rs("description")) %></FONT></TD></TR>
     <TR>
        <TD>&nbsp;&nbsp;&nbsp;<FONT color=red face="">COMPANY NAME</FONT></TD>
        <TD>
            <%= ucase(rs("companyname")) %></TD></TR>
    
    <TR>
        <TD>&nbsp;&nbsp;&nbsp;<FONT color=red face="">COMPLEX NAME</FONT></TD>
        <TD>
            <%= ucase(rs("complexname")) %>
            <TR>
        <TD>&nbsp;&nbsp;&nbsp;<FONT color=red face="">STREET-1 </FONT></TD>
        <TD>
            <%= ucase(rs("street1")) %></TD></TR>
    
    <TR>
        <TD>&nbsp;&nbsp;&nbsp;<FONT color=red face="">STREET-2</FONT></TD>
        <TD><%= ucase(rs("street2")) %></TD></TR>
        
            
    <TR>
        <TD>&nbsp;&nbsp;&nbsp;<FONT color=red face="">AREA </FONT></TD>
        <TD><FONT color=red face="">
           <%= ucase(rs("area")) %> 
            </FONT></TD></TR>
            <TR>
        <TD>&nbsp;&nbsp;&nbsp;<FONT color=red face="">CITY </FONT></TD>
        <TD><FONT color=red face="">
           <%= ucase(rs("city")) %>
            </FONT></TD></TR>
    
            <TR>
        <TD>&nbsp;&nbsp;&nbsp;<FONT color=red face="">PIN CODE </FONT></TD>
        <TD><FONT color=red face="">
           <%= ucase(rs("pincode")) %>
            </FONT></TD></TR>
    
    <TR>
        <TD>&nbsp;&nbsp;&nbsp;<FONT color=red face="">PHONE NO:</FONT></TD>
        <TD><FONT color=red face="">
           <%= ucase(rs("phoneno")) %> 
            </FONT></TD></TR>
    <TR>
        <TD>&nbsp;&nbsp;&nbsp;<FONT color=red face="">FAX NO:</FONT></TD>
        <TD><FONT color=red face="">
            <%= ucase(rs("faxno")) %></FONT></TD></TR>
     <TR>
        <TD>&nbsp;&nbsp;&nbsp;<FONT color=red>EMAILID</FONT></TD>
        <TD><FONT color=red>
            <%= rs("emailid") %></FONT></TD></TR>
    <TR>
        <TD>&nbsp;&nbsp;&nbsp;<FONT color=red face="">DIRECTOR NAME </FONT></TD>
        <TD><FONT color=red face="">
            <%= ucase(rs("directorname")) %>
            </TD></TR>
   <TR>
      <TD>&nbsp;&nbsp;&nbsp;<FONT color=red face="">A/C INCHARGE NO.</FONT></TD>
        <TD><FONT color=red face="">
            <%= ucase(rs("acno")) %>
            </TD></TR>
    
            <TR>
        <TD>&nbsp;&nbsp;&nbsp;<FONT color=red>PAYMENT CONDITION</FONT></TD>
        <TD>
            <%= ucase(rs("payment")) %>
            </TD></TR>
            
            
            
        <TD ALIGN=center colspan="2">
            </TD></TR>
           
<%
end if 
%>

                
     
                      
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
