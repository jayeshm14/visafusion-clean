<!-- #include file="../connection.asp" -->
<%

refno=64100
agent=2600
updatedby="any one"
remark="Harjai tu kab aayega"

sqlbh="insert into bighistory values('"&refno&"','"&agent&"','"&FormatDateTime(now(),0)&"','"&updatedby&"','"&remark&"')"
con.execute(sqlbh)


RESPONSE.WRITE "Hogaya kaam"
%>