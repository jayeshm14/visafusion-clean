<%@ Language=VBScript %>
<%
if session("priv") = "" then
	response.redirect "default.asp?rsn=usb"
end if
%>
<!-- #include file="connection.asp" -->
<%
        country=cint(request("countryID"))
             
		set rs= server.createobject("adodb.recordset")

        stmt2="select* from embassy where embassyID="&country
        rs.open stmt2,con,2,3
    if not rs.eof then
        description = ucase(rs("description"))
        embassyname =  ucase(rs("embassyname"))
        chancery = ""

		if trim(rs("street1"))<>"" then
		chancery = chancery &""& ucase(rs("street1")) & " "
		end if
		if trim(rs("street2"))<>"" then
		chancery = chancery &""& ucase(rs("street2")) & " "
		end if
		if trim(rs("area"))<>"" then
		chancery = chancery &""& ucase(rs("area"))&" "
		end if
		if trim(rs("city"))<>"" then
		chancery = chancery &""& ucase(rs("city"))&" "
		end if

        phone = rs("phoneno")
        fax = rs("faxno")
        email = rs("emailID")
        website = rs("chancery")
    end if
   rs.close

		set rs1= server.createobject("adodb.recordset")
	    stmt1="select description from embassy where embassyID="&country
		rs1.open stmt1,con,2,3
		if not rs1.eof then
			CountryName = rs1("description")
		else
			CountryName = ""
		end if

		set rs2= server.createobject("adodb.recordset")
	    stmt2="select Continent_File from CountryInfo where CountryID="&country
		rs2.open stmt2,con,2,3
		if not rs2.eof then
			Continent_File = rs2("Continent_File")
		else
			Continent_File = ""
		end if


%> 
<html>
<head>
<title>www.udaanindia.com</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

</head>

<body bgcolor="#FFFFFF"  topmargin=0 leftmargin=0 marginwidth=0 marginheight=0 >
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td>
      <table width="100%" border="0" cellpadding="0" cellspacing="0">
        <tr valign="top" align="left">
          
          <td width="98%"> 
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr valign="top" align="left"> 
                
          <td>
          <%
      agentID=request("jn")
       %> 
          <% if session("priv")="adm" then %> <!-- include file="topAdmin.asp"--> 
      <%
elseif session("priv")="emp" then
%>
<!-- include file="top.asp"--> 
<% 
elseif session("priv")="agt" then
%>
<!-- #include file="topAgent.asp"--> <% 
elseif session("priv")="guest" then
%> <% end if %> </td> </tr> 
<tr>
                <td> 
  <table width=780 border=0 align=center cellpadding=0 cellspacing=0 height="247">
    <tr> 
        <td align=left valign=top background="images/bigtablebg.gif" height="149"> 
          <table width="742" border="0" align="center" cellpadding="0" cellspacing="0">
            <tr> 
              <td height="25" colspan="2" valign="bottom"> 
                <table width="95%" height="21" border="0" align="center" cellpadding="0" cellspacing="0" class="tdborder">
                  <tr> 
                    <td width="30%" align="center" background="images/yellowbgband.gif" bgcolor="FBBD06"> 
                      <p class="toplinkvisa"><a href="CountryInfo.asp?agentusb=yesuma&amp;logon=Y&amp;anp=34&amp;cd=2345&amp;seckey=xyz25g78md20422npr054416panftphjkslsktls&amp;ses=k3456l7dj9javyemsn&amp;company=udaan&amp;jn=<%=agentID%>&countryID=<%=country%>" class="toplinkvisa">Country 
                        Info</a></p>
                    </td>
                    <td width="15%" align="center" background="images/yellowbgband.gif" bgcolor="FBBD06"><a href="embassy_info.asp?agentusb=yesuma&amp;logon=Y&amp;anp=34&amp;cd=2345&amp;seckey=xyz25g78md20422npr054416panftphjkslsktls&amp;ses=k3456l7dj9javyemsn&amp;company=udaan&amp;jn=<%=agentID%>&countryID=<%=country%>" class="toplinkvisa">Embassy 
                      Info</a></td>
                    <td width="15%" align="center" background="images/yellowbgband.gif" bgcolor="FBBD06"> 
                      <a href="visa.asp?agentusb=yesuma&amp;logon=Y&amp;anp=34&amp;cd=2345&amp;seckey=xyz25g78md20422npr054416panftphjkslsktls&amp;ses=k3456l7dj9javyemsn&amp;company=udaan&amp;jn=<%=agentID%>" class="toplinkvisa">Visa 
                      Info</a> </td>
                    <td width="15%" align="center" background="images/yellowbgband.gif" bgcolor="FBBD06"><a href="forms.asp?agentusb=yesuma&amp;logon=Y&amp;anp=34&amp;cd=2345&amp;seckey=xyz25g78md20422npr054416panftphjkslsktls&amp;ses=k3456l7dj9javyemsn&amp;company=udaan&amp;jn=<%=agentID%>" class="toplinkvisa">Visa 
                      Form </a></td>
                    <td width="20%" align="center" background="images/yellowbgband.gif" bgcolor="FBBD06"><a href="understand_visas.asp?agentusb=yesuma&amp;logon=Y&amp;anp=34&amp;cd=2345&amp;seckey=xyz25g78md20422npr054416panftphjkslsktls&amp;ses=k3456l7dj9javyemsn&amp;company=udaan&amp;jn=<%=agentID%>&amp;countryID=<%=country%>" class="toplinkvisa">Understand 
                      Visas </a></td>
                  </tr>
                </table>
              </td>
            </tr>
            <tr> 
              <td width="253" height="13">&nbsp;</td>
              <td width="490" height="13" align="right">&nbsp;</td>
            </tr>
            <tr> 
              <td width="253" height="350" align="right" valign="top" bgcolor="BD402C"> 
                <table width="246" border="0" align="right" cellpadding="0" cellspacing="0" class="tdborder">
                  <tr> 
                    <td height="21" align="center" background="images/yellowbgband.gif">
                      <p class="rbctext">Continent Map </p>
                    </td>
                  </tr>
                  <tr> 
                    <td height="380" align="left" valign="top" bgcolor="BD402C" class="trail">
<% if Continent_File <> "" and not(isNull(Continent_File)) then %>
<embed src="Continent_SWF/<%=Continent_File%>" width="246" height="380" wmode="transparent">
                      </embed>
<% end if %>
</td>
                  </tr>
                </table>
              </td>
              <td width="490" align="center" valign="top" bgcolor="BD402C"> 
                <table width="480" border="0" cellpadding="0" cellspacing="0" class="tdborder">
                  <tr> 
                    <td height="21" background="images/yellowbgband.gif">
                      <p class="lbltext"><%=CountryName%> EMBASSY INFORMATION </p>
                    </td>
                  </tr>
                  <tr bgcolor="BD402C"> 
                    <td valign="top" height="380">
                      <table width="480" border="0" cellspacing="0" cellpadding="0">
                        <tr> 
                          <td height="40" colspan="2" valign="middle"> 
                            <p class="visaheading"><%=embassyname%></p>
                          </td>
                        </tr>
                        <tr> 
                          <td width="100" height="25"> 
                            <p class="visaembassyheading">Chancery:</p>
                          </td>
                          <td width="380"> 
                            <p class="visaparagraph"><%=chancery%></p>
                          </td>
                        </tr>
                        <tr> 
                          <td width="100" height="25"> 
                            <p class="visaembassyheading">Phone:</p>
                          </td>
                          <td width="380"> 
                            <p class="visaparagraph"><%=phone%></p>
                          </td>
                        </tr>
                        <tr> 
                          <td width="100" height="25"> 
                            <p class="visaembassyheading">Facsimile:</p>
                          </td>
                          <td width="380"> 
                            <p class="visaparagraph"><%=fax%></p>
                          </td>
                        </tr>
                        <tr> 
                          <td width="100" height="25"> 
                            <p class="visaembassyheading">Email:</p>
                          </td>
                          <td width="380" align="left"> 
                            <p class="visaparagraph"><%=email%></p>
                          </td>
                        </tr>
                        <tr>
                          <td width="100" height="25"><p class="visaembassyheading">Web Site:</p></td>
                          <td width="380" align="left"><p class="visaparagraph"><%=website%></td>
                        </tr>
                      </table>
                    </td>
                  </tr>
                </table>
              </td>
            </tr>
          </table>
        </tr>
  </table>

                
                
                
                
</tr>
<tr>
                <td><!-- #include file="HomeBottom.asp" --></td>
          
    </tr>
</table>
</body>
</html>
