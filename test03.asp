 <%@ Language=VBScript %>
<!-- #include file="connection.asp" --> 
<html>
set 
<a href="c:\tally\tally.exe">power vcd</a>
<%response.write "daya og we"&weekday(date()+1)
response.write "date time"&formatdatetime(now(),3)%>
 <select size=1  name="agentlist" >
                                              <%

set rsStatus=server.createobject("adodb.recordset")
set textfile1=server.createobject("scripting.FileSystemObject")
set second1=textfile1.createtextFile ("c:\rajvenesh.doc")
'textfile.OpenTextFile"c:\rajvenesh.txt",ForAppending,True
'set newStream=textfile.Openastextstream (ForAppending,false)
second1.WriteLIne " gkjhhjhlkjk hljhkljkjthis is textffhghgjhjk"
second1.close

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
                                             <select size=1  name="agentlist1" >
                                              <%

status ="Sent"
set rsStatus=server.createobject("adodb.recordset")
rsStatus.activeconnection=con
rsStatus.open "select description from status order by Description",con
while not rsStatus.eof
response.write("<option")
if ucase(rsStatus("Description"))= ucase(status) then
response.write(" Selected")
End if
response.write(">")
response.write rsStatus("Description")
response.write("</option>")

rsStatus.movenext
wend
rsStatus.close
%> 
                                            </select>
                                            </html>