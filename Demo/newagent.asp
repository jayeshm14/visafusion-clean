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
                                    <FORM action="addnewagents.asp"  method=post name="agentform" onsubmit="return checkAll()" >

                              
                        <table width="100%" border="0" cellpadding="0" cellspacing="0" background="images/backform.jpg">
                          <tr> 
                            <td width="45%"> 
                          
                          <TR> 
                            <TD width="45%" bgcolor="#E1FFFF"><b><font face="Verdana" size="2"><FONT color=red>&nbsp;AGENT 
                              NAME</FONT></font></b></TD>
                            <TD width="55%" bgcolor="#E1FFFF"><FONT color=red face=""> 
                              <INPUT  name="agentname" size="20" onBlur="javascript:checkAll(this.value)" onsubmit="return checkAll()">
                              </FONT></TD>
                          </TR>
                          <TR bgcolor="#FFFFF8"> 
                            <TD width="45%"><b><font face="Verdana" size="2"><FONT color=red>&nbsp;COMPANY 
                              NAME</FONT></font></b></TD>
                            <TD width="55%"> 
                              <INPUT  name=company type=text size="40">
                            </TD>
                          </TR>
                          <TR> 
                            <TD width="45%" bgcolor="#E1FFFF"><b><font face="Verdana" size="2"><FONT color=red>&nbsp;COMPLEX 
                              NAME</FONT></font></b></TD>
                            <TD width="55%" bgcolor="#E1FFFF"> 
                              <INPUT  name=complex type=text>
                            </TD>
                          </TR>
                          <TR bgcolor="#FFFFF8"> 
                            <TD width="45%"><b><font face="Verdana" size="2" color="#FF0000"> 
                              &nbsp;AGENCY'S AFFILIATION</font></b></TD>
                            <TD width="55%"> 
                              <input type="checkbox" name="IATA" value="Y">
                              <b><font face="Verdana" size="2">IATA 
                              <input type="checkbox" name="TAAI" value="Y">
                              TAAI 
                              <input type="checkbox" name="TAFI" value="Y">
                              TAFI </font></b></TD>
                          </TR>
                          <TR> 
                            <TD width="45%" bgcolor="#E1FFFF"><b><font face="Verdana" size="2"><FONT color=red>&nbsp;STREET-1</FONT></font></b></TD>
                            <TD width="55%" bgcolor="#E1FFFF"><FONT color=red face=""> 
                              <INPUT  name=street1 type=text>
                              </FONT></TD>
                          </TR>
                          <TR bgcolor="#FFFFF8"> 
                            <TD width="45%"><b><font face="Verdana" size="2"><FONT color=red>&nbsp;STREET-2</FONT></font></b></TD>
                            <TD width="55%"><FONT color=red face=""> 
                              <INPUT name=street2 type=text>
                              </FONT></TD>
                          </TR>
                          <TR> 
                            <TD width="45%" bgcolor="#E1FFFF"><b><font face="Verdana" size="2"><FONT color=red>&nbsp;AREA</FONT></font></b></TD>
                            <TD width="55%" bgcolor="#E1FFFF"> 
                              <INPUT name=area type=text>
                            </TD>
                          </TR>
                          <TR bgcolor="#FFFFF8"> 
                            <TD width="45%"><b><font face="Verdana" size="2"><FONT color=red>&nbsp;CITY</FONT></font></b></TD>
                            <TD width="55%"><FONT color=red> 
                              <INPUT name=city type=text>
                              </FONT></TD>
                          </TR>
                          <TR> 
                            <TD width="45%" bgcolor="#E1FFFF"><b><font face="Verdana" size="2"><FONT color=red>&nbsp;PIN 
                              CODE</FONT></font></b></TD>
                            <TD width="55%" bgcolor="#E1FFFF"> 
                              <INPUT name="pincode" type=text>
                            </TD>
                          </TR>
                          <TR bgcolor="#FFFFF8"> 
                            <TD width="45%"><b><font face="Verdana" size="2"><FONT color=red>&nbsp;PHONE 
                              NO:</FONT></font></b></TD>
                            <TD width="55%"> 
                              <INPUT name="phoneno" type=text>
                            </TD>
                          </TR>
                          <TR> 
                            <TD width="45%" bgcolor="#E1FFFF"><b><font color="red" face="Verdana" size="2">&nbsp;FAX 
                              NO:</font></b></TD>
                            <TD width="55%" bgcolor="#E1FFFF"> 
                              <INPUT name="faxno" type=text>
                            </TD>
                          </TR>
                          <TR bgcolor="#FFFFF8"> 
                            <TD width="45%"><b><font color="red" face="Verdana" size="2">&nbsp;EMAIL 
                              ID</font></b></TD>
                            <TD width="55%"> 
                              <INPUT name="emailid" type=text>
                            </TD>
                          </TR>
                          <TR> 
                            <TD width="45%" bgcolor="#E1FFFF"><b><font color="red" face="Verdana" size="2">&nbsp;DIRECTOR 
                              NAME</font><font face="Verdana" size="2"><font color=red> 
                              &amp; MOBILE NO.</font></font></b></TD>
                            <TD width="55%" bgcolor="#E1FFFF"> 
                              <INPUT name="directorname" type=text>
                              <font color=red face=""> <img src="updateimg/phone1.jpg" width="20" height="20" align="absbottom"> 
                              <input  name=DirectorPH type=text>
                              </font> </TD>
                          </TR>
                          <TR bgcolor="#FFFFF8"> 
                            <TD width="45%"><b><font face="Verdana" size="2"><font color=red>&nbsp;A/C 
                              MANAGER NAME &amp; MOBILE NO.</font></font></b></TD>
                            <TD width="55%"> 
                              <INPUT name="acno" type=text>
                              <font color=red face=""> <img src="updateimg/phone1.jpg" width="20" height="20" align="absbottom"> 
                              <input  name=AcMgrPH type=text>
                              </font> </TD>
                          </TR>
                          <TR> 
                            <TD width="45%" bgcolor="#E1FFFF"> <b><font face="Verdana" size="2" color="#FF0000">&nbsp;VISA'S 
                              INCHARGE'S NAME &amp; MOBILE NO.</font></b></TD>
                            <TD width="55%" bgcolor="#E1FFFF"><font color=red face=""> 
                              <input name=VisaInchargeName type=text>
                              </font><font color=red face=""><img src="updateimg/phone1.jpg" width="20" height="20" align="absbottom"></font><font color=red face=""> 
                              <input  name=VisaInchargePH type=text>
                              </font></TD>
                          </TR>
                          <TR bgcolor="#FFFFF8"> 
                            <TD width="45%"><b><font face="Verdana" size="2"><font color=red>&nbsp;PAYMENT 
                              CONDITION </font></font></b></TD>
                            <TD width="55%"> 
                              <input name=payment type=text >
                              <br>
                              <font size="1">( <font face="Verdana" color="#333333"><b>FIT</b>(14 
                              PAX AND BELOW)</font><b>/</b><font face="Verdana"><b> 
                              GIT</b>(15 PAX AND ABOVE)</font></font> <font size="1"><b>/<font face="Verdana">COURIER</font></b><font face="Verdana">)</font></font></TD>
                          </TR>
                          <TR> 
                            <TD width="45%" bgcolor="#E1FFFF"><b><font face="Verdana" size="2"><font color="#FF0000">&nbsp;Want 
                              to Add on Web Server</font></font></b></TD>
                            <TD width="55%" bgcolor="#E1FFFF"> 
                              <input type="checkbox" name="web" value="yes">
                            </TD>
                          </TR>
                          <tr> 
                            <TD ALIGN=center colspan="2" bgcolor="#FFFFF8"> 
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
