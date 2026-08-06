<%@ Language=VBScript %>
<!-- #include file="connection.asp" -->

<script language="javascript">
function checkAll()
{
a=document.FORM1.countryd.value
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

<body bgcolor="#FFFFFF" topmargin=0 leftmargin=0 marginwidth=0 marginheight=0 >
<table width="80%" border="0" cellpadding="1" cellspacing="1" align="center">
  <tr> 
    <td><!-- #include file="topadmin.asp" --></td>
  </tr>
  <tr> 
    <td> 
      <table width="75%" align="center" cellpadding="0" cellspacing="0">
        <tr bgcolor="#FFE898"> 
          <td height="19"> 
            <div align="center"><span class="tableCaption">Edit Information</span></div>
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
                        <form action="editedone.asp"  method=post name=FORM1 onSubmit="return checkAll()">
                          
                        
                      <table align=center 
border=0 cellpadding=1 cellspacing=1 width=75% id=TABLE1>
                        <%
            
                countryid=cint(request("country"))

set rs=server.createobject("adodb.recordset")
stmt="select * from embassy where embassyid="&countryid
rs.open stmt,con,2,3
 
 if rs.eof then
response.write " Data not Found"
else

%> 
                        <tr> 
                          <input type= "hidden" name="countryid" value="<%= countryid %>" >
                          <input type= "hidden" name="oldcountryd" value="<%=ucase( rs("description")) %>" >
                          <td><b><font color="red" face="Verdana" size="2">COUNTRY 
                            NAME :</font></b></td>
                          <td><font color=red face=""> 
                            <input type= "text" name="countryd" value="<%=ucase( rs("description")) %>" onBlur="javascript:checkAll()" >
                            </font></td>
                        </tr>
                        <tr> 
                          <td><b><font color="red" face="Verdana" size="2">EMBASSY 
                            NAME : </font></b></td>
                          <td> 
                            <input  name=embassyname type=text value="<%=ucase(rs("embassyname")) %>">
                          </td>
                        </tr>
                        <tr> 
                          <td><b><font color="red" face="Verdana" size="2">STREET 
                            - 1 : </font></b></td>
                          <td> 
                            <input  name=street1 type=text value="<%=ucase(rs("street1")) %>">
                          </td>
                        </tr>
                        <tr> 
                          <td><b><font color="red" face="Verdana" size="2">STREET 
                            - 2 :</font></b></td>
                          <td> 
                            <input  name=street2 type=text value="<%= ucase(rs("street2")) %>">
                          </td>
                        </tr>
                        <tr> 
                          <td><b><font color="red" face="Verdana" size="2">AREA 
                            : </font></b></td>
                          <td><font color=red face=""> 
                            <input  name=area type=text value="<%= ucase(rs("area")) %>">
                            </font></td>
                        </tr>
                        <tr> 
                          <td><b><font color="red" face="Verdana" size="2">CITY 
                            : </font></b></td>
                          <td><font color=red face=""> 
                            <input  name=city type=text value="<%=ucase(rs("city")) %>">
                            </font></td>
                        </tr>
                        <tr> 
                          <td><b><font color="red" face="Verdana" size="2">PHONE 
                            NO. : </font></b></td>
                          <td><font color=red face=""> 
                            <input  name=phoneno type=text value="<%= rs("phoneno") %>">
                            </font></td>
                        </tr>
                        <tr> 
                          <td height="32"><b><font color="red" face="Verdana" size="2">FAX 
                            NO. :</font></b></td>
                          <td height="32"><font color=red face=""> 
                            <input name=faxno type=text value="<%= rs("faxno") %>">
                            </font></td>
                        </tr>
                        <tr> 
                          <td><b><font color="red" face="Verdana" size="2">EMAIL 
                            ID. : </font></b></td>
                          <td><font color=red> 
                            <input name=email type=text value="<%= lcase(rs("emailid")) %>">
                            </font></td>
                        </tr>
                        <tr> 
                          <td><b><font color="red" face="Verdana" size="2">WORKING 
                            HOURS : </font></b></td>
                          <td><font color=red face=""> 
                            <input name=workingh type=text value="<%= ucase(rs("workinghours")) %>">
                            </font></td>
                        </tr>
                        <tr> 
                          <td><b><font color="red" face="Verdana" size="2">WEB 
                            SITE : </font></b></td>
                          <td><font color=red face=""> 
                            <input name=chancery type=text value="<%= ucase(rs("chancery")) %>">
                            </font></td>
                        </tr>
                        <tr> 
                          <td><b><font color="red" face="Verdana" size="2">CHANCERY 
                            PHONE :</font></b></td>
                          <td> 
                            <input name=chanceryphone type=text value="<%= ucase(rs("chanceryphone")) %>">
                          </td>
                        </tr>
                        <tr> 
                          <td><b><font color="red" face="Verdana" size="2"> CHANCERY 
                            ADDRESS :</font></b></td>
                          <td> 
                            <input name=chanceryaddress type=text value="<%= ucase(rs("chanceryaddress"))%>">
                          </td>
                        </tr>
                        <tr>
                          <td align="center"><span class="WSRightBold"> ADD TO 
                            THE WEB SERVER? </span></td>
                          <td> 
                            <input type="Checkbox" name="WebEntry" value="Y" checked >
                          </td>
                        </tr>
                        <input type="hidden" name="flag" value="y">
                        <tr>
                          <td colspan="2" align="center">
                            <input type="submit" value="Submit" class="ud">
                          </td>
                        </tr></form>
                        <%
end if 
%> 
                      </table>
         
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
