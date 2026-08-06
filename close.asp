<%uname=session("uname")
response.expires =0
%>
<!-- #include file="connection.asp" -->
<%response.buffer=true %>
<%
uname=session("uname")
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
                <td><!-- #include file="topadmin.asp" --></td>
              </tr>
              <tr>
                <td><% 
today=date()
set rs5=server.createobject("adodb.recordset")
query1="select * from security where  Day(date1)="&day(today)&" and month(date1)="&month(today)&" and year(date1)="&year(today)&" and closingtime is null"
'response.write "hjh"&query1
rs5.open query1,con,2,3
if not rs5.eof then
rs5("closingtime")=time()
rs5("closedby")=uname
rs5.update
'response.write "Closed for the day."
response.clear
myurl= "securityhome.asp?uname="&uname&"&flag=1"
response.redirect(myurl)
'response.write time()
Else
response.clear
myurl= "securityhome.asp?uname="&uname&"&flag=2"
response.redirect(myurl)
'response.write "<P ALIGN=CENTER>THE APPLICATION IS  NOT OPEN.</P>"
rs5.close
con.close
End if
%></td>
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
