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
set rs=server.createobject("adodb.recordset")

query1="select * from security where  Day(date1)="&day(today)&" and month(date1)="&month(today)&" and year(date1)="&year(today)&"and closingtime is null"

rs.open query1,con,2,3

if rs.eof then

rs.addnew
rs("date1")=date()
rs("openingtime")=time()
rs("openby")=uname
rs.update
'response.write "<P ALIGN=CENTER><span class='WSRightBold'>HAVE A NICE DAY</span></p>"
response.clear
myurl= "securityhome.asp?uname="&uname&"&flag=3"
response.redirect(myurl)
Else
'response.write "<P ALIGN=CENTER><span class='WSRightBold'>THE APPLICATION IS ALREADY OPENED FOR THE DAY  BY "& UCASE(rs("openby")) &". <BR>HAVE A NICE DAY</span></P>"
response.clear
myurl= "securityhome.asp?uname="&uname&"&flag=4"
response.redirect(myurl)

'response.write "<P ALIGN=CENTER><span class='WSRightBold'><a href='open.asp?new=yes'>click here for open any way</a>.</span></p>"
End if
rs.close
con.close
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
