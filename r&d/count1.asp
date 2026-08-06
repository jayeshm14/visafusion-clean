<%

Function IntegerToWords(inputNum)
  Dim retVal, ones(19),tens(9),thou(5)
  Dim dig1,dig2,dig3,level,lasttwo,s,x,lenX
  
  If Not IsNumeric(inputNum) Then
    'Make sure that the input is a number
    retval="input is not numeric"  
  ElseIf Instr(1,inputNum,".")>0 Then
    'Make sure that the input is an integer
    retval="input is not an integer"
  ElseIf Len(inputNum)>14 Then
    'Make sure that the input is not too long
    retval="input must be less than 1 quadrillion"
  ElseIf inputNum<0 Then
    'Make sure that the input is positive
    retval="input must be a positive integer"
  Else
    ones(1)="one"
    ones(2)="two"
    ones(3)="three"
    ones(4)="four"
    ones(5)="five"
    ones(6)="six"
    ones(7)="seven"
    ones(8)="eight"
    ones(9)="nine"
    ones(10)="ten"
    ones(11)="eleven"
    ones(12)="twelve"
    ones(13)="thirteen"
    ones(14)="fourteen"
    ones(15)="fifteen"
    ones(16)="sixteen"
    ones(17)="seventeen"
    ones(18)="eighteen"
    ones(19)="nineteen"
    tens(2)="twenty"
    tens(3)="thirty"
    tens(4)="forty"
    tens(5)="fifty"
    tens(6)="sixty"
    tens(7)="seventy"
    tens(8)="eighty"
    tens(9)="ninety"
    thou(1)="thousand"
    thou(2)="million"
    thou(3)="billion"
    thou(4)="trillion"

    'Convert the input into a string
    s=CStr(inputNum)
    level=0
  
    Do Until s=""
      'Get the three rightmost characters
      x=Right(s,3) 
  
      lenX=len(x)
      'Separate the three digits
      If lenX=1 Then        
        dig1=0
        dig2=0
      ElseIf lenX=2 Then
        dig1=0
        dig2=CInt(left(x,1))
      Else  
        dig1=CInt(left(x,1))
        dig2=CInt(mid(x,2,1))
      End If
      dig3=CInt(right(x,1))
      'get the last two digits
      lasttwo=CInt(Right(x,2))

      'append a thousand, million where appropriate
      If level>0 and dig1+dig2+dig3>0 Then
        retval=trim(thou(level) & " " & retval)
      End If

      'check that the last two digits is nonzero    
      If lasttwo>0 Then        
        If lasttwo<20 Then
          'if less than 20, use "ones" array only
          retval=trim(ones(lasttwo) & " " & retval)
        Else
          'if at least 20, use "tens" and "ones" array
          retval=trim(trim(tens(dig2) & _
            " " & ones(dig3)) & " " & retval)
        End If
      End If
      
      If dig1>0 then
        retval = trim(ones(dig1) & _
          " hundred " & retval)
      End If
        
      newLen=len(s)-3
      If newLen>0 Then
        s=Left(s,newLen)
      Else
        s=""
      End If              
      level = level + 1
    Loop
  End If
  IntegerToWords=retval
End Function

response.write(ucase(IntegerToWords(99999)))


%>
<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>

<body bgcolor="#FFFFFF">

</body>
</html>
