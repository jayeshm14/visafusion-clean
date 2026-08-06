<%@ Language=VBScript %>
<!-- #include file="connection.asp" -->
<script language="javascript">
function checkAll()
{
a=document.FORM1.country.value
ulen=a.length
//alert("value & len:"+a+ulen)
if (ulen==0)
{
alert("COUNTRY NAME IS REQUIRED")
return false
}
}
</script>

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
            <table width="80%" border="0" cellpadding="1" cellspacing="1" align="center">
              <tr> 
                <td><!-- #include file="topadmin.asp" --></td>
              </tr>
              <tr> 
                <td> 
                  <table width="75%" align="center" cellpadding="0" cellspacing="0">
                    <tr bgcolor="#FFE898"> 
                      <td height="19"> 
                        <div align="center"><span class="tableCaption">Embassy</span> 
                        </div>
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
                            <td bgcolor="#FFFFFF" align="center"> 
                              <table width="100%" border="0" bgcolor="#FFFFF8" cellpadding="0" cellspacing="0" background="images/backform.jpg" >
                                <tr> 
                                  <td> 
                                    <form action="addembassy.asp"  method=post name=FORM1 onSubmit="return checkAll()">
                                      
                        <table align=center border=0 cellpadding=1 cellspacing=1 width=75% id=TABLE1>
                          <tr> 
                            <td><b><font color="red" face="Verdana" size="2">COUNTRYNAME</font></b></td>
                            <td><font color=red face=""> 
                              <input  name="country" onBlur="javascript:checkAll()" >
                              </font></td>
                          </tr>
                          <tr> 
                            <td><b><font color="red" face="Verdana" size="2">EMBASSY 
                              NAME</font></b></td>
                            <td> 
                              <input  name=embassy type=text>
                            </td>
                          </tr>
                          <tr> 
                            <td><b><font color="red" face="Verdana" size="2">STREET-1</font></b></td>
                            <td><font color=red face=""> 
                              <input  name=street1 type=text>
                              </font></td>
                          </tr>
                          <tr> 
                            <td><b><font color="red" face="Verdana" size="2">STREET-2</font></b></td>
                            <td><font color=red face=""> 
                              <input name=street2 type=text>
                              </font></td>
                          </tr>
                          <tr> 
                            <td><b><font color="red" face="Verdana" size="2">AREA</font></b></td>
                            <td><font color=red face=""> 
                              <input name=area type=text>
                              </font></td>
                          </tr>
                          <tr> 
                            <td><b><font color="red" face="Verdana" size="2">CITY</font></b></td>
                            <td><font color=red> 
                              <input name=city type=text>
                              </font></td>
                          </tr>
                          <tr> 
                            <td><b><font color="red" face="Verdana" size="2">PHONE 
                              NO:</font></b></td>
                            <td> 
                              <input name=phoneno type=text>
                            </td>
                          </tr>
                          <tr> 
                            <td><b><font color="red" face="Verdana" size="2">FAX 
                              NO:</font></b></td>
                            <td> 
                              <input name=faxno type=text>
                            </td>
                          </tr>
                          <tr> 
                            <td><b><font color="red" face="Verdana" size="2">EMAILID</font></b></td>
                            <td> 
                              <input name=emailid type=text>
                            </td>
                          </tr>
                          <tr> 
                            <td><b><font color="red" face="Verdana" size="2">WORKING 
                              HOURS</font></b></td>
                            <td> 
                              <input name=workingh type=text>
                            </td>
                          </tr>
                          <tr> 
                            <td><b><font color="red" face="Verdana" size="2">WEB 
                              SITE</font></b></td>
                            <td> 
                              <input name=chancery type=text>
                            </td>
                          </tr>
                          <tr> 
                            <td><b><font color="red" face="Verdana" size="2">CHANCERY 
                              PHONE</font></b></td>
                            <td> 
                              <input name=chanceryphone type=text>
                            </td>
                          </tr>
                          <tr> 
                            <td><b><font color="red" face="Verdana" size="2">CHANCERY 
                              ADDRESS</font></b></td>
                            <td> 
                              <input name=chanceryaddress type=text size="30">
                            </td>
                          </tr>
                          <td align=right><font text=red> 
                            <input name=submit1 type=submit value=Submit>
                            </font></td>
                          <td text="red"> 
                            <input id=reset1 name=reset1 type=reset value=Reset>
                          </td>
                          </tr>
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
