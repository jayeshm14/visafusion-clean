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
<script language="javascript">
<!--

function CheckName()
{
a=document.entry.pname.value
ulen=a.length

//alert("value & len:"+a+ulen)
if (ulen==0)
{
alert("PAX NAME IS REQUIRED")
return false
}
}

function CheckRefName()
{
b=document.entry.Refname.value
blen=b.length
b=b.toLowerCase()
//alert("value & len:"+b+blen)
if (b=="check")
{
document.entry.retrieveremark.value="Kindly forward us the enclosure letter with clear communication details. We are not able to find out the name of the contact person in your organization, who has forwarded the case."
}

if (blen==0)
{
alert("REFERER NAME IS REQUIRED")

return false
}
}

function CheckCompName()
{
c=document.entry.company.value
clen=c.length
c=c.toLowerCase()

if (clen==0)
{
alert("COMPANY NAME IS REQUIRED")
return false
}
}

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
getpax=document.entry.pname.value
gettotalp=document.entry.totalp.value
getcountry=document.entry.countrylist.value
receive=document.entry.recdate.value
referer=document.entry.Refname.value
travdate=document.entry.travdate.value
company = document.entry.company.value
flag=0
msg=""

if (getentries > gettotalp)
{
msg=msg+"THE ENTRIES CAN NOT BE MORE THAN TOTAL PAX.\n"
flag=1
}
if (getpax=="")
{
msg=msg+"PLEASE ENTER PAX NAME IN THE ENTRIES.\n"
flag=1
}

if (getentries==""||gettotalp=="" )
{
msg=msg+"PLEASE CHECK VALUES IN THE ENTRIES.\n"
flag=1
}
if (isNaN(gettotalp))
{
msg=msg+"PLEASE ENTER A VALID NUMBER IN THE PASSENGERS.\n"
flag=1
}
if (receive=="")
{
msg=msg+"PLEASE ENTER THE RECIEVE DATE.\n"
flag=1
}
if (referer=="")
{
msg=msg+"PLEASE ENTER THE REFERER NAME OR ENTER CHECK.\n"
flag=1
}
if (company=="")
{
msg=msg+"PLEASE ENTER THE COMPANY NAME OR ENTER CHECK.\n"
flag=1
}
if (travdate=="")
{
msg=msg+"Travel Date is required, Please enter travel date.\n"
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

<script language="javascript" src="datecheck.js"></script>

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
                <td>
                <!-- #include file="top.asp" -->

</td>
              </tr>
              <tr>
                <td>


                <table width="100%" border="0" cellpadding="0" cellspacing="0">



              <tr>
                <td height="4" colspan="6">
                  <p align="center"><b><font size="3" color="#ff0000" face="Arial, Helvetica, sans-serif">
                   <%
                   if request("msgID")="1" then
                   response.write " The information added successfully.<br></font>"
%>
<!-- #include file="displayRefno.asp" -->
<!-- #include file="emailReceipt.asp" -->
<%

                   End if

'set rs=server.createobject("adodb.recordset")
'rs.open "select max(refno) from mainentry ",con,2,3
'if not rs.eof then
'refno=rs(0)+1
'end if
'rs.close

                   %>

                    </font></font></b></p>
                </td>
              </tr>

            </table>

            <form action="makeentry.asp#formtop" method=post name="entry" onsubmit="return checkAll()">
            <input type="hidden" name="username" value="<%= session("uname")%>" >
              <table width="44%" border="0" cellpadding="0" cellspacing="0" align="center">
<tr>
                  <td>

                  <a name="formtop"></a>
                    <table width="75%" border="0" align="center" cellpadding="0" cellspacing="0" bordercolor="#000090">
                      
          <tr bgcolor="#FFFFFF"> 
            <td height="19"> 
              <div align="center"><b><font size="4" color="#CC0000" face="verdana"><font color="#000099"><b><img src="updateimg/Submission%20Form%20Heading.jpg" width="321" height="87"></b></font></font></b> 
              </div>
                        </td>
                        </tr>
                      </table>

                  </td>
                </tr>
<tr>
                  <td>
                    <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" bgcolor="#000C80">
                                              <tr><td colspan="2"><img src="images/linetop.jpg" width="755" height="13"></td>
                      </tr>
                      <tr>
                        <td>
                          
              <table width="97%" border="0" align="center" cellpadding="0" cellspacing="0">
                <tr>
                              <td align="left" width="1"><img src="images/pixelsline.gif" width="1" height="7"></td>
                              
                  <td width="700"> 
                    <table width="100%" border="0" bgcolor="#FFFFF8" cellpadding="0" cellspacing="0" background="images/backform.jpg">
                                  <tr>
                                    <td>
                                      
                          <table width=94% border=0 cellspacing=1 cellpadding=1 align="center">
                            <tr> 
                              <td width="25%" bgcolor="#F0F0FF"><font size="2" face="Verdana" color="#0000FF"><b>Date</b></font></td>
                              <td width="2%" bgcolor="#F0F0FF"><font size="2" face="verdana" color="blue"><b>:</b></font> 
                              </td>
                              <td colspan="4"><font face="verdana" size=2 color="red"><b><%
      response.write ucase((formatdatetime(now(),1)))%></font></b> </td>
                            </tr>
                            <tr> 
                              <td width="25%" bgcolor="#F0F0FF"><font size="2" face="Verdana" color="#0000FF"><b>Pax 
                                Name</b></font></td>
                              <td width="2%" bgcolor="#F0F0FF"><font size="2" face="Arial, Helvetica, sans-serif" color="#0000CC"><b>:</b></font> 
                                <font size="2" face="Arial, Helvetica, sans-serif" color="#0000CC"><b> 
                                </b></font></td>
                              <td width="25%"> <font size="2" face="Arial, Helvetica, sans-serif" color="#0000CC"><b> 
                                <input type="text" name="pname" maxlength="30" size="16" onblur="JavaScript:CheckName()">
                                </b></font></td>
                              <td width="22%" bgcolor="#F0F0FF"><font size="2" face="Verdana" color="#0000FF"><b>Passport 
                                No</b></font></td>
                              <td width="2%" bgcolor="#F0F0FF"><font size="2" face="Arial, Helvetica, sans-serif" color="#0000CC"><b>: 
                                </b></font></td>
                              <td width="24%"> <font size="2" face="Arial, Helvetica, sans-serif" color="#0000CC"><b> 
                                <input type="text" name="passport" maxlength="50" size="16">
                                </b></font></td>
                            </tr>
                            <tr> 
                              <td width="25%" bgcolor="#F0F0FF"><font size="2" face="Verdana" color="#0000FF"><b>Passengers</b></font></td>
                              <td width="2%" bgcolor="#F0F0FF"><font size="2" face="Arial, Helvetica, sans-serif" color="#0000CC"><b>:</b></font> 
                                <font size="2" face="Arial, Helvetica, sans-serif" color="#0000CC"><b> 
                                </b></font></td>
                              <td width="25%"> <font size="2" face="Arial, Helvetica, sans-serif" color="#0000CC"><b> 
                                <input type="text" name="totalp" maxlength="10" size="10" value=1 onBlur="javascript:putvalue1(this.value)">
                                </b></font></td>
                              <td width="22%" bgcolor="#F0F0FF"><font size="2" face="Verdana" color="#0000FF"><b>Entries</b></font></td>
                              <td width="2%" bgcolor="#F0F0FF"><font size="2" face="Arial, Helvetica, sans-serif" color="#0000CC"><b>:</b></font> 
                              </td>
                              <td width="24%"> <font size="2" face="Arial, Helvetica, sans-serif" color="#0000CC"><b> 
                                <input size=10  name=entries value="1" onBlur="javascript:CheckNum(this.value)" maxlength="10">
                                </b></font></td>
                            </tr>
                            <tr> 
                              <td width="25%" bgcolor="#F0F0FF"><font size="2" face="Verdana" color="#0000FF"><b>Agent</b></font></td>
                              <td width="2%" bgcolor="#F0F0FF"><font size="2" face="Arial, Helvetica, sans-serif" color="#0000CC"><b>:</b></font> 
                              </td>
                              <td width="25%"> <font size="2" face="verdana, Helvetica, sans-serif" color="#0000CC"><b> 
                                <select  name="agentlist" size=1 >
                                  <%
Call LoadListBox("agents",0)

%> 
                                </select>
                                </b></font></td>
                              <td width="22%"><font face="Verdana" size="2" color="#0000FF"></font></td>
                              <td width="2%">&nbsp; </td>
                              <td width="24%">&nbsp;</td>
                            </tr>
                            <tr> 
                              <td width="25%" bgcolor="#F0F0FF"><font size="2" face="Verdana" color="#0000FF"><b>Date 
                                of Birth</b></font></td>
                              <td width="2%" bgcolor="#F0F0FF"><font size="2" face="Arial, Helvetica, sans-serif" color="#0000CC"><b>:</b></font> 
                              </td>
                              <td width="25%"> <font size="2" face="Arial, Helvetica, sans-serif" color="#0000CC"><b> 
                                <input type="text" name="dob" size="9" maxlength="10" onFocus="javascript:this.value=''" onKeyUp="DateFormat(this,this.value,event,false,'3')" onBlur="DateFormat(this,this.value,event,true,'3')">
                                </b><font face="Verdana" color="#FF0033"><b>(DD/MM/YY) 
                                </b> </font></font></td>
                              <td width="22%" bgcolor="#F0F0FF"><font size="2" face="Verdana" color="#0000FF"><b>Recieving 
                                Date</b></font></td>
                              <td width="2%" bgcolor="#F0F0FF"><font size="2" face="Arial, Helvetica, sans-serif" color="#0000CC"><b>:</b></font> 
                                <font size="2" face="Arial, Helvetica, sans-serif" color="#0000CC"><b> 
                                </b></font></td>
                              <td width="24%"> <font size="2" face="Arial, Helvetica, sans-serif" color="#0000CC"><b> 
                                <input type="text" name="recdate" size="10" value="<%= Day(Now())&"/" &Month(Now())&"/"&Year(Now())%>" maxlength="10" >
                                </b><font face="Verdana" color="#FF0033"><b>(DD/MM/YY)</b></font> 
                                </font></td>
                            </tr>
                            <tr> 
                              <td width="25%" bgcolor="#F0F0FF"><font size="2" face="Verdana" color="#0000FF"><b>Submit 
                                Date</b></font></td>
                              <td width="2%" bgcolor="#F0F0FF"><font size="2" face="Arial, Helvetica, sans-serif" color="#0000CC"><b>:</b></font> 
                                <font size="2" face="Arial, Helvetica, sans-serif" color="#0000CC"><b> 
                                </b></font></td>
                              <td width="25%"> <font size="2" face="Arial, Helvetica, sans-serif" color="#0000CC"><b> 
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
					%> 
                                <input type="text" name="subdate" maxlength="10" size="9" value="<%= trim(mydate)%>" >
                                </b><font face="Verdana" color="#FF0033"><b>(DD/MM/YY)</b></font></font></td>
                              <td width="22%" bgcolor="#F0F0FF"><font size="2" face="Verdana" color="#0000FF"><b>Collection 
                                Date</b></font></td>
                              <td width="2%" bgcolor="#F0F0FF"><font size="2" face="Arial, Helvetica, sans-serif" color="#0000CC"><b>:</b></font> 
                              </td>
                              <td width="24%"> <font size="2" face="Arial, Helvetica, sans-serif" color="#0000CC"><b> 
                                <input type="text" name="coldate" maxlength="10" size="10" value="<%= trim(mydate)%>" >
                                </b><font face="Verdana" color="#FF0033"><b>(DD/MM/YY) 
                                </b> </font></font></td>
                            </tr>
                            <tr> 
                              <td width="25%" bgcolor="#F0F0FF"><font size="2" face="Verdana" color="#0000FF"><b>POE/ECNR</b></font></td>
                              <td width="2%" bgcolor="#F0F0FF"><font size="2" face="Arial, Helvetica, sans-serif" color="#0000CC"><b>:</b></font> 
                                <font size="2" face="Arial, Helvetica, sans-serif" color="#0000CC"><b> 
                                </b></font></td>
                              <td width="25%"> <font size="2" face="Arial, Helvetica, sans-serif" color="#0000CC"><b> 
                                <select name="poe" size="1">
                                  <%
                                             'Call LoadListBox("poe",1)

                                             %> 
											<option value=1 Selected>NONE</option>
                                </select>
                                </b></font></td>
                              <td width="22%" bgcolor="#F0F0FF"><font size="2" face="Verdana" color="#0000FF"><b>Status 
                                </b></font></td>
                              <td width="2%" bgcolor="#F0F0FF"><font size="2" face="Arial, Helvetica, sans-serif" color="#0000CC"><b>:</b></font> 
                                <font size="2" face="Arial, Helvetica, sans-serif" color="#0000CC"><b> 
                                </b></font></td>
                              <td width="24%"> <font size="2" face="Arial, Helvetica, sans-serif" color="#0000CC"><b> 
                                <select name="status" size="1">
                                  <%
                                             getStatusID=getIDForDescription("status","Submitted")
                                             Call LoadListBox("Status",getStatusID)
                                             %> 
                                </select>
                                </b></font></td>
                            </tr>
                            <tr> 
                              <td width="25%" bgcolor="#F0F0FF"><font size="2" face="Verdana" color="#0000FF"><b>Referer</b></font></td>
                              <td width="2%" bgcolor="#F0F0FF"><font size="2" face="Arial, Helvetica, sans-serif" color="#0000CC"><b>:</b></font> 
                                <font size="2" face="Arial, Helvetica, sans-serif" color="#0000CC"><b> 
                                </b></font></td>
                              <td width="25%"> <font size="2" face="Arial, Helvetica, sans-serif" color="#0000CC"><b> 
                                <input type="text" name="Refname" size="16" maxlength="30" onblur="JavaScript:CheckRefName()">
                                </b></font></td>
                              <td width="22%" bgcolor="#F0F0FF"><font size="2" face="Verdana" color="#0000FF"><b>Company 
                                / File No.</b></font></td>
                              <td width="2%" bgcolor="#F0F0FF"><font size="2" face="Arial, Helvetica, sans-serif" color="#0000CC"><b>: 
                                </b></font></td>
                              <td width="24%"> <font size="2" face="Arial, Helvetica, sans-serif" color="#0000CC"><b> 
                                <input type="text" name="company" maxlength="50" size="16" onblur="JavaScript:CheckCompName()">
                                </b></font></td>
                            </tr>
                            <tr> 
                              <td width="25%" valign="top" bgcolor="#F0F0FF"><font size="2" face="Verdana" color="#0000FF"><b>Travel 
                                Date</b></font></td>
                              <td width="2%" valign="top" bgcolor="#F0F0FF"><font size="2" face="Arial, Helvetica, sans-serif" color="#0000CC"><b>&nbsp;</b></font> 
                                <font size="2" face="Arial, Helvetica, sans-serif" color="#0000CC"><b> 
                                </b></font></td>
                              <td width="25%" valign="top" rowspan="2"><font size="2" face="Arial, Helvetica, sans-serif" color="#0000CC"><b> 
                                <input type="text" name="travdate" size="9" maxlength="10" onFocus="javascript:this.value=''" onKeyUp="DateFormat(this,this.value,event,false,'3')" onBlur="DateFormat(this,this.value,event,true,'3')">
                                </b><font face="Verdana" color="#FF0033"><b>(DD/MM/YY)</b></font></font></td>
                              <td width="22%" valign="top" bgcolor="#F0F0FF"><b><font size="2" face="Verdana" color="#0000FF">Select 
                                Country (s)</font></b></td>
                              <td width="2%" valign="top" bgcolor="#F0F0FF"><font size="2" face="Arial, Helvetica, sans-serif" color="#0000CC"><b>:</b></font> 
                              </td>
                              <td width="24%" valign="top" rowspan="2"><font size="2" face="Arial, Helvetica, sans-serif" color="#0000CC"><b> 
                                <select size=10 name="countrylist" multiple>
                                  <%
                                             Call LoadListBox("Embassy",0)
                                             %> 
                                </select>
                                </b></font></td>
                            </tr>
                            <tr> 
                              <table>
                                <tr> 
                                  <td width="20%"><font size="2" FONT face="verdana" color="#0000FF"><b>Client 
                                    Message</b></font></td>
                                  <td colspan="2"> 
                                    <textarea cols=50 rows=4 name="retrieveremark"></textarea>
                                  </td>
                                </tr>
                              </table>
                            </tr>
                            <tr> 
                              <td colspan="1" width="25%"> <div align="center"> 
                                <% if session("priv")="adm" then %> 
                                <input type="submit" value="Submit" id=submit1 name=submit1>
                                <% end if %> 
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
                              
                  <td align="right" width="10"> <img src="images/pixelsline.gif" width="1" height="7"> 
                  </td>
                            </tr>
                          </table>
                        </td>
                      </tr>
                      <tr>
                        <td><img src="images/linebottom.jpg" width="755" height="13"></td>
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
