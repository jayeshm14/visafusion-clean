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
                
               
                 
                <%  
                date1=date()-30
                 
                 description=request.form("description")
                  
                 
                
                  set rs=server.createobject("adodb.recordset")
                  stmt="select * from dailyupdate where entrydate>#"&date1&"#"
                  rs.open stmt,con,2,3
                  if rs.eof then
                  response.write "<tr><td>NO UPDATE FOUND FOR THIS MONTH<td><tr>"
                  else
                  
                  while not rs.eof
                               
                  response.write "<tr><td>&nbsp;<td><tr>"
                  response.write "<tr><td>"&(rs("description"))&"<td><tr>"
                  
                  rs.movenext
                  wend
                                   
                  end if
                  rs.close
                
                %>
                </table>
                
                                
                </td>
              </tr>
            </table>
          </td>
        </tr>
      </table>
    </td>
  </tr>
  <td width="2%" valign="top" align="left"><!-- #include file="left.asp" --></td>
</table>
</body>
</html>
