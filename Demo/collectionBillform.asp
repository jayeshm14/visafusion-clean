<!-- #include file="connection.asp" -->
<% response.buffer=true %>
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

<body bgcolor="#FFFFFF" topmargin="0" leftmargin="0" marginwidth="0" marginheight="0">
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
                <td valign="top"> 
                  <table width="99%" border="0">
                    <tr> <%RESPONSE.WRITE session("lname")%>  </tr>
                   <tr> 
                      <td colspan="6" align="center"><b><font size="3" color="#CC0000">
                      COLLECTION FORM</font></b> </td>
                    </tr>
                   
                  </table>
                  
                </td>
              </tr>
            </table>
<form name="regist" action="collectionsubmit.asp" method="post">
<input type="hidden" name="username" value="<%= session("uname")%>">

              
<%
refno=request("refno")
set rs=server.createobject("adodb.recordset")
set rscert=server.createobject("adodb.recordset")
set rs1=server.createobject("adodb.recordset")
set rscountry=server.createobject("adodb.recordset")
set rsDetails=server.createobject("adodb.recordset")
Set rsInvoice =server.createobject("adodb.recordset")
stmt="select * from mainEntry where refno="&refno
rs.open stmt,con,2,3
if rs.eof then
response.write "<font size=2 color=#0000CC> Please check the reference number.</font>"
else
bill=rs.fields("bill")
agent=rs.fields("agent")
refname=ucase(rs.fields("refferer"))
recdate=rs.fields("receivedate")
pname=ucase(rs.fields("paxname"))
dob=rs.fields("dateofbirth")
passport=ucase(rs.fields("passportno"))
entries=rs.fields("entries")
company=ucase(rs.fields("companyname"))
totalp=rs.fields("totalpassengers")
subdate=rs.fields("subdate")
coldate=rs.fields("coldate")
category=rs.fields("category")
attestation=rs.fields("attestation")
poe=rs.fields("poe")
entrytype=rs.fields("entrytype")
mainstatus=rs.fields("status")
retrieveremark=rs.fields("AgentInstruction")
%> 
              <table width="75%" border="0" cellspacing="1" cellpadding="1" align="center">
                <% if bill="Y" then
              %>
                <tr><td colspan="4"><font size="3" color="#CC0000">BILL HAS ALREDY FORMED </font></td> </tr>
                <%
                end if
                %>
                <tr> 
                <input type="hidden" name="pname" value="<%= pname%>">
                  <td colspan="2"><font size="2" color="#0000CC"><b>Date: <% response.write(formatdatetime(now(),1))%></b></font></td>
                  <td colspan="2"><font size="2" color="#0000CC"><b>Refrence Number: 
                    <%= refno %> 
                    <input type="hidden" name="refno" value="<%= refno %>">
                    <input type="hidden" name="agent" value="<%= agent%>">
                   
</b></font></td>
                </tr>
                <tr> 
                  <td width="21%"><font size="2" color="#0000CC"><b>Agent</b></font></td>
                  <td colspan="3"> <font size="2" color="#006600"><b>
                  
                  <%
                  call writeIDDescription("agents",agent)
                  %> 
                    
                    </b></font></td>
                </tr>
                <tr> 
                  <td width="21%"><font size="2" color="#0000CC"><b>Referer</b></font></td>
                  <td width="30%"> <font size="2" color="#006600"><b><%= refname %> 
                    
                    </b></font></td>
                  <td width="25%"><font size="2" color="#0000CC"><b>Company</b></font></td>
                  <td width="19%"> <font size="2" color="#006600"><b><%=company %> 
                    
                    </b></font></td>
                <tr> 
                  <td width="21%"><font size="2" color="#0000CC"><b>PAX Name</b></font></td>
                  <td width="30%"> <font size="2" color="#006600"><b><%= pname %> 
                    
                    </b></font></td>
                  <td width="25%"><font size="2" color="#0000CC"><b>Passport No 
                    </b></font></td>
                  <td width="19%"> <font size="2" color="#006600"><b><%=passport %> 
                    
                    </b></font></td>
                </tr>
                <tr> 
                  <td width="21%"><font size="2" color="#0000CC"><b> Pessengers 
                    </b></font></td>
                  <td width="30%"> <font size="2" color="#006600"><b><%= totalp %> 
                    
                    </b></font></td>
                  <td width="25%"><font size="2" color="#0000CC"><b>Entries </b></font></td>
                  <td width="19%"> <font size="2" color="#006600"><b><%= entries %> 
                    
                    </b></font></td>
                </tr>
                <tr> 
                  <td width="21%" nowrap><font size="2" color="#0000CC"><b>Date Of Birth 
                    </b></font></td>
                  <td width="30%"> <font size="2" color="#006600"><b><%=dob%> 
                    </b></font> 
                  <td width="25%"><font size="2" color="#0000CC"><b>Receive date 
                    </b></font></td>
                  <td width="19%"> <font size="2" color="#006600"><b><%=recdate%> 
                    
                    </b></font></td>
                <tr> 
                  <td width="21%"><font size="2" color="#0000CC"><b>Submit Date 
                    </b></font></td>
                  <td width="30%"> <font size="2" color="#006600"><b><%= subdate %> 
                    
                    </b></font></td>
                  <td width="25%"><font size="2" color="#0000CC"><b>Collection 
                    Date </b></font></td>
                  <td width="19%"> <font size="2" color="#006600"><b><%= coldate %> 
                    
                    </b></font></td>
                </tr>
                <!--                <tr>                   <td width="21%"><font size="2" color="#0000CC"><b>Category </b></font></td>                  <td width="30%"> <font size="2" color="#006600"><b>                  <%                  call writeIDDescription("category",category)                  %>                                                           </b></font></td>                  <td width="25%"><font size="2" color="#0000CC"><b>Attestation                     </b></font></td>                  <td width="19%"> <font size="2" color="#006600"><b>                  <%                  call writeIDDescription("attestation",attestation)                  %>                                                           </b></font></td>                </tr>                -->
                <tr> 
                  <td width="21%"><font size="2" color="#0000CC"><b>POE/ECNR </b></font></td>
                  <td width="30%"> <font size="2" color="#006600"><b>
                  <%
                  call writeIDDescription("poe",poe)
                  %> 
                  
                    
                    </b></font></td>
                  <td width="25%"><font size="2" color="#0000CC"><b>Status</b></font></td>
                  <td width="19%"> <font size="2" color="#006600"><b>
                  <%
                  call writeIDDescription("status",mainstatus)
                  %> 
                  
                  
                    </b></font></td>
                </tr>
                <tr> 
                  <td width="21%"><font size="2" color="#0000CC"><b>Country(s)</b></font></td>
                  <td width="30%"><font size="2" color="#006600"><b>
                <%
                firstflag="Y"
		stmt1="select distinct(countryID) from PaxStatus where refno="&refno
		rs1.open stmt1,con
		while not rs1.eof
		if firstflag="Y" then
		call writeIDDescription("embassy", rs1.fields("countryID"))
		firstflag="N"
		else
		response.write ", "
		call writeIDDescription("embassy", rs1.fields("countryID"))
		end if 
		rs1.movenext
		wend
		rs1.close
		%>
</td>             
                </tr>
                
                <tr> 
                  <td width="21%" height="21"><font size="2" color="#0000CC"><b>Status</b></font></td>
                  <td width="30%" height="21"> 
                    <select name="mainstatus" size="1">
                                                
                      <%

Call LoadListBox("status",mainstatus)

			%> 

                                            </select>
                  </td>
                  <script language="JavaScript">
<!--
function getDate(date)
	{
		var ws = "status:no; help:no; dialogWidth:320px; dialogHeight:300px;";
		var url = "Calendar.html";
                var dt = showModalDialog(url, window, ws);
		if (dt != null) {
			if (dt.month == "")
				date.value = "";
			else
				date.value =  dt.date + "/" + dt.month + "/" + dt.year;
		}
	}


//-->
</script>
                 <td width="25%"><font size="2" color="#0000CC"><b>Sent Date</b></font></td>
                  <td width="19%"> <font size="2" color="#006600"><b><input type="text" name="sentdate" value size="10">
                  </font><font size="2"><a href="javascript:getDate(regist.sentdate)"><img src="images/cal.jpg" border="0" align="absmiddle"></a> 
                  </font>
                    
                    </b></font></td>
                </tr>
                
            
    <%
i=0

countrylist=""

GetALLData="select * from entrydetails where  refno="&refno &" Order by paxname"
rscountry.activeconnection=con
rscountry.open GetALLData,con
while not rscountry.eof
pname1=rscountry.fields("paxname")
PaxID=rscountry("Paxid")
getinvoice="select * from paxstatus where  PaxID="&PaxID

rsInvoice.open getinvoice,con
while not rsInvoice.EOF 
i=i+1
temp_ddcharges=rsInvoice("ddcharges")
temp_handlingfee=rsInvoice("handlingfee")
temp_visafee=rsInvoice("visafee")

temp_total=rsInvoice("total")
temp_subdate=SysToUsrDate(rsInvoice("subdate"))
temp_coldate=SysToUsrDate(rsInvoice("coldate"))
temp_sentdate=SysToUsrDate(rsInvoice("sentdate"))

%>
		<tr> 
                  <td colspan="4" width="75%"> 
                    <hr>
                  </td>
                </tr>
    		<tr> 
                  <td colspan="4"> 
                    <div align="left"><font size="2" color="#0000CC"><b>Please 
                      Enter the information regarding <font size="3" color="#006600"><b> <%= ucase(pname1) %></b></font> for country 
                      <%
                      call writeIDDescription("embassy", rsinvoice.fields("countryID")) 
                      %>
                      </b></font> </div>
                       
                      <input type="hidden" name="paxid<%=i%>" value="<%=PaxID  %>">
                       <input type="hidden" name="countryinv<%=i%>" value="<%=rsInvoice.fields("countryID")  %>">
                  </td>
                </tr>
                      
                      <% 
                      categoryid=getIDForDescription("category","Attestation")
                      if categoryid=category then
                      
                      stmt="select * from paxAttestation where paxID="&PaxID&" and countryID="&rsinvoice.fields("countryID")
                      rscert.open stmt,con
                      if not rscert.eof then
                      response.write "<tr><td><font size='2' color='#006600'><b> CERTIFICATES:</b></font></td><td colspan=3><font size='2' color='#006600'><b> " 
                      while not rscert.eof
                      
                      call writeIDDescription("certificate",rscert("certificateID"))
                       response.write " ( "
                       call writeIDDescription("Attestation",rscert("AttestationID"))
                       response.write "), "
                       rscert.movenext
			wend
			 response.write " </b></font></td></tr>"
			End if
			end if
                      %>
                <tr> 
                <td><font size="2" color="#0000CC"><b> Charges</b></font></td>
                  <td width="30%" colspan="3"> 
                    
                    <table border="1"><tr>
                    
                  <td> <font size="2" color="#006600"><b> Visa</b></font></td>
                    <td> <font size="2" color="#006600"><b>DD</b></font></td>
                    
                    <td> <font size="2" color="#006600"><b> Handling</b></font></td>
                   
                    <td> <font size="2" color="#006600"><b>Total</b></font></td>
                    </tr>
                    <tr>
                    
                  <td> <font size="2" color="#006600"><b> 
                  <input type="text" name="visafee<%=i%>" value="<%=temp_visafee%>" size="8" onblur="add2Total<%=i%>()" maxlength="20"></b></font></td>
                    <td> <font size="2" color="#006600"><b>
                    <input type="text" name="dd<%=i%>" value="<%=temp_ddcharges%>" size="8" onblur="add2Total<%=i%>()" maxlength="20">
                    </b></font></td>
                    
                    <td> <font size="2" color="#006600"><b>
                    <input type="text" name="handling<%=i%>" value="<%=temp_handlingfee%>" size="8" onblur="add2Total<%=i%>()" maxlength="20">
                    </b></font></td>
                    
                    <td> <font size="2" color="#006600"><b>
                    <input type="text" name="total<%=i%>" value="<%=temp_total%>" size="10" maxlength="20" readonly>
                    </b></font></td>
                    </tr>
                    </table>
                      
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
				
				
				document.regist.total<%=i%>.value= eval(visa+dd+handling);
				}    
		</script>
		</b></font></td>
                </tr>
                
                <tr> 
                  <td width="21%"><font size="2" color="#0000CC"><b>Status</b></font></td>
                  <td width="30%"> <font size="2" color="#006600"><b> 
                   
                    <select name="status<%=i%>" size="1">
                                               
                      <%
statusCountry= rsInvoice.fields("statusID") 
Call LoadListBox("status",statusCountry)
%> 

                                            </select>
                                             <input type="hidden" name="oldstatus<%=i%>" value="<%= statusCountry %>">
                  </b></font>
                    </td>
                    <td><font size="2" color="#0000CC"><b>Submit Date </b></font></td>
                    <td>
                      <input type="text" name="subdate<%=i%>" value="<%=temp_subdate %>" size="10">
                      </td>
                  
                </tr>
                 <tr> 
                 <td><font size="2" color="#0000CC"><b>Collection Date </b></font></td>
                    <td> <font size="2" color="#006600"><b>
                      <input type="text" name="coldate<%=i%>" value="<%=temp_coldate %>" size="10">
                      </b></font></td>
                      
                <td><font size="2" color="#0000CC"><b>Sent date </b></font></td>
                    <td> <font size="2" color="#006600"><b>
                      <input type="text" name="sentdate<%=i%>" value="<%=temp_sentdate %>" size="10">
                      </b></font></td></tr>
                    
                 <tr> 
                  <td width="20%"><font size="2" color="#0000CC"><b>Category</b></font></td>
                  <td width="30%"> <font size="2" color="#006600"><b> 
                   
                    <select name="categorymain<%=i%>" size="1">
                                               
                      <%
category1= rsInvoice.fields("category") 
Call LoadListBox("category",category1)
%> 

                                            </select>
                  </b></font></td>
               
                </tr>
                <tr> 
                  <td width="20%"><font size="2" color="#0000CC"><b>Remarks</b></font></td>
                  <td width="80%" colspan="3"> <font size="2" color="#006600"><b> 
                    <input type="text" name="remark<%=i%>" value="<%=ucase(rsInvoice.fields("remarks")) %>" size="70">
                     </b></font></td>
               
                </tr>
<%    


                                  
rsInvoice.movenext
wend
 rsInvoice.close
rscountry.movenext

wend
'rscert.close
rscountry.close()

 %>               
                
                
                
               <tr> 
                  <td colspan="4" width="75%"> 
                    <hr>
                  </td>
                </tr> 
                
                <tr> 
                  <td width="21%"><font size="2" color="#0000CC"><b>Internal Remarks</b></font></td>
                  <td colspan="2"> 
                    <textarea cols="50" rows="5" name="internalrem"><%=ucase(rs("internalremark"))%></textarea>
                  </td>
                </tr>
                <tr> 
                  <td width="21%"><font size="2" color="#0000CC"><b>Client Remarks</b></font></td>
                  <td colspan="2"> 
                    <textarea cols="50" rows="5" name="externalrem"><%=Ucase(rs("externalremark"))%></textarea>
                  </td>
                  <td width="19%"></td>
                  <td width="5%"><font color="#006600"></font></td>
                </tr>
                 <tr> 
                <%
                
                if rs.fields("bill")="Y" then
                %>
                <td colspan="4"> 
                    <div align="center"> <font size="2" color="#0000CC"><b> 
                     Bill has been completed
                    
                      </b></font></div>
                  </td></tr>
                  <%
                  else
                  %>
                  <td colspan="2"> 
                    <div align="right"> <font size="2" color="#0000CC"><b> 
                      <input type="hidden" name="ivalue" value="<%=i%>">
                      <input type="submit" value="Submit" id="submit1" name="submit1">
                      </b></font></div>
                  </td>
                  <td colspan="2"> <font size="2" color="#0000CC"><b> 
                    <input type="reset" value="reset" name="reset1">
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
              <% End if%>
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
