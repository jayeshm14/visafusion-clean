<%@ Language=VBScript %>
<!-- #include file="connection.asp" -->
<html>
<head>
<title>www.udaanindia.com</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script language="javascript">
function checkAll()
{
a=document.userform.username.value
ulen=a.length
//alert("value & len:"+a+ulen)
if (ulen==0)
{
alert("USER NAME IS REQUIRED")
return false
}
}
</script>
</head>

<body bgcolor="#FFFFFF"  topmargin=0 leftmargin=0 marginwidth=0 marginheight=0 >
<table width="50%" border="0" cellspacing="0" cellpadding="0" align="LEFT">
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
              <tr BGCOLOR="#F0F0FF" >
<td align="center" colspan=6><span class="TableCaption"> Select Date</span>
</td></tr>
              <tr><td>&nbsp;</td></tr>
                <td>

<%
'Option Explicit
if request("flag")=11 then
response.write "<tr><td align='center'><font size=2 color=#006600><b> MEESAGE HAS BEEN SENT SUCCESSFULLY.</b></font></td></tr>"
end if
set rsdetail=Server.CreateObject("ADODB.Recordset")
set rsflag=Server.CreateObject("ADODB.Recordset")
Function FormatStr(String)
	on Error resume next
	String = Replace(String, CHR(13), "")
	String = Replace(String, CHR(10) & CHR(10), "</P><P>")
	String = Replace(String, CHR(10), "<BR>")
	FormatStr = String
End Function

Dim dtToday 
dtToday = Date()

Dim dtCurViewMonth ' First day of the currently viewed month
Dim dtCurViewDay ' Current day of the currently viewed month
Dim frmDate ' Date submitted by form

' if the GO button was used, build the date from the month and year

If InStr(1, Request.Form, "subGO", 1) > 0  then
	if Request.Form("CURDATE_month") = "" then
		tmpMonth = month(now())
	else
		tmpMonth = Request.Form("CURDATE_month")
	End If
	
	if Request.Form("CURDATE_year") = "" then
		tmpyear = year(now())
	else
		tmpyear = Request.Form("CURDATE_year")
	End If
	

		
	tmpDate = "1 " & tmpMonth & " 1999"
	
	mnth = Month(tmpDate)
	frmDate = DateSerial(tmpyear, mnth, 1)
Else

	frmDate = Request.Form("CURDATE")
	
end if

if Request("view_date") <> "" then 
	frmDate= DateSerial(year(Request("view_date")), month(Request("view_date")), 1)
end if

%>


<% REM This section defines functions to be used later on. %>
<% REM This sets the Previous Sunday and the Current Month %>
<% 

'--------------------------------------------------
   Function DtPrevSunday(ByVal dt)
      Do While WeekDay(dt) > vbSunday
         dt = DateAdd("d", -1, dt)
      Loop
   DtPrevSunday = dt
   End Function
'--------------------------------------------------
%>

<%REM Set current view month from posted CURDATE,  or
' the current date as appropriate.

' if posted from the form
' if prev button was hit on the form
   If InStr(1, Request.Form, "subPrev", 1) > 0 Then
      dtCurViewMonth = DateAdd("m", -1, frmDate)
' if next button was hit on the form
   ElseIf InStr(1, Request.Form, "subNext", 1) > 0 Then
      dtCurViewMonth = DateAdd("m", 1, frmDate)
' anyother time
      Else
' date add in text box
         If InStr(1, Request.Form, "subGO", 1) > 0 then
			dtCurViewMonth = frmDate
		 Else
			if Request("view_date") <> "" then 
				dtCurviewMonth = frmDate
			else
            dtCurViewMonth = DateSerial(Year(dtToday), Month(dtToday), 1)
            End If
         End If
   End If
%>

<% REM --------BEGINNING OF DRAW CALENDAR SECTION-------- %>
<% REM This section executes the event query and draws a matching calendar. %>
<%
   Dim iDay, iWeek, sFontColor, dictDte(31,2), intCount
   strSql = "SELECT * FROM diary WHERE month(dte)= " & month(dtCurViewMonth) & " and year(dte) = " & year(dtCurViewMonth) & " order by dte"
   set rs = con.Execute (StrSql)
   
   intCount= 0
   
   ' populate array with days of month
   
   do until rs.EOF
	if Day(rs("dte")) = intCount + 1 then 
		dictDte(intCount, 1) = final
		final=""
		rs.Movenext
	Else 
		dictDte(intCount, 1) = " "
	End If
	dictDte(intCount, 2) = intCount + 1
	intCount = intCount + 1
      
   loop
%>

<center>
       <form NAME="fmNextPrev" ACTION="calendar.asp" METHOD="POST" >
       <table CELLPADDING="3" CELLSPACING="0" WIDTH="50%" BORDER="2" BGCOLOR="#99CCFF" BORDERCOLORDARK="#003399" BORDERCOLORLIGHT="#FFFFFF">
          <tr VALIGN="MIDDLE" ALIGN="CENTER">
             <td COLSPAN="7">
             <table CELLPADDING="0" CELLSPACING="0" WIDTH="100%" BORDER="0">
                <tr VALIGN="MIDDLE" ALIGN="CENTER">
                   <td WIDTH="30%" ALIGN="RIGHT">
                      
                   </td>
                   <td WIDTH="40%">
                      <font FACE="Arial" COLOR="#000000">
                      <b><%=monthName(Month(dtCurViewMonth)) & " " & Year(dtCurViewMonth)%></b>
                     </font>
                   </td>
                   <td WIDTH="30%" ALIGN="LEFT">
                      
                   </td>
                </tr>
             </table>
             </td>
          </tr>

          <tr VALIGN="TOP" ALIGN="CENTER" BGCOLOR="#000099">

          <% For iDay = vbSunday To vbSaturday %>
             <th WIDTH="14%"><font FACE="Arial" SIZE="-2" COLOR="#FFFFFF"><%=WeekDayName(iDay)%></font></th>
          <%Next %>

         </tr>

<%
   dtCurViewDay = DtPrevSunday(dtCurViewMonth)
  
   For iWeek = 0 To 5
      Response.Write "<TR VALIGN=TOP>" & vbCrLf

Dim sBGCOLOR 
sBGCOLOR = "#99ccff"


For iDay = 0 To 6
sBGCOLOR = "#99ccff"
If Month(dtCurViewDay) = Month(dtCurViewMonth) Then
 If dtCurViewDay = dtToday Then sBGCOLOR = "#99ccbb"
else 
 sBGCOLOR = "#99ccff"
 
End If
Response.Write "<TD HEIGHT=20 bgcolor='" & sBGCOLOR & "' >"
         
  	
   If Month(dtCurViewDay) = Month(dtCurViewMonth) Then
		If dtCurViewDay = dtToday Then
               sFontColor = "#ff0000"

            Else
               sFontColor = "#00000"
            End If
      
         '---- Write day of month
            Response.Write "<FONT FACE=""Arial"" SIZE=""-2"" COLOR=""" & sFontColor & """><B>"
            Response.Write "<a href=newReminder.asp?uname="&session("uname")& "&view_date=" & month(dtCurViewday) & "/" &  day(dtCurViewday)& "/" & year(dtCurViewday) & ">"  & Day(dtCurViewDay) & "</a></B><br>" & formatStr(dictDte(Day(dtCurViewDay)- 1, 1)) & "</FONT><BR>"
         
         '---Else
            '---Response.Write " "
         End If

         Response.Write "</TD>" & vbCrLf
         dtCurViewDay = DateAdd("d", 1, dtCurViewDay)
      Next
      Response.Write "</TR>" & vbCrLf
   Next
%>

</table>

<select name="CURDATE_month">
  <option value="January">January
  <option value="February">February
  <option value="March">March
  <option value="April">April
  <option value="May">May
  <option value="June">June
  <option value="July">July
  <option value="August">August
  <option value="September">September
  <option value="October">October
  <option value="November">November
  <option value="December">December
</select>



<input TYPE="text" NAME="CURDATE_YEAR" VALUE="<%=year(dtCurViewMonth)%>" size="6"><br>
<input type="hidden" Name="CURDATE" Value="<%=dtCurViewMonth%>">



<%REM --------END OF DRAW CALENDAR SECTION-------- 
con.Close
set con = nothing
%>
  
<input type="submit" value=" GO " name="subGO"  >
</form>
</center></div>
</font>
</center>



                
                
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
