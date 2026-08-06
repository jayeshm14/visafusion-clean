<!-- #include file="../connection.asp" -->
<%
'OPTION EXPLICIT

Dim UnitNames, TeenNames, DecadeNames
UnitNames = Array(" zero"," one"," two"," three"," four", _
                  " five"," six"," seven"," eight"," nine" )
TeenNames = Array(" ten"," eleven"," twelve"," thirteen"," fourteen", _
                  " fifteen"," sixteen"," seventeen"," eighteen"," nineteen" )
DecadeNames = Array(" zero"," ten"," twenty"," thirty"," forty", _
                    " fifty"," sixty"," seventy"," eighty"," ninety" )

Function NumberAsWord( num )
    Dim millions, thousands, hundreds, decades, result

    If Not isNumeric( num ) Then
        NumberAsWord = "<i>That is NOT a valid number!</i>"
        Exit Function
    End If

    result = ""
    num = CDbl(num)

	If num = 0 Then
		NumberAsWord = "zero"
		Exit Function
	End If

    If num < 0 Then
        num = - num
        result = "<i>NEGATIVE</i> "
    End If

    millions = 999999

    On Error Resume Next
    millions = num \ 1000000
    num = CLng( num MOD 1000000 )
    On Error GoTo 0

    If millions > 0 Then
        If millions > 999 Then
            NumberAsWord = result & "BILLIONS and BILLIONS"
            Exit Function
        End If
        result = result & NumberAsWord( millions ) & " million"
        If num = 0 Then
            NumberAsWord = result
            Exit Function
        End If
    End If
    
    thousands = num \ 1000
    num = num MOD 1000
    If thousands > 0 Then
        result = result & NumberAsWord( thousands ) & " thousand"
        If num = 0 Then
            NumberAsWord = result
            Exit Function
        End If
    End If
    
    hundreds = num \ 100
    num = num MOD 100           
    If hundreds > 0 Then
        result = result & UnitNames( hundreds ) & " hundred"
    End If
    
    decades = num \ 10
    num = num MOD 10
    If decades = 1 Then
        result = result & TeenNames( num ) 
    Else
        If decades > 1 Then
            result = result & DecadeNames( decades )
        End If
        If num > 0 Then
            result = result & UnitNames( num )
        End If
    End If

    NumberAsWord = result
End Function
response.write(ucase(NumberAsWord(99999999)))
%>
<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>

<body bgcolor="#FFFFFF">

</body>
</html>
