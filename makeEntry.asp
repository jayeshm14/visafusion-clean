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
<title>www.UdaanIndia.com</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<script language="javascript" src="datecheck.js"></script>

<script language="javascript">
<!--
function CheckNum(var1)
{
if (isNaN(var1))
{
alert("Please enter a valid number.")
}
}

function MM_preloadImages() { //v3.0
  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}

function MM_swapImgRestore() { //v3.0
  var i,x,a=document.MM_sr; for(i=0;a&&i<a.length&&(x=a[i])&&x.oSrc;i++) x.src=x.oSrc;
}

function MM_findObj(n, d) { //v3.0
  var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
    d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document); return x;
}

function MM_swapImage() { //v3.0
  var i,j=0,x,a=MM_swapImage.arguments; document.MM_sr=new Array; for(i=0;i<(a.length-2);i+=3)
   if ((x=MM_findObj(a[i]))!=null){document.MM_sr[j++]=x; if(!x.oSrc) x.oSrc=x.src; x.src=a[i+2];}
}
//-->
</script>
<meta name="GENERATOR" content="Microsoft Visual Studio 6.0">
</head>

<body  topmargin=0 leftmargin=0 marginwidth=0 marginheight=0 >
<table width="101%" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td>
      <table width="75%" border="0" cellpadding="0" cellspacing="0">
        <tr>
          
          <td width="85%" valign="top"> 
            <table width="100%" border="0" cellpadding="0" cellspacing="0">
              <tr> 
                <td colspan="6"><!-- #include file="top.asp" --></td>
              </tr>
              
             
            </table>
           
            
              <form  action="insertentry.asp" method=post>
              <input type="hidden" name="username" value="<%= session("uname")%>" >
              <%
flag=0
agent=Request.Form("agentlist")
refname=Request.Form("refname")


if trim(request("pname"))<>"" then
pname=request("pname")
else
pname="NE"
end if
dob=Request.Form("dob")
passport=Request.Form("passport")
company=Request.Form("company")
totalp=Request.Form("totalp")
subdate=Request.Form("subdate")
subdate=UsrToSysDate(subdate)
if subdate<>"" then
if weekday(subdate)=1 or weekday(subdate)=7 then
subweekendFlag=1
end if 
end if

coldate=Request.Form("coldate")
coldate=UsrToSysDate(coldate)
if coldate<>"" then
if weekday(coldate)=1 or weekday(coldate)=7 then
colweekendFlag=1
end if 
end if

recdate=Request.Form("recdate")
travdate=Request.Form("travdate")

'category=Request.Form("category")
'attestation=Request.Form("attestation")
poe=Request.Form("poe")
entrytype=Request.Form("entrytype")
retrieveremark=Request.Form("retrieveremark")
status=lcase(Request.Form("status"))
entries=cint(Request.Form("entries"))
count=0
count=request.form("countrylist").count
dim countrylist(200) 
cnt=1
for ii=1 to count
if request.form("countrylist")(ii)<> "" then
countrylist(cnt)= Request.Form("countrylist")(ii)
cnt=cnt+1
end if
next
set rs=server.createobject("adodb.recordset")

%> 
              <div align="center">
              
                <table width="44%" border="0" cellpadding="0" cellspacing="0" align="center">
                  <tr><td><a name="formtop">&nbsp;</a>
                      <table width="75%" border="1" align="center" cellpadding="0" cellspacing="0" bordercolor="#000090">
                        <tr bgcolor="#FFFFF0"> 
                          <td height="19"> 
                            <div align="center"><b><font size="3" color="#CC0000" face="Arial, Helvetica, sans-serif"><font color="#000099"><i>SUBMISSION 
                              FORM</i></font></font></b> </div>
                          </td>
                        </tr>
                      </table>
                    </td></tr><tr> 
                    <td height="200"> 
                      <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" bgcolor="#000C80">
                        <tr> 
                          <td><img src="images/linetop.jpg" width="576" height="13"></td>
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
                                        <table width=90% border=0 cellspacing=1 cellpadding=1 align="center">
                                          <tr> 
                                            <td width="26%" bgcolor="#F0F0FF"><font size="2" color="#0000CC" face="Arial, Helvetica, sans-serif"><b>Date</b></font></td>
                                            <td width="2%" bgcolor="#F0F0FF"><font size="2" color="#0000CC" face="Arial, Helvetica, sans-serif"><b>: 
                                              </b></font></td>
                                            <td colspan="4"><font size="2" color="#0000CC"><font face="Arial, Helvetica, sans-serif" color="#FF0000"><% response.write ucase((formatdatetime(now(),1)))%></font></font> 
                                            </td>
                                          </tr>
                                          <%
  for ii=1 to count
			country=Cint(request.form("countrylist")(ii))
			canadaid=getIDForDescription("Embassy","canada")
			if country= canadaid then
			canadaflag=1
			end if
			australiaid=getIDForDescription("Embassy","australia")
			if country= australiaid then
			australiaflag=1
			end if
			newzealandid=getIDForDescription("Embassy","newzealand")
			if country= newzealandid then
			newzealandflag=1
			end if

					if coldate<>"" then
					query1="select * from holidaylist where countryID="&country&" and (Day(holiday)="&day(coldate)&" and month(holiday)="&month(coldate)&" and year(holiday)="&year(coldate)&")"
					
					rs.open query1,con
					if not rs.eof then
					response.write "<tr> <td colspan=6><img src='images/alert1.gif'> <font size=2 color='#006600'> Embassy of <B>"
					call writeIDDescription("embassy",country)
					response.write " </b> is closed on "&formatdatetime(rs("holiday"),1)&" Due to <B> "&ucase(rs("description"))&"</b>. Collection not possible. <BR></font></td></tr>"
					insertEntry="N"
					'coldate=cdate(coldate)+1
					end if
					rs.close
					end if
					if subdate<>"" then
					query1="select * from holidaylist where countryID="&country&" and ((Day(holiday)="&day(subdate)&" and month(holiday)="&month(subdate)&" and year(holiday)="&year(subdate)&"))"
					
					rs.open query1,con
					if not rs.eof then
					response.write "<tr> <td colspan=6><img src='images/alert1.gif'><font size=2 color='#006600'> Embassy of <B>"
					call writeIDDescription("embassy",country)
					response.write " </b> is closed on "&formatdatetime(rs("holiday"),1)&" Due to <B> "&ucase(rs("description"))&"</b>. Submission not possible.<BR></font></td></tr>"
					insertEntry="N"
					'subdate=cdate(subdate)+1
					end if
					rs.close
					end if

next
if subweekendFlag=1 then
response.write "<tr> <td colspan=6><img src='images/alert1.gif'><font size=2 color='#006600'>SUBMISSION DATE FALLS ON THE WEEKEND "&formatDatetime(subdate,1)&".</font></td></tr> "
end if 
if colweekendFlag=1 then
response.write "<tr> <td colspan=6><img src='images/alert1.gif'><font size=2 color='#006600'>COLLECTION DATE FALLS ON THE WEEKEND"&formatDatetime(coldate,1)&".</font></td></tr> "
end if 
recdate=UsrToSysDate(recdate)
travdate=UsrToSysDate(travdate)

%> 
                                          <tr> 
                                            <td width="26%" bgcolor="#F0F0FF"><font size="2" color="#0000CC" face="Arial, Helvetica, sans-serif"><b>Agent</b></font></td>
                                            <td width="2%" bgcolor="#F0F0FF"><font size="2" color="#0000CC" face="Arial, Helvetica, sans-serif"><b>:</b></font></td>
                                            <td colspan=4> <font size="2" color="#006600" face="Arial, Helvetica, sans-serif">
                                            <% 
                                            call writeIddescription("agents",agent)
                                  
                                             %> 
                                             
                                              <input type="hidden" name="agent" value="<%=agent %>" >
                                              </font><font size="2" color="#0000CC" face="Arial, Helvetica, sans-serif"> 
                                              </font></td>
                                          </tr>
                                          <tr> 
                                            <td width="26%" bgcolor="#F0F0FF"><font size="2" color="#0000CC" face="Arial, Helvetica, sans-serif"><b>Refferer 
                                              Name</b></font></td>
                                            <td width="2%" bgcolor="#F0F0FF"><font size="2" color="#0000CC" face="Arial, Helvetica, sans-serif"><b>:</b></font></td>
                                            <td width="23%"> <font size="2" color="#006600" face="Arial, Helvetica, sans-serif"><%= ucase(refname) %> 
                                              <input type="hidden" name="refname" value="<%=refname %>" >
                                              </font></td>
                                            <td width="20%" bgcolor="#F0F0FF"><font size="2" color="#0000CC" face="Arial, Helvetica, sans-serif"><b>Company</b></font></td>
                                            <td width="2%" bgcolor="#F0F0FF"><font size="2" color="#0000CC" face="Arial, Helvetica, sans-serif"><b>:</b></font></td>
                                            <td width="27%"> <font size="2" color="#006600" face="Arial, Helvetica, sans-serif"><%=ucase(company) %> 
                                              <input type="hidden" name="company" value="<%=company %>" >
                                              <input type="hidden" name="passport" value="<%=passport %>" >
                                              <input type="hidden" name="totalp" value=<%=totalp %> >
                                              <input type="hidden" name="entries" value=<%=entries %> >
                                              <input type="hidden" name="dob" value="<%=dob %>" >
                                              <input type="hidden" name="subdate" value="<%=subdate %>" >
                                              <input type="hidden" name="coldate" value="<%=coldate %>" >
                                              </font></td>
                                          
                                          
                                          <tr> 
                                            <td width="26%" bgcolor="#F0F0FF"><font size="2" color="#0000CC" face="Arial, Helvetica, sans-serif"><b>PAX 
                                              Name</b></font></td>
                                            <td width="2%" bgcolor="#F0F0FF"><font size="2" color="#0000CC" face="Arial, Helvetica, sans-serif"><b>:</b></font></td>
                                            <td width="23%"> <font size="2" color="#006600" face="Arial, Helvetica, sans-serif"><%= ucase(pname) %> 
                                              <input type="hidden" name="pname" value="<%=pname %>" >
                                              </font></td>
                                            <td width="20%" bgcolor="#F0F0FF"><font size="2" color="#0000CC" face="Arial, Helvetica, sans-serif"><b>Receive 
                                              date </b></font></td>
                                            <td width="2%" bgcolor="#F0F0FF"><font size="2" color="#0000CC" face="Arial, Helvetica, sans-serif"><b>:</b></font></td>
                                            <td width="27%"> <font size="2" color="#006600" face="Arial, Helvetica, sans-serif">
                                            <%
                                            If recdate <> "" Then
                                             Response.write ucase(FormatDateTime(recdate,1))
                                            End if
                                            %> 
                                              <input type="hidden" name="recdate" value="<%=recdate %>" >
                                              <input type="hidden" name="travdate" value="<%=travdate %>" >
                                              </font></td>
                                          </tr>
                                          
                                         
                                          
                                          
                                          <tr> 
                                            <td width="26%" bgcolor="#F0F0FF"><font size="2" color="#0000CC" face="Arial, Helvetica, sans-serif"><b>POE/ECNR 
                                              </b></font></td>
                                            <td width="2%" bgcolor="#F0F0FF"><font size="2" color="#0000CC" face="Arial, Helvetica, sans-serif"><b>: 
                                              </b></font></td>
                                            <td width="23%"> <font size="2" color="#006600" face="Arial, Helvetica, sans-serif">
                                            <%
                                            if poe <> "" then
                                            call writeIDdescription("poe",poe)
                                            end if
                                             %> 
                                              <input type="hidden" name="poe" value="<%=poe %>" >
                                              </font></td>
                                            <td width="20%" bgcolor="#F0F0FF"><font size="2" color="#0000CC" face="Arial, Helvetica, sans-serif"><b>Status</b></font></td>
                                            <td width="2%" bgcolor="#F0F0FF"><font size="2" color="#0000CC" face="Arial, Helvetica, sans-serif"><b>:</b></font></td>
                                            <td width="27%"> <font size="2" color="#006600" face="Arial, Helvetica, sans-serif">
                                            <%
                                            if status <> "" then
                                            call writeIDdescription("status",status)
                                            end if
                                             %> 
                                              <input type="hidden" name="status" value="<%=status %>" >
                                              </font></td>
                                          </tr>
                                          
                                          <script language="javascript">
function CheckNum(var1)
{
if (isNaN(var1))
{
alert("Please enter a valid number.")
return false;
}
}
</script>
                                          
     
	<table border=1>
	<tr>
	<TD><font size=2 color=#0000CC><b>PAXNAME</B></FONT></TD>
	<TD><font size=2 color=#0000CC><b>PASSPORT #</B></FONT></TD>
	<TD><font size=2 color=#0000CC><b>TOTAL</B></FONT></TD>
	<TD><font size=2 color=#0000CC><b>D.O.B</B></FONT></TD>
	
	</TR>
	
	
	<%
	response.write "<TR><TD><input type=text name='name1' value="& "'"& ucase(pname) &"'"&"size=15 > </TD><TD> <input type=text name='epassport1' value="&"'"&passport&"'"& "size=10></TD><TD> <input type=text name='totp1'  value='1' size=4></TD><TD><input type=text name=dob1 value='"&request("dob")&"' size=10 > "
	if canadaflag=1 and dob="" then
		response.write "<img src='images/alert1.gif'> <b>DOB</b></TD></tr>"
  	elseif australiaflag=1 and dob="" then
		response.write "<img src='images/alert1.gif'> <b>DOB</b></TD></tr>"
	elseif newzealandflag=1 and dob="" then
		response.write "<img src='images/alert1.gif'> <b>DOB</b></TD></tr>"
	else
		response.write "</TD></tr>"
	end if
					  

	 
	for l=1 to count
	
	response.write "<TR><TD ><font size=""2"" color=""#006600"" face=""Arial, Helvetica, sans-serif"">"
	response.write "<input type=checkbox name=country1"&l&" value='"&countrylist(l)&"' checked>"
	varCountry=countrylist(l)
	call WriteIDDescription("embassy",varCountry)
	response.write " </td><td><select name=categorytype1"&l&" size=""1"">"
	 Call LoadListBox("category",2)
	response.write "</td><TD ><select name=entrytype1"&l&" size=""1"">"
	  Call LoadListBox("Entrytype",2)
                                          
	response.write "</SELECT></td><TD COLSPAN=2><font size=""1"" color=""#006600"" face=""Arial, Helvetica, sans-serif"">SUB:<input type=text name=subdate1"&l&" size='10' value="&systousrdate(subdate)&" > <br> COL:<input type=text name=coldate1"&l&" size='10' value="&systousrdate(coldate)&">"
	response.write "CONF.<input type=radio name=colcheck1"&l&"  value='conf' >CHK.<input type=radio name=colcheck1"&l&"  value='chk' checked >  </FONT></TD></TR>"
	next
	
	response.write "</FONT></td></TR>"
	for k=2 to entries
	response.write "<TR><TD><input type=text name=name"&k&" size=15 ></TD><TD> <input type=text name=epassport"&k&"   size=10></TD><TD><input type=text name=totp"&k&"  value=1 size=4> </TD><TD><input type=text name=dob"&k&"   size='10'>"
	if canadaflag=1 and dob="" then
		response.write "<img src='images/alert1.gif'></TD></TR>"
		else
		response.write "</TD></TR>"
	 end if
	
	for l=1 to count
	response.write "<TR><TD <TD><font size=""2"" color=""#006600"" face=""Arial, Helvetica, sans-serif"">"
	response.write "<input type=checkbox name=country"&k&l&" value='"&countrylist(l)&"' checked>"
	varCountry=countrylist(l)
	call WriteIDDescription("embassy",varCountry)
	response.write " </td><td><select name=categorytype"&k&l&" size=""1"">"
	 Call LoadListBox("category",2)
	 response.write "</td><TD><select name=entrytype"&k&l&" size=""1"">"
	  Call LoadListBox("Entrytype",2)
                                          
	response.write "</SELECT></td><TD COLSPAN=2><font size=""1"" color=""#006600"" face=""Arial, Helvetica, sans-serif"">SUB:<input type=text name=subdate"&k&l&" size='10' value="&systousrdate(subdate)&"  ><br>COL:<input type=text name=coldate"&k&l&" size='10' value="&systousrdate(coldate)&" >"
	response.write "CONF.<input type=radio name=colcheck"&k&l&"  value='conf' >CHK.<input type=radio name=colcheck"&k&l&"  value='chk' checked >  </FONT></TD></TR>"
	next
	
	next
	
	response.write "<input type=hidden name=raj value="&entries&" >"
response.write "<input type=hidden name=venesh value="&count&" ></b></font> </td></TR>"


	
	
%> 



                                          <tr> 
                                            <td  bgcolor="#F0F0FF"><font size="2" color="#0000CC" face="Arial, Helvetica, sans-serif"><b>Client's 
                                              Message </b></font></td>
                                            <td width="2%" bgcolor="#F0F0FF"><font size="2" color="#0000CC" face="Arial, Helvetica, sans-serif"><b>:</b></font></td>
                                            <td colspan="4"> <font size="2" color="#CC0000"><font face="Arial, Helvetica, sans-serif">&nbsp;<%=ucase(retrieveremark) %> 
                                              <input type="hidden" name="retrieveremark" value="<%=retrieveremark %>" >
                                              </font></font></td>
                                          </tr>
                                          <tr> 
                                            <td colspan="6" > 
                                              <div align="center"> <font size="2" color="#0000CC"><b> 
<% if session("priv")="adm" then %>
                                                <input type="submit" value="Submit" id=submit1 name=submit1>
<% end if %>
                                                </b></font>
                                            <font size="2" color="#0000CC"><b> 
                                              <input type="button" value="Edit"  onClick="javascript:history.back()" name=reset1>
                                              </b></font></div></td>
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
                  
                  <tr>
                <td><!-- #include file="empBottom.asp" --></td>
          
    </tr>
                </table>
                
              </div>
              <p>&nbsp;</p>
            </form>


</td>
        </tr>
      </table>
    </td>
  </tr>
</table>
</body>
</html>
