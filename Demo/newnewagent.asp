<%@ Language=VBScript %>
<!-- #include file="connection.asp" -->
<html>
<head>
<title>www.udaanindia.com</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script language="javascript">
function checkAll()
{
MYflag=0
flag=0
msg=""
a=document.agentform.agentname.value
len1=a.length
//alert("value & len:"+a+ulen)
if (len1==0)
{
msg=msg+"AGENT NAME IS REQUIRED.\n"
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
payment=document.agentform.payment.value

if (isNaN(payment))
{
msg=msg+"CREDIT ALLOWED MUST BE SOME NUMBER.\n"
flag=1
}
if (flag==1)
{
alert(msg)
return false;
}

}
</script>
</head>

<body bgcolor="#FFFFFF"  topmargin=0 leftmargin=0 marginwidth=0 marginheight=0 onLoad="MM_preloadImages('images/profilen2.gif','images/updaten2.gif','images/registrationn2.gif','images/contactn2.gif','images/queriean2.gif','images/logout2.gif')" >
<table width="75%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td>
      <table width="75%" border="0" cellpadding="0" cellspacing="0">
        <tr valign="top" align="left">

          <td width="98%"> 
            <table width="75%" border="0" cellspacing="0" cellpadding="0">
              <tr valign="top" align="left"> 
                <td><!-- #include file="topadmin.asp" --></table></td>
              </tr>
              <tr>
                <td>
<table width="80%" border="0" cellpadding="1" cellspacing="1" align="center">
  <tr> 
    <td> 
      <table width="75%" align="center" cellpadding="0" cellspacing="0">
        <tr bgcolor="#FFE898"> 
          <td height="19"> 
            <div align="center"><span class="tableCaption">Agent Information</span> </div>
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
                                    <FORM action="newaddnewagents.asp"  method=post name="agentform" onsubmit="return checkAll()" >

                              <table width="100%" border="0" bgcolor="#FFFFF8" cellpadding="0" cellspacing="0" background="images/backform.jpg">
                                <tr> 
                                  <td> 
                                    
                                <TR> 
                                  <TD>&nbsp;&nbsp;&nbsp;<FONT color=red face="arial">AGENT 
                                    NAME</FONT></TD>
                                  <TD><FONT color=red face=""> 
                                    <INPUT  name="agentname" size="20" onBlur="javascript:checkAll(this.value)" onsubmit="return checkAll()">
                                    </FONT></TD>
                                </TR>
                                <TR> 
                                  <TD>&nbsp;&nbsp;&nbsp;<FONT color=red face="">COMPANY 
                                    NAME</FONT></TD>
                                  <TD> 
                                    <INPUT  name=company type=text size="40">
                                  </TD>
                                </TR>
                                <TR> 
                                  <TD>&nbsp;&nbsp;&nbsp;<FONT color=red face="">COMPLEX 
                                    NAME</FONT></TD>
                                  <TD> 
                                    <INPUT  name=complex type=text>
                                  </TD>
                                </TR>
                                <TR> 
                                  <TD>&nbsp;&nbsp;&nbsp;<FONT color=red face="">STREET-1</FONT></TD>
                                  <TD><FONT color=red face=""> 
                                    <INPUT  name=street1 type=text>
                                    </FONT></TD>
                                </TR>
                                <TR> 
                                  <TD>&nbsp;&nbsp;&nbsp;<FONT color=red face="">STREET-2</FONT></TD>
                                  <TD><FONT color=red face=""> 
                                    <INPUT name=street2 type=text>
                                    </FONT></TD>
                                </TR>
                                <TR> 
                                  <TD>&nbsp;&nbsp;&nbsp;<FONT color=red face="">AREA</FONT></TD>
                                  <TD> 
                                    <INPUT name=area type=text>
                                  </TD>
                                </TR>
                                <TR> 
                                  <TD>&nbsp;&nbsp;&nbsp;<FONT color=red>CITY</FONT></TD>
                                  <TD><FONT color=red> 
                                    <INPUT name=city type=text>
                                    </FONT></TD>
                                </TR>
                                <TR> 
                                  <TD>&nbsp;&nbsp;&nbsp;<FONT color=red>PIN CODE</FONT></TD>
                                  <TD> 
                                    <INPUT name="pincode" type=text>
                                  </TD>
                                </TR>
                                <TR> 
                                  <TD>&nbsp;&nbsp;&nbsp;<FONT color=red>PHONE 
                                    NO:</FONT></TD>
                                  <TD> 
                                    <INPUT name="phoneno" type=text>
                                  </TD>
                                </TR>
                                <TR> 
                                  <TD>&nbsp;&nbsp;&nbsp;<FONT color=red></FONT><FONT color=red face="">FAX 
                                    NO:</FONT></TD>
                                  <TD> 
                                    <INPUT name="faxno" type=text>
                                  </TD>
                                </TR>
                                <TR> 
                                  <TD>&nbsp;&nbsp;&nbsp;<FONT color=red></FONT><FONT color=red face="">EMAIL 
                                    ID</FONT></TD>
                                  <TD> 
                                    <INPUT name="emailid" type=text>
                                  </TD>
                                </TR>
                                <TR> 
                                  <TD>&nbsp;&nbsp;&nbsp;<FONT color=red></FONT><FONT color=red face="">DIRECTOR 
                                    NAME</FONT></TD>
                                  <TD> 
                                    <INPUT name="directorname" type=text>
                                  </TD>
                                </TR>
                                <TR> 
                                  <TD>&nbsp;&nbsp;&nbsp;<FONT color=red></FONT><FONT color=red face="">A/C 
                                    NO</FONT></TD>
                                  <TD> 
                                    <INPUT name="acno" type=text>
                                  </TD>
                                </TR>
                                <TR>
                                  <TD>&nbsp;<font color=red></font><font color=red face="">&nbsp;&nbsp;CREDIT 
                                    ALLOWED </font></TD>
                                  <TD>
                                    <input name=payment type=text size="5">
                                    Days(Enter No.) </TD>
                                </TR>
                               
                                  <TD ALIGN=center colspan="2">
                                    <INPUT name=submit1 type=submit value=Submit class="ud">
                                    &nbsp;&nbsp;&nbsp;&nbsp; 
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
  <tr>
                <td><!-- #include file="empBottom.asp" --></td>
          
    </tr>

</table>

</table></body></html>
