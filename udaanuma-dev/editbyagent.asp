<%@ Language=VBScript %>
<!-- #include file="connection.asp" -->
<%
response.buffer= true

if session("priv")="" then
response.clear
response.redirect "default.asp?rsn=usb"
end if
%>
<html>
<head>
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
<!-- #include file="topAgent.asp"-->  
</td> </tr> 
<tr>
                <td> 
  <table width=780 border=0 align=center cellpadding=0 cellspacing=0 height="247">
    <tr> 
        <td align=left valign=top background="images/bigtablebg.gif" height="449"> 
          <table width="650" border="0" align="center" bgcolor="BD402C">
            <tr> 
              <td>&nbsp;</td>
            </tr>
            <tr> 
              <td> 
                <table width="450" align="center" cellpadding="0" cellspacing="0" bgcolor="#008432">
                  <tr> 
                    <td height="21" background="images/yellowbgband.gif" align="center"> 
                      <p class="lbltext"> AGENT INFORMATION</p>
                    </td>
                  </tr>
                </table>
              </td>
            </tr>
            <tr> 
              <td height="495"> 
                <table width="100%" border="0" cellpadding="0" cellspacing="0">
                  <tr> 
                    <td colspan="2"> <%
                agent=request("jn")
set rs=server.createobject("adodb.recordset")
stmt="select * from agents where agentsID="&cint(agent)

rs.open stmt,con,2,3

if rs.eof then
%> 
                  <tr> 
                    <td align="center" colspan="2"> <%
response.write " Data not Found"
%> </td>
                  </tr>
                  <%
else
%> 
                  <form action="editdonebyagent1.asp"  method=post name=agentform onSubmit="return checkAll()">
                    <tr> 
                      <input  type="hidden"name="agentid" value="<%= agent %>" >
                      <input type="hidden" name="agent" value="<%= ucase(rs("description")) %>">
                      <input type="hidden" name="jn" value="<%= request("jn") %>">
                      <td width="45%">
<p class="updatetext"><strong>AGENT NAME</strong></p></td>
                      <td width="55%">
<p class="updatetext"><strong><%= ucase(rs("description")) %></strong></p>
                        <input type="hidden"  name="newagent" value="<%= ucase(rs("description")) %>" class=inputbox>
                        </td>
                    </tr>
                    <tr> 
                      <td width="45%"><p class="updatetext"><strong>COMPANY 
                        NAME</strong></p></td>
                      <td width="55%"> 
                        <input  name=company type=text value="<%= ucase(rs("companyname")) %>" size="40" class=inputbox>
                      </td>
                    </tr>
                    <tr> 
                      <td width="45%"><p class="updatetext"><strong>COMPLEX 
                        NAME</strong></p></td>
                      <td width="55%"> 
                        <input  name=complexname type=text value="<%= ucase(rs("complexname")) %>" class=inputbox>
                      </td>
                    </tr>
                    <tr> 
                    <tr> 
                      <td width="45%"><p class="updatetext"><strong>AGENCY'S 
                        AFFILIATION</strong></p></td>
                      <td width="55%"> <p class="updatetext"><strong>
                        <input type="checkbox" name="IATA" value="Y" 
		                              <%  
                                      if ucase(rs("IATA")) ="Y" THEN
                                      response.Write " CHECKED > "
                                      ELSE
                                      response.Write " >"
                                      end if
                                      %>
                        IATA 
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
                                      %> TAFI</strong></p>
                        </td>
                    </tr>
                    <tr> 
                      <td width="45%"><p class="updatetext"><strong>STREET-1 
                        </strong></p></td>
                      <td width="55%"> 
                        <input  name=street1 type=text value="<%= ucase(rs("street1")) %>" class=inputbox>
                      </td>
                    </tr>
                    <tr> 
                      <td width="45%"><p class="updatetext"><strong>STREET-2</strong></p></td>
                      <td width="55%"> 
                        <input  name=street2 type=text value="<%= ucase(rs("street2")) %>" class=inputbox>
                      </td>
                    </tr>
                    <tr> 
                      <td width="45%"><p class="updatetext"><strong>AREA 
                        </strong></p></td>
                      <td width="55%">
                        <input  name=area type=text value="<%= ucase(rs("area")) %>" class=inputbox>
                        </td>
                    </tr>
                    <tr> 
                      <td width="45%"><p class="updatetext"><strong>CITY 
                        </strong></p></td>
                      <td width="55%">
                        <input  name=city type=text value="<%= ucase(rs("city")) %>" class=inputbox>
                        </td>
                    </tr>
                    <tr> 
                      <td width="45%"><p class="updatetext"><strong>PIN 
                        CODE </strong></p></td>
                      <td width="55%">
                        <input  name=pincode type=text value="<%= ucase(rs("pincode")) %>" class=inputbox>
                        </td>
                    </tr>
                    <tr> 
                      <td width="45%"><p class="updatetext"><strong>PHONE 
                        NO:</strong></p></td>
                      <td width="55%">
                        <input  name=phoneno type=text value="<%= ucase(rs("phoneno")) %>" class=inputbox>
                        </td>
                    </tr>
                    <tr> 
                      <td width="45%"><p class="updatetext"><strong>FAX 
                        NO:</strong></p></td>
                      <td width="55%">
                        <input name=faxno type=text value="<%= ucase(rs("faxno")) %>" class=inputbox>
                        </td>
                    </tr>
                    <tr> 
                      <td width="45%"><p class="updatetext"><strong>EMAILID</strong></td>
                      <td width="55%">
                        <input name=emailid type=text value="<%= rs("emailid") %>" class=inputbox>
                        </td>
                    </tr>
                    <tr> 
                      <td width="45%" height="21"><p class="updatetext"><strong>DIRECTOR'S 
                        NAME & MOBILE NO. </strong></p></td>
                      <td width="55%" height="21"> 
                        <input name=directorname type=text value="<%= ucase(rs("directorname")) %>" class=inputbox>
                        &nbsp; <img src="images/phone1.jpg" width="20" height="20" align="absbottom"> 
                        <input  name=DirectorPH type=text value="<%= ucase(rs("DirectorPH")) %>" class=inputbox>
                      </td>
                    </tr>
                    <tr> 
                      <td width="45%"><p class="updatetext"><strong>A/C 
                        MANAGER NAME &amp; MOBILE NO.</strong></p></td>
                      <td width="55%"> 
                        <input name=acno type=text value="<%= ucase(rs("acno")) %>" class=inputbox>
                        &nbsp; <img src="images/phone1.jpg" width="20" height="20" align="absbottom"> 
                        <input  name=AcMgrPH type=text value="<%= ucase(rs("AcMgrPH")) %>" class=inputbox>
                      </td>
                    </tr>
                    <tr> 
                      <td width="45%"><p class="updatetext"><strong>VISA'S 
                        INCHARGE'S NAME &amp; MOBILE NO.</strong></p></td>
                      <td width="55%"> 
                        <input name=VisaInchargeName type=text value="<%= ucase(rs("VisaInchargeName")) %>" class=inputbox>
                        &nbsp; <img src="images/phone1.jpg" width="20" height="20" align="absbottom"><font color=red face=""> 
                        <input  name=VisaInchargePH type=text value="<%= ucase(rs("VisaInchargePH")) %>" class=inputbox>
                        </font></td>
                    </tr>
                    <tr> 
                      <td width="45%">&nbsp;&nbsp;&nbsp;</td>
                      <td width="55%"> 
                        <input name=payment type="hidden" value="<%= ucase(rs("payment")) %>">
                      </td>
                    </tr>
                    <tr> 
                      <td align=center colspan="2"> 
                        <input name=submit1 type=submit value=Submit class="ud">
                        &nbsp;&nbsp;&nbsp;&nbsp; 
                        <input id=reset1 name=reset1 type=reset value=Reset class="ud">
                      </td>
                    </tr>
                  </form>
                </table>
                <%
end if 
%> 
            </tr>
            <tr>
              <td>&nbsp; </td>
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
