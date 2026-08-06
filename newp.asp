<%@ Language=VBScript %>
<!-- #include file="connection.asp" -->

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
            <table width="75%" border="0" cellspacing="0" cellpadding="0">
              <tr valign="top" align="left"> 
                <td><!-- #include file="topadmin.asp" --></td>
              </tr>
              <tr>
                <td>

<body bgcolor="#FFFFFF">
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
                  <table width="100%" border="0" bgcolor="#FFFFF8" cellpadding="0" cellspacing="0" background="images/backform.jpg">
                    <tr> 
                      <td>
                

                <%
                agent=request("agent")
set rs=server.createobject("adodb.recordset")
stmt="select * from agents where agentsID="&cint(agent)

rs.open stmt,con,2,3

if rs.eof then
%>
<tr><td align="center">
<%
response.write " Data not Found"
%>
</td></tr>
<%
else
%>

<FORM action="editdoneagent1.asp"  method=post name=agentform onsubmit="return checkAll()">

    
   <TR><INPUT  type="hidden"name="agentid" value="<%= agent %>" >
    <INPUT type="hidden" name="agent" value="<%= ucase(rs("description")) %>">
        <TD><FONT color=red face="arial">AGENT NAME</FONT></TD>
        <TD><FONT color=red face="">
            <INPUT  name="newagent" value="<%= ucase(rs("description")) %>" onblur="javascript:checkAll(this.value)" ></FONT></TD></TR>
     <TR>
        <TD><FONT color=red face="">COMPANY NAME</FONT></TD>
        <TD>
            <INPUT  name=company type=text value="<%= ucase(rs("companyname")) %>" size="40"></TD></TR>
    
    <TR>
        <TD><FONT color=red face="">COMPLEX NAME</FONT></TD>
        <TD>
            <INPUT  name=complexname type=text value="<%= ucase(rs("complexname")) %>"></TD></TR>
            <TR>
        <TD><FONT color=red face="">STREET-1 </FONT></TD>
        <TD>
            <INPUT  name=street1 type=text value="<%= ucase(rs("street1")) %>"></TD></TR>
    
    <TR>
        <TD><FONT color=red face="">STREET-2</FONT></TD>
        <TD><INPUT  name=street2 type=text value="<%= ucase(rs("street2")) %>"></TD></TR>
        
            
    <TR>
        <TD><FONT color=red face="">AREA </FONT></TD>
        <TD><FONT color=red face="">
           <INPUT  name=area type=text value="<%= ucase(rs("area")) %>"> 
            </FONT></TD></TR>
            <TR>
        <TD><FONT color=red face="">CITY </FONT></TD>
        <TD><FONT color=red face="">
           <INPUT  name=city type=text value="<%= ucase(rs("city")) %>"> 
            </FONT></TD></TR>
    
            <TR>
        <TD><FONT color=red face="">PIN CODE </FONT></TD>
        <TD><FONT color=red face="">
           <INPUT  name=pincode type=text value="<%= ucase(rs("pincode")) %>"> 
            </FONT></TD></TR>
    
    <TR>
        <TD><FONT color=red face="">PHONE NO:</FONT></TD>
        <TD><FONT color=red face="">
           <INPUT  name=phoneno type=text value="<%= ucase(rs("phoneno")) %>"> 
            </FONT></TD></TR>
    <TR>
        <TD><FONT color=red face="">FAX NO:</FONT></TD>
        <TD><FONT color=red face="">
            <INPUT name=faxno type=text value="<%= ucase(rs("faxno")) %>"></FONT></TD></TR>
     <TR>
        <TD><FONT color=red>EMAILID</FONT></TD>
        <TD><FONT color=red>
            <INPUT name=emailid type=text value="<%= rs("emailid") %>"></FONT></TD></TR>
    <TR>
        <TD><FONT color=red face="">DIRECTOR NAME </FONT></TD>
        <TD><FONT color=red face="">
            <INPUT name=directorname type=text value="<%= ucase(rs("directorname")) %>"> 
            </TD></TR>
   <TR>
        <TD><FONT color=red face="">A/C INCHARGE NO.</FONT></TD>
        <TD><FONT color=red face="">
            <INPUT name=acno type=text value="<%= ucase(rs("acno")) %>"> 
            </TD></TR>
    
            <TR>
        <TD><FONT color=red>PAYMENT CONDITION</FONT></TD>
        <TD>
            <INPUT name=payment type=text value="<%= ucase(rs("payment")) %>">
            </TD></TR>
            
            
            
        <TD ALIGN=right><font text=red><INPUT name=submit1 type=submit value=Submit></font></td>
        <td text="red"><INPUT id=reset1 name=reset1 type=reset value=Reset>
            </TD></TR>
           
            </form>
<%
end if 
%>

                
     
                      
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
</body>
</html>
