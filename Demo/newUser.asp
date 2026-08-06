<%@ Language=VBScript %>
<!-- #include file="connection.asp" -->
<%
response.buffer= true
if session("uname")="" then
response.clear
response.redirect "relogin.asp?rsn=V"
end if
if session("priv")="" then
response.clear
response.redirect "relogin.asp?rsn=V"
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
            <div align="center"><span class="tableCaption"> User Information</span></div>
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
                     <FORM action="addnewuser.asp"  method=post name=userform onsubmit="return checkAll()">
                          
                        <table align=center 
border=0 cellpadding=1 cellspacing=1 width=75% id=TABLE1>
                          <TR> 
                            <td ><b><font color="red" face="Verdana" size="2">USERNAME</font></b></TD>
                            <td align="left"><FONT color=red face=""> 
                              <INPUT  name="username"  size=20>
                              </FONT></TD>
                            <td>&nbsp;</td>
                          </TR>
                          <TR> 
                            <td ><b><font color="red" face="Verdana" size="2">PASSWORD</font></b></TD>
                            <td> 
                              <INPUT  name=Pass1 type=Password size=20>
                            </TD>
                            <td>&nbsp;</td>
                          </tr>
                          <TR> 
                            <td ><b><font color="red" face="Verdana" size="2">CONFIRM 
                              PASSWORD</font></b></TD>
                            <TD> 
                              <INPUT  name=Pass2 type=Password size=20>
                            </TD>
                            <td>&nbsp;</td>
                          </tr>
                          <TR> 
                            <td ><b><font color="red" face="Verdana" size="2">PRIVILEGE</font></b></TD>
                            <TD><FONT color=red face=""> 
                              <select  name=privilege>
                                <option value="adm">ADMINISTRATOR</option>
                                <option value="emp">EMPLOYEE</option>
                                <option value="agt">AGENT</option>
                              </select>
                              </FONT></TD>
                            <td>&nbsp;</td>
                          </tr>
                          <TR> 
                            <td ><b><font color="red" face="Verdana" size="2">FIRST 
                              NAME</font></b></TD>
                            <TD><FONT color=red face=""> 
                              <INPUT  name=fname type=text>
                              </FONT></TD>
                            <td>&nbsp;</td>
                          </tr>
                          <TR> 
                            <td ><b><font color="red" face="Verdana" size="2">LAST 
                              NAME</font></b></TD>
                            <TD><FONT color=red face=""> 
                              <INPUT  name=lname type=text>
                              </FONT></TD>
                            <td>&nbsp;</td>
                          </tr>
                          <TR> 
                            <td ><b><font color="red" face="Verdana" size="2">ADDRESS-1</font></b></TD>
                            <TD><FONT color=red face=""> 
                              <INPUT  name=street1 type=text>
                              </FONT></TD>
                            <td>&nbsp;</td>
                          </tr>
                          <TR> 
                            <td ><b><font color="red" face="Verdana" size="2">ADDRESS-2</font></b></TD>
                            <TD><FONT color=red face=""> 
                              <INPUT name=street2 type=text>
                              </FONT></TD>
                            <td>&nbsp;</td>
                          </tr>
                          <TR> 
                            <td ><b><font color="red" face="Verdana" size="2">CITY</font></b></TD>
                            <TD><FONT color=red> 
                              <INPUT name=city type=text>
                              </FONT></TD>
                            <td>&nbsp;</td>
                          </tr>
                          <TR> 
                            <td ><b><font color="red" face="Verdana" size="2">STATE</font></b></TD>
                            <TD><FONT color=red face=""> 
                              <INPUT name=state type=text>
                              </font></TD>
                            <td>&nbsp;</td>
                          </tr>
                          <TR> 
                            <td ><b><font color="red" face="Verdana" size="2">COUNTRY</font></b></TD>
                            <TD><FONT color=red face=""> 
                              <INPUT name=country type=text>
                              </font></TD>
                            <td>&nbsp;</td>
                          </tr>
                          <TR> 
                            <td ><b><font color="red" face="Verdana" size="2">PIN 
                              CODE</font></b></TD>
                            <TD> 
                              <INPUT name=pincode type=text>
                            </TD>
                            <td>&nbsp;</td>
                          </tr>
                          <TR> 
                            <td ><b><font color="red" face="Verdana" size="2">PHONE 
                              NO:</font></b></TD>
                            <TD> 
                              <INPUT name=phoneno type=text>
                            </TD>
                            <td>&nbsp;</td>
                          </tr>
                          <TR> 
                            <td ><b><font color="red" face="Verdana" size="2">FAX 
                              NO:</font></b></TD>
                            <TD> 
                              <INPUT name=faxno type=text>
                            </TD>
                            <td>&nbsp;</td>
                          </tr>
                          <TR> 
                            <td ><b><font color="red" face="Verdana" size="2">EMAILID</font></b></TD>
                            <TD> 
                              <INPUT name=emailid type=text>
                            </TD>
                            <td>&nbsp;</td>
                          </tr>
                          <% if session("uname")="uma" or ucase(session("su"))="Y"then %> 
                          <tr> 
                            <TD ALIGN=left><b><font face="Verdana" size="2"><font color="#FF0000">Add 
                              This user on server</font></font></b></td>
                            <td text="red"> 
                              <input type="checkbox" name="web" value="yes">
                            </TD>
                          </TR>
                          <% end if %> 
                          <tr> 
                            <TD ALIGN=right><font text=red> 
                              <INPUT name=submit1 type=submit value=Submit class="ud">
                              </font></td>
                            <td text="red"> 
                              <INPUT id=reset1 name=reset1 type=reset value=Reset class="ud">
                            </TD>
                          </TR>
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
