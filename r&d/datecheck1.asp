<SCRIPT LANGUAGE="VBScript">

Sub datecheck_OnBlur

 If isDate(Document.Form1.Datecheck.Value) then

  else
    msgbox "Incorrect Date Format", vbCritical, "Date Missing"
Document.Form1.Datecheck.focus
return false
  End If

End Sub

</SCRIPT>


<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>

<body bgcolor="#FFFFFF">
<form method="post" action="" name="form1">
  <input type="text" name="datecheck">
  <input type="submit" name="Submit" value="Submit">
</form>
</body>
</html>
