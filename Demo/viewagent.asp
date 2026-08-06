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
                  <table width="100%" border="0" bgcolor="#FFFFF8" cellpadding="0" cellspacing="0">
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

  
   <TR bgcolor="#E1FFFF">
    <TD><FONT color=red face="verdana" size="2"><b>AGENT NAME</b></FONT></TD>
        <TD><FONT color=red face="verdana" size="2"><%= ucase(rs("description")) %></FONT></TD></TR>
     <TR>
        <TD><FONT color=red face="verdana" size="2"><b>COMPANY NAME</b></FONT></TD>
        <TD><b><FONT color=blue face="verdana" size="2">
            <%= ucase(rs("companyname")) %></b>
			</font></TD></TR>
    
    <TR bgcolor="#E1FFFF">
        <TD><FONT color=red face="verdana" size="2"><b>COMPLEX NAME</b></FONT></TD>
        <TD><FONT color=red face="verdana" size="2">
            <%= ucase(rs("complexname")) %>
            </font><TR>
                          <TR> 
                            <TD><b><font face="Verdana" size="2" color="#FF0000">AGENCY'S 
                              AFFILIATION</font></b></TD>
                            <TD> <b><font face="Verdana" size="2" color="#FF0000">
                             <% if ucase(rs("IATA")) ="Y" THEN
                                      response.Write "IATA , "
                                end if 
                                if ucase(rs("TAAI")) ="Y" THEN
                                  	  response.Write "TAAI , "
                                end if
                                if ucase(rs("TAFI")) ="Y" THEN
                                      response.Write " TAFI "
                                end if
                               %></font></b></TD>
                          </TR>
                          <TR bgcolor="#E1FFFF"> 
        <TD><FONT color=red face="verdana" size="2"><b>STREET-1</b></FONT></TD>
        <TD><FONT color=red face="verdana" size="2">
            <%= ucase(rs("street1")) %>
			</font></TD></TR>
    
    <TR>
        <TD><FONT color=red face="verdana" size="2"><b>STREET-2</b></FONT></TD>
        <TD><FONT color=red face="verdana" size="2">
        <%= ucase(rs("street2")) %>
          </font></TD></TR>
        
            
    <TR bgcolor="#E1FFFF">
        <TD><FONT color=red face="verdana" size="2"><b>AREA</b></FONT></TD>
        <TD><FONT color=red face="verdana" size="2">
           <%= ucase(rs("area")) %> 
            </FONT></TD></TR>
            <TR>
        <TD><FONT color=red face="verdana" size="2"><b>CITY</b></FONT></TD>
        <TD><FONT color=red face="verdana" size="2">
           <%= ucase(rs("city")) %>
            </FONT></TD></TR>
    
            <TR bgcolor="#E1FFFF">
        <TD><FONT color=red face="verdana" size="2"><b>PIN CODE</b></FONT></TD>
        <TD><FONT color=red face="verdana" size="2">
           <%= ucase(rs("pincode")) %>
            </FONT></TD></TR>
    
    <TR>
        <TD><FONT color=red face="verdana" size="2"><b>PHONE NO:</b></FONT></TD>
        <TD><FONT color=red face="verdana" size="2">
           <%= ucase(rs("phoneno")) %> 
            </FONT></TD></TR>
    <TR bgcolor="#E1FFFF">
        <TD><FONT color=red face="verdana" size="2"><b>FAX NO:</b></FONT></TD>
        <TD><FONT color=red face="verdana" size="2">
            <%= ucase(rs("faxno")) %></FONT></TD></TR>
     <TR>
        <TD><FONT color=red face="verdana" size="2"><b>EMAILID</b></FONT></TD>
        <TD><FONT color=red face="verdana" size="2">
            <%= rs("emailid") %></FONT></TD></TR>
    <TR bgcolor="#E1FFFF">
        <TD><FONT color=red face="verdana" size="2"><b>DIRECTOR NAME & MOBILE NO.</b></FONT></TD>
        <TD><FONT color=red face="verdana" size="2">
            <%= ucase(rs("directorname")) %><% if rs("DirectorPH") <> "" then %>&nbsp; <img src="updateimg/phone1.jpg" width="20" height="20" align="absbottom"><% end if %>
            <%= ucase(rs("DirectorPH")) %>
            </font></TD></TR>

<TR>
      <TD><FONT color=red face="verdana" size="2"><b>A/C MANAGER NAME & MOBILE NO.<br></font></b></TD>
        <TD><FONT color=red face="verdana" size="2">
            <%= ucase(rs("acno")) %><% if rs("AcMgrPH") <> "" then %> &nbsp; <img src="updateimg/phone1.jpg" width="20" height="20" align="absbottom"> <% end if %>
			<%= ucase(rs("AcMgrPH")) %>
            </font></TD></TR>

<TR bgcolor="#E1FFFF">
      <TD><FONT color=red face="verdana" size="2"><b>VISA'S INCHARGE'S NAME &amp; MOBILE NO.</font></b></TD>
        <TD><FONT color=red face="verdana" size="2">
              <%= ucase(rs("VisaInchargeName")) %><% if rs("VisaInchargePH") <> "" then %>&nbsp;<img src="updateimg/phone1.jpg" width="20" height="20" align="absbottom"><% end if %>
				<%= ucase(rs("VisaInchargePH")) %>
            </font></TD></TR>

            <TR>
<TR>
      <TD><FONT color=red face="verdana" size="2"><b>SEND SMS AT.</font></b></TD>
        <TD><FONT color=red face="verdana" size="2">
				<%= ucase(rs("smsno")) %>
            </font></TD></TR>

 <TR bgcolor="#E1FFFF">
        <TD><FONT color=red face="verdana" size="2"><b>PAYMENT CONDITION</b></FONT></TD>
        <TD><b><FONT color=blue face="verdana" size="2">
            <%= ucase(rs("payment")) %></b>
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
