<!-- #include file="connection.asp" -->
<%
total=cint(request("counter"))
del=request("delete")
response.write total

for i=1 to total
if request("item"&i)<>"" then
response.write request("date"&i)&"--"&request("country"&i)&"<br>"
con.execute("delete from holidaylist where holiday=#"&request("date"&i)&"# and countryid="&request("country"&i))
response.write("delete from holidaylist where holiday=#"&request("date"&i)&"# and countryid="&request("country"&i))
end if
next

%>