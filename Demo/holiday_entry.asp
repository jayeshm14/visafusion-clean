<%@ Language=VBScript %>
<!-- #include file="connection.asp" -->
<!-- #include file="connectionweb.asp" -->
<%
response.buffer= true
%>
<html>
<head>
<title>www.udaanindia.com</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="Styles.css">
</head>

<body bgcolor="#FFFFFF"  topmargin=0 leftmargin=0 marginwidth=0 marginheight=0 >
<table width="75%" border="0" cellspacing="0" cellpadding="0" align="center">
  <tr valign="top" align="left">
    <td><%if session("uname")="" then
response.clear
response.redirect "relogin.asp?rsn=V"
end if

%> <% if session("priv")="adm" then
%> <!-- #include file="topadmin.asp" --> <%
else
%> <!-- #include file="top.asp" --><%
end if
%></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>
      <table width="75%" align="center" cellpadding="0" cellspacing="0">

        <tr bgcolor="#FFE898">
          <td height="19">
            <div align="center"><span class="tableCaption"> ADD HOLIDAYS </span></div>
          </td>
        </tr>
      </table>
    </td>
  </tr>
  <tr>
    <td height="2" ALIGN="CENTER">
      <table width="75%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td><img src="images/linetopgreen1.gif" width="660" height="10"></td>
        </tr>
        <tr bgcolor="#009933">
          <td>
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td align="left" width="1"><img src="images/pixelsline.gif" width="1" height="7"></td>
                <td bgcolor="#FFFFFF">
                  <table width="100%" border="0" bgcolor="#FFFFF8" cellpadding="0" cellspacing="0" background="images/backform.jpg">

                    <tr>
                      <td colspan="3">&nbsp;</td>
                    </tr>
                    <tr>
                      <td colspan="3"> <form name="searchform" action="holidaysubmit.asp">
                        <div align="center"><span class="WebSite">
                               <%

                flag=request("flag")

                 holiday=request.form("holiday_date")

                 description=request.form("holiday_desc")
                if not (flag="" or isempty(flag)) then
                  count=cint(request.form("countrylist").count)
                  set rs=server.createobject("adodb.recordset")


                 for ii=1 to count
			CountryID=request.form("countrylist")(ii)
			if request.form("countrylist")(ii)<> "" and request.form("holiday_date") <> "" then

		          stmt="select * from holidaylist where holiday='"&usrtosysdate(holiday)&"' and countryid="&request.form("countrylist")(ii)
                  		rs.open stmt,con,2,3
		          if rs.EOF then
		                  rs.addnew
		                  rs("countryid")=cint(CountryID)
		                  rs("holiday")=usrtosysdate(holiday)
		                  rs("description")=description
		                  rs.update

		                  sucessStr=sucessStr&getDescriptionForID("Embassy",CountryID)&"  "
		                  response.write " "
		           Else
		           notsucessStr=notsucessStr&getDescriptionForID("Embassy",CountryID)&"  "
		           End if
		           rs.close

		         'enter into webserver
		         if request("webentry")="Y" then

		          stmt="select * from holidaylist where holiday='"&usrtosysdate(holiday)&"' and countryid="&request.form("countrylist")(ii)
                  		rs.open stmt,webcon,2,3
		          if rs.EOF then
		                  rs.addnew
		                  rs("countryid")=cint(CountryID)
		                  rs("holiday")=usrtosysdate(holiday)
		                  rs("description")=description
		                  rs.update

		                  sucessStr=sucessStr&" (W) "
		                  response.write " "
		           Else
		           notsucessStr=notsucessStr&getDescriptionForID("Embassy",CountryID)&"  "
		           End if
		           rs.close

		           end if


		        end if

		    if request("WO")="Y" and CountryID<>"" then
		    stmt="delete from weeklyoff where Embassyid="&CountryID
            rs.open stmt,con,2,3

		    stmt="select * from weeklyoff where  Embassyid="&CountryID
              rs.open stmt,con,2,3
		          if rs.EOF then
		                  for dn=1 to 7
		                  if request("day"&dn)<>"" then
		                  rs.addnew
		                  rs("Embassyid")=cint(CountryID)
		                  rs("weekend")=cint(request("day"&dn))
		                  rs("description")=description
		                  rs.update
		                  end if
		                  next
		                  sucessStr=sucessStr&getDescriptionForID("Embassy",CountryID)&"  "
		                  response.write " "

		           Else
		           notsucessStr=notsucessStr&getDescriptionForID("Embassy",CountryID)&"  "
		           End if


		     rs.close

		    'Enter into webserver
		    if request("webentry")="Y" then
		    stmt="delete from weeklyoff where Embassyid="&CountryID
            rs.open stmt,webcon,2,3

		    stmt="select * from weeklyoff where  Embassyid="&CountryID
              rs.open stmt,webcon,2,3
		          if rs.EOF then
		                  for dn=1 to 7
		                  if request("day"&dn)<>"" then
		                  rs.addnew
		                  rs("Embassyid")=cint(CountryID)
		                  rs("weekend")=cint(request("day"&dn))
		                  rs("description")=description
		                  rs.update
		                  end if
		                  next
		                  sucessStr=sucessStr&" (W) "
		                  response.write " "

		           Else
		           notsucessStr=notsucessStr&getDescriptionForID("Embassy",CountryID)&"  "
		           End if
		     rs.close

		     end if

            end if

		next


                 if sucessStr<>"" then
                 response.write "<span class='WSRightBold'>HOLIDAY FOR "&sucessStr&"  ENTERED SUCCESSFULLY </span><BR>"
                 end if
                  if notsucessStr<>"" then
                  response.write "<span class='WSRightBold'>HOLIDAY FOR "&notsucessStr&" ALREADY EXISTS </span>"
                 end if
                 end if
                  %>
                        </div></span>
                        </form> </td>
                    </tr>
                    <tr> <td colspan="2">
                    <span class="barfont">
                      <form method="post" action="holiday_entry.asp">
                      <%if request("WO")="Y" then%>
                      <a href="holiday_entry.asp">ADD HOLIDAYS</a>
                      <% else %>
                      <a href="holiday_entry.asp?WO=Y">ADD WEEKLY OFF</a>
                      <% end if %>

                      </span>
                 <tr>

                 <td align="center">
                 	<span class="WSRightBold"> SELECT COUNTRY </span></td><td>
                    	<select size=10 name="countrylist" multiple>
                                              <%
                                             Call LoadListBox("Embassy",0)
                                             %>
                    	</select>
                     </td></tr>    </td>
                    </tr>
                    <%if request("WO")="Y" then%>

                    <tr><td align="center"><span class="WSRightBold"> WEEKLY OFF </span></td><td>

                    <input type="checkbox" name="day2" value="2" >MON
                    <input type="checkbox" name="day3" value="3" >TUE
                    <input type="checkbox" name="day4" value="4" >WED
                    <input type="checkbox" name="day5" value="5" >THU<br>
                    <input type="checkbox" name="day6" value="6" >FRI
                    <input type="checkbox" name="day7" value="7" >SAT
                    <input type="checkbox" name="day1" value="1" >SUN
                    <input type="hidden" name="WO" value="Y">
                    </td></tr>
                <tr><td align="center"><span class="WSRightBold"> DESCRIPTION </SPAN></td><td> <input type="text" size="20" name="holiday_desc" VALUE="WEEKLY OFF"></td></tr>

                   <%else%>

                    <tr><td align="center"><span class="WSRightBold"> HOLIDAY DATE </span></td><td> <input type="text" size="20" name="holiday_date" ID="Text1"></td></tr>
                <tr><td align="center"><span class="WSRightBold"> DESCRIPTION </SPAN></td><td> <input type="text" size="20" name="holiday_desc" ID="Text2"></td></tr>


                   <%end if%>

                   <tr><td align="center"><span class="WSRightBold"> ADD TO THE WEB SERVER? </span></td><td> <input type="Checkbox" name="WebEntry" value="Y" checked ></td></tr>

                <input type="hidden" name="flag" value="y">

                <tr><td colspan="2" align="center"><input type="submit" value="Submit" class="ud">

                </td></tr>
                </form>
                    <tr>
                      <td colspan="3">
                        <div align="center"><span class="WebSite"><!-- #include file="Adminbottom.asp" --></span>
                        </div>
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
          <td><img src="images/linetopgreen2.gif" width="660" height="10"></td>
        </tr>
      </table>
    </td>
  </tr>
  <tr valign="top" align="left">
    <td>&nbsp;</td>
  </tr>
</table>

</body>
</html>
