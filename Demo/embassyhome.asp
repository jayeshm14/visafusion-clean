<%@ Language=VBScript %>
<!-- #include file="connection.asp" -->
<%
response.buffer= true

if session("uname")="" then
response.clear
response.redirect "relogin.asp?rsn=S"
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
          <div align="center"><img src="updateimg/Embassy%20Information%20Heading.jpg" width="300" height="69"></div>
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
                        <div align="right"><span class="WSRightBold">EMBASSY NAME</span> 
                          <span class="WSRightBold"> :&nbsp;&nbsp;&nbsp;</span><span class="WSRightBold"> 
                          </span><span class="WSRightBold"> </span></div>
                      </td><form name="searchform" action="embassytestsubmit.asp">
                      <td width="50%"> 
                        <div align="left"><span class="WSRightBold"> 
                          <select size=1  name="country">
                            <%
                                              Call LoadListBox("embassy",embassyID)
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
                          <input type="submit"  class="ud" name="submit" value="  Add  " >
      <input type="submit" size="20" class="ud" name="submit" value="  Edit  " >
                        </div></span>
                        </form> </td>
                    </tr>
                    <tr> <td colspan="3"> 
                      <div align="center"><span class="WebSite"> <%
              
              if request("country")<> "" and request("flag")="3" then
              response.write "Information Of "& ucase(request("country"))&" Updated "
              elseif request("country")<> "" and request("flag")="2" then
              response.write "Country "& ucase(request("country"))&" Alredy Exist, Change The Name "
              elseif request("country")<> "" and request("flag")="1" then
              response.write "Country "& ucase(request("country"))&" Added Successfuly."
              elseif request("Country")<> "" and request("flag")=4 then
              response.write "Country "& ucase(request("country"))&" Updated Successfully"
              end if
              %>       </div></span></td>
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
