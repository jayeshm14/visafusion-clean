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
<html>
<head>
<title>www.udaanindia.com</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="Styles.css">
</head>

<body bgcolor="#FFFFFF"  topmargin=0 leftmargin=0 marginwidth=0 marginheight=0 >
<table width="75%" border="0" cellspacing="0" cellpadding="0" align="center">
  <tr valign="top" align="left"> 
    <td>
<% if session("priv")="adm" then
%> 
<!-- #include file="topadmin.asp"-->           
<%
else
%>
<!-- #include file="top.asp"--> 
<% 
end if
%>
</td>
  </tr>
  <tr> 
    <td>&nbsp;</td>
  </tr>
  <tr> 
    <td> 
      <table width="75%" align="center" cellpadding="0" cellspacing="0">
        <tr bgcolor="#FFE898"> 
          <td height="19"> 
            <div align="center"><span class="tableCaption">AGENT INFORMATION</span></div>
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
                        <div align="right"><span class="WSRightBold">AGENT NAME</span> 
                          <span class="WSRightBold"> :</span><span class="WSRightBold"> 
                          </span></div>
                      </td>
                      <td width="50%"> <form name="searchform" action="agenttestsubmit.asp">
                        <div align="left"><span class="WSRightBold"> 
                          <select size=1  name="agent">
                            <%
                                             Call LoadListBox("agents",agentID)
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
                          <input type="submit"  class="ud" name="submit" value="View" >
<% if session("priv")="adm" then %>
                          <input type="submit"  class="ud" name="submit" value="Edit" >
                          <input type="submit"  class="ud"  name="submit" value="Add" >
<% end if %>
                          <input type="submit"  class="ud" name="submit" value="View Status">
<% if session("priv")="adm" then %>
                          <input type="submit"  class="ud" name="submit" value="E-mail Status">
                          <input type="submit"  class="ud" name="submit" value="Statement">
                          <input type="submit"  class="ud" name="submit" value="Receipt">
<% end if %>
                        </div></span>
                        </form> </td>
                    </tr>
                    <tr> <td colspan="3"> 
                      <div align="center"><span class="WebSite"> <%
              
              if request("agent")<> "" and request("flag")=2 then
              response.write "For Agent "& ucase(request("agent"))&" New Information saved. "
              elseif request("agent")<> "" and request("flag")=1 then
              response.write "Agent "& ucase(request("agent"))&" Alredy Exist,Change User Name. "
              elseif request("agent")<> "" and request("flag")=3 then
              response.write "Agent " &ucase(request("agent"))&" Has Been Added Successfully. "
              elseif request("agent")<> "" and request("flag")=4 then
              response.write "Agent "& ucase(request("agent"))&" Already  Exist,Change User Name "
              end if
              %>        </div></span></td>
                    </tr>
                    <tr> 
                      <td colspan="3"> 
                        <div align="center"><span class="WebSite"><!-- #include file="empBottom.asp" --></span> 
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
