<%@ Language=VBScript %>
<!-- #include file="connection.asp" --><html><head>
<%
if session("uname")="" then
response.clear
response.redirect "relogin.asp?rsn=V"
end if
if session("priv")="" then
response.clear
response.redirect "relogin.asp?rsn=V"
end if
%>
<script language="javascript">
function checkAll()
{
	MYflag=0
	flag=0
	msg=""
	a=document.agentform.agent.value
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
	msg=msg+"SPACES ARE NOT ALLOWED IN AGENT NAME.\n"
	flag=1
	}
	
	if (flag==1)
	{
	alert(msg)
	return false;
	}
}
function checkNum(var1)
{
if (isNaN(var1))
{
alert("Please enter a valid number.")
window.document.agentform.payment.select()
return false;
}
}

</script>


<title>www.udaanindia.com</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
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
<FORM action="editdoneagent1.asp"  method=post name=agentform onsubmit="return checkAll()">
                              
                        <table width="100%" border="0" bgcolor="#FFFFF8" cellpadding="0" cellspacing="0">
                          <tr> 
                            <td> <%
                agent=request("agent")
set rs=server.createobject("adodb.recordset")
stmt="select * from agents where agentsID="&cint(agent)

rs.open stmt,con,2,3

if rs.eof then
%> 
                          <tr> 
                            <td align="center"> <%
response.write " Data not Found"
%> </td>
                          </tr>
                          <%
else
%> 
                          <TR> 
                            <INPUT  type="hidden"name="agentid" value="<%= agent %>" >
                            <INPUT type="hidden" name="agent" value="<%= ucase(rs("description")) %>">
                            <TD bgcolor="#E1FFFF"><b><font face="Verdana" size="2"><font color="red">AGENT 
                              NAME</font></font></b></TD>
                            <TD colspan="5" bgcolor="#E1FFFF"><FONT color=red face=""> 
                              <% if ucase(session("uname"))<>"UMA" and ucase(session("su"))<>"Y" then %> 
                              <%= ucase(rs("description")) %> 
                              <input type="hidden" name="newagent" value="<%= ucase(rs("description")) %>">
                              <% else %> 
                              <input type="text" name="newagent" value="<%= ucase(rs("description")) %>">
                              <% end if %> </FONT></TD>
                          </TR>
                          <TR> 
                            <TD><b><font face="Verdana" size="2"><font color="red">COMPANY 
                              NAME</font></font></b></TD>
                            <TD colspan="5"> 
                              <INPUT  name=company type=text value="<%= ucase(rs("companyname")) %>" size="40">
                            </TD>
                          </TR>
                          <TR> 
                            <TD bgcolor="#E1FFFF"><b><font face="Verdana" size="2"><FONT color=red>COMPLEX 
                              NAME</FONT></font></b></TD>
                            <TD colspan="5" bgcolor="#E1FFFF"> 
                              <INPUT  name=complexname type=text value="<%= ucase(rs("complexname")) %>">
                            </TD>
                          </TR>
                          <TR> 
                            <TD><b><font face="Verdana" size="2" color="#FF0000">AGENCY'S 
                              AFFILIATION</font></b></TD>
                            <TD> 
                              <input type="checkbox" name="IATA" value="Y" 
		                              <%  
                                      if ucase(rs("IATA")) ="Y" THEN
                                      response.Write " CHECKED > "
                                      ELSE
                                      response.Write " >"
                                      end if
                                      %>
                              <b><font face="Verdana" size="2">IATA 
                              <input type="checkbox" name="TAAI" value="Y"
                              <%  
                                      if ucase(rs("TAAI")) ="Y" THEN
                                      response.Write " CHECKED > "
                                      ELSE
                                      response.Write " >"
                                      end if
                                      %> TAAI 
                              <input type="checkbox" name="TAFI" value="Y"
                              <%  
                                      if ucase(rs("TAFI")) ="Y" THEN
                                      response.Write " CHECKED > "
                                      ELSE
                                      response.Write " >"
                                      end if
                                      %> TAFI</font></b></TD>
                          </TR>
                          <TR> 
                            <TD bgcolor="#E1FFFF"><b><font face="Verdana" size="2"><FONT color=red>STREET-1 
                              </FONT></font></b></TD>
                            <TD colspan="5" bgcolor="#E1FFFF"> 
                              <INPUT  name=street1 type=text value="<%= ucase(rs("street1")) %>">
                            </TD>
                          </TR>
                          <TR> 
                            <TD><b><font face="Verdana" size="2"><FONT color=red>STREET-2</FONT></font></b></TD>
                            <TD colspan="5"> 
                              <INPUT  name=street2 type=text value="<%= ucase(rs("street2")) %>">
                            </TD>
                          </TR>
                          <TR> 
                            <TD bgcolor="#E1FFFF"><b><font face="Verdana" size="2"><FONT color=red>AREA 
                              </FONT></font></b></TD>
                            <TD colspan="5" bgcolor="#E1FFFF"><FONT color=red face=""> 
                              <INPUT  name=area type=text value="<%= ucase(rs("area")) %>">
                              </FONT></TD>
                          </TR>
                          <TR> 
                            <TD><b><font face="Verdana" size="2"><FONT color=red>CITY 
                              </FONT></font></b></TD>
                            <TD colspan="5"><FONT color=red face=""> 
                              <INPUT  name=city type=text value="<%= ucase(rs("city")) %>">
                              </FONT></TD>
                          </TR>
                          <TR> 
                            <TD bgcolor="#E1FFFF"><b><font face="Verdana" size="2"><FONT color=red>PIN 
                              CODE </FONT></font></b></TD>
                            <TD colspan="5" bgcolor="#E1FFFF"><FONT color=red face=""> 
                              <INPUT  name=pincode type=text value="<%= ucase(rs("pincode")) %>">
                              </FONT></TD>
                          </TR>
                          <TR> 
                            <TD><b><font face="Verdana" size="2"><FONT color=red>PHONE 
                              NO:</FONT></font></b></TD>
                            <TD colspan="5"><FONT color=red face=""> 
                              <INPUT  name=phoneno type=text value="<%= ucase(rs("phoneno")) %>">
                              </FONT></TD>
                          </TR>
                          <TR> 
                            <TD bgcolor="#E1FFFF"><b><font face="Verdana" size="2"><FONT color=red>FAX 
                              NO:</FONT></font></b></TD>
                            <TD colspan="5" bgcolor="#E1FFFF"><FONT color=red face=""> 
                              <INPUT name=faxno type=text value="<%= ucase(rs("faxno")) %>">
                              </FONT></TD>
                          </TR>
                          <TR> 
                            <TD height="23"><b><font face="Verdana" size="2"><FONT color=red>EMAILID 
                              </FONT></font></b></TD>
                            <TD colspan="5" height="23"><FONT color=red> <b><font face="Verdana" size="2"></font></b> 
                              <INPUT name=emailid type=text value="<%= rs("emailid") %>" size="47">
                              <b><font color=red><b><font face="Verdana" size="2"><font color=red>&nbsp;</font></font></b></font><font face="Verdana" size="2"></font></b></FONT></TD>
                          </TR>
                          <TR> 
                            <TD height="26" bgcolor="#E1FFFF"><b><font face="Verdana" size="2"><FONT color=red>DIRECTOR'S 
                              NAME <br>
                              &amp; MOBILE NO.</FONT></font></b></TD>
                            <TD colspan="5" height="26" bgcolor="#E1FFFF"><FONT color=red face=""> 
                              <INPUT name=directorname type=text value="<%= ucase(rs("directorname")) %>">
                              &nbsp; <img src="updateimg/phone1.jpg" width="20" height="20" align="absbottom">
                              <input  name=DirectorPH type=text value="<%= ucase(rs("DirectorPH")) %>">
                              </font></TD>
                          </TR>
                          <TR> 
                            <TD><b><font face="Verdana" size="2"><FONT color=red>A/C 
                              MANAGER NAME &amp;<br>
                              MOBILE NO.</FONT></font></b></TD>
                            <TD colspan="5"><FONT color=red face=""> 
                              <input name=acno type=text value="<%= ucase(rs("acno")) %>">
                              &nbsp; <img src="updateimg/phone1.jpg" width="20" height="20" align="absbottom"> 
                              <input  name=AcMgrPH type=text value="<%= ucase(rs("AcMgrPH")) %>">
                              </font></TD>
                          </TR>
                          <TR> 
                            <TD bgcolor="#E1FFFF"><b><font face="Verdana" size="2" color="#FF0000">VISA'S 
                              INCHARGE'S NAME &amp; <br>
                              MOBILE NO.</font></b></TD>
                            <TD colspan="5" bgcolor="#E1FFFF"><font color=red face=""> 
                              <input name=VisaInchargeName type=text value="<%= ucase(rs("VisaInchargeName")) %>">
                              </font>&nbsp; <font color=red face=""><img src="updateimg/phone1.jpg" width="20" height="20" align="absbottom"></font><font color=red face="">
                              <input  name=VisaInchargePH type=text value="<%= ucase(rs("VisaInchargePH")) %>">
                              </font> </TD>
                          </TR>
                          
                           <TR> 
                                    
                            <TD><font color="red" face="Verdana" size="2"><b>SEND 
                              SMS AT </b></font></TD>
                                    <TD><FONT color=red face=""> 
                                      <INPUT name=smsno type=text  maxlength=65 value="<%= ucase(rs("smsno")) %>" ID="Text1">
                                      </font></TD>
                                  </TR>
                          <TR bgcolor="#CCFFFF"> 
                            <TD height="39"> <b><font face="Verdana" size="2"><font color=red>PAYMENT 
                              CONDITION </font></font></b></TD>
                            <TD colspan="5" height="39"> <font face="Verdana" size="2" color="#333333"><b> 
                              </b> </font> 
                              <input name=payment type=text value="<%= ucase(rs("payment")) %>" >
                              <br>
                              <font size="1">( <font face="Verdana" color="#333333"><b>FIT</b>(14 
                              PAX AND BELOW)</font><b>/</b><font face="Verdana"><b> 
                              GIT</b>(15 PAX AND ABOVE)</font></font> <font size="1"><b>/<font face="Verdana">COURIER</font></b><font face="Verdana">)</font></font></TD>
                          </TR>
                          <TR bgcolor="#FFFFFF"> 
                            <TD><font face="Verdana" size="2"><b><font color="#FF0000">CURRENTLY 
                              ACTIVE?</font></b></font></TD>
                            <TD colspan="5"> <input type="checkbox" name="Active" value='Y'
                                      <%  
                                      if ucase(rs("Active")) ="Y" THEN
                                      response.Write " CHECKED > "
                                      ELSE
                                      response.Write " >"
                                      end if
                                      %>                                      
                                      
                                    </TD>
                          </TR>
                          <TR bgcolor="#CCFFFF"> 
                            <TD><font face="Verdana" size="2"><b><font color="#FF0000">Want 
                              to Edit on Web Server</font></b></font></TD>
                            <TD colspan="5"> 
                              <input type="checkbox" name="web" value="yes">
                            </TD>
                          </TR>
                          <tr bgcolor="#E1FFFF"> 
                            <TD ALIGN=center colspan="6"> 
                              <INPUT name=submit1 type=submit value=Submit class="ud">
                            &nbsp;&nbsp;&nbsp;&nbsp; 
                            <INPUT id=reset1 name=reset1 type=reset value=Reset class="ud">
                          </TD>
                          </TR>
                          <%
end if 
%> 
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
