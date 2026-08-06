
<%@ Language=VBScript %>
    <% response.buffer=true %>
<!-- #include file="connection.asp" -->
<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="styles.css" type="text/css">
</head>

<body bgcolor="#FFFFFF">
<table width="80%" border="0" cellpadding="0" cellspacing="0" align="center">
  <tr> 
    <td> <!-- #include file="top.asp" --></td></tr>
    <tr><td>&nbsp;</td></tr><td>
      <table width="75%" align="center" cellpadding="0" cellspacing="0">
        <tr bgcolor="#FFE898"> 
          <td height="19"> 
            <div align="center"><b><font size="3" color="#CC0000" face="Arial, Helvetica, sans-serif"><font color="#000099"><span class="tableCaption">ADD CERTIFICATES </span> 
              </font></font></b></div>
          </td>
        </tr>
      </table>
    </td>
  </tr>
  <tr> 
    <td> 
      <table width="83%" border="0" align="center" cellpadding="0" cellspacing="0" >
        <tr bgcolor="#FFFFFF"> 
          <td><img src="images/linetopgreen1.gif" width="660" height="10"></td>
        </tr>
        <tr> 
          <td> 
            <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
              <tr> 
                <td align="left" width="1"><img src="images/pixelsline.gif" width="1" height="7"></td>
                <td width="560"> 
                  <table width="100%" border="0" bgcolor="#FFFFF8" cellpadding="0" cellspacing="0" background="images/backform.jpg">
                    <tr> 
                      <td><table width="75%" border="0" cellspacing="0" cellpadding="0" align="center">
  <tr>
    <td>
      <table width="75%" border="0" cellpadding="0" cellspacing="0">
        <tr valign="top" align="center">
          
          <td width="98%"> 
            
                <td></td>
              </tr>
              <tr>
                <td align="center">
            
<% 
refno=request("refno")
paxID=request("paxID")
countryID=request("country")
attestation=request("attestation")
pname=request("pname")
if request("insertFlag")="" then
REsponse.write "<span class='WSRightBold'>ADD MORE CERTIFICATES(S) FOR PASSENGER :"& ucase(pname)&"</span><br>"
%>

<form Name=addmore action=addMoreCertificate.asp>
<input type="hidden" name="insertFlag" value="go">
<input type="hidden" name="refno" value="<%= refno %>">
<input type="hidden" name="paxID" value="<%= paxID %>">
<input type="hidden" name="country" value="<%= countryID %>">
<table>


<tr>
<td><span class="WSRightBold"> Attestation </span><td>
				<select name="attestation" size="1">
                                              <%
                                             Call LoadListBox("Attestation",1)
                                             %>
                                              </select>
</td></tr>
<tr><td><span class="WSRightBold">SELECT COUNTRY(s)</span></td>
<td>
<select size=10 name="certificate" multiple>
<%
call loadlistbox("certificate",certificateid)                   
%> </select>
</td></tr>

<tr><td align="center">
<input type="submit" name="submit" class="ud"value="add">                    
</td></tr>
</table>                    
 </form>
 
 <% 

 Else

set rs=server.createobject("adodb.recordset")
set rsHistory=server.createobject("adodb.recordset")
count=0
count=request("certificate").count


for ii=1 to count
if request("certificate")(ii)<> "" then

stmt="select * from paxAttestation where paxID="&paxID&" and countryID="&countryID&" and certificateid="&request("certificate")(ii)

rs.open stmt,con,2,3
if rs.eof then
rs.addnew
rs("paxID")=paxID
rs("countryID")=cint(countryID)
rs("attestationID")=cint(attestation)
rs("certificateid")=request("certificate")(ii)
rs.update

				

Response.Write "<P align=center> <span class='WSRightBold'>CERTIFICATE "
call writeIddescription("certificate",request("certificate")(ii))
response.write  " ADDED SUCCESSFULLY.</span></p>"
else
Response.Write "<P align=center><span class='WSRightBold'> CERTIFICATE  "
call writeIddescription("certificate",request("certificate")(ii))
response.write " ALREADY ADDED FOR PAX "&pname&"</span><br></p>"

end if
end if
rs.close()			
next

Response.Write "<P align=center><a href='editEntry.asp?refno="&refno &"'>Click here to  view changes</a>.</p>"
'response.clear()
'myurl="editEntry.asp?refno="&refno
'response.redirect myurl
End if


%>
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
                  </table>
                </td>
            </table>
          </td>
        </tr>
        <tr bgcolor="#FFFFFF"> 
          <td align="center"><img src="images/linetopgreen2.gif" width="660" height="10"></td>
        </tr>
        <tr>
                <td><!-- #include file="empBottom.asp" --></td>
          
    </tr>
      </table>
    </td>
  </tr>
  
</table>
</body>
</html>





