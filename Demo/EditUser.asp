<%@ Language=VBScript %>
<!-- #include file="connection.asp" -->
<%
response.buffer= true
 
if session("uname")="" then
response.clear
response.redirect "relogin.asp?rsn=S"
end if
%>
<html><head>
<script language="javascript">
function checkAll()
{
username=document.userform.username.value
pass1=document.userform.Pass1.value
pass2=document.userform.Pass2.value
MYflag=0
flag=0
msg=""
a=document.userform.username.value
len1=a.length
//alert("value & len:"+a+ulen)
if (len1==0)
{
msg=msg+"USER NAME IS REQUIRED.\n"
flag=1
}


for (i=0 ; i<len1;i++)
{
  str=a.substring(i,i+1)
  
	if(str==" ")
	{ 
	
	 MYflag=1
	}
}
if (MYflag==1)
{
msg=msg+"SPACES ARE NOT ALLOWED IN USER NAME.\n"
flag=1
}
if (pass1=="" || pass2=="")
{
msg=msg+"PASSWORD CAN NOT BE BLANK.\n"
flag=1
}

if (pass1!=pass2)
{
msg=msg+"PASSWORD AND CONFIRM SHOULD BE SAME.\n"
flag=1
}

if (flag==1)
{
alert(msg)
return false;
}

}
</script>


<title>www.udaanindia.com</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>

<body bgcolor="#FFFFFF" topmargin=0 leftmargin=0 marginwidth=0 marginheight=0 onLoad="MM_preloadImages('images/profilen2.gif','images/updaten2.gif','images/registrationn2.gif','images/contactn2.gif','images/queriean2.gif','images/logout2.gif')" >
<table width="80%" border="0" cellpadding="1" cellspacing="1" align="center">
  <tr> 
    <td><!-- #include file="topadmin.asp" -->
  
  <tr> 
    <td> 
      <table width="75%" align="center" cellpadding="0" cellspacing="0">
        <tr bgcolor="#FFE898"> 
          <td height="19"> 
            <div align="center"><span class="tableCaption">Edit User Information</span></div>
          </td>
        </tr>
      </table>
    </td>
  </tr>
  <tr> 
    <td height="2" align="center"> 
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
                     <FORM action="editdonetest.asp"  method=post name=userform  onsubmit="return checkAll()">
                          
                        <table align=center 
border=0 cellpadding=1 cellspacing=1 width=75% id=TABLE1>
                          <%
                           

set rs=server.createobject("adodb.recordset")
stmt="select * from udaan_users where username='"&lcase(trim(request("username")))&"'"
rs.open stmt,con,2,3
if rs.eof then
response.write " Data not Found"
else
%> 
                          <TR> 
                            <TD><b><font color="#FF0000" face="Verdana" size="2">USERNAME</font></b></TD>
                            <TD><FONT color="#CC0000" face=""> <% if ucase(session("uname"))="UMA" or ucase(session("su"))="Y" then %> 
                              <input type="text" name="username" value="<%=ucase(rs("username")) %>">
                              <% else %> <%=ucase(rs("username")) %> 
                              <INPUT  type="hidden" name="username" value="<%=ucase(rs("username")) %>" >
                              <% end if %> 
                              <INPUT  type="hidden" name="oldusername" value="<%=ucase(rs("username")) %>" >
                              </FONT></TD>
                          </TR>
                          <TR> 
                            <TD><b><font color="#FF0000" face="Verdana" size="2">PASSWORD</font></b></TD>
                            <TD> 
                              <INPUT  name=Pass1 type=Password value="<%= ucase(rs("password")) %>">
                              <% if ucase(session("uname"))="UMA" or ucase(session("su"))="Y" then %><%=ucase(rs("password"))%><% end if %> 
                            </TD>
                          </TR>
                          <TR> 
                            <TD><b><font color="#FF0000" face="Verdana" size="2">CONFIRM 
                              PASSWORD</font></b></TD>
                            <TD> 
                              <INPUT  name=Pass2 type=Password value="<%= ucase(rs("password")) %>">
                            </TD>
                          </TR>
                          <%' if ucase(session("uname"))="UMA" then %> 
                          <TR> 
                            <TD><b><font color="#FF0000" face="Verdana" size="2">PRIVILEGE</font></b></TD>
                            <TD><FONT color="#CC0000" face=""> 
                              <select  name=privilege value="">
                                <option value="ADM" <% if ucase(rs("privilege"))="ADM" then
           response.write "Selected" 
           End If%> >ADMINISTRATOR</option>
                                <option value="EMP" <% if ucase(rs("privilege"))="EMP" then
           response.write "Selected" 
           End If%> >EMPLOYEE</option>
                                <option value="AGT" <% if ucase(rs("privilege"))="AGT" then
           response.write "Selected" 
           End If%> >AGENT</option>
                              </select>
                              </FONT></TD>
                          </TR>
                          <%' end if %> 
                          <TR> 
                            <TD><b><font color="#FF0000" face="Verdana" size="2">FIRST 
                              NAME</font></b></TD>
                            <TD><FONT color="#CC0000" face=""> 
                              <INPUT  name=fname type=text value="<%= ucase(rs("firstname")) %>">
                              </FONT></TD>
                          </TR>
                          <TR> 
                            <TD><b><font color="#FF0000" face="Verdana" size="2">LAST 
                              NAME</font></b></TD>
                            <TD><FONT color="#CC0000" face=""> 
                              <INPUT  name=lname type=text value="<%= ucase(rs("lastname")) %>">
                              </FONT></TD>
                          </TR>
                          <TR> 
                            <TD><b><font color="#FF0000" face="Verdana" size="2">STREET-1</font></b></TD>
                            <TD><FONT color="#CC0000" face=""> 
                              <INPUT  name=street1 type=text value="<%= ucase(rs("address1")) %>">
                              </FONT></TD>
                          </TR>
                          <TR> 
                            <TD><b><font color="#FF0000" face="Verdana" size="2">STREET-2</font></b></TD>
                            <TD><FONT color="#CC0000" face=""> 
                              <INPUT name=street2 type=text value="<%= ucase(rs("address2")) %>">
                              </FONT></TD>
                          </TR>
                          <TR> 
                            <TD><b><font color="#FF0000" face="Verdana" size="2">CITY</font></b></TD>
                            <TD><FONT color="#CC0000"> 
                              <INPUT name=city type=text value="<%= ucase(rs("city")) %>">
                              </FONT></TD>
                          </TR>
                          <TR> 
                            <TD><b><font color="#FF0000" face="Verdana" size="2">STATE</font></b></TD>
                            <TD><FONT color="#CC0000" face=""> 
                              <INPUT name=state type=text value="<%= ucase(rs("state")) %>">
                              </font></TD>
                          </TR>
                          <TR> 
                            <TD><b><font color="#FF0000" face="Verdana" size="2">COUNTRY</font></b></TD>
                            <TD><FONT color="#CC0000" face=""> 
                              <INPUT name=country type=text value="<%= ucase(rs("country")) %>">
                              </font></TD>
                          </TR>
                          <TR> 
                            <TD><b><font color="#FF0000" face="Verdana" size="2">PINCODE</font></b></TD>
                            <TD> 
                              <INPUT name=pincode type=text value="<%= ucase(rs("pincode")) %>">
                            </TD>
                          </TR>
                          <TR> 
                            <TD><b><font color="#FF0000" face="Verdana" size="2">PHONE 
                              NO:</font></b></TD>
                            <TD> 
                              <INPUT name=phoneno type=text value="<%= ucase(rs("phoneno"))%>">
                            </TD>
                          </TR>
                          <TR> 
                            <TD><b><font color="#FF0000" face="Verdana" size="2">FAX 
                              NO:</font></b></TD>
                            <TD> 
                              <INPUT name=faxno type=text value="<%= rs("faxno") %>">
                            </TD>
                          </TR>
                          <TR> 
                            <TD><b><font color="#FF0000" face="Verdana" size="2">EMAILID</font></b></TD>
                            <TD> 
                              <INPUT name=emailid type=text value="<%= ucase(rs("emailid")) %>">
                            </TD>
                          </TR>
                          <% if session("uname")="uma" or ucase(session("su"))="Y" then %> 
                          <tr> 
                            <TD ALIGN=left><b><font face="Verdana" size="2" color="#FF0000">Add 
                              This user on server</font></b></td>
                            <td text="red"> 
                              <input type="checkbox" name="web" value="yes">
                            </TD>
                            <% end if %> </TR>
                          <TD ALIGN=right><font text=red> 
                            <INPUT name=submit1 type=submit value=Submit class="ud">
                            </font></td>
                          <td text="red"> 
                            <INPUT id=reset1 name=reset1 type=reset value=Reset class="ud">
                          </TD>
                          </TR>
                          <%
end if 
%> 
                        </table>
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
            </table>
          
        
      
    
  
  <tr>
                <td><!-- #include file="empBottom.asp" --></td>
          
    </tr>

</body>
</html>
