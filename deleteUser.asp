<%@ Language=VBScript %>
<!-- #include file="connection.asp" -->
<%
response.buffer=true
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
              </tr><TR><td>
<%

set rs=server.createobject("adodb.recordset")
stmt="select * from udaan_users where username='"& lcase(trim(request("username")))&"'"
stmt1="delete from udaan_users where username='"& lcase(trim(request("username")))&"'"
rs.open stmt,con,2,3
if rs.eof then
response.write " Data not Found"
else
con.execute stmt1
'response.write " User <b>" & trim(request("username")) & "</b> data has been deleted from database "
response.clear
myurl= "userhome.asp?uname="&request("username")&"&flag=4"
response.redirect(myurl)
end if

%>
</table>
</table>
</table>
</body></html>