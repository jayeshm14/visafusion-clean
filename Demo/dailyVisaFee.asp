<%@ Language=VBScript %>
<%
response.buffer= true
%>
<!-- #include file="connection.asp" -->
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
                <td>

<body bgcolor="#FFFFFF">
<table width="80%" border="0" cellpadding="1" cellspacing="1" align="center">
  <tr> 
    <td> 
      <table width="75%" align="center" cellpadding="0" cellspacing="0">
        <tr bgcolor="#FFE898"> 
          <td height="19"> 
            <div align="center"><span class="tableCaption">Daily Visa Fee Summary</span> 
            </div>
          </td>
        </tr>
      </table>
    </td>
  </tr>
  <tr> 
    <td height="2">
      <table width="75%" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td><img src="images/linetopgreen1.gif" width="753 height="10"></td>
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
today=date()
totalvisafee=0
sdate=usrtosysdate(request("date"))
if sdate="" then
sdate=date()
end if
                  set rs=server.createobject("adodb.recordset")
				  set rss=server.createobject("adodb.recordset")
		 
				'if request("RefnoWise")="yes" then
                  stmt="select a.refno refno, d.invoiceno invoiceno, d.invtype invtype, a.paxid, b.paxname paxname, a.countryid,c.description CountryName, a.subdate subdate,a.visafee from paxstatus a, entrydetails b, embassy c,invoice d where a.paxid=b.paxid and a.countryid=c.embassyid and a.refno*=d.refno and day(subdate) = "&day(sdate)&" and month(subdate)="&month(sdate)&" and year(subdate)="&year(sdate)&" order by refno desc"
				'else
                '  stmt="select * from invoice where day(invoicedate) = "&day(sdate)&" and month(invoicedate)="&month(sdate)&" and year(invoicedate)="&year(sdate)&" order by invoiceno desc"
				'end if
                  rs.open stmt,con,3,3

                 %>
                  <td align="center"></td>
               
<td align="center">

<table width="97%" border="1">
  <tr> 
    <td colspan="9"> 


<form name=dailybill action="dailyVisafee.asp">
<font face="Arial, Helvetica, sans-serif" size="2"><b>Select a Date:</b></font> <select name="date">
<option value="<%=systousrdate(today)%>" selected><%=systousrdate(today)%></option> 
<% for i=1 to 250 %>
<option value="<%=systousrdate(Cdate(today)-i)%>"><%=systousrdate(cdate(today)-i)%></option>
<% next %>
</select>
<input type="submit" value=" GO " name="submit" class="ud">
</form>
    </td>
  </tr>
<%  if rs.eof then %>
  <tr> 
    <td colspan="9"> 
<span class="WSRightBold"> No Submission was done on -- <%=formatdatetime(Cdate(sdate),1)%>. </span>
    </td>
  </tr>
<%
else
startfrom=rs.fields("Refno")
rs.movelast
endtill=rs.fields("Refno")
rs.movefirst
%>
  <tr> 
    <td colspan="9"> 
      <div align="left"><b>Total  <%=rs.recordcount%>  Visa Submitted on  <%=formatdatetime(Cdate(sdate),1)%>.</b></div>
    </td>
  </tr>
  <tr> 
    <td width="10%"> 
      <div align="left"><b>Ref No.</b></div>
    </td>
    <td width="10%"> 
      <div align="left"><b>Agent Name</b></div>
    </td>
    <td width="10%" nowrap > 
      <div align="left"><b>Pax Name</b></div>
    </td>
    <td width="6%" nowrap > 
      <div align="left"><b>Country</b></div>
    </td>
    <td width="6%"> 
      <div align="left"><b>Bill</b></div>
    </td>
    <td width="6%"> 
      <div align="left"><b>Status</b></div>
    </td>
    <td width="6%"> 
      <div align="left"><b>VisaFee</b></div>
    </td>
    <td colspan="2"> 
      <div align="left"><b>Remark</b></div>
    </td>
  </tr>
<% while not rs.eof 
 refno=rs.fields("refno")
 paxid=rs.fields("paxid")
 countryid=rs.fields("countryid")
 invtype=rs.fields("invtype")
 visafee=rs.fields("visafee")
 CountryName=rs.fields("CountryName")
 
 stmts="select status,agent,internalremark from mainentry where refno='"&refno&"'"
 rss.open stmts,con,3,3
status=rss.fields("status")
agent=rss.Fields("agent")
remark=rss.Fields("internalremark")
rss.close
%>
  <tr> 
    <td width="10%"> 
    <font face="Arial, Helvetica, sans-serif" size="2">
  <div align="left">
  <%IF invtype="B" then%>
<% if session("priv")="adm" then %>
<a href="refnoTotaldetailsub.asp?refno=<%=rs.fields("refno")%>&cmd=Billed">
<% end if %>
<%=rs.fields("refno")%>
<% if session("priv")="adm" then %>
</a>
<% end if %>
<% else %>

<%=rs.fields("refno")%>

<% end if %>

</div>
    </font> </td>
    <td width="10%"  > 
    <font face="Arial, Helvetica, sans-serif" size="2">
      <div align="left"><%
      Agentname=getDescriptionForID("agents",agent)
Agentname=left (Agentname,20)
response.write Agentname %></div>
    </font> </td>
  <%IF invtype="B" then%>
    <td width="10%"><font face="Arial, Helvetica, sans-serif" size="2">
    
    <%=ucase(left(rs.fields("paxname"),10))%>
    </font> </td>
    <% else 
    invtype="N"%>
    <td width="6%"><font face="Arial, Helvetica, sans-serif" size="2">
    
    <a href="collectionFormPaxCountry.asp?refno=<%=refno%>&paxID=<%=paxid%>&agent=<%=agent%>&country=<%=countryid%>&pname=<%=rs.fields("paxname")%>"><%=left(rs.fields("paxname"),10)%></a>
    </font> </td>
    
    
    <%end if%>
    <td width="10%"><font face="Arial, Helvetica, sans-serif" size="2"><%=ucase(CountryName)%></font></td>
    <td width="6%">
    <font face="Arial, Helvetica, sans-serif" size="2">
<% if session("priv")="adm" and invtype="B" then %>
<a href="editbill.asp?refno=<%=rs.fields("refno")%>&cmd=Billed">
<%=invtype %>
</a>
<% else %>

<%=invtype %>

<% end if  %>

</font> </td>
    <td width="6%"> 
    
      <div align="left">
      <font face="Arial, Helvetica, sans-serif" size="2">
      <%
call writeIDDescription("status",status)
%> </font> </div>
    </td>
    <td width="6%"> 
      <div align="left"><font face="Arial, Helvetica, sans-serif" size="2">
      <b><% IF visafee>0 then
      response.Write visafee&"/-"
      totalvisafee=totalvisafee+visafee
      else 
      response.Write "0/-"
      end if
      %></b></font> </div>
    </td>
   <td colspan="2"><font face="Arial, Helvetica, sans-serif" size="2"> <%=remark%> </font></td>
  </tr>
<%
rs.movenext
wend
end if
rs.close
%>
<tr> 
    <td width="10%" colspan=6> 
      <div align="Right"><b>Total Visa Fee:</b></div>
    </td>
    <td width="6%" colspan=3> 
      <div align="left"><b>
      <%IF totalvisafee > 0 then
      response.Write totalvisafee&"/-"
      else 
      response.Write "0/-"
      end if%>
      </b></div>
    </td>
    </tr>
</table>



</td>
                          
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
          <td><img src="images/linetopgreen2.gif" width="753" height="10"></td>
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
