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
              </tr>
              <tr>
                <td>
                
<%
 

countrydes=ucase(request("countryd"))
oldcountrydes=ucase(request("oldcountryd"))
dim resFlag
set rs=server.createobject("adodb.recordset")
stmt="select * from  embassy where description='" &countrydes&"' and '"& oldcountrydes&"' <> '"&countrydes&"'"
'response.write stmt
rs.open stmt,con,2,3
if not rs.eof then
response.clear
	resFlag = 2
'myurl= "embassyhome.asp?country="&countrydes&"&flag=2"
'response.redirect(myurl)
  'response.write "country name already exist"
  rs.close
else
  rs.close
  country=cint(request("countryid"))
  response.write country
  stmt="select * from embassy where embassyID="&country
  response.write stmt
  rs.open stmt,con,2,3
  if not rs.eof then
    rs("description")=countrydes
    rs("embassyname")=lcase(request("embassyname"))
    rs("street1")=lcase(request("street1"))
    rs("street2")=lcase(request("street2"))
    rs("area")=lcase(request("area"))
    rs("city")=lcase(request("city"))
    rs("phoneno")=lcase(request("phoneno"))
    rs("faxno")=lcase(request("faxno"))
    rs("emailid")=lcase(request("email"))
    rs("workinghours")=lcase(request("workingh"))
    rs("chancery")=lcase(request("chancery"))
    rs("chanceryphone")=lcase(request("chanceryphone"))
    rs("chanceryaddress")=lcase(request("chanceryaddress"))
    rs.update
    response.clear
	rs.close
	resFlag = 3
	'myurl= "embassyhome.asp?country="&countrydes&"&flag=3"
	'response.redirect(myurl)
    'response.write "new  informa saved"
  end if
  response.clear
	resFlag = 4
  'myurl= "embassyhome.asp?country="&oldcountrydes&"&flag=4"
  'response.redirect(myurl)
end if


if request("WebEntry")="Y" then
%>
<!-- #include file="connectionweb.asp" -->
<%
set rs=server.createobject("adodb.recordset")
stmt="select * from  embassy where description='" &countrydes&"' and '"& oldcountrydes&"' <> '"&countrydes&"'"
'response.write stmt
rs.open stmt,webcon,2,3
if not rs.eof then
response.clear
 resFlag = 2
'myurl= "embassyhome.asp?country="&countrydes&"&flag=2"
'response.redirect(myurl)
  'response.write "country name already exist"
  rs.close
else
  rs.close
  country=cint(request("countryid"))
  response.write country
  stmt="select * from embassy where embassyID="&country
  response.write stmt
  rs.open stmt,webcon,2,3
  if not rs.eof then
    rs("description")=countrydes
    rs("embassyname")=lcase(request("embassyname"))
    rs("street1")=lcase(request("street1"))
    rs("street2")=lcase(request("street2"))
    rs("area")=lcase(request("area"))
    rs("city")=lcase(request("city"))
    rs("phoneno")=lcase(request("phoneno"))
    rs("faxno")=lcase(request("faxno"))
    rs("emailid")=lcase(request("email"))
    rs("workinghours")=lcase(request("workingh"))
    rs("chancery")=lcase(request("chancery"))
    rs("chanceryphone")=lcase(request("chanceryphone"))
    rs("chanceryaddress")=lcase(request("chanceryaddress"))
    rs.update
    response.clear
	resFlag = 3
	'myurl= "embassyhome.asp?country="&countrydes&"&flag=3"
	'response.redirect(myurl)
    'response.write "new  informa saved"
  end if
  response.clear
  resFlag = 4
  'myurl= "embassyhome.asp?country="&oldcountrydes&"&flag=4"
  'response.redirect(myurl)
end if

end if

if resFlag = 3 then
	myurl= "embassyhome.asp?country="&countrydes&"&flag=3"
elseif resFlag = 2 then
	myurl= "embassyhome.asp?country="&countrydes&"&flag=2"
else
	myurl= "embassyhome.asp?country="&oldcountrydes&"&flag=4"
end if
response.redirect(myurl)
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
