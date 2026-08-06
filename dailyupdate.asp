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

<body bgcolor="#FFFFFF">
<table width="80%" border="0" cellpadding="1" cellspacing="1" align="center">
  <tr> 
    <td> 
      <table width="75%" align="center" cellpadding="0" cellspacing="0">
        <tr bgcolor="#FFFFFF"> 
          <td height="19"> 
            <div align="center"><img src="updateimg/Daily%20Updates%20Heading.jpg" width="271" height="81"> 
            </div>
          </td>
        </tr>
      </table>
    </td>
  </tr>
  <tr> 
    <td height="2">
      <table width="75%" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td><img src="images/linetopgreen1.gif" width="660" height="10"></td>
        </tr>
        <tr bgcolor="#009933"> 
          <td> 
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td align="left" width="1"><img src="images/pixelsline.gif" width="1" height="7"></td>
                <td bgcolor="#FFFFFF"> 
                  <table width="100%" border="0" bgcolor="#FFFFF8" cellpadding="0" cellspacing="0" background="images/backform.jpg">
                    <tr> 
                      <td>
                
                             <%  
                flag=request("flag")
                 entryd=request.form("entryd")
                 description=request.form("description")
                  
                 
                if not (flag="" or isempty(flag)) then
                  set rs=server.createobject("adodb.recordset")
                  stmt="select * from dailyupdate where entrydate='"&usrtosysdate(entryd)&"'"
                  rs.open stmt,con,2,3
                  if rs.eof then
                 
                 
                  rs.addnew
                  rs("entrydate")=usrtosysdate(entryd)
                  rs("description")=description
                  rs.update
                  %>
                  <td align="center"><span class="WSRightBold"> Message has been recorded. </span></td>
                 
                  <%
                  else
                   rs("entrydate")=usrtosysdate(entryd)
                  rs("description")=description
                  rs.update
                  %>
                    <td align="center"><span class="WSRightBold"> TODAY'S MESSAGE HAS BEEN UPDATED </span></td>
                  <%
                  end if
                  rs.close
                 end if 
                %>
                
   
                
                 	<form method="post" action="dailyupdate.asp">
                 
                     
                <tr><td><span class="WSRightBold">&nbsp; <FONT color=red face="verdana" size="2"><b>Date :</font> </span></td><td> <input type="text" size="20" name="entryd" value="<%=SysToUsrDate(date())%>"></td></tr>
                <tr><td><span class="WSRightBold">&nbsp; <FONT color=red face="verdana" size="2"><b>Message :</font> </span></td><td> <textarea cols=50 rows=5 name="description"><%=todaysupdate(date())%></textarea></td></tr>
                <input type="hidden" name="flag" value="y">
                <tr><td colspan="2" align="center"><input type="submit" value="Submit" class="ud"></td></tr>
                </form>
              
                      
                     </td>
                    </tr>
                  </table>
                </td>
                <td align="right" width="1"><img src="images/pixelsline.gif" width="1" height="7"></td>
              </tr>
            </table>
          </td>
        </tr>
        <tr> 
          <td><img src="images/linetopgreen2.gif" width="660" height="10"></td>
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
