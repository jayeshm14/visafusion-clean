<%@ Language=VBScript %>
<!-- #include file="connection.asp" -->
<html>
<head>
<title>www.udaanindia.com</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="Styles.css">
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
                <td><!-- #include file="top.asp" --></td>
              </tr>
              <tr>
                <td>
                <b><font size='2' color='#CC0000' face='Arial, Helvetica, sans-serif'>EDIT USER INFORMATION :</font></b>

<form name="searchform" action="usertestsubmit.asp">

<table width="30%" border="0">
 <table border=0 align="center"> <tr>
    <td><font size='2' color='#CC0000' face='Arial, Helvetica, sans-serif'><u><b><font size="4"><font size="3">USER NAME</font>:</font></b></u></font></td>
    <td><font color="#DC890C">
            
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
                    
      </font></td>
  </tr><%
              
              if request("username")<> "" and request("flag")="1" then
              response.write "user "& ucase(request("username"))&" new user added succesfully "
              elseif request("username")<> "" and request("flag")="2" then
              response.write "user "& ucase(request("username"))&" Alredy Exist "
              elseif request("agent")<> "" and request("flag")=3 then
              response.write "agent"&ucase(request("agent"))&" Alredy Exist "
              elseif request("agent")<> "" and request("flag")=4 then
              response.write "agent"&ucase(request("agent"))&" Details Updated "
              end if
              %>
  
   <tr bgcolor="#FFE898"> 
    <td align="center" colspan=2><font color="#DC890C">
      <input type="submit"  class="ud" name="submit" value="Edit" >
      <input type="submit"  class="ud"  name="submit" value="Add" >
      
     
      </font></td>
  </tr>
</table></form>
                
                
                </td>
              </tr>
            </table>
          </td>
        </tr>
      </table>
    </td>
  </tr><tr>
                <td></td>
          
    </tr>
</table>
</body>
</html>
