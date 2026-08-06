<%@ Language=VBScript %>
<% server.scripttimeout=3000 %>
<!-- #include file="connection.asp" -->
<%
response.buffer= true
if session("uname")="" then
response.clear
response.redirect "relogin.asp?rsn=V"
end if

%>

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
				date.value = dt.date + "/" + dt.month + "/" + dt.year;
		}
	}

//-->
</script>

<script language="JavaScript">
<!--

function numvalid(a)
{
if(isNaN(a.value))
{
alert("Please fill numeric value for " + a.name)
a.focus()
a.select()
}
}

function check()
{
if(document.collection1.refno.value=="")
{
alert("Please enter Ref No.!.")
document.collection1.refno.focus()
return false
}

if(isNaN(document.collection1.refno.value))
{
alert("Please fill numeric value for Ref No.")
document.collection1.refno.focus()
document.collection1.refno.select()
return false
}
document.collection1.submit()
}

function check2()
{
if(document.collection2.pptno.value=="")
{
alert("Please enter Passport No.!.")
document.collection2.pptno.focus()
return false
}
document.collection2.submit()
}
//-->
</script>
<html>
<head>
<title>www.udaanindia.com</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="Styles.css">
</head>

<body bgcolor="#FFFFFF"  topmargin=0 leftmargin=0 marginwidth=0 marginheight=0 >
<table width="75%" border="0" cellspacing="0" cellpadding="0" align="center" height="310">
  <tr valign="top" align="left"> 
    <td height="21">
<% if session("priv")="adm" then
%> 
              
<!-- #include file="topadmin.asp" -->           
      <%
else
%>
<!-- #include file="top.asp" --> 
<% 
end if
%></td>
  </tr>
  <tr> 
    <td height="21">
 <center>
<span class="WSRightBold"><FONT color=red face="verdana" size="2">Select Agent :</font></span>                      
<input type="hidden" name="datesearch" value="yes">
<%
dim rs
set rs=server.createobject("adodb.recordset")
Set rs = con.execute("select description from agents where agentsid<200 order by description")
%>
<OBJECT ID="ComboBox1" WIDTH=300 HEIGHT=24
CLASSID="CLSID:8BD21D30-EC42-11CE-9E0D-00AA006002F3">
<PARAM NAME="VariousPropertyBits" VALUE="746604571">
<PARAM NAME="DisplayStyle" VALUE="3">
<PARAM NAME="Size" VALUE="7938;635">
<PARAM NAME="MatchEntry" VALUE="1">
<PARAM NAME="ShowDropButtonWhen" VALUE="2">
<PARAM NAME="Value" VALUE="">
<PARAM NAME="FontEffects" VALUE="1073741825">
<PARAM NAME="FontHeight" VALUE="165">
<PARAM NAME="FontCharSet" VALUE="0">
<PARAM NAME="FontPitchAndFamily" VALUE="2">
<PARAM NAME="FontWeight" VALUE="700">
</OBJECT>
<% Do While Not rs.EOF %>
<SCRIPT LANGUAGE="VBScript">
ComboBox1.Additem "<%=rs("description")%>"
                  </SCRIPT>                
<% 
rs.MoveNext
Loop
rs.Close
%> <font color="#000080"><b>&nbsp; </b></font><b><font color="#000080"><a href="searchPax2.asp?comboBox1=<%=description%>" target="_self" >
CLICK 
HERE</a></font></b></center>
    </td>
  </tr>

</body>

</html>