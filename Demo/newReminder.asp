<%@ Language=VBScript %>
<!-- #include file="connection.asp" -->

<html>
<head>
<script language="javascript">
<!--
function Checkdate()
{

a=document.schedular.viewdate.value
ulen=a.length

//alert("value & len:"+a+ulen)
if (ulen==0)
{
alert("TASK DATE IS REQUIRED")
return false
}
}
-->
</script>


<title>www.udaanindia.com</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

</head>

<body bgcolor="#FFFFFF" topmargin=0 leftmargin=0 marginwidth=0 marginheight=0 >
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
             
               <tr> <td>
                <form Name="schedular" action="Addtoschedular.asp" method="Post" onsubmit="return Checkdate()">
                <input type=Hidden name="from" value="<%=request("uname")%>" >
                <h2><p align="center"> COMPOSE THE MESSAGE </p></h2>
                <table border=0 align="center">
              <tr><td><font size="2" face="Arial, Helvetica, sans-serif" color="#3300CC">
		TO</font>
		</td> 
		<td><select size=1 name="to" >
<%                 
set rs=server.createobject("adodb.recordset")
rs.activeconnection=con
rs.open "select username from udaan_users where privilege='adm' or privilege='emp' or privilege='su' order by username",con,2,3
while not rs.eof
response.write("<option value='"&rs("username")&"'")
if lcase(rs("username"))=lcase(request("uname")) then
response.write " Selected"
end if

response.write "> "&ucase(rs("username"))&"</option>"

rs.movenext
wend
rs.close
%> 
                    </select>
		</td></tr> 
               <tr><td><font size="2" face="Arial, Helvetica, sans-serif" color="#3300CC">
		Task Date</font>
		</td> 
		<td><input type=text onblur="Checkdate()" name=viewdate value=<%= SysToUsrDate(Request("view_date"))%> size=10>
		</td></tr> 
		<tr><td><font size="2" face="Arial, Helvetica, sans-serif" color="#3300CC">Subject</font>
		</td> 
		<td> <input type=text name="subject"  size=50>
		
               </td> 
		</tr>
		<tr><td colspan="2"><font size="2" face="Arial, Helvetica, sans-serif" color="#3300CC">
               Comments </font><br>
               <textarea name=description cols=60 rows=10></textarea>
               </td> 
		</tr>
		<tr><td colspan="2" align="center">
          <input type=submit value=Submit>
                </td></tr>
                </table>
                </form>
                
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
