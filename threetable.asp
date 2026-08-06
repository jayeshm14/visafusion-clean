<!-- #include file="connection.asp" -->

<%

set rs=server.createobject("adodb.recordset")
con.begintrans

stmt1="delete from mainentry where refno=30"
stmt2="delete from entrydetails where refno=30"
stmt3="delete from paxstatus where refno=30"
con.execute stmt1
con.execute stmt2
con.execute stmt3
con.committrans
response.write "records deleted"
%>