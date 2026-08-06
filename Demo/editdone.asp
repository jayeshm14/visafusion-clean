<%@ Language=VBScript %>
<!-- #include file="connection.asp" -->
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
doEdit="Y"
set rs=server.createobject("adodb.recordset")
rs.open "select* from udaan_users where username='"&ucase(request("username"))&"'",con,2,3
if not rs.eof then
response.write "USER WITH THIS NAME ALREADY EXISTS.<BR> <a href='javascript:history.back()'>CLICK HERE</a> TO EDIT THE USER NAME."
doEdit="N"
end if

rs.close
if doEdit="Y" then
stmt="select * from  udaan_users where username='"&request("oldusername")&"'"
'response.write stmt
rs.open stmt,con,2,3
if not rs.eof then
rs("username")=request("username")
rs("password")=lcase(request("pass1"))
rs("privilege")=lcase(request("privilege"))
rs("firstname")=lcase(request("fname"))
rs("lastname")=lcase(request("lname"))
rs("address1")=lcase(request("street1"))
rs("address2")=lcase(request("street2"))
rs("city")=lcase(request("city"))
rs("state")=lcase(request("state"))
rs("country")=lcase(request("country"))
rs("phoneno")=lcase(request("phoneno"))
rs("faxno")=lcase(request("faxno"))
rs("pincode")=lcase(request("pincode"))
rs("emailid")=lcase(request("emailid"))
rs.update
end if
response.write"<font size='2' color='#CC0000' face='Arial, Helvetica, sans-serif'>THE USER <b>"&UCASE(request("username")) &" </b> HAS BEEN EDITED SUCCESSFULLY.<BR></FONT>"
End if
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
