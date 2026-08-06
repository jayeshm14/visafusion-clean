<%@ Language=VBScript %>
<% server.scripttimeout=3000 %>
<!-- #include file="connection.asp" -->
<%
response.buffer= true
if session("uname")="" then
response.clear
response.redirect "relogin.asp?rsn=V"
end if

%>

<script language="JavaScript">
<!--
function getDate(date)
	{
		var ws = "status:no; help:no; dialogWidth:320px; dialogHeight:300px;";
		var url = "Calendar.html";
                var dt = showModalDialog(url, window, ws);
		if (dt != null) {
			if (dt.month == "")
				date.value = "";
			else
				date.value = dt.date + "/" + dt.month + "/" + dt.year;
		}
	}

//-->
</script>

<script language="JavaScript">
<!--

function numvalid(a)
{
if(isNaN(a.value))
{
alert("Please fill numeric value for " + a.name)
a.focus()
a.select()
}
}

function check()
{
if(document.collection1.refno.value=="")
{
alert("Please enter Ref No.!.")
document.collection1.refno.focus()
return false
}

if(isNaN(document.collection1.refno.value))
{
alert("Please fill numeric value for Ref No.")
document.collection1.refno.focus()
document.collection1.refno.select()
return false
}
document.collection1.submit()
}

function check2()
{
if(document.collection2.pptno.value=="")
{
alert("Please enter Passport No.!.")
document.collection2.pptno.focus()
return false
}
document.collection2.submit()
}
//-->
</script>


<html>
<head>
<title>www.udaanindia.com</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="Styles.css">
</head>

<body bgcolor="#FFFFFF"  topmargin=0 leftmargin=0 marginwidth=0 marginheight=0 >
<table width="75%" border="0" cellspacing="0" cellpadding="0" align="center" height="310">
  <tr valign="top" align="left"> 
    <td height="21">
<% if session("priv")="adm" then
%> 
              
<!-- #include file="topadmin.asp" -->           
      <%
else
%>
<!-- #include file="top.asp" --> 
<% 
end if
%></td>
  </tr>
  <tr> 
    <td height="21">&nbsp;</td>
  </tr>
  <tr> 
    <td height="31">
      <table width="75%" align="center" cellpadding="0" cellspacing="0">
      
        <tr bgcolor=""> 
          <td height="19"> 
            <div align="center"><span class="tableCaption"><img src="updateimg/Advance Search Heading 1.jpg" width="310" height="80"></span><a href="searchEntry1.asp"><span class="WSRightBold"><FONT color=red face="verdana" size="2">search by date</font></a></div> 

          </td>
        </tr>
      </table>
    </td>
  </tr>
  <tr> 
    <td height="216" ALIGN="CENTER"> 
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
                   
                    
                      <tr><td>&nbsp;</td></tr>
                   <tr>
                   <td align="center"> 
<form name=collection1 action="searchPax2.asp" method="post" onSubmit="return check()">
                   <span class="WSRightBold"><FONT color=red face="verdana" size="2">Ref. Number :</font>
                        
                        <input type="text" name="refno" size="10" maxlength="6">
                       
                        <input type="submit" name="Submit2" class="ud" value="Go">
                   </span>
</form>
                      </td>
                    </tr> 
                   <tr>
                   <td align="center"> 
<form name=collection2 action="searchPax2.asp" method="post" onSubmit="return check2()">
                   <span class="WSRightBold"><FONT color=red face="verdana" size="2">Passport Number :</font>
                        
                        <input type="text" name="pptno" size="10" maxlength="10">
                       
                        <input type="submit" name="Submit3" class="ud" value="Go">
                   </span>
</form>
                      </td>
                    </tr> 
                    <tr>
                    
                        </tr>
                   <tr>
                    <td>&nbsp;</td>
                   </tr>
                   <tr>
                    
                   <td align="center"> 
<form name=collection3 action="searchPax2.asp" method="post">
                    <span class="WSRightBold"><FONT color=red face="verdana" size="2">Select Country :</font> 
                       
                   
                    
                      
                        <select name="countryID" size="1">
                          <% 
              call loadlistbox("embassy",embassyID)
              %> 
                        </select>
                        <input type="submit" name="Submit4" class="ud" value="Go">
                    </span>
</form>
                      </td>
                                     
                    </tr>
                    <tr>
                      <td>&nbsp;</td>
                    </tr>
                    <tr> 
                      <td align="center"> 
<form name="regist" action="searchPax2.asp" method="post">
                  <span class="WSRightBold"><FONT color=red face="verdana" size="2">Select Agent :</font></span>
                        
                        <input type="hidden" name="datesearch" value="yes">
                       <select size=1  name="agent" >
                          <% 
		              call loadlistbox("agents",agentID)
		          %> 
                        </select>
                        <input type="submit" class="ud" value="Go"> 
</form>
					</td></tr>
				<tr><td align="center"><b><a href="SearchMyCountry.asp" target="_blank"><FONT color=blue face="verdana" size="3">Search My Country</font></a></b></td></tr>
                         <tr><td>&nbsp;</td></tr>
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
    <td height="21">&nbsp;</td>
  </tr>
</table>
   
</body>
</html>
