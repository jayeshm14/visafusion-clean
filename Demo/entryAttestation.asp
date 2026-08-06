<%@ Language=VBScript %>
<!-- #include file="connection.asp" -->
<html>

<head>
<title>www.udaanindia.com</title>
<script language="javascript">
<!--
function CheckNum(var1)
{
if (isNaN(var1))
{
alert("Please enter a valid number.")
return false;
}
}

function putvalue1(var1)
{
CheckNum(var1)
document.entry.entries.value = document.entry.totalp.value
}

function checkAll()
{
getentries=document.entry.entries.value
gettotalp=document.entry.totalp.value
getcountry=document.entry.countrylist.value
flag=0
msg=""
if (isNaN(getentries))
{
msg=msg+"Please enter a valid number in the entries.\n"
flag=1
}
if (isNaN(gettotalp))
{
msg=msg+"Please enter a valid number in the Passengers.\n"
flag=1
}

if (getcountry=="")
{
conval=window.confirm("YOU HAVE NOT SELECTED ANY COUNTRY. CONTINUE?")
if(!conval)
{
return false
}

}
if (flag==1)
{
alert(msg)
return false;
}

}
-->
</script>
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
                <td><!-- #include file="top.asp" --></td>
              </tr>
              <tr>
                <td>
                            
                
                <table width="100%" border="0" cellpadding="0" cellspacing="0">
              
              
              
              <tr> 
                <td height="4" colspan="6"> 
                  <p align="center"><b><font size="3" color="#ff0000" face="Arial, Helvetica, sans-serif">
                   <% 
                   if request("msgID")="1" then 
					response.write " The information regarding "&ucase(request("pname"))&" added successfully.<br>Ref No is # <font color=red>"&request("refno")&"</font>"
                   End if
                   
set rs=server.createobject("adodb.recordset")
rs.open "select max(refno) from mainentry ",con,2,3
if not rs.eof then
refno=rs(0)+1
end if
rs.close
                   %>
                   
                    </font></font></b></p>
                </td>
              </tr>
             
            </table>
           
            <form action="makeEntryAttestation.asp#formtop" method=post name="entry" onsubmit="return checkAll()">
            <input type="hidden" name="username" value="<%= session("uname")%>" >
              <table width="44%" border="0" cellpadding="0" cellspacing="0" align="center">
<tr>
                  <td>
			<a name="formtop">&nbsp;</a>                                
                    <table width="75%" border="1" align="center" cellpadding="0" cellspacing="0" bordercolor="#000090">
                      <tr bgcolor="#FFFFF0"> 
                        <td height="19"> 
                          <div align="center"><b><font size="3" color="#CC0000" face="Arial, Helvetica, sans-serif"><font color="#000099"><i>SUBMISSION 
                            FORM --> Ref No : <%=refno%></i></font></font></b> </div>
                        </td>
                        </tr>
                      </table>
                    
                  </td>
                </tr>                
<tr> 
                  <td> 
                    <table width="83%" border="0" align="center" cellpadding="0" cellspacing="0" bgcolor="#000C80">
                                              <tr><td><img src="images/linetop.jpg" width="576" height="13"></td>
                      </tr>
                      <tr> 
                        <td> 
                          <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
                            <tr> 
                              <td align="left" width="1"><img src="images/pixelsline.gif" width="1" height="7"></td>
                              <td width="560"> 
                                <table width="100%" border="0" bgcolor="#FFFFF8" cellpadding="0" cellspacing="0" background="images/backform.jpg">
                                  <tr> 
                                    <td> 
                                      <table width=94% border=0 cellspacing=1 cellpadding=1 align="center">
                                        <tr> 
                                          <td width="16%" bgcolor="#F0F0FF"><font size="2" face="Arial, Helvetica, sans-serif" color="#0000CC"><b>Date</b></font></td>
                                          <td width="2%" bgcolor="#F0F0FF"><font size="2" face="Arial, Helvetica, sans-serif" color="#0000CC"><b>:</b></font> 
                                          </td>
                                          <td colspan="4"><font face="arial" size=2 color="red"><% 
      response.write ucase((formatdatetime(now(),1)))%></font> </td>
                                        </tr>
                                        
                                        
                                        <tr> 
                                          <td width="16%" bgcolor="#F0F0FF"><font size="2" face="Arial, Helvetica, sans-serif" color="#0000CC"><b>Pax 
                                            Name</b></font></td>
                                          <td width="2%" bgcolor="#F0F0FF"><font size="2" face="Arial, Helvetica, sans-serif" color="#0000CC"><b>:</b></font> 
                                            <font size="2" face="Arial, Helvetica, sans-serif" color="#0000CC"><b> 
                                            </b></font></td>
                                          <td width="30%"> <font size="2" face="Arial, Helvetica, sans-serif" color="#0000CC"><b> 
                                            <input type="text" name="pname" maxlength="30" size="16">
                                            </b></font></td>
                                          <td width="22%" bgcolor="#F0F0FF"><font size="2" face="Arial, Helvetica, sans-serif" color="#0000CC"><b>Passport 
                                            No</b></font></td>
                                          <td width="2%" bgcolor="#F0F0FF"><font size="2" face="Arial, Helvetica, sans-serif" color="#0000CC"><b>: 
                                            </b></font></td>
                                          <td width="28%"> <font size="2" face="Arial, Helvetica, sans-serif" color="#0000CC"><b> 
                                            <input type="text" name="passport" maxlength="50" size="16">
                                            </b></font></td>
                                        </tr>
                                        <tr> 
                                          <td width="16%" bgcolor="#F0F0FF"><font size="2" face="Arial, Helvetica, sans-serif" color="#0000CC"><b>Passengers</b></font></td>
                                          <td width="2%" bgcolor="#F0F0FF"><font size="2" face="Arial, Helvetica, sans-serif" color="#0000CC"><b>:</b></font> 
                                            <font size="2" face="Arial, Helvetica, sans-serif" color="#0000CC"><b> 
                                            </b></font></td>
                                          <td width="30%"> <font size="2" face="Arial, Helvetica, sans-serif" color="#0000CC"><b> 
                                            <input type="text" name="totalp" maxlength="10" size="10" value=1 onBlur="javascript:putvalue1(this.value)">
                                            </b></font></td>
                                          <td width="22%" bgcolor="#F0F0FF"><font size="2" face="Arial, Helvetica, sans-serif" color="#0000CC"><b>Entries</b></font></td>
                                          <td width="2%" bgcolor="#F0F0FF"><font size="2" face="Arial, Helvetica, sans-serif" color="#0000CC"><b>:</b></font> 
                                          </td>
                                          <td width="28%"> <font size="2" face="Arial, Helvetica, sans-serif" color="#0000CC"><b> 
                                            <input size=10  name=entries value="1" onBlur="javascript:CheckNum(this.value)" maxlength="10">
                                            </b></font></td>
                                        </tr>
                                        
                                        <tr> 
                                          <td width="16%" bgcolor="#F0F0FF"><font size="2" face="Arial, Helvetica, sans-serif" color="#0000CC"><b>Agent</b></font></td>
                                          <td width="2%" bgcolor="#F0F0FF"><font size="2" face="Arial, Helvetica, sans-serif" color="#0000CC"><b>:</b></font> 
                                          </td>
                                          <td width="30%"> <font size="2" face="Arial, Helvetica, sans-serif" color="#0000CC"><b> 
                                            <select size=1  name="agentlist" >
                                              <%
Call LoadListBox("agents",0)

%> 
                                            </select>
                                            </b></font></td>
                                          <td width="22%">&nbsp;</td>
                                          <td width="2%">&nbsp; </td>
                                          <td width="28%">&nbsp;</td>
                                        </tr>
                                        <tr> 
                                          <td width="16%" bgcolor="#F0F0FF"><font size="2" face="Arial, Helvetica, sans-serif" color="#0000CC"><b>Date 
                                            of Birth</b></font></td>
                                          <td width="2%" bgcolor="#F0F0FF"><font size="2" face="Arial, Helvetica, sans-serif" color="#0000CC"><b>:</b></font> 
                                          </td>
                                          <td width="30%"> <font size="2" face="Arial, Helvetica, sans-serif" color="#0000CC"><b> 
                                            <input type="text" name="dob" size="9" maxlength="12">
                                            </b>(DD/MM/YY) </font></td>
                                          <td width="22%" bgcolor="#F0F0FF"><font size="2" face="Arial, Helvetica, sans-serif" color="#0000CC"><b>Recieving 
                                            Date</b></font></td>
                                          <td width="2%" bgcolor="#F0F0FF"><font size="2" face="Arial, Helvetica, sans-serif" color="#0000CC"><b>:</b></font> 
                                            <font size="2" face="Arial, Helvetica, sans-serif" color="#0000CC"><b> 
                                            </b></font></td>
                                          <td width="28%"> <font size="2" face="Arial, Helvetica, sans-serif" color="#0000CC"><b> 
                                            <input type="text" name="recdate" size="10" value="<%= Day(Now())&"/" &Month(Now())&"/"&Year(Now())%>">
                                            </b>(DD/MM/YY) </font></td>
                                        </tr>
                                        <tr> 
                                          <td width="16%" bgcolor="#F0F0FF"><font size="2" face="Arial, Helvetica, sans-serif" color="#0000CC"><b>Submit 
                                            Date</b></font></td>
                                          <td width="2%" bgcolor="#F0F0FF"><font size="2" face="Arial, Helvetica, sans-serif" color="#0000CC"><b>:</b></font> 
                                            <font size="2" face="Arial, Helvetica, sans-serif" color="#0000CC"><b> 
                                            </b></font></td>
                                          <td width="30%"> <font size="2" face="Arial, Helvetica, sans-serif" color="#0000CC"><b>
                                          <%
					      	mytime=cdate("12:00:00 PM")
						if time>mytime then
						mydate1=date()+1
						if weekday(mydate1)=1  then
						mydate1=mydate1+1
						end if
						if  weekday(mydate1)=7 then
						mydate1=mydate1+2
						end if
						mydate=Day(mydate1)&"/" &Month(mydate1)&"/"&Year(mydate1)
						else
						mydate1=date()
						if weekday(mydate1)=1  then
						mydate1=mydate1+1
						end if
						if  weekday(mydate1)=7 then
						mydate1=mydate1+2
						end if
						mydate=Day(mydate1)&"/" &Month(mydate1)&"/"&Year(mydate1)
						end if 
						 categoryid=getIDForDescription("category","Attestation")
                                             
					%> 
						<input type="hidden" name="category" value="<%=categoryid%>">
                                            <input type="text" name="subdate" maxlength="12" size="9" value="<%= trim(mydate)%>" >
                                            </b>(DD/MM/YY)</font></td>
                                          <td width="22%" bgcolor="#F0F0FF"><font size="2" face="Arial, Helvetica, sans-serif" color="#0000CC"><b>Collection 
                                            Date</b></font></td>
                                          <td width="2%" bgcolor="#F0F0FF"><font size="2" face="Arial, Helvetica, sans-serif" color="#0000CC"><b>:</b></font> 
                                          </td>
                                          <td width="28%"> <font size="2" face="Arial, Helvetica, sans-serif" color="#0000CC"><b> 
                                            <input type="text" name="coldate" maxlength="12" size="10" value="<%= trim(mydate)%>" >
                                            </b>(DD/MM/YY) </font>
                                            
                                            
                                            
                                            </td>
                                            
                                        </tr>
                                        <tr> 
                                          <td width="16%" bgcolor="#F0F0FF"><font size="2" face="Arial, Helvetica, sans-serif" color="#0000CC"><b>Category 
                                            </b></font></td>
                                          <td width="2%" bgcolor="#F0F0FF"><font size="2" face="Arial, Helvetica, sans-serif" color="#0000CC"><b>:</b></font> 
                                          </td>
                                          <td width="30%"> <font size="2" face="Arial, Helvetica, sans-serif" color="#0000CC"><b> 
                                            ATTESTATION
                                            </b></font></td>
                                          <td width="22%" bgcolor="#F0F0FF"><font size="2" face="Arial, Helvetica, sans-serif" color="#0000CC"><b>Attestation</b></font></td>
                                          <td width="2%" bgcolor="#F0F0FF"><font size="2" face="Arial, Helvetica, sans-serif" color="#0000CC"><b>:</b></font> 
                                            <font size="2" face="Arial, Helvetica, sans-serif" color="#0000CC"><b> 
                                            </b></font></td>
                                          <td width="28%"> <font size="2" face="Arial, Helvetica, sans-serif" color="#0000CC"><b> 
                                            <select name="attestation" size="1">
                                              <%
                                             Call LoadListBox("Attestation",1)
                                             %>
                                              </select>
                                            </b></font></td>
                                        </tr>
                                        <tr> 
                                          <td width="16%" bgcolor="#F0F0FF"><font size="2" face="Arial, Helvetica, sans-serif" color="#0000CC"><b>POE/ECNR</b></font></td>
                                          <td width="2%" bgcolor="#F0F0FF"><font size="2" face="Arial, Helvetica, sans-serif" color="#0000CC"><b>:</b></font> 
                                            <font size="2" face="Arial, Helvetica, sans-serif" color="#0000CC"><b> 
                                            </b></font></td>
                                          <td width="30%"> <font size="2" face="Arial, Helvetica, sans-serif" color="#0000CC"><b> 
                                            <select name="poe" size="1">
                                             <%
                                             Call LoadListBox("poe",1)
                                             %>
                                            </select>
                                            </b></font></td>
                                          <td width="22%" bgcolor="#F0F0FF"><font size="2" face="Arial, Helvetica, sans-serif" color="#0000CC"><b>Status 
                                            </b></font></td>
                                          <td width="2%" bgcolor="#F0F0FF"><font size="2" face="Arial, Helvetica, sans-serif" color="#0000CC"><b>:</b></font> 
                                            <font size="2" face="Arial, Helvetica, sans-serif" color="#0000CC"><b> 
                                            </b></font></td>
                                          <td width="28%"> <font size="2" face="Arial, Helvetica, sans-serif" color="#0000CC"><b> 
                                            <select name="status" size="1">
                                              <%
                                             getStatusID=getIDForDescription("status","Submitted")
                                             Call LoadListBox("Status",getStatusID)
                                             %>
                                             </select>
                                            </b></font></td>
                                        </tr>
                                        <tr> 
                                          <td width="16%" bgcolor="#F0F0FF"><font size="2" face="Arial, Helvetica, sans-serif" color="#0000CC"><b>Referer</b></font></td>
                                          <td width="2%" bgcolor="#F0F0FF"><font size="2" face="Arial, Helvetica, sans-serif" color="#0000CC"><b>:</b></font> 
                                            <font size="2" face="Arial, Helvetica, sans-serif" color="#0000CC"><b> 
                                            </b></font></td>
                                          <td width="30%"> <font size="2" face="Arial, Helvetica, sans-serif" color="#0000CC"><b> 
                                            <input type="text" name="Refname" size="16" maxlength="30">
                                            </b></font></td>
                                          <td width="22%" bgcolor="#F0F0FF"><font size="2" face="Arial, Helvetica, sans-serif" color="#0000CC"><b>Company</b></font></td>
                                          <td width="2%" bgcolor="#F0F0FF"><font size="2" face="Arial, Helvetica, sans-serif" color="#0000CC"><b>: 
                                            </b></font></td>
                                          <td width="28%"> <font size="2" face="Arial, Helvetica, sans-serif" color="#0000CC"><b> 
                                            <input type="text" name="company" maxlength="50" size="16">
                                            </b></font></td>
                                        </tr>
                                        <tr> 
                                           <td width="22%" valign="top" bgcolor="#F0F0FF"><font size="2" face="Arial, Helvetica, sans-serif" color="#0000CC"><b>Select 
                                            Certificate(s) </b></font></td>
                                          <td width="2%" valign="top" bgcolor="#F0F0FF"><font size="2" face="Arial, Helvetica, sans-serif" color="#0000CC"><b>:</b></font> 
                                          </td>
                                          <td width="28%" valign="top" rowspan="2"><font size="2" face="Arial, Helvetica, sans-serif" color="#0000CC"><b> 
                                            <select size=10 name="certificate" multiple>
                                              <%
                                             Call LoadListBox("certificate",0)
                                             %>
                                            </select>
                                            </b></font></td>
                                          <td width="22%" valign="top" bgcolor="#F0F0FF"><font size="2" face="Arial, Helvetica, sans-serif" color="#0000CC"><b>Select 
                                            Country </b>(s)</font></td>
                                          <td width="2%" valign="top" bgcolor="#F0F0FF"><font size="2" face="Arial, Helvetica, sans-serif" color="#0000CC"><b>:</b></font> 
                                          </td>
                                          <td width="28%" valign="top" rowspan="2"><font size="2" face="Arial, Helvetica, sans-serif" color="#0000CC"><b> 
                                            <select size=10 name="countrylist" multiple>
                                              <%
                                             Call LoadListBox("Embassy",0)
                                             %>
                                            </select>
                                            </b></font></td>
                                        </tr><tr>
                                        <table><tr> 
                  <td width="20%"><font size="2" color="#0000CC"><b>Client's Message</b></font></td>
                  <td colspan="2"> 
                    <textarea cols=50 rows=4 name="retrieveremark"></textarea>
                  </td>
                </tr>
                </table></tr>
                                        <tr> 
                                          <td colspan="1"> 
                                            <div align="center"> 
                                              <input type="submit" value="Submit" id=submit1 name=submit1>
                                         
                                            <input type="reset" value="Reset" id=reset1 name=reset1>
                                          </td>
                                        </tr>
                                        <tr> 
                                          <td colspan="3"></td>
                                          <td colspan="3"></td>
                                        </tr>
                                      </table>
                                    </td>
                                  </tr>
                                </table>
                              </td>
                              <td align="right" width="1"> <img src="images/pixelsline.gif" width="1" height="7"> 
                              </td>
                            </tr>
                          </table>
                        </td>
                      </tr>
                      <tr> 
                        <td><img src="images/linebottom.jpg" width="576" height="13"></td>
                      </tr>
                    </table>
                  </td>
                </tr>
              </table>
              <font size="2" face="Arial, Helvetica, sans-serif" color="#0000CC"><b> 
              </b></font> 
            </form>
            <p>&nbsp;</p>



</td>
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
