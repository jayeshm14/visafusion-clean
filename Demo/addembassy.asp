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
              </tr>
              <tr>
                <td>
                <%

set rs=server.createobject("adodb.recordset")
if trim(request("country"))<>"" then
rs.open "select * from embassy where description='"&request("country")&"'",con,2,3
if rs.eof then
rs.addnew

rs("description")=trim(lcase(request("country")))
rs("embassyname")=lcase(request("embassy"))
rs("street1")=lcase(request("street1"))
rs("street2")=lcase(request("street2"))
rs("area")=lcase(request("area"))
rs("city")=lcase(request("city"))
rs("phoneno")=lcase(request("phoneno"))
rs("faxno")=lcase(request("faxno"))
rs("emailid")=lcase(request("emailid"))
rs("workinghours")=lcase(request("workingh"))
rs("chancery")=lcase(request("chancery"))
rs("chanceryphone")=lcase(request("chanceryphone"))
rs("chanceryaddress")=lcase(request("chanceryaddress"))
rs.update
rs.close

response.clear
myurl= "embassyhome.asp?country="&request("country")&"&flag=1"
response.redirect(myurl)
response.write"<font size='2' color='#CC0000' face='Arial, Helvetica, sans-serif'>THE INFORMATIONS FOR COUNTRY <B> "&ucase(request("country"))&"</b> HAS BEEN ADDED.<BR></font>"

else
response.clear
myurl= "embassyhome.asp?country="&request("country")&"&flag=2"
response.redirect(myurl)
'response.write"<font size='2' color='#CC0000' face='Arial, Helvetica, sans-serif'>THE INFORMATIONS FOR COUNTRY <B> "&ucase(request("country"))&"</b> ALREADY EXISTS IN OUR DATABASE.<BR></font>"
end if
else
response.write"<font size='2' color='#CC0000' face='Arial, Helvetica, sans-serif'>THE INFORMATIONS FOR COUNTRYNAME CANNOT BE BLANK.<BR></font>"
END IF
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
