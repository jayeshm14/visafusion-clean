<%@ Language=VBScript %>
<!-- #include file="connection.asp" -->
<% response.buffer=true
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
                <td>
              <%
            

set rs=server.createobject("adodb.recordset")
stmt="select* from udaan_users where username='"&request("username")&"'" & "and password='"& request("pass1")&"'"
rs.open stmt,con,2,3
if rs.eof then
'response.write "YOU ARE NOT AUTHORIZED TO CHANGE THE PASSWORD. <br>PLEASE CHECK USERNAME OR PASSWORD."
response.clear
  myurl= "changepassword.asp?flag=3"
  response.redirect(myurl)
else
if lcase(request("pass2"))<>lcase(request("pass3")) then
'response.write"PLEASE ENTER THE SAME VALUES FOR NEW AND CONFIRM PASSWORD. "
response.clear
  myurl= "changepassword.asp?flag=2"
  response.redirect(myurl)
else
rs("password")=lcase(request("pass2"))
rs.update
'response.write "PASSWORD CHANGED SUCCESSFULLY."
response.clear
  myurl= "changepassword.asp?flag=1"
  response.redirect(myurl)
end if
end if
rs.close

%>
                
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
