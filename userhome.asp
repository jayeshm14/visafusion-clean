<%@ Language=VBScript %>
<!-- #include file="connection.asp" -->
<%
response.buffer= true

if session("uname")="" then
response.clear
response.redirect "relogin.asp?rsn=S"
end if
if (ucase(session("uname"))<>"UMA" or ucase(session("uname"))<>"RAJ") and ucase(session("su"))<>"Y" then
'response.redirect "EditUser.asp?username="&session("uname")
end if
%>
<html>
<head>
<title>www.udaanindia.com</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="Styles.css">
</head>

<body bgcolor="#FFFFFF"  topmargin=0 leftmargin=0 marginwidth=0 marginheight=0 >
<table width="75%" border="0" cellspacing="0" cellpadding="0" align="center">
  <tr valign="top" align="left"> 
    <td><!-- #include file="topAdmin.asp" --></td>
  </tr>
  <tr> 
    <td>&nbsp;</td>
  </tr>
  <tr> 
    <td> 
      <table width="75%" align="center" cellpadding="0" cellspacing="0">
        
      <tr bgcolor="#FFFFFF"> 
        <td height="19"> 
          <div align="center"><img src="updateimg/User%20Information%20Heading.jpg" width="318" height="85"></div>
          </td>
        </tr>
      </table>
    </td>
  </tr>
  <tr> 
    <td height="2" ALIGN="CENTER"> 
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
                      <td colspan="2"> 
                        <div align="right"><span class="WSRightBold">USER NAME</span> 
                          <span class="WSRightBold"> :&nbsp;&nbsp;&nbsp;</span><span class="WSRightBold"> 
                          </span><span class="WSRightBold"> </span></div>
                      </td><form name="searchform" action="usertestsubmit.asp">
                      <td width="50%"> 
                        <div align="left"><span class="WSRightBold"> 
                         <select size=1 name="username" >
                      <%

set rs=server.createobject("adodb.recordset")
rs.activeconnection=con
rs.open "select username from udaan_users order by username",con,2,3
while not rs.eof
response.write("<option value='"&rs("username")&"' >")
response.write ucase(rs("username"))
response.write("</option>")
rs.movenext
wend
rs.close
%> 
                    </select>
                          </span></div>
                      </td>
                    </tr>
                    <tr> 
                      <td colspan="3">&nbsp;</td>
                    </tr>
                    <tr> 
                      <td colspan="3"> 
                        <div align="center"><span class="WebSite"> 
       <input type="submit"  class="ud" name="submit" value="Edit " >
      <input type="submit"  class="ud"  name="submit" value="Add " >
      <input type="submit"  class="ud"  name="submit" value="Delete " >
                        </div></span>
                        </form> </td>
                    </tr>
                    <tr> <td colspan="3"> 
                      <div align="center"><span class="WebSite">  <%
              
              if request("uname")<> "" and request("flag")=1 then
              response.write "User "& ucase(request("uname"))&" Added Successfully "
              elseif request("uname")<> "" and request("flag")=2 then
              response.write "User "& ucase(request("uname"))&" Alredy Exist "
              elseif request("uname")<> "" and request("flag")=3 then
              response.write "uname"&ucase(request("agent"))&" Alredy Exist "
              elseif request("uname")<> "" and request("flag")=4 then
              response.write "User "&ucase(request("uname"))&" has been Deleted.  "
              elseif request("uname")<> "" and request("flag")=5 then
              response.write "User "&ucase(request("uname"))&" has been Edited Successfully.  "
              end if
              %>      </div></span></td>
                    </tr>
                    <tr> 
                      <td colspan="3"> 
                        <div align="center"><span class="WebSite"><!-- #include file="Adminbottom.asp" --></span> 
                        </div>
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
  <tr valign="top" align="left"> 
    <td>&nbsp;</td>
  </tr>
</table>
   
</body>
</html>
