<!-- #include file="connection.asp" -->
<html>

<head>
<meta name="GENERATOR" content="Microsoft FrontPage 5.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<title>New Page 1</title>
</head>
<body>
<table border="1" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#111111" width="100%" id="AutoNumber1">
  <tr>
    <td width="15%"><%
Set rs = con.execute("select agentsID,description from agents where agentsid<200 order by description")
%>
<OBJECT ID="agent" WIDTH=190 HEIGHT=24
CLASSID="CLSID:8BD21D30-EC42-11CE-9E0D-00AA006002F3">
<PARAM NAME="VariousPropertyBits" VALUE="746604571">
<PARAM NAME="DisplayStyle" VALUE="3">
<PARAM NAME="Size" VALUE="5027;635">
<PARAM NAME="agent" VALUE="1">
<PARAM NAME="ShowDropButtonWhen" VALUE="2">
<PARAM NAME="agent" VALUE="Please Select Value">
<PARAM NAME="FontEffects" VALUE="1073741825">
<PARAM NAME="FontHeight" VALUE="165">
<PARAM NAME="FontCharSet" VALUE="0">
<PARAM NAME="FontPitchAndFamily" VALUE="2">
<PARAM NAME="FontWeight" VALUE="700">  
</OBJECT>
<% Do While Not rs.EOF %>
<SCRIPT LANGUAGE="vbscript">
agent.Additem "<%=rs("description")%>"
    </SCRIPT>
<% 
rs.MoveNext
Loop
rs.Close

%> 
    
     
</td>
    
    <td width="25%"><td width="60%"><b><font size="4" color="#000080"><a href="5555.asp?agent">CLICK HERE</font></b></td>
</td>
    
  </tr>
</table>

 
</body>

</html>