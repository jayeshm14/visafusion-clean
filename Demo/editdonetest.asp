<%@ Language=VBScript %>
<!-- #include file="connection.asp" -->
<% response.buffer=true
%>
<html>
<head>
<title>www.udaanindia.com</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>

<body bgcolor="#FFFFFF"  topmargin=0 leftmargin=0 marginwidth=0 marginheight=0 onLoad="MM_preloadImages('images/profilen2.gif','images/updaten2.gif','images/registrationn2.gif','images/contactn2.gif','images/queriean2.gif','images/logout2.gif')" >
<table width="75%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td>
      <table width="75%" border="0" cellpadding="0" cellspacing="0">
        <tr valign="top" align="left">
          
          <td width="98%"> 
            <table width="75%" border="0" cellspacing="0" cellpadding="0">
              <tr valign="top" align="left"> 
                <td><!-- #include file="topadmin.asp" --></table></td>
              </tr>
              <tr>
                <td>
                <%
olduser=request("oldusername")
newuser=request("username")
'doEdit="Y"
set rs=server.createobject("adodb.recordset")
stmt="select * from  udaan_users where username='" &olduser&"'"
rs.open stmt,con,2,3
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

if request("web")="yes" then
%>
<!-- #include file="connectionweb.asp" -->
<%
set rsweb=server.createobject("adodb.recordset")
stmtweb="select * from  udaan_users where username='" &olduser&"'"
rsweb.open stmtweb,webcon,2,3

if rsweb.eof then
rsweb.addnew
end if
rsweb("username")=request("username")
rsweb("password")=lcase(request("pass1"))
rsweb("privilege")=lcase(request("privilege"))
rsweb("firstname")=lcase(request("fname"))
rsweb("lastname")=lcase(request("lname"))
rsweb("address1")=lcase(request("street1"))
rsweb("address2")=lcase(request("street2"))
rsweb("city")=lcase(request("city"))
rsweb("state")=lcase(request("state"))
rsweb("country")=lcase(request("country"))
rsweb("phoneno")=lcase(request("phoneno"))
rsweb("faxno")=lcase(request("faxno"))
rsweb("pincode")=lcase(request("pincode"))
rsweb("emailid")=lcase(request("emailid"))
rsweb.update

end if


'response.redirect"THE USER <b>"&UCASE(request("username")) &" </b> HAS BEEN EDITED SUCCESSFULLY.<BR>"
response.clear
  myurl= "userhome.asp?uname="&olduser&"&flag=5"
  response.redirect(myurl)
%>
                </td>
              </tr>
            </table>
          </td>
        </tr>
      </table>
    
  
  <tr>
                <td><!-- #include file="empBottom.asp" --></td>
          
    </tr>

</body>
</html>
