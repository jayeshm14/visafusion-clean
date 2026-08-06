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
<body bgcolor="#FFFFFF"  topmargin=0 leftmargin=0 marginwidth=0 marginheight=0 onLoad="MM_preloadImages('images/home2.jpg','#982339540000');MM_preloadImages('images/news2.jpg','#982339618320');MM_preloadImages('images/services2.jpg','#982339651880');MM_preloadImages('images/about2.jpg','#982339709880');MM_preloadImages('images/contact2.jpg','#982339751960');MM_preloadImages('images/go2.jpg','#982340617580')">
<table width="75%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td>
      <table width="75%" border="0" cellpadding="0" cellspacing="0">
        <tr valign="top" align="left">
          
          <td width="98%"> 
            <table width="75%" border="0" cellspacing="0" cellpadding="0">
              <tr valign="top" align="left"> 
                <td><!-- #include file="top.asp" --></td>
              </tr>
              <tr>
                <td>
              <%
set rs=server.createobject("adodb.recordset")
stmt="select* from scheduler" 
rs.open stmt,con,2,3

rs.addnew
rs("messageread")="n"
if request("to")<> "" then
rs("messageto")=request("to")
end if
if request("from")<> "" then
rs("messagefrom")=request("from")
end if
if request("viewdate")<> "" then
rs("date")=request("viewdate")
end if
if request("subject")<> "" then
rs("subject")=request("subject")
end if
if request("description")<> "" then
rs("description")=request("description")
end if


rs.update
response.clear
  myurl= "calendar.asp?flag=11"
  response.redirect(myurl)
'response.write "<table width='100%'><tr><td align='center'><font size=2 color=#006600><b> MEESAGE HAS BEEN SENT SUCCESSFULLY.</b></font></td></tr></table>"

RS.CLOSE
%>
               
                </td>
              </tr>
            </table>
          </td>
        </tr>
      </table>
    </td>
  </tr>
</table>
</body>
</html>
