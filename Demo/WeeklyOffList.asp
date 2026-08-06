<%@ Language=VBScript %>
<!-- #include file="connection.asp" -->
<%
response.buffer= true

if session("priv")="" then
response.clear
response.redirect "relogin.asp?rsn=usb"
end if
%>
<html>
	<head>
		<title>www.udaanindia.com</title>
		<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
	</head>
	<body bgcolor="#FFFFFF" topmargin="0" leftmargin="0" marginwidth="0" marginheight="0">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td>
					<table width="100%" border="0" cellpadding="0" cellspacing="0">
						<tr valign="top" align="left">
							<td width="98%">
								<table width="100%" border="0" cellspacing="0" cellpadding="0">
									<tr valign="top" align="left">
										<td>
											<%
      agentID=request("jn")
       %>
											<% if session("priv")="adm" then %> <!-- #include file="topAdmin.asp"-->
											<%
elseif session("priv")="emp" then
%>
											<!-- #include file="top.asp"-->
											<% 
elseif session("priv")="agt" then
%>
											<!-- #include file="topAgent.asp"-->
											<% 
elseif session("priv")="guest" then
%>
											<table width="765" border="0" cellspacing="0" cellpadding="0" align="left">
												<tr>
													<td><img src="images/topn1.jpg" width="760" height="71"></td>
												</tr>
												<tr>
													<td>
														<table width="100%" border="0" cellspacing="0" cellpadding="0">
															<tr>
																<td width="1%"><img src="images/whitw.gif" width="13" height="20"></td>
																<td width="11%"><a href="Default.asp"><img src="images/homen1.gif" width="99" height="20" border="0" name="Image7" onMouseOver="MM_swapImage('Image7','','images/homen2.gif',1)"></a></td>
																<td width="12%"><a href="profile.asp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image1','','images/profilen2.gif',1)"><img src="images/profilen1.gif" width="102" height="20" name="Image1" border="0"></a></td>
																<td width="12%"><a href="update.asp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image2','','images/updaten2.gif',1)"><img src="images/updaten1.gif" width="102" height="20" name="Image2" border="0"></a></td>
																<td width="12%"><a href="registration.asp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image3','','images/registrationn2.gif',1)"><img src="images/registrationn1.gif" width="102" height="20" name="Image3" border="0"></a></td>
																<td width="12%"><a href="contactus.asp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image4','','images/contactn2.gif',1)"><img src="images/contactn1.gif" width="102" height="20" name="Image4" border="0"></a></td>
																<td width="12%"><a href="queries.asp"><img src="images/queriean3.gif" width="101" height="20" name="Image5" border="0"></a></td>
																<td width="11%"><a href="logon.asp"><img src="images/logonn1.gif" width="100" height="20" name="Image6" onMouseOver="MM_swapImage('Image6','','images/logonn2.gif',1)"
																			border="0"></a></td>
																<td width="17%"><img src="images/pixekn.gif" width="58" height="20"></td>
															</tr>
														</table>
													</td>
												</tr>
												<tr>
													<td><img src="images/linecolor.gif" width="760" height="12"></td>
												</tr>
												<tr>
													<td><img src="images/pixelb.gif" width="33" height="5"></td>
												</tr>
											</table>
											<% end if %>
										</td>
									</tr>
									<tr>
										<td>
											<%

set rs=server.createobject("adodb.recordset")
month1=request("selmonth")
year1=request("selyear")
if month1<>"" and year1<>"" then
date1=month1&"/01/"&year1
else
date1=date()
end if
%>
											<br>
											<table width="80%" border="0" cellpadding="1" cellspacing="1" align="center">
												<tr>
													<td>
														<table width="82%" align="left" cellpadding="0" cellspacing="0" bgcolor="#008432">
															<tr bgcolor="#FFE898">
																<td height="19">
																	<div align="center"><b><font size="3" color="#CC0000" face="Arial, Helvetica, sans-serif">WEEKLY 
																				OFF LIST </font></b>
																	</div>
																</td>
															</tr>
														</table>
													</td>
												</tr>
												<tr>
													<td>
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
																						<td>
																							<table width="90%" border="0" align="CENTER" cellpadding="1" cellspacing="1">
																								<tr bgcolor="#FFF5D7">
																									<td><b>Country</b></td>
																									<td><b>Date</b></td>
																									<td><b>Reason</b></td>
																								</tr>
																								<%

              
                      
            stmt="select CASE WHEN weekend = 1 THEN 'SUNDAY' WHEN weekend = 2 THEN 'MONDAY' WHEN weekend = 3 THEN 'TUESDAY' WHEN weekend = 4 THEN 'WEDNESDAY' WHEN weekend = 5 THEN 'THURSDAY' WHEN weekend = 6 THEN 'FRIDAY' WHEN weekend = 7 THEN 'SATURDAY' END AS WEEKEND, WeeklyOff.embassyid, WeeklyOff.description reason, embassy.description from WeeklyOff,embassy where  WeeklyOff.embassyid=embassy.embassyid "
          if request("countryID")<>"" then
          stmt=stmt& " and WeeklyOff.embassyid="&request("countryID")
          end if
          if request("OrdByDay")<>"" then
           stmt=stmt&" order by WeeklyOff.weekend"
          else
          stmt=stmt&" order by embassy.description, WeeklyOff.weekend"
          end if
            rs.open stmt,con,2,3
                  IF not rs.eof then
                  while not  rs.eof
                              response.write"<tr><td><span class='TableDataFont'>"& rs("description")
                              response.write"</span></td><td><span class='TableDataFont'>"& rs("weekend")
		                        response.write"</span></td><td><span class='TableDataFont'>"&  rs("reason")
								response.write"</span></td></tr>"
								rs.movenext
					wend            
		               
		               
		        else
		        response.write"<tr><td colspan =3 align=center><span class='WSRightBold'>NO HOLIDAYS FOR THIS MONTH</span></TD></TR>" 
		        end if
		
      
                  rs.close
%>
																								<form name="holiday" action="WeeklyOffList.asp">
																									<select name="countryID" size="1" ID="Select1">
																										<option value="" Selected>ALL</option>
																										<% 
                          			countryID=request("countryID")
                                             
						if Isnull(countryID) or IsEmpty(countryID) or countryID="" then
						countryID=0
						End If
	             	 			call loadlistbox("embassy",countryID)
	              	%>
																									</select>
																									<input type="submit" value=" GO " name="submit" class="ud">
																									<span class="barfont">
																									<a href="WeeklyOffList.asp?OrdByDay=Y&countryID=<%=request("countryID")%>"> ORDER BY WEEK DAY </a>
																									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
																								<a href="HolidayList.asp"> HOLIDAY LIST </a>
																								
																								</span> 
																								
																								</form>
																								
																							</table>
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
											</table>
										</td>
									</tr>
								</table>
							</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td><!-- #include file="HomeBottom.asp" --></td>
			</tr>
		</table>
	</body>
</html>
