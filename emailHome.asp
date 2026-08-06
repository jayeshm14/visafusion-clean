<%@ Language=VBScript %>
<!-- #include file="connection.asp" -->
<html>
<head>
<title>www.udaanindia.com</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
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
				date.value = dt.month + "/" + dt.date + "/" + dt.year;
		}
	}


//-->
</script>

</head>

<body bgcolor="#FFFFFF" topmargin="0" leftmargin="0" marginwidth="0" marginheight="0">
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
                <form name="regist" action="emailCriteria.asp">
                Send email to all the agents whose status  is 
                				<select name="status" size="1">
                                              <%
 set rsStatus=server.createobject("adodb.recordset")
rsStatus.activeconnection=con
rsStatus.open "select description from status order by Description",con,2,3
while not rsStatus.eof
response.write("<option>")
response.write rsStatus("Description")
response.write("</option>")
rsStatus.movenext
wend
rsStatus.close
%>                                
                                           	 </select>
                
                <br>
                and has submitted application on or after 
                <input type="text" name="date1" value size="10" readonly>
                </font><a href="javascript:getDate(regist.date1)"><img src="images/cal.jpg" border="0" align="absmiddle"></a>
                <input type="submit" value="Send Email">
                </form>
                <p>
                <form name="notregist" action="emailDaysPending.asp">
                Send email to all the agents whose status  is Pending for last
                                <input type="text" name="days" value="0" size="5"> days.
                </font>
                <input type="submit" value="Send Email">
                </form>
                </p>
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
