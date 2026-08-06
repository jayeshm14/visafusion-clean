<!-- #include file="connection.asp" -->
<script language="javascript">
<!--

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

<LINK href="includes/stylesheet.css" type=text/css rel=stylesheet>
<style type="text/css">
<!--
a {  font-family: Arial; font-size: 10pt; font-weight: bold; text-decoration: none; color: #000000}
a:hover {  font-family: Arial; font-size: 10pt; font-weight: bold; color: #FF0000; text-decoration: none}
-->
</style>



<form name="searchform" action="agent.asp">
  <table width="700" border="0" cellpadding="0" cellspacing="0" class="tdborder" align="center">
    <tr> 
      <td height="21" background="images/yellowbgband.gif"> 
        <p class="lbltext">Status of Reference no. <%=request("refno")%></p>
      </td>
    </tr>
    <tr> 
      <td height="20" valign="top" bgcolor="BD402C">&nbsp; </td>
    </tr>
    <tr> 
      <td height="20" valign="top" bgcolor="BD402C"> 
        <table width="600" border="0" align="center" cellpadding="0" cellspacing="0">
          <tr> 
            <td bgcolor="#B21E0D"> 
              <table width="650" height="53" border="0" align="center" cellpadding="0" cellspacing="1">
                <tr> 
                  <td width="120" height="25" align="left" bgcolor="#FBBD06"> 
                    <p class="dynamicheadingagent">PAX Name </p>
                  </td>
                  <td width="60" align="left" bgcolor="#FBBD06"> 
                    <p class="dynamicheadingagent">Status</p>
                  </td>
                  <td width="70" align="left" bgcolor="#FBBD06"> 
                    <p class="dynamicheadingagent">Received</p>
                  </td>
                  <td width="70" align="left" bgcolor="#FBBD06"> 
                    <p class="dynamicheadingagent">Submit</p>
                  </td>
                  <td width="70" align="left" bgcolor="#FBBD06"> 
                    <p class="dynamicheadingagent">Collection</p>
                  </td>
                  <td width="70" align="left" bgcolor="#FBBD06"> 
                    <p class="dynamicheadingagent">Country</p>
                  </td>
                </tr>
                <%  
set rs=server.createobject("adodb.recordset")
stmt ="select Entrydetails.Totalpax, mainentry.poe, paxstatus.refno,paxstatus.paxID,MainEntry.internalRemark,MainEntry.agentInstruction,EntryDetails.paxname,paxstatus.coldate,paxstatus.colcheck,paxstatus.Subdate, paxstatus.countryID,paxstatus.statusID,paxstatus.remarks,paxstatus.sentdate,entryDetails.Paxname,MainEntry.receivedate, Mainentry.Agent from Mainentry,EntryDetails,Paxstatus where paxstatus.paxid=entrydetails.paxid and entrydetails.refno=mainentry.refno and entrydetails.refno = "&request("refno")
'response.write stmt
rs.open stmt,con

if rs.eof then 
response.write "<tr bgcolor='#F0F0FF'><td colspan=11 align=center><font face='arial' size=2 color='#ff0000'>NO DATA FOUND, PLEASE CHECK YOUR REFERENCE NUMBER.</font></td></tr>" 
else 
while not rs.eof
paxID=rs.fields("paxID") 
refno=rs.fields("refno") 
agent=rs.fields("agent")
receivedate=SysToUsrDate(rs.fields("receivedate"))
subdate=SysToUsrDate(rs.fields("subdate"))
coldate=SysToUsrDate(rs.fields("coldate"))
check=rs.fields("colcheck")

if check="chk" and coldate<>"" then
coldate="CHK - "&coldate
end if

'response.write "<tr bgcolor='#F0F0FF'>"
poe=rs.fields("poe")
'if poe<>"1" then
'poe=getDescriptionForID("poe",poe)
'response.write("<br><b><font color='red'>"&poe&"</font></b>")
'end if
'response.write "</font></td>"
'response.write "<td width='70' height='25' align='right' bgcolor='BD402C'><p class='dynamictext1'>"&ucase(rs.fields("paxname"))&"</font></td>"
'response.write "<td width='70' height='25' align='right' bgcolor='BD402C'><p class='dynamictext1'>"
''call writeIDDescription("agents",agent)
'response.write"</font></td>"
'call writeIDDescription("status",rs.fields("statusid"))
'response.write"<td width='70' height='25' align='right' bgcolor='BD402C'><p class='dynamictext1'>"&receivedate&"</font></td><td width='70' height='25' align='right' bgcolor='BD402C'><p class='dynamictext1'>"&subdate&"</font></td><td width='70' height='25' align='right' bgcolor='BD402C'><p class='dynamictext1'>"&coldate&"</font></td><td width='70' height='25' align='right' bgcolor='BD402C'><p class='dynamictext1'>"&rs.fields("totalpax")&"</font></td><td width='70' height='25' align='right' bgcolor='BD402C'><p class='dynamictext1'>"
'if cmd="country" then
''response.write "<a href='collectionFormAgentPaxCountry.asp?refno="&refno&"&paxID="&paxID&"&agent="&agent&"&country="&rs.fields("countryID")&"&pname="&rs.fields("paxname")&"' > "
'call writeIDDescription("embassy",rs.fields("countryID"))
''response.write "</a>"

'else 
''response.write "<a href='collectionFormAgentPaxCountry.asp?refno="&refno&"&paxID="&paxID&"&agent="&agent&"&country="&rs.fields("countryID")&"&pname="&rs.fields("paxname")&"' > "
'call writeIDDescription("embassy",rs.fields("countryID"))
''response.write "</a>"

'end if

'response.write "<tr><td width='70' height='25' colspan=11 align='right' bgcolor='BD402C'></td></tr>"
%> 
                <tr> 
                  <td width="120" height="25" align="left" bgcolor="#FBBD06"> 
                    <p class="dynamictext1"><%=ucase(rs.fields("paxname"))%> <br>
                      <%
if poe<>"1" then
poe=getDescriptionForID("poe",poe)
response.write("("&poe&")")
end if
%></p>
                  </td>
                  <td width="60" align="left" bgcolor="#FBBD06"> 
                    <p class="dynamictext1"><% call writeIDDescription("status",rs.fields("statusid"))%></p>
                  </td>
                  <td width="70" align="left" bgcolor="#FBBD06"> 
                    <p class="dynamictext1"><%=receivedate%></p>
                  </td>
                  <td width="70" align="left" bgcolor="#FBBD06"> 
                    <p class="dynamictext1"><%=subdate%></p>
                  </td>
                  <td width="70" align="left" bgcolor="#FBBD06"> 
                    <p class="dynamictext1"><%=coldate%></p>
                  </td>
                  <td width="70" align="left" bgcolor="#FBBD06"> 
                    <p class="dynamictext1"><% call writeIDDescription("embassy",rs.fields("countryID"))%></p>
                  </td>
                </tr>
                <%
rs.movenext
wend
end if

rs.close()
%> 
              </table>
            </td>
          </tr>
        </table>
      </td>
    </tr>
    <tr> 
      <td height="20" valign="top" bgcolor="BD402C">&nbsp;</td>
    </tr>
  </table>
</form>
