<%@ Language=VBScript %>
<!-- #include file="connection.asp" -->
<html>
<head>
<title>www.udaanindia.com</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="styles.css" type="text/css">
</head>

<body bgcolor="#FFFFFF" topmargin=0 leftmargin=0 marginwidth=0 marginheight=0 >
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
<%

set rs=server.createobject("adodb.recordset")
rs.activeconnection=con
stmt1="select * from scheduler where messageid="&cint(request("id"))
rs.open stmt1,con,2,3
if rs.eof then
response.write "NO MESSAGE RECEIVED"
else
rs("messageread")="y"
rs.update
end if

%>
<table BORDER=0 vALIGN=right  width=40% align="center">
<tr>
<td><span class="WSRightBold"> TO :</span>: <span class="Website">
<%=rs("messageto")%> </span>
</b></td></tr>
<tr>
<td><span class="WSRightBold">FROM :</span> <span class="Website">
<%=rs("messagefrom")%> 
 </span></td></tr>
<tr>
<td><span class="WSRightBold">DATE :</span><span class="Website">
<%=formatDateTime(rs("date"),1)%> 
 </span></td></tr>
<tr>
<td><span class="WSRightBold">SUBJECT :</span><span class="Website">
<%
if trim(rs("subject"))= "" then
response.write "None"
else
response.write rs("subject")
end if
%> 
 </span></td></tr>
<tr>
<td><span class="WSRightBold">MESSAGE : </span>
</td></tr>
<tr>
<td colspan="2">
<span class="Website">
<%=rs("description")%> 
 </span></td></tr></table><table align="center">
<tr>
                <td><!-- #include file="empBottom.asp" --></td>
          
    </tr>
</TABLE>

<% 
 rs.close 
%>
