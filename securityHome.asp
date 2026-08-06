<%@ Language=VBScript %>
<!-- #include file="connection.asp" -->
<%
response.buffer= true
%>
<script language="javascript">
function open1()
{
conval=window.confirm("OPENING THE TRANSACTIONS FOR THE DAY?")
if(conval)
{
location.reload();
location.href="open2.asp"
}
}



function close1()
{
conval=window.confirm("ARE YOU SURE TO CLOSE THE TRANSACTIONS FOR THE DAY?")
if(conval)
{
location.reload();
location.href="close.asp"
}

}
</script>
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
          <div align="center"><span class="tableCaption"><font face="Verdana" size="3"><b><img src="updateimg/Security%20Heading.jpg" width="200" height="81"></b></font></span></div>
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
                      <td colspan="3">&nbsp;</td>
                    </tr><form name="searchform" action="agenttestsubmit.asp">
                    <tr> 
                      <td > 
                        <div align="center"><span class="WSRightBold"><a href="javascript:open1()"><font face="Verdana" size="2"><b><font color="#FF0033">OPEN 
                          TRANSACTION</font></b></font></A></span></div>
                      </td>
                        <TD>&nbsp;</td>
			  <td>
                        <div align="center"><span class="WSRightBold"><a href="javascript:close1()"><font face="Verdana" size="2"><b><font color="#FF0033">CLOSE 
                          TRANSACTION</font></b></font></A></span> </div>
                        </span>
                        </td>
                    </tr> </form>
                    <tr> <td colspan="3"> 
                      <div align="center"><span class="WSRightBold"> <%
              
              if  request("flag")=1 then
              response.write "Aplication Is Closed For THe Day "
              elseif   request("flag")=2 then
              response.write "THE APPLICATION IS  NOT OPEN. "
              elseif   request("flag")=3 then
              response.write "HAVE A NICE DAY"
              elseif  request("flag")=4 then
              response.write "THE APPLICATION IS ALREADY OPENED FOR THE DAY   <BR>HAVE A NICE DAY "
              end if
              %>    </div></span></td>
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
