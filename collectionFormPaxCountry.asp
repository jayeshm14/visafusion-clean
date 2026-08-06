<!-- #include file="connection.asp" -->
<% response.buffer=true %>
<% response.buffer=true 
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

<script language="JavaScript">
<!--
function MM_preloadImages() { //v2.0
  if (document.images) {
    var imgFiles = MM_preloadImages.arguments;
    if (document.preloadArray==null) document.preloadArray = new Array();
    var i = document.preloadArray.length;
    with (document) for (var j=0; j<imgFiles.length; j++) if (imgFiles[j].charAt(0)!="#"){
      preloadArray[i] = new Image;
      preloadArray[i++].src = imgFiles[j];
  } }
}

function MM_swapImgRestore() { //v2.0
  if (document.MM_swapImgData != null)
    for (var i=0; i<(document.MM_swapImgData.length-1); i+=2)
      document.MM_swapImgData[i].src = document.MM_swapImgData[i+1];
}

function MM_swapImage() { //v2.0
  var i,j=0,objStr,obj,swapArray=new Array,oldArray=document.MM_swapImgData;
  for (i=0; i < (MM_swapImage.arguments.length-2); i+=3) {
    objStr = MM_swapImage.arguments[(navigator.appName == 'Netscape')?i:i+1];
    if ((objStr.indexOf('document.layers[')==0 && document.layers==null) ||
        (objStr.indexOf('document.all[')   ==0 && document.all   ==null))
      objStr = 'document'+objStr.substring(objStr.lastIndexOf('.'),objStr.length);
    obj = eval(objStr);
    if (obj != null) {
      swapArray[j++] = obj;
      swapArray[j++] = (oldArray==null || oldArray[j-1]!=obj)?obj.src:oldArray[j];
      obj.src = MM_swapImage.arguments[i+2];
  } }
  document.MM_swapImgData = swapArray; //used for restore
}
//-->
</script>
</head>

<body bgcolor="#FFFFFF"  topmargin=0 leftmargin=0 marginwidth=0 marginheight=0 >
<table width="100%" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td>
      <table width="75%" border="0" cellpadding="0" cellspacing="0">
        <tr>
          
          <td width="98%" valign="top"> 
            <table width="100%" border="0" cellpadding="0" cellspacing="0">
              <tr><td>
               <!-- #include file="top.asp" -->
              </tr>
              <tr>
                <td valign=top> 
                  <table width="99%" border="0">
                    <tr>  <font size="2" face="verdana" color="#006600"><b><%RESPONSE.WRITE session("lname")%></font>  </tr>
                   <tr> 
                      <td colspan="6" align="center"><b><font size="3" face="verdana" color="#CC0000">
                      COLLECTION FORM</font></b> </td>
                    </tr>
                   
                  </table>
                  </tr>
                   
                  </table>
                  
                </td>
              </tr>
            </table>
<form name="regist" action="collectionPaxSubmit.asp" method="post">
<input type="hidden" name="username" value="<%= session("uname")%>" >
 <input type="hidden" name="pname" value="<%= request("pname")%>" >
 <input type="hidden" name="agent" value="<%= request("agent")%>" >
 <input type="hidden" name="refno" value="<%=request("refno") %>" >
 <input type="hidden" name="cmd" value="<%= request("cmd")%>" >
<input type="hidden" name="page" value="<%= request("page")%>" >           
    <%
    refno=request("refno")
    PaxID=request("Paxid")
    countryID=request("country")
    categoryid=getIDForDescription("category","Attestation")
set rs=server.createobject("adodb.recordset")
set rscountry=server.createobject("adodb.recordset")
Set rsInvoice =server.createobject("adodb.recordset")
Set rscert =server.createobject("adodb.recordset")
        
stmt="select * from mainEntry where refno="&refno                
rs.open stmt,con,2,3
if not rs.eof then
bill=rs("bill")
internal=ucase(rs("internalremark"))             
external=Ucase(rs("externalremark"))  
mainstatus=rs.fields("status")  
category=rs.fields("category")             
end if

i=0

countrylist=""

GetALLData="select * from entrydetails where  PaxID="&PaxID &" Order by paxname"
rscountry.activeconnection=con
rscountry.open GetALLData,con
while not rscountry.eof
pname1=rscountry.fields("paxname")

getinvoice="select * from paxstatus where  PaxID="&PaxID &" and countryID="&countryID

rsInvoice.open getinvoice,con
while not rsInvoice.EOF 
i=i+1
temp_ddcharges=rsInvoice("ddcharges")
temp_handlingfee=rsInvoice("handlingfee")
temp_visafee=rsInvoice("visafee")
temp_VFSTTCharges=rsInvoice("VFSTTCharges")

temp_total=rsInvoice("total")
temp_subdate=SysToUsrDate(rsInvoice("subdate"))
temp_coldate=SysToUsrDate(rsInvoice("coldate"))
temp_colcheck=rsInvoice("colcheck")
temp_sentdate=SysToUsrDate(rsInvoice("sentdate"))

%>
<table width=75% border=0 cellspacing=1 cellpadding=1 align="center">
                <% if bill="Y" then
              %>
                <tr><td colspan=4><font size="3" face="verdana" color="#CC0000">BILL HAS ALREDY FORMED </font></td> </tr>
                <%
                end if
                %>
                <tr> 
                  <td colspan="4"> 
                    <div ><font size="2" face="verdana" color="#0000CC"><b>Please 
                      Enter the information regarding <font size="3" color="#006600"><b> <%= ucase(pname1) %></b></font> for country 
                      <%
                      call writeIDDescription("embassy", rsinvoice.fields("countryID")) 
                      
                       if not categoryid=category then
                       response.write " ( "
                        call writeIDDescription("entrytype", rsinvoice.fields("entrytype"))
                        response.write " )" 
                       end if
                      %>
                      </b></font> </div>
                      <input type="hidden" name="paxid<%=i%>" value="<%=PaxID  %>" >
                     
                       <input type="hidden" name="countryinv<%=i%>" value="<%=rsInvoice.fields("countryID")  %>" >
                  </td>
                </tr>
                
                 <% 
                      
                      if categoryid=category then
                      
                      stmt="select * from paxAttestation where paxID="&PaxID&" and countryID="&rsinvoice.fields("countryID")
                      rscert.open stmt,con
                      if not rscert.eof then
                      response.write "<tr><td valign='top'><font size='2' color='#0000cc'><b> CERTIFICATES:</b></font></td><td colspan=3><font size='2' color='#006600'><b> " 
                      while not rscert.eof
                      
                      call writeIDDescription("certificate",rscert("certificateID"))
                       response.write " ( "
                       call writeIDDescription("Attestation",rscert("AttestationID"))
                       response.write ")<br> "
                       rscert.movenext
			wend
			 response.write " </b></font></td></tr>"
			End if
			end if
                      %>
                <tr> 
                <td><font size="2" color="#0000CC"><b> Charges</b></font></td>
                  <td width="30%" colspan=3> 

<% if ucase(session("uname"))="UMA" or ucase(session("uname"))="VIPIN" or ucase(session("uname"))="BINEET" or ucase(session("uname"))="MANISH" or ucase(session("uname"))="HKSHAH" or ucase(session("su"))="Y" then %>
                    <Table border="1"><tr>
                    
                  <td > <font size="2" face="verdana" color="#006600"><b> Visa</b></font></td>
                    <td> <font size="2" face="verdana" color="#006600"><b>DD</b></font></td>
                  
                    <td > <font size="2" face="verdana" color="#006600"><b> Handling</b></font></td>
                    <td > <font size="2" face="verdana" color="#006600"><b>VFS/TT/Other</b></font></td>
                   
                    <td > <font size="2" face="verdana" color="#006600"><b>Total</b></font></td>
                    </tr>
                    <tr>
                    
                  <td > <font size="2" color="#006600"><b> 
                  <input type="text" name="visafee<%=i%>" value="<%=temp_visafee%>" size="8" onblur="add2Total<%=i%>()" maxlength="20"></b></font></td>
                    <td> <font size="2" color="#006600"><b>
                    <input type="text" name="dd<%=i%>" value="<%=temp_ddcharges%>" size="8"    onblur="add2Total<%=i%>()" maxlength="20">
                    </b></font></td>
                    
                    <td > <font size="2" color="#006600"><b>
                    <input type="text" name="handling<%=i%>" value="<%=temp_handlingfee%>" size="8" onblur="add2Total<%=i%>()" maxlength="20">
                    </b></font></td>

                    <td > <font size="2" color="#006600"><b>
                    <input type="text" name="VFSTTCharges<%=i%>" value="<%=temp_VFSTTCharges%>" size="8" onblur="add2Total<%=i%>()" maxlength="20">
                    </b></font></td>

                    <td> <font size="2" color="#006600"><b>
                    <input type="text" name="total<%=i%>" value="<%=temp_total%>" size="10" maxlength="20" readonly>
                    <input type="hidden" name="oldtotal<%=i%>" value="<%=temp_total%>" >
                    </b></font></td>
                    </tr>
                    </table>
<% else %>
                    <Table border="1"><tr>
                    
                  <td > <font size="2" face="verdana" color="#006600"><b> Visa</b></font></td>
                    <td> <font size="2" face="verdana" color="#006600"><b>DD</b></font></td>
                  
                    <td > <font size="2" face="verdana" color="#006600"><b> Handling</b></font></td>
                    <td > <font size="2" face="verdana" color="#006600"><b> VFS/TT/Other</b></font></td>
                   
                    <td > <font size="2" face="verdana" color="#006600"><b>Total</b></font></td>
                    </tr>
                    <tr>
                    
                  <td > <font size="2" face="verdana" color="#006600"><b> 
                  <input type="text" name="visafee<%=i%>" value="<%=temp_visafee%>" size="8" onblur="add2Total<%=i%>()" maxlength="20" onfocus="blur()"></b></font></td>
                    <td> <font size="2" face="verdana" color="#006600"><b>
                    <input type="text" name="dd<%=i%>" value="<%=temp_ddcharges%>" size="8"    onblur="add2Total<%=i%>()" maxlength="20" onfocus="blur()">
                    </b></font></td>
                    
                    <td > <font size="2" face="verdana" color="#006600"><b>
                    <input type="text" name="handling<%=i%>" value="<%=temp_handlingfee%>" size="8" onblur="add2Total<%=i%>()" maxlength="20" onfocus="blur()">
                    </b></font></td>
                    <td > <font size="2" face="verdana" color="#006600"><b>
                    <input type="text" name="VFSTTCharges<%=i%>" value="<%=temp_VFSTTCharges%>" size="8" onblur="add2Total<%=i%>()" maxlength="20" onfocus="blur()">
                    </b></font></td>
                    
                    <td> <font size="2" face="verdana" color="#006600"><b>
                    <input type="text" name="total<%=i%>" value="<%=temp_total%>" size="10" maxlength="20" readonly>
                    <input type="hidden" name="oldtotal<%=i%>" value="<%=temp_total%>" >
                    </b></font></td>
                    </tr>
                    </table>
<% end if  %>                      
                   </td>
                                      
             <script language="javascript">
				function add2Total<%=i%>()
				{
				var visa=parseFloat(document.regist.visafee<%=i%>.value);
				if (isNaN(visa)) 
				{
				visa=0;
				}
				
				var dd=parseFloat(document.regist.dd<%=i%>.value);
				if (isNaN(dd)) 
				{
				dd=0;
				}
				
				var handling=parseFloat(document.regist.handling<%=i%>.value)
				if (isNaN(handling)) 
				{
				handling=0;
				}

				var VFSTTCharges=parseFloat(document.regist.VFSTTCharges<%=i%>.value)
				if (isNaN(VFSTTCharges)) 
				{
				VFSTTCharges=0;
				}
				
				
				document.regist.total<%=i%>.value= eval(visa+dd+handling+VFSTTCharges);
				}    
		</script>
		</b></font></td>
                </tr>
                
                <tr> 
                  <td width="21%"><font size="2" face="verdana" color="#0000CC"><b>Status</b></font></td>
                  <td width="30%"> <font size="2" face="verdana" color="#006600"><b> 
                   
                    <select name="status<%=i%>" size="1">
                                               
                      <%
statusCountry= rsInvoice.fields("statusID") 
Call LoadListBox("status",statusCountry)
%> 

                                            </select>
                                             <input type="hidden" name="oldstatus<%=i%>" value="<%= statusCountry %>">
                  </b></font>
                    </td>
                    <td colspan="2"><font size="2" face="verdana" color="#0000CC"><b>Submit Date </b></font>
                    
                      <input type="text" name="subdate<%=i%>" value="<%=temp_subdate %>" size="10">
                      </td>
                  
                </tr>
                 <tr> 
                 <td><font size="2" face="verdana" color="#0000CC"><b>Collection Date </b></font></td>
                    <td> <font size="2" color="#006600"><b>
                      <input type="text" name="coldate<%=i%>" value="<%=temp_coldate %>" size="10">
                      CONF.<input type=radio name="colcheck<%=i%>"  value='conf'
                      <% if temp_colcheck="conf" then 
                      response.write " Checked"
                      End if 
                      %>
                       >CHK.<input type=radio name="colcheck<%=i%>"  value='chk' 
                       <% if temp_colcheck="chk" then 
                      response.write " Checked"
                      End if 
                      %>
                      </b></font></td>
                      
                <td colspan="2"><font size="2" face="verdana" color="#0000CC"><b>Sent date </b></font>
                  <font size="2" color="#006600"><b>
                      <input type="text" name="sentdate<%=i%>" value="<%=temp_sentdate %>" size="10">
                      </b></font></td></tr>
                    
                 
                <tr> 
                  <td width="20%"><font size="2" face="verdana" color="#0000CC"><b>Remarks</b></font></td>
                  <td width="80%" colspan=3> <font size="2" color="#006600"><b> 
                    <input type="text" name="remark<%=i%>" value="<%=ucase(rsInvoice.fields("remarks")) %>" size="65" >
                     </b></font></td>
               
                </tr>
<%                
rsInvoice.movenext
wend
 rsInvoice.close
rscountry.movenext
wend
rscountry.close()
 
 %>      
 <input type="hidden" name="mainstatus" value="<%=mainstatus  %>" >


               
                
                <tr> 
                  <td width="21%"><font size="2" face="verdana" color="#0000CC"><b>Internal Remarks</b></font></td>
                  <td colspan="2"> 
                    <textarea cols=50 rows=5 name="internalrem"><%=internal%></textarea>
                  </td>
                </tr>
                <tr> 
                  <td width="21%"><font size="2" face="verdana" color="#0000CC"><b>Client Remarks</b></font></td>
                  <td colspan="2"> 
                    <textarea cols=50 rows=5 name="externalrem"><%=external%></textarea>
                  </td>
                  <td width="19%"></td>
                  <td width="5%"><font color="#006600"></font></td>
                </tr>
                
                <tr> 
                <%
                
                if rs.fields("bill")="Y" and session("uname")<>"uma" then
                %>
                <td colspan="4"> 
                    <div align="center"> <font size="2" face="verdana" color="#0000CC"><b> 
                     Bill has been completed
                    
                      </b></font></div>
                  </td></tr>
                  <%
                  else
                  %>
                  <td colspan="2"> 
                    <div align="right"> <font size="2" color="#0000CC"><b> 
                      <input type="hidden" name="ivalue" value="<%=i%>">
<% if session("priv")="adm" then %>
                      <input type="submit" value="Submit" id=submit1 name=submit1>
<% end if %>
                      </b></font></div>
                  </td>
                  <td colspan="2"> <font size="2" color="#0000CC"><b> 
                    <input type="reset" value="reset"   name=reset1>
                    </b></font></td>
                </tr>
                <% 
                end if
                %>
                <tr> 
                  <td colspan="2"></td>
                  <td colspan="2"></td>
                </tr>
              </table>
            
            </form>
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
