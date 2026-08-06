<%@ Language=VBScript %>
<!-- #include file="connection.asp" -->
<%
response.buffer= true

if session("priv")="" then
response.clear
response.redirect "default.asp?rsn=usb"
end if
%>
<html>
<head>
<title>www.udaanindia.com</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

</head>

<body bgcolor="#FFFFFF"  topmargin=0 leftmargin=0 marginwidth=0 marginheight=0 >
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
          <% if session("priv")="adm" then %> <!-- include file="topAdmin.asp"--> 
      <%
elseif session("priv")="emp" then
%>
<!-- include file="top.asp"--> 
<% 
elseif session("priv")="agt" then
%>
<!-- #include file="topAgent.asp"--> <% 
elseif session("priv")="guest" then
%> <% end if %> </td> </tr> 
<tr>
                <td> 
  <table width=780 border=0 align=center cellpadding=0 cellspacing=0 height="4776">
    <tr> 
      <td align=left valign=top background="images/bigtablebg.gif" height="4525"> 
        <table width="80%" border="0" cellpadding="1" cellspacing="1" align="center" height="4784" >
          <tr bgcolor="BD402C"> 
            <td height="10"> <br>
                      
                        <table width="75%" align="center" cellpadding="0" cellspacing="0" bgcolor="#008432">
                          <tr> 
                            <td height="21" background="images/yellowbgband.gif" align="center"> 
                    <p class="lbltext"> VISA FORMS</p>
                            </td>
                          </tr>
                        </table>
                      </td>
                    </tr>
                    
          <tr> 
            <td height="4449"> 
              <table width="100%" border="0" cellpadding="0" cellspacing="0" height="8" align="center" >
                <tr bgcolor="BD402C"> 
                  <td height="2"> <p align="justify" class="updatetext"><strong>
                    <a href="#a" class="toplinkadmin">A</a> 
                      - <a href="#b" class="toplinkadmin">B</a> - <a href="#c" class="toplinkadmin">C</a> - <a href="#d" class="toplinkadmin">D</a> 
                      - <a href="#e" class="toplinkadmin">E</a> - <a href="#f" class="toplinkadmin">F</a> - <a href="#g" class="toplinkadmin">G</a> 
                      - <a href="#h" class="toplinkadmin">H</a> -<a href="#i" class="toplinkadmin"> I </a>- <a href="#j" class="toplinkadmin">J</a> 
                      - <a href="#k" class="toplinkadmin">K</a> - <a href="#l" class="toplinkadmin">L</a> - <a href="#m" class="toplinkadmin">M</a> 
                      - <a href="#n" class="toplinkadmin">N</a> - <a href="#o" class="toplinkadmin">O</a> - <a href="#p" class="toplinkadmin">P</a> 
                      - <a href="#r" class="toplinkadmin">R</a> - <a href="#s" class="toplinkadmin">S</a> - <a href="#t" class="toplinkadmin">T</a> 
                      - <a href="#u" class="toplinkadmin">U</a> - <a href="#v" class="toplinkadmin">V</a> - <a href="#y" class="toplinkadmin">Y</a> 
                      - <a href="#z" class="toplinkadmin">Z</a></strong></p>
                  </td>
                </tr>
                <tr> 
                  <td height="4611"> 
                    <table width="100%" height="4668">
                      <tr bgcolor="BD402C"> 
                        <td colspan="14" height="57"> 
                          <p align="justify" class="updatetext"><strong>YOU CAN 
                            DOWNLOAD FORMS BY CLICK ON BELOW LINKS, THE FILES 
                            ARE IN .PDF FORMAT (PLEASE OPEN WITH ACROBAT READER), 
                            IT WILL TAKE SOME TIME TO DOWNLOAD.<br>
                            <br>
                            FOR DOWNLOAD ACROBAT READER CLICK HERE --&gt;&gt; 
                            <a href="http://www.adobe.com/products/acrobat/readermain.html" target="_blank" class="toplinkadmin"><img src="IMAGES/get_adobe_reader.gif" width="88" height="31" border="0"></a></strong></p>
                        </td>
                      </tr>
                      <tr bgcolor="BD402C"> 
                        <td colspan="13" height="5"><font face="Verdana" size="6"><b><font color="#FFFFFF"> 
                          <center>
                            <font color="#FFCC00">A</font> 
                          </center>
                          </font></b></font><a name="a"></a></td>
                        <td width="86%" height="5">&nbsp;</td>
                      </tr>
                      <tr bgcolor="BD402C"> 
                        <td colspan="13" height="2"> 
                          <p class="updatetext"><strong>ARGENTINA</strong></p>
                        </td>
                        <td width="86%" height="2"><img src="images/dnload.gif" width="20" height="20"> 
                          <a href="http://www.udaanindia.com/forms/Argentina.pdf" target="_blank" class="toplinkadmin">ARGENTINA 
                          VISA FORM</a></td>
                      </tr>
                      <tr bgcolor="BD402C"> 
                        <td colspan="13" height="24"> 
                          <p class="updatetext"><strong>AUSTRALIA</strong></p>
                        </td>
                        <td width="86%" height="24"> <img src="images/dnload.gif" width="20" height="20"> 
                          <a href="http://www.udaanindia.com/forms/aus/48R-Tourist.pdf" target="_blank" class="toplinkadmin">TOURIST( 
                          48R )</a> <img src="images/dnload.gif" width="20" height="20"> 
                          <a href="http://www.udaanindia.com/forms/aus/456-small%20stay%20business.pdf" target="_blank" class="toplinkadmin">BUSINESS( 
                          456 )</a> <img src="images/dnload.gif" width="20" height="20"> 
                          <a href="http://www.udaanindia.com/forms/aus/M67-FAMILY%20SHEET.pdf" target="_blank" class="toplinkadmin">DETAIL 
                          OF RELATIVES ( M-67 )<br>
                          </a><img src="images/dnload.gif" width="20" height="20"><a href="http://www.udaanindia.com/forms/aus/1066-long%20stay%20business.pdf" target="_blank" class="toplinkadmin">LONG 
                          STAY BUSINESS FORM( 1066 )</a> <img src="images/dnload.gif" width="20" height="20"><a href="http://www.udaanindia.com/forms/aus/876-Transit%20form.pdf" target="_blank" class="toplinkadmin">TRANSIT 
                          FORM( 876 )</a><br>
                          <img src="images/dnload.gif" width="20" height="20"><a href="http://www.udaanindia.com/forms/aus/Medical%20Form%20No-26.pdf" target="_blank" class="toplinkadmin">MEDICAL 
                          FORM ( No-26 )</a> <img src="images/dnload.gif" width="20" height="20"><a href="http://www.udaanindia.com/forms/aus/Medical%20Form%20No-160.pdf" target="_blank" class="toplinkadmin">MEDICAL 
                          FORM ( No-160 )</a> <img src="images/dnload.gif" width="20" height="20"> 
                          <a href="http://www.udaanindia.com/forms/aus/AUTHORISATION%20FORM%20FOR%20AUSTRALIA-956.pdf" target="_blank" class="toplinkadmin">AUTHORISATION 
                          FORM FOR AUSTRALIA-( 956 )</a></td>
                      </tr>
                      <tr bgcolor="BD402C"> 
                        <td colspan="13" height="20"> 
                          <p class="updatetext"><strong>AFGHANISTAN</strong></p>
                        </td>
                        <td width="86%" height="20"><img src="images/dnload.gif" width="20" height="20"> 
                          <a href="http://www.udaanindia.com/forms/Afganistan.pdf" target="_blank" class="toplinkadmin">AFGHANISTAN 
                          VISA FORM</a> </td>
                      </tr>
                      <tr bgcolor="BD402C"> 
                        <td colspan="13" height="20"> 
                          <p class="updatetext"><strong>ALGERIA</strong></p>
                        </td>
                        <td width="86%" height="20"><img src="images/dnload.gif" width="20" height="20"> 
                          <a href="http://www.udaanindia.com/forms/algeria.pdf" target="_blank" class="toplinkadmin">ALGERIA 
                          VISA FORM</a> </td>
                      </tr>
                      <tr bgcolor="BD402C"> 
                        <td colspan="13" height="20"> 
                          <p class="updatetext"><strong>ANGOLA</strong></p>
                        </td>
                        <td width="86%" height="20"><img src="images/dnload.gif" width="20" height="20"> 
                          <a href="http://www.udaanindia.com/forms/ANGOLA.PDF" target="_blank" class="toplinkadmin">ANGOLA 
                          VISA FORM</a> </td>
                      </tr>
                      <tr bgcolor="BD402C"> 
                        <td colspan="13" height="20"> 
                          <p class="updatetext"><strong>ARMENIA</strong></p>
                        </td>
                        <td width="86%" height="20"><img src="images/dnload.gif" width="20" height="20"> 
                          <a href="http://www.udaanindia.com/forms/Armenia.pdf" target="_blank" class="toplinkadmin">ARMENIA 
                          VISA FORM</a> </td>
                      </tr>
                      <tr bgcolor="BD402C"> 
                        <td colspan="13" height="20"> 
                          <p class="updatetext"><strong>AUSTRIA</strong></p>
                        </td>
                        <td width="86%" height="20"><img src="images/dnload.gif" width="20" height="20"> 
                          <a href="http://www.udaanindia.com/forms/austria.pdf" target="_blank" class="toplinkadmin">AUSTRIA 
                          FORM</a></td>
                      </tr>
                      <tr bgcolor="BD402C"> 
                        <td colspan="13" height="2"> 
                          <p class="updatetext"><strong>AZERBAIJAN</strong></p>
                        </td>
                        <td width="86%" height="2"><img src="images/dnload.gif" width="20" height="20"> 
                          <a href="http://www.udaanindia.com/forms/Azarbaycan%20Visa%20Form.pdf" target="_blank" class="toplinkadmin">AZERBAIJAN 
                          VISA FORM</a> </td>
                      </tr>
                      <tr bgcolor="BD402C"> 
                        <td colspan="13" height="2"><font face="Verdana" size="6"><b><font color="#FFFFFF"> 
                          <center>
                            <font color="#FFCC00">B</font> 
                          </center>
                          </font></b></font><a name="b"></a></td>
                        <td width="86%" height="2">&nbsp;</td>
                      </tr>
                      <tr bgcolor="BD402C"> 
                        <td colspan="13" height="2"> 
                          <p class="updatetext"><strong>BAHAMAS</strong></p>
                        </td>
                        <td width="86%" height="2"><img src="images/dnload.gif" width="20" height="20"> 
                          <a href="http://www.udaanindia.com/forms/uk/VAF5%20-%20Overseas%20Territory%20visa%20form.pdf" target="_blank" class="toplinkadmin">BAHAMAS 
                          / BELIZE VISA FORM</a></td>
                      </tr>
                      <tr bgcolor="BD402C"> 
                        <td colspan="13" height="2"> 
                          <p class="updatetext"><strong>BELGIUM</strong></p>
                        </td>
                        <td width="86%" height="2"><img src="images/dnload.gif" width="20" height="20"> 
                          <a href="http://www.udaanindia.com/forms/Belgium.pdf" target="_blank" class="toplinkadmin">BELGIUM 
                          VISA FORM</a></td>
                      </tr>
                      <tr bgcolor="BD402C"> 
                        <td colspan="13" height="2"> 
                          <p class="updatetext"><strong>BELARUS</strong></p>
                        </td>
                        <td width="86%" height="2"><img src="images/dnload.gif" width="20" height="20"> 
                          <a href="http://www.udaanindia.com/forms/BELARUS%20VISA%20FORM.pdf" target="_blank" class="toplinkadmin">BELARUS 
                          VISA FORM</a></td>
                      </tr>
                      <tr bgcolor="BD402C"> 
                        <td colspan="13" height="2"> 
                          <p class="updatetext"><strong>BENIN</strong></p>
                        </td>
                        <td width="86%" height="2"><img src="images/dnload.gif" width="20" height="20"> 
                          <a href="http://www.udaanindia.com/forms/Benin.pdf" target="_blank" class="toplinkadmin">BENIN 
                          VISA FORM</a> </td>
                      </tr>
                      <tr bgcolor="BD402C"> 
                        <td colspan="13" height="2"> 
                          <p class="updatetext"><strong>BRAZIL</strong></p>
                        </td>
                        <td width="86%" height="2"><img src="images/dnload.gif" width="20" height="20"> 
                          <a href="http://www.udaanindia.com/forms/Brazil.pdf" target="_blank" class="toplinkadmin">BRAZIL 
                          VISA FORM</a> <img src="images/dnload.gif" width="20" height="20"> 
                          <a href="http://www.udaanindia.com/forms/Brazil%20Seaman%20Family.pdf" target="_blank" class="toplinkadmin">LETTER 
                          OF FORMAT FROM SHIPPING COMPANIES ( SEAMAN FAMILY )</a></td>
                      </tr>
                      <tr bgcolor="BD402C"> 
                        <td colspan="13" height="2"> 
                          <p class="updatetext"><strong>BULGARIA</strong></p>
                        </td>
                        <td width="86%" height="2"><img src="images/dnload.gif" width="20" height="20"> 
                          <a href="http://www.udaanindia.com/forms/BULGARIA%20VISA%20FORM.pdf" target="_blank" class="toplinkadmin">BULGARIA 
                          VISA FORM</a></td>
                      </tr>
                      <tr bgcolor="BD402C"> 
                        <td colspan="13" height="2"> 
                          <p class="updatetext"><strong>BURKINA FASO</strong></p>
                        </td>
                        <td width="86%" height="2"><img src="images/dnload.gif" width="20" height="20"> 
                          <a href="http://www.udaanindia.com/forms/Burkina%20Faso.pdf" target="_blank" class="toplinkadmin">BURKINA 
                          FASO VISA FORM</a> </td>
                      </tr>
                      <tr bgcolor="BD402C">
                        <td colspan="13" height="2"><p class="updatetext"><strong>BOTSWANA</strong></td>
                        <td width="86%" height="2"><img src="images/dnload.gif" width="20" height="20"> 
                          <a href="http://www.udaanindia.com/forms/BOTSWANA.pdf" target="_blank" class="toplinkadmin">BOTSWANA 
                          VISA FORM</a> </td>
                      </tr>
                      <tr bgcolor="BD402C"> 
                        <td colspan="13" height="2"> 
                          <p class="updatetext"><strong>BRUNEI DARUSSALAM</strong></p>
                        </td>
                        <td width="86%" height="2"><img src="images/dnload.gif" width="20" height="20"> 
                          <a href="http://www.udaanindia.com/forms/BRUNEI/Brunei.pdf" target="_blank" class="toplinkadmin">BRUNEI 
                          DARUSSALAM VISA FORM</a> <img src="images/dnload.gif" width="20" height="20"><a href="http://www.udaanindia.com/forms/BRUNEI/Bru-doct-list.pdf" target="_blank" class="toplinkadmin">LIST 
                          OF PANEL DOCTORS </a> <img src="images/dnload.gif" width="20" height="20"> 
                          <a href="http://www.udaanindia.com/forms/BRUNEI/bru-medical-form.pdf" target="_blank" class="toplinkadmin">BRUNEI 
                          MEDICAL FORM</a></td>
                      </tr>
                      <tr bgcolor="BD402C"> 
                        <td colspan="13" height="2"> 
                          <p class="updatetext"><strong>BOSNIA HERZEGOVINA</strong> 
                        </td>
                        <td width="86%" height="2"><img src="images/dnload.gif" width="20" height="20"><a href="http://www.udaanindia.com/forms/BOSNIA%20HERZEGOVINA.pdf" target="_blank" class="toplinkadmin">BOSNIA 
                          HERZEGOVINA VISA FORM</a></td>
                      </tr>
                      <tr bgcolor="BD402C"> 
                        <td colspan="13" height="2"> 
                          <p class="updatetext"><strong>BANGLADESH</strong></p>
                        </td>
                        <td width="86%" height="2"><img src="images/dnload.gif" width="20" height="20"> 
                          <a href="http://www.udaanindia.com/forms/bangladesh.pdf" target="_blank" class="toplinkadmin">BANGLADESH 
                          VISA FORM</a> </td>
                      </tr>
                      <tr bgcolor="BD402C"> 
                        <td colspan="13" height="2"><font face="Verdana" size="6"><b><font color="#FFFFFF"> 
                          <center>
                            <font color="#FFCC00">C</font> 
                          </center>
                          </font></b></font><a name="c"></a></td>
                        <td width="86%" height="2">&nbsp;</td>
                      </tr>
                      <tr bgcolor="BD402C"> 
                        <td colspan="13" valign="middle" height="14"> 
                          <p class="updatetext"><strong>CANADA</strong></p>
                        </td>
                        <td valign="top" width="86%" height="14"> 
                          <p><img src="images/dnload.gif" width="20" height="20"> 
                            <a href="http://www.udaanindia.com/forms/canada/canada-family-sheet.pdf" target="_blank" class="toplinkadmin">CANADA 
                            FAMILY SHEEET</a> <img src="images/dnload.gif" width="20" height="20"> 
                            <a href="http://www.udaanindia.com/forms/canada/IMM5257B-RESIDANT.pdf" target="_blank" class="toplinkadmin">BUSINESS,TOURIST 
                            AND RESIDENCE FORM </a><img src="images/dnload.gif" width="20" height="20"> 
                            <a href="http://www.udaanindia.com/forms/canada/IMM1295B-WORK.pdf" target="_blank" class="toplinkadmin">CANADA 
                            WORK VISA FORM</a> <img src="images/dnload.gif" width="20" height="20"><a href="http://www.udaanindia.com/forms/canada/IMM1294S-STUDY.pdf" target="_blank" class="toplinkadmin">CANADA 
                            STUDY VISA FORM</a> <img src="images/dnload.gif" width="20" height="20"> 
                            <a href="http://www.udaanindia.com/forms/canada/Canada%20Travellor%20Form.pdf" target="_blank" class="toplinkadmin">CANADA 
                            TRAVELER FORM</a> <img src="images/dnload.gif" width="20" height="20"> 
                            <a href="http://www.udaanindia.com/forms/canada/Student%20Questionaire.pdf" target="_blank" class="toplinkadmin">STUDENT<br>
                            QUESTIONAIRE FORM</a> <img src="images/dnload.gif" width="20" height="20"> 
                            <a href="http://www.udaanindia.com/forms/canada/Canada%20Authority%20Letter.doc" target="_blank" class="toplinkadmin">CANADA 
                            AUTHORITY LETTER</a> </p>
                        </td>
                      <tr bgcolor="BD402C"> 
                        <td colspan="13" valign="top" height="21"> 
                          <p class="updatetext"><strong>CHINA</strong></p>
                        </td>
                        <td valign="top" width="86%" height="21"><img src="images/dnload.gif" width="20" height="20"> 
                          <a href="http://www.udaanindia.com/forms/china.pdf" target="_blank" class="toplinkadmin">CHINA 
                          VISA FORM </a><img src="images/dnload.gif" width="20" height="20"><u><a href="http://www.udaanindia.com/forms/China Medical form.pdf" target="_blank" class="toplinkadmin">CHINA 
                          MEDICAL FORM</a></u></td>
                      </tr>
                      <tr bgcolor="BD402C"> 
                        <td colspan="13" valign="top" height="2"> 
                          <p class="updatetext"><strong>CHILE</strong></p>
                        </td>
                        <td valign="top" width="86%" height="2"><img src="images/dnload.gif" width="19" height="20"> 
                          <a href="http://www.udaanindia.com/forms/Chile.pdf" target="_blank" class="toplinkadmin">CHILE 
                          VISA FORM</a> <img src="images/dnload.gif" width="19" height="20"> 
                          <a href="http://www.udaanindia.com/forms/CHILE-AUTH.DOC" target="_blank" class="toplinkadmin">CHILE 
                          AUTHORITY LETTER</a> </td>
                      </tr>
                      <tr bgcolor="BD402C"> 
                        <td colspan="13" valign="top" height="2"> 
                          <p class="updatetext"><strong>CONGO</strong></p>
                        </td>
                        <td valign="top" width="86%" height="2"><img src="images/dnload.gif" width="20" height="20"> 
                          <a href="http://www.udaanindia.com/forms/Congo.pdf" target="_blank" class="toplinkadmin">CONGO 
                          VISA FORM</a> </td>
                      </tr>
                      <tr bgcolor="BD402C"> 
                        <td colspan="13" valign="top" height="15"> 
                          <p class="updatetext"><strong>CYPRUS</strong></p>
                        </td>
                        <td valign="top" width="86%" height="15"><img src="images/dnload.gif" width="20" height="20"> 
                          <a href="http://www.udaanindia.com/forms/Cyprus.pdf" target="_blank" class="toplinkadmin">CYPRUS 
                          VISA FORM</a> <img src="images/dnload.gif" width="20" height="20"> 
                          <a href="http://www.udaanindia.com/forms/Cyprus%20Sponsership%20form.pdf" target="_blank" class="toplinkadmin">CYPRUS 
                          SPONSERSHIP FORM</a> </td>
                      </tr>
                      <tr bgcolor="BD402C"> 
                        <td colspan="13" valign="top" height="2"> 
                          <p class="updatetext"><strong>CROATIA</strong></p>
                        </td>
                        <td valign="top" width="86%" height="2"><img src="images/dnload.gif" width="20" height="20"> 
                          <a href="http://www.udaanindia.com/forms/Croatia.pdf" target="_blank" class="toplinkadmin">CROATIA 
                          VISA FORM</a> <img src="images/dnload.gif" width="20" height="20"> 
                          <a href="http://www.udaanindia.com/forms/Croatia%20Invitation%20Format.pdf" target="_blank" class="toplinkadmin">CROATIA 
                          INVITATION FORMAT<br>
                          </a><img src="images/dnload.gif" width="20" height="20"> 
                          <a href="http://www.udaanindia.com/forms/Croatia%20Sponsership%20Format.pdf" target="_blank" class="toplinkadmin">CROATIA 
                          SPONSERSHIP FORMAT</a> </td>
                      </tr>
                      <tr bgcolor="BD402C"> 
                        <td colspan="13" valign="top" height="2"> 
                          <p class="updatetext"><strong>CUBA</strong></p>
                        </td>
                        <td valign="top" width="86%" height="2"><img src="images/dnload.gif" width="20" height="20"> 
                          <a href="http://www.udaanindia.com/forms/CUBA.PDF" target="_blank" class="toplinkadmin">CUBA 
                          VISA FORM</a> </td>
                      </tr>
                      <tr bgcolor="BD402C"> 
                        <td colspan="13" valign="top" height="2"> 
                          <p class="updatetext"><strong>CZECH</strong></p>
                        </td>
                        <td valign="top" width="86%" height="2"><img src="images/dnload.gif" width="20" height="20"> 
                          <a href="http://www.udaanindia.com/forms/czech.pdf" target="_blank" class="toplinkadmin">CZECH 
                          VISA FORM</a> <img src="images/dnload.gif" width="20" height="20"> 
                          <a href="http://www.udaanindia.com/forms/Czech%20Affidavit.pdf" target="_blank" class="toplinkadmin">AFFIDAVIT 
                          ONLY FOR CZECH MULTIPLE VISA </a></td>
                      </tr>
                      <tr bgcolor="BD402C"> 
                        <td colspan="13" valign="top" height="2"> 
                          <p class="updatetext"><strong>COSTA RICA</strong></p>
                        </td>
                        <td valign="top" width="86%" height="2"><img src="images/dnload.gif" width="20" height="20"> 
                          <a href="http://www.udaanindia.com/forms/costarica.pdf" target="_blank" class="toplinkadmin">COSTA 
                          RICA VISA FORM</a> </td>
                      </tr>
                      <tr bgcolor="BD402C"> 
                        <td colspan="13" valign="top" height="2"> 
                          <p class="updatetext"><strong>CAMBODIA</strong></p>
                        </td>
                        <td valign="top" width="86%" height="2"><img src="images/dnload.gif" width="20" height="20"> 
                          <a href="http://www.udaanindia.com/forms/Cambodia.pdf" target="_blank" class="toplinkadmin">CAMBODIA 
                          VISA FORM</a> </td>
                      </tr>
                      <tr bgcolor="BD402C"> 
                        <td colspan="13" valign="top" height="2"> 
                          <p class="updatetext"><strong>COLOMBIA</strong></p>
                        </td>
                        <td valign="top" width="86%" height="2"><img src="images/dnload.gif" width="20" height="20"> 
                          <a href="http://www.udaanindia.com/forms/columbia.pdf" target="_blank" class="toplinkadmin">COLOMBIA 
                          VISA FORM</a> <img src="images/dnload.gif" width="20" height="20"><a href="http://www.udaanindia.com/forms/Colombia%20work%20permit.pdf" target="_blank" class="toplinkadmin">COLOMBIA 
                          WORK VISA FORM</a> </td>
                      </tr>
                      <tr bgcolor="BD402C"> 
                        <td colspan="13" valign="top" height="2"><font face="Verdana" size="6"><b><font color="#FFFFFF"> 
                          <center>
                            <font color="#FFCC00">D</font> 
                          </center>
                          </font></b></font><a name="d"></a></td>
                        <td valign="top" width="86%" height="2">&nbsp;</td>
                      </tr>
                      <tr bgcolor="BD402C"> 
                        <td colspan="13" valign="top" height="29">
                          <p class="updatetext"><strong>DJIBOUTI</strong></P>
                        </td>
                        <td valign="top" width="86%" height="29"><img src="images/dnload.gif" width="20" height="20"> 
                          <a href="http://www.udaanindia.com/forms/DJIBOUTI.pdf" target="_blank" class="toplinkadmin">DJIBOUTI 
                          VISA FORM</a> </td>
                      </tr>
                      <tr bgcolor="BD402C"> 
                        <td colspan="13" valign="top" height="29"> 
                          <p class="updatetext"><strong>DUBAI</strong></p>
                        </td>
                        <td valign="top" width="86%" height="29"><img src="images/dnload.gif" width="20" height="20"> 
                          <a href="http://www.udaanindia.com/forms/Dubai.pdf" target="_blank" class="toplinkadmin">DUBAI 
                          VISA FORM</a></td>
                      </tr>
                      <tr bgcolor="BD402C"> 
                        <td colspan="13" valign="top" height="29"> 
                          <p class="updatetext"><strong>DENMARK</strong></p>
                        </td>
                        <td valign="top" width="86%" height="29"> <img src="images/dnload.gif" width="20" height="20"> 
                          <a href="http://www.udaanindia.com/forms/DENMARK.pdf" target="_blank" class="toplinkadmin">DENMARK 
                          VISA FORM </a><img src="images/dnload.gif" width="20" height="20"> 
                          <a href="http://www.udaanindia.com/forms/DENMARK-WORK.pdf" target="_blank" class="toplinkadmin">DENMARK 
                          WORK VISA FORM <br>
                          </a><img src="images/dnload.gif" width="20" height="20"> 
                          <a href="http://www.udaanindia.com/forms/DENMARK%20FAMILY%20INFORMATION.pdf" target="_blank" class="toplinkadmin">DENMARK 
                          FAMILY INFORMATION VISA FORM </a><br>
                          <img src="images/dnload.gif" width="20" height="20"> 
                          <a href="http://www.udaanindia.com/forms/DENMARK%20CONSENT%20FORM.pdf" target="_blank" class="toplinkadmin">DENMARK 
                          CONSENT VISA FORM</a> </td>
                      </tr>
                      <tr bgcolor="BD402C"> 
                        <td colspan="13" valign="top" height="31"><b> 
                          <p class="updatetext"><strong>DOMINICAN REPUBLIC</strong></p>
                          </b></td>
                        <td valign="top" width="86%" height="31"><img src="images/dnload.gif" width="20" height="20"> 
                          <a href="http://www.udaanindia.com/forms/DOMINICAN%20REPUBLIC.pdf" target="_blank" class="toplinkadmin">DOMINICAN 
                          REPUBLIC VISA FORM</a> </td>
                      </tr>
                      <tr bgcolor="BD402C"> 
                        <td colspan="13" valign="top" height="31"><font face="Verdana" size="6"><b><font color="#FFFFFF"> 
                          <center>
                            <font color="#FFCC00">E</font> 
                          </center>
                          </font></b></font><a name="e"></a> </td>
                        <td valign="top" width="86%" height="31">&nbsp;</td>
                      </tr>
                      <tr bgcolor="BD402C"> 
                        <td colspan="13" valign="top" height="2"> 
                          <p class="updatetext"><strong>ETHIOPIA</strong></p>
                        </td>
                        <td valign="top" width="86%" height="2"><img src="images/dnload.gif" width="20" height="20"><a href="http://www.udaanindia.com/forms/ETHIOPIA.pdf" target="_blank" class="toplinkadmin">ETHIOPIA 
                          VISA FORM</a></td>
                      </tr>
                      <tr bgcolor="BD402C"> 
                        <td colspan="13" valign="top" height="2"> 
                          <p class="updatetext"><strong>ESTONIA</strong></p>
                        </td>
                        <td valign="top" width="86%" height="2"><img src="images/dnload.gif" width="20" height="20"><a href="http://www.udaanindia.com/forms/Estonia.pdf" target="_blank" class="toplinkadmin">ESTONIA 
                          VISA FORM</a> <img src="images/dnload.gif" width="20" height="20"> 
                          <a href="http://www.udaanindia.com/forms/Estonia-inv.pdf" target="_blank" class="toplinkadmin">ESTONIA 
                          INVITATION FORM</a> </td>
                      </tr>
                      <tr bgcolor="BD402C"> 
                        <td colspan="13" valign="top" height="2"> 
                          <p class="updatetext"><strong>ECUADOR</strong></p>
                        </td>
                        <td valign="top" width="86%" height="2"><img src="images/dnload.gif" width="20" height="20"><a href="http://www.udaanindia.com/forms/Ecuador%20visa%20form.pdf" target="_blank" class="toplinkadmin">ECUADOR 
                          VISA FORM</a> </td>
                      </tr>
                      <tr bgcolor="BD402C"> 
                        <td colspan="13" valign="top" height="2"> 
                          <p class="updatetext"><strong>ERITREA</strong></p>
                        </td>
                        <td valign="top" width="86%" height="2"><img src="images/dnload.gif" width="20" height="20"><a href="http://www.udaanindia.com/forms/Eritrea.pdf" target="_blank" class="toplinkadmin">ERITREA 
                          VISA FORM</a></td>
                      </tr>
                      <tr bgcolor="BD402C"> 
                        <td colspan="13" valign="top" height="2"> 
                          <p class="updatetext"><strong>EGYPT</strong></p>
                        </td>
                        <td valign="top" width="86%" height="2"><img src="images/dnload.gif" width="20" height="20"><a href="http://www.udaanindia.com/forms/Egypt.pdf" target="_blank" class="toplinkadmin">EGYPT 
                          VISA FORM</a></td>
                      </tr>
                      <tr bgcolor="BD402C"> 
                        <td colspan="13" valign="top" height="2"><font face="Verdana" size="6"><b><font color="#FFFFFF"> 
                          <center>
                            <font color="#FFCC00">F</font> 
                          </center>
                          </font></b></font><a name="f"></a> </td>
                        <td valign="top" width="86%" height="2">&nbsp;</td>
                      </tr>
                      <tr bgcolor="BD402C"> 
                        <td colspan="13" valign="top" height="2"> 
                          <p class="updatetext"><strong>FINLAND</strong></p>
                        </td>
                        <td valign="top" width="86%" height="2"><img src="images/dnload.gif" width="20" height="20"><a href="http://www.udaanindia.com/forms/FINLAND.pdf" target="_blank" class="toplinkadmin">FINLAND 
                          VISA FORM</a> <img src="images/dnload.gif" width="20" height="20"> 
                          <a href="http://www.udaanindia.com/forms/Finland%20work%20permit.pdf" target="_blank" class="toplinkadmin">FINLAND 
                          WORK VISA FORM</a> </td>
                      </tr>
                      <tr bgcolor="BD402C"> 
                        <td colspan="13" valign="top" height="2"> 
                          <p class="updatetext"><strong>FRANCE</strong></p>
                        </td>
                        <td valign="top" width="86%" height="2"><img src="images/dnload.gif" width="20" height="20"><a href="http://www.udaanindia.com/forms/France.pdf" target="_blank" class="toplinkadmin">FRANCE 
                          VISA FORM </a> <img src="images/dnload.gif" width="20" height="20"> 
                          <a href="http://www.udaanindia.com/forms/France%20Undertaking%20Form.pdf" target="_blank" class="toplinkadmin">FRANCE 
                          UNDERTAKING FORM</a> </td>
                      </tr>
                      <tr bgcolor="BD402C"> 
                        <td colspan="13" valign="top" height="2"><font face="Verdana" size="6"><b><font color="#FFFFFF"> 
                          <center>
                            <font color="#FFCC00">G</font> 
                          </center>
                          </font></b></font><a name="g"></a></td>
                        <td valign="top" width="86%" height="2">&nbsp;</td>
                      </tr>
                      <tr bgcolor="BD402C"> 
                        <td colspan="13" valign="top" height="2"> 
                          <p class="updatetext"><strong>GAMBIA</strong> 
                        </td>
                        <td valign="top" width="86%" height="2"><img src="images/dnload.gif" width="20" height="20"> 
                          <a href="http://www.udaanindia.com/forms/GAMBIA%20VISA%20FORM.pdf" target="_blank" class="toplinkadmin">GAMBIA 
                          VISA FORM</a> </td>
                      </tr>
                      <tr bgcolor="BD402C"> 
                        <td colspan="13" valign="top" height="2"> 
                          <p class="updatetext"><strong>GHANA</strong></p>
                        </td>
                        <td valign="top" width="86%" height="2"><img src="images/dnload.gif" width="20" height="20"> 
                          <a href="http://www.udaanindia.com/forms/Ghana.pdf" target="_blank" class="toplinkadmin">GHANA 
                          VISA FORM</a> </td>
                      </tr>
                      <tr bgcolor="BD402C"> 
                        <td colspan="13" valign="top" height="2"> 
                          <p class="updatetext"><strong>GEORGIA</strong></p>
                        </td>
                        <td valign="top" width="86%" height="2"><img src="images/dnload.gif" width="20" height="20"> 
                          <a href="http://www.udaanindia.com/forms/Georgia.pdf" target="_blank" class="toplinkadmin">GEORGIA 
                          VISA FORM</a> </td>
                      </tr>
                      <tr bgcolor="BD402C"> 
                        <td colspan="13" valign="top" height="2"> 
                          <p class="updatetext"><strong>GERMANY</strong></p>
                        </td>
                        <td valign="top" width="86%" height="2"><img src="images/dnload.gif" width="20" height="20"> 
                          <a href="http://www.udaanindia.com/forms/German.pdf" target="_blank" class="toplinkadmin">GERMANY 
                          VISA FORM</a> <img src="images/dnload.gif" width="20" height="20"> 
                          <a href="http://www.udaanindia.com/forms/Germany%20Residence%20visa.pdf" target="_blank" class="toplinkadmin">GERMANY 
                          RESIDENCE VISA FORM<br>
                          </a> <img src="images/dnload.gif" width="20" height="20"> 
                          <a href="http://www.udaanindia.com/forms/Germany%20Declaration%20Form.pdf" target="_blank" class="toplinkadmin">GERMANY 
                          DECLARATION FORM</a> <img src="images/dnload.gif" width="20" height="20"> 
                          <a href="http://www.udaanindia.com/forms/GERMAN%20LONG%20TERM%20DECLARATION%20FORM.pdf" target="_blank" class="toplinkadmin">GERMANY 
                          LONG TERM DECLARATION FORM</a> </td>
                      </tr>
                      <tr bgcolor="BD402C"> 
                        <td colspan="13" valign="top" height="2"> 
                          <p class="updatetext"><strong>GREECE</strong></p>
                        </td>
                        <td valign="top" width="86%" height="2"><img src="images/dnload.gif" width="20" height="20"> 
                          <a href="http://www.udaanindia.com/forms/Greece.pdf" target="_blank" class="toplinkadmin">GREECE 
                          VISA FORM</a> </td>
                      </tr>
                      <tr bgcolor="BD402C"> 
                        <td colspan="13" valign="top" height="2"> 
                          <p class="updatetext"><strong>GUYANA</strong> 
                        </td>
                        <td valign="top" width="86%" height="2"><img src="images/dnload.gif" width="20" height="20"> 
                          <a href="http://www.udaanindia.com/forms/GUYANA%20VISA%20FORM.pdf" target="_blank" class="toplinkadmin">GUYANA 
                          VISA FORM</a> </td>
                      </tr>
                      <tr bgcolor="BD402C"> 
                        <td colspan="13" valign="top" height="2"><font face="Verdana" size="6"><b><font color="#FFFFFF"> 
                          <center>
                            <font color="#FFCC00">H</font> 
                          </center>
                          </font></b></font><a name="h"></a> </td>
                        <td valign="top" width="86%" height="2">&nbsp;</td>
                      </tr>
                      <tr bgcolor="BD402C"> 
                        <td colspan="13" valign="top" height="2"> 
                          <p class="updatetext"><strong>HONGKONG</strong></p>
                        </td>
                        <td valign="top" width="86%" height="2"><img src="images/dnload.gif" width="20" height="20"> 
                          <a href="http://www.udaanindia.com/forms/Hong-kong.pdf" target="_blank" class="toplinkadmin">HONGKONG 
                          VISA FORM</a> </td>
                      </tr>
                      <tr bgcolor="BD402C"> 
                        <td colspan="13" valign="top" height="2"> 
                          <p class="updatetext"><strong>HUNGARY</strong></p>
                        </td>
                        <td valign="top" width="86%" height="2"><img src="images/dnload.gif" width="20" height="20"> 
                          <a href="http://www.udaanindia.com/forms/Hungary%20Long%20Term.pdf" target="_blank" class="toplinkadmin">HUNGARY 
                          LONG TERM VISA FORM</a> <img src="images/dnload.gif" width="20" height="20"> 
                          <a href="http://www.udaanindia.com/forms/Hungary%20Short%20Term.pdf" target="_blank" class="toplinkadmin">HUNGARY 
                          SHORT TERM VISA FORM</a> <img src="images/dnload.gif" width="20" height="20"> 
                          <a href="http://www.udaanindia.com/forms/Hungary%20Declaration%20Form.pdf" target="_blank" class="toplinkadmin">HUNGARY 
                          DECLARATION FORM FOR MULTIPLE VISA </a> <img src="images/dnload.gif" width="20" height="20"> 
                          <a href="http://www.udaanindia.com/forms/Schengen%20visa%20form%20-%20Hungary.pdf" target="_blank" class="toplinkadmin">SCHENGEN 
                          VISA FORM FOR HUNGARY</a> </td>
                      </tr>
                      <tr bgcolor="BD402C"> 
                        <td colspan="13" valign="top" height="2"><font face="Verdana" size="6"><b><font color="#FFFFFF"> 
                          <center>
                            <font color="#FFCC00">I</font> 
                          </center>
                          </font></b></font><a name="i"></a></td>
                        <td valign="top" width="86%" height="2">&nbsp;</td>
                      </tr>
                      <tr bgcolor="BD402C"> 
                        <td colspan="13" valign="top" height="2"> 
                          <p class="updatetext"><strong>ICELAND</strong></p>
                        </td>
                        <td valign="top" width="86%" height="2"><img src="images/dnload.gif" width="20" height="20"> 
                          <a href="http://www.udaanindia.com/forms/ICELAND.pdf" target="_blank" class="toplinkadmin">ICELAND 
                          VISA FORM</a> </td>
                      </tr>
                      <tr bgcolor="BD402C"> 
                        <td colspan="13" valign="top" height="2"> 
                          <p class="updatetext"><strong>INDONESIA</strong></p>
                        </td>
                        <td valign="top" width="86%" height="2"><img src="images/dnload.gif" width="20" height="20"> 
                          <a href="http://www.udaanindia.com/forms/INDONESIA.pdf" target="_blank" class="toplinkadmin">INDONESIA 
                          VISA FORM</a> </td>
                      </tr>
                      <tr bgcolor="BD402C"> 
                        <td colspan="13" valign="top" height="2"> 
                          <p class="updatetext"><strong>ISRAEL</strong></p>
                        </td>
                        <td valign="top" width="86%" height="2"><img src="images/dnload.gif" width="20" height="20"> 
                          <a href="http://www.udaanindia.com/forms/ISRAEL.pdf" target="_blank" class="toplinkadmin">ISRAEL 
                          VISA FORM</a> </td>
                      </tr>
                      <tr bgcolor="BD402C"> 
                        <td colspan="13" valign="top" height="2"> 
                          <p class="updatetext"><strong>IRAQ</strong></p>
                        </td>
                        <td valign="top" width="86%" height="2"><img src="images/dnload.gif" width="20" height="20"> 
                          <a href="http://www.udaanindia.com/forms/Iraq.pdf" target="_blank" class="toplinkadmin">IRAQ 
                          VISA FORM</a> </td>
                      </tr>
                      <tr bgcolor="BD402C"> 
                        <td colspan="13" valign="top" height="2"> 
                          <p class="updatetext"><strong>IRAN</strong></p>
                        </td>
                        <td valign="top" width="86%" height="2"><img src="images/dnload.gif" width="20" height="20"> 
                          <a href="http://www.udaanindia.com/forms/Iran.pdf" target="_blank" class="toplinkadmin">IRAN 
                          VISA FORM</a> </td>
                      </tr>
                      <tr bgcolor="BD402C"> 
                        <td colspan="13" valign="top" height="2"> 
                          <p class="updatetext"><strong>IRELAND</strong></p>
                        </td>
                        <td valign="top" width="86%" height="2"><img src="images/dnload.gif" width="20" height="20"> 
                          <a href="http://www.udaanindia.com/forms/IRELAND.pdf" target="_blank" class="toplinkadmin">IRELAND 
                          VISA FORM</a> </td>
                      </tr>
                      <tr bgcolor="BD402C"> 
                        <td colspan="13" valign="top" height="2"> 
                          <p class="updatetext"><strong>ITALY</strong></p>
                        </td>
                        <td valign="top" width="86%" height="2"><img src="images/dnload.gif" width="20" height="20"> 
                          <a href="http://www.udaanindia.com/forms/Italy.pdf" target="_blank" class="toplinkadmin">ITALY 
                          VISA FORM</a> <img src="images/dnload.gif" width="20" height="20"> 
                          <a href="http://www.udaanindia.com/forms/Italy%20Invitation%20Form.pdf" target="_blank" class="toplinkadmin">ITALY 
                          INVITATION FORM</a> <img src="images/dnload.gif" width="20" height="27"><a href="http://www.udaanindia.com/forms/DECLARATION%20ON%20TRAVEL%20HEALTH%20INSURANCE.pdf" target="_blank" class="toplinkadmin">DECLARATION 
                          ON TRAVEL HEALTH INSURANCE</a></td>
                      </tr>
                      <tr bgcolor="BD402C"> 
                        <td colspan="13" valign="top" height="2"> 
                          <p class="updatetext"><strong>IVORYCOAST</strong></p>
                        </td>
                        <td valign="top" width="86%" height="2"><img src="images/dnload.gif" width="20" height="20"> 
                          <a href="http://www.udaanindia.com/forms/IVORYCOST.pdf" target="_blank" class="toplinkadmin">IVORYCOAST 
                          VISA FORM</a> </td>
                      </tr>
                      <tr bgcolor="BD402C"> 
                        <td colspan="13" valign="top" height="2"><font face="Verdana" size="6"><b><font color="#FFFFFF"> 
                          <center>
                            <font color="#FFCC00">J</font> 
                          </center>
                          </font></b></font><a name="j"></a></td>
                        <td valign="top" width="86%" height="2">&nbsp;</td>
                      </tr>
                      <tr bgcolor="BD402C"> 
                        <td colspan="13" valign="top" height="2"> 
                          <p class="updatetext"><strong>JAPAN</strong></p>
                        </td>
                        <td valign="top" width="86%" height="2"><img src="images/dnload.gif" width="20" height="20"> 
                          <a href="http://www.udaanindia.com/forms/Japan.pdf" target="_blank" class="toplinkadmin">JAPAN 
                          VISA FORM</a> </td>
                      </tr>
                      <tr bgcolor="BD402C"> 
                        <td colspan="13" valign="top" height="2"> 
                          <p class="updatetext"><strong>JORDAN</strong></p>
                        </td>
                        <td valign="top" width="86%" height="2"><img src="images/dnload.gif" width="20" height="20"> 
                          <a href="http://www.udaanindia.com/forms/Jordan.pdf" target="_blank" class="toplinkadmin">JORDAN 
                          VISA FORM</a> </td>
                      </tr>
                      <tr bgcolor="BD402C"> 
                        <td colspan="13" valign="top" height="2"> 
                          <p class="updatetext"><strong>JAMAICA</strong></p>
                        </td>
                        <td valign="top" width="86%" height="2"><img src="images/dnload.gif" width="20" height="20"> 
                          <a href="http://www.udaanindia.com/forms/JAMAICA.pdf" target="_blank" class="toplinkadmin">JAMAICA 
                          VISA FORM</a> </td>
                      </tr>
                      <tr bgcolor="BD402C"> 
                        <td colspan="13" valign="top" height="2"><font face="Verdana" size="6"><b><font color="#FFFFFF"> 
                          <center>
                            <font color="#FFCC00">K</font> 
                          </center>
                          </font></b></font><a name="k"></a></td>
                        <td valign="top" width="86%" height="2">&nbsp;</td>
                      </tr>
                      <tr bgcolor="BD402C"> 
                        <td colspan="13" valign="top" height="2"> 
                          <p class="updatetext"><strong>KENYA</strong></p>
                        </td>
                        <td valign="top" width="86%" height="2"><img src="images/dnload.gif" width="20" height="20"> 
                          <a href="http://www.udaanindia.com/forms/Kenya.pdf" target="_blank" class="toplinkadmin">KENYA 
                          VISA FORM</a> </td>
                      </tr>
                      <tr bgcolor="BD402C"> 
                        <td colspan="13" valign="top" height="2"> 
                          <p class="updatetext"><strong>KOREA(SOUTH)</strong></p>
                        </td>
                        <td valign="top" width="86%" height="2"><img src="images/dnload.gif" width="20" height="20"> 
                          <a href="http://www.udaanindia.com/forms/Koria(south).pdf" target="_blank" class="toplinkadmin">KOREA(SOUTH) 
                          VISA FORM</a> </td>
                      </tr>
                      <tr bgcolor="BD402C"> 
                        <td colspan="13" valign="top" height="2"> 
                          <p class="updatetext"><strong>KAZAKSTAN</strong></p>
                        </td>
                        <td valign="top" width="86%" height="2"><img src="images/dnload.gif" width="20" height="20"> 
                          <a href="http://www.udaanindia.com/forms/Kazakhstan.pdf" target="_blank" class="toplinkadmin">KAZAKSTAN 
                          VISA FORM</a> </td>
                      </tr>
                      <tr bgcolor="BD402C"> 
                        <td colspan="13" valign="top" height="2"> 
                          <p class="updatetext"><strong>KYRGYZSTAN</strong></p>
                        </td>
                        <td valign="top" width="86%" height="2"><img src="images/dnload.gif" width="20" height="20"> 
                          <a href="http://www.udaanindia.com/forms/KYRGYZ.pdf" target="_blank" class="toplinkadmin">KYRGYZSTAN 
                          VISA FORM</a> </td>
                      </tr>
                      <tr bgcolor="BD402C"> 
                        <td colspan="13" valign="top" height="2"><font face="Verdana" size="6"><b><font color="#FFFFFF"> 
                          <center>
                            <font color="#FFCC00">L</font> 
                          </center>
                          </font></b></font><a name="l"></a> </td>
                        <td valign="top" width="86%" height="2">&nbsp;</td>
                      </tr>
                      <tr bgcolor="BD402C"> 
                        <td colspan="13" valign="top" height="2"> 
                          <p class="updatetext"><strong>LUXEMBOURG</strong></p>
                        </td>
                        <td valign="top" width="86%" height="2"><img src="images/dnload.gif" width="20" height="20"> 
                          <a href="http://www.udaanindia.com/forms/Luxembourg.pdf" target="_blank" class="toplinkadmin"> 
                          LUXEMBOURG VISA FORM</a> </td>
                      </tr>
                      <tr bgcolor="BD402C"> 
                        <td colspan="13" valign="top" height="2"> 
                          <p class="updatetext"><strong>LAOS</strong></p>
                        </td>
                        <td valign="top" width="86%" height="2"><img src="images/dnload.gif" width="20" height="20"> 
                          <a href="http://www.udaanindia.com/forms/Laos.pdf" target="_blank" class="toplinkadmin">LAOS 
                          VISA FORM</a> </td>
                      </tr>
                      <tr bgcolor="BD402C"> 
                        <td colspan="13" valign="top" height="2"> 
                          <p class="updatetext"><strong>LEBANON</strong></p>
                        </td>
                        <td valign="top" width="86%" height="2"><img src="images/dnload.gif" width="20" height="20"> 
                          <a href="http://www.udaanindia.com/forms/Lebanon.pdf" target="_blank" class="toplinkadmin">LEBANON 
                          VISA FORM</a> </td>
                      </tr>
                      <tr bgcolor="BD402C"> 
                        <td colspan="13" valign="top" height="2"> 
                          <p class="updatetext"><strong>LIBYA</strong></p>
                        </td>
                        <td valign="top" width="86%" height="2"><img src="images/dnload.gif" width="20" height="20"> 
                          <a href="http://www.udaanindia.com/forms/Libya.pdf" target="_blank" class="toplinkadmin">LIBYA 
                          VISA FORM</a> </td>
                      </tr>
                      <tr bgcolor="BD402C"> 
                        <td colspan="13" valign="top" height="2"><font face="Verdana" size="6"><b><font color="#FFFFFF"> 
                          <center>
                            <font color="#FFCC00">M</font> 
                          </center>
                          </font></b></font><a name="m"></a></td>
                        <td valign="top" width="86%" height="2">&nbsp;</td>
                      </tr>
                      <tr bgcolor="BD402C"> 
                        <td colspan="13" valign="top" height="2"> 
                          <p class="updatetext"><strong>MALAYSIA</strong></p>
                        </td>
                        <td valign="top" width="86%" height="2"><img src="images/dnload.gif" width="20" height="20"> 
                          <a href="http://www.udaanindia.com/forms/malaysia.pdf" target="_blank" class="toplinkadmin">MALAYSIA 
                          VISA FORM</a> </td>
                      </tr>
                      <tr bgcolor="BD402C"> 
                        <td colspan="13" valign="top" height="2"> 
                          <p class="updatetext"><strong>MALAWI</strong></p>
                        </td>
                        <td valign="top" width="86%" height="2"><img src="images/dnload.gif" width="20" height="20"> 
                          <a href="http://www.udaanindia.com/forms/MALAWI.pdf" target="_blank" class="toplinkadmin">MALAWI 
                          VISA FORM</a> </td>
                      </tr>
                      <tr bgcolor="BD402C"> 
                        <td colspan="13" valign="top" height="2"> 
                          <p class="updatetext"><strong>MAURITIUS</strong></p>
                        </td>
                        <td valign="top" width="86%" height="2"><img src="images/dnload.gif" width="20" height="20"> 
                          <a href="http://www.udaanindia.com/forms/Mauritius.pdf" target="_blank" class="toplinkadmin">MAURITIUS 
                          VISA FORM</a> </td>
                      </tr>
                      <tr bgcolor="BD402C"> 
                        <td colspan="13" valign="top" height="2"> 
                          <p class="updatetext"><strong>MADAGASCAR</strong> 
                        </td>
                        <td valign="top" width="86%" height="2"><img src="images/dnload.gif" width="20" height="20"> 
                          <a href="http://www.udaanindia.com/forms/Madagascar.pdf" target="_blank" class="toplinkadmin">MADAGASCAR 
                          VISA FORM</a></td>
                      </tr>
                      <tr bgcolor="BD402C"> 
                        <td colspan="13" valign="top" height="2"> 
                          <p class="updatetext"><strong>MOROCCO</strong></p>
                        </td>
                        <td valign="top" width="86%" height="2"><img src="images/dnload.gif" width="20" height="20"> 
                          <a href="http://www.udaanindia.com/forms/Morocco.pdf" target="_blank" class="toplinkadmin"> 
                          MOROCCO VISA FORM</a> </td>
                      </tr>
                      <tr bgcolor="BD402C"> 
                        <td colspan="13" valign="top" height="2"> 
                          <p class="updatetext"><strong>MALTA</strong></p>
                        </td>
                        <td valign="top" width="86%" height="2"><img src="images/dnload.gif" width="20" height="20"> 
                          <a href="http://www.udaanindia.com/forms/Malta.pdf" target="_blank" class="toplinkadmin">MALTA 
                          VISA FORM</a> </td>
                      </tr>
                      <tr bgcolor="BD402C"> 
                        <td colspan="13" valign="top" height="2"> 
                          <p class="updatetext"><strong>MEXICO</strong></p>
                        </td>
                        <td valign="top" width="86%" height="2"><img src="images/dnload.gif" width="20" height="20"> 
                          <a href="http://www.udaanindia.com/forms/Mexico.pdf" target="_blank" class="toplinkadmin">MEXICO 
                          VISA FORM</a> </td>
                      </tr>
                      <tr bgcolor="BD402C"> 
                        <td colspan="13" valign="top" height="2"> 
                          <p class="updatetext"><strong>MONGOLIA</strong></p>
                        </td>
                        <td valign="top" width="86%" height="2"><img src="images/dnload.gif" width="20" height="20"> 
                          <a href="http://www.udaanindia.com/forms/Mongolia.pdf" target="_blank" class="toplinkadmin">MONGOLIA 
                          VISA FORM</a> </td>
                      </tr>
                      <tr bgcolor="BD402C"> 
                        <td colspan="13" valign="top" height="2"> 
                          <p class="updatetext"><strong>MOZAMBIQUE</strong></p>
                        </td>
                        <td valign="top" width="86%" height="2"><img src="images/dnload.gif" width="20" height="20"> 
                          <a href="http://www.udaanindia.com/forms/Mozambique.pdf" target="_blank" class="toplinkadmin">MOZAMBIQUE 
                          VISA FORM</a> </td>
                      </tr>
                      <tr bgcolor="BD402C"> 
                        <td colspan="13" valign="top" height="2"> 
                          <p class="updatetext"><strong>MYANMAR</strong></p>
                        </td>
                        <td valign="top" width="86%" height="2"><img src="images/dnload.gif" width="20" height="20"> 
                          <a href="http://www.udaanindia.com/forms/Myanmar-Business.pdf" target="_blank" class="toplinkadmin">MYANMAR 
                          BUSINESS FORM</a> <img src="images/dnload.gif" width="20" height="20"><a href="http://www.udaanindia.com/forms/Myanmar-Tourist.pdf" target="_blank" class="toplinkadmin">MYANMAR 
                          TOURIST FORM</a> </td>
                      </tr>
                      <tr bgcolor="BD402C"> 
                        <td colspan="13" valign="top" height="2"><font face="Verdana" size="6"><b><font color="#FFFFFF"> 
                          <center>
                            <font color="#FFCC00">N</font> 
                          </center>
                          </font></b></font><a name="n"></a> </td>
                        <td valign="top" width="86%" height="2">&nbsp;</td>
                      </tr>
                      <tr bgcolor="BD402C"> 
                        <td colspan="13" valign="top" height="2"> 
                          <p class="updatetext"><strong>NETHERLAND</strong></p>
                        </td>
                        <td valign="top" width="86%" height="2"><img src="images/dnload.gif" width="20" height="20"> 
                          <a href="http://www.udaanindia.com/forms/Netherlands.pdf" target="_blank" class="toplinkadmin">NETHERLAND 
                          VISA FORM</a> <img src="images/dnload.gif" width="20" height="20"> 
                          <a href="http://www.udaanindia.com/forms/Netherlands%20Antilles%20Visa%20Form.pdf" target="_blank" class="toplinkadmin">NETHERLAND 
                          ANTILLES VISA FORM</a> </td>
                      </tr>
                      <tr bgcolor="BD402C"> 
                        <td colspan="13" valign="middle" height="8"> 
                          <p class="updatetext"><strong>NEW ZEALAND</strong></p>
                        </td>
                        <td valign="top" width="86%" height="8"> 
                          <p><img src="images/dnload.gif" width="20" height="20"> 
                            <a href="http://www.udaanindia.com/forms/Newzealand/newzealand%20familysheet.pdf" target="_blank" class="toplinkadmin">NEWZEALAND 
                            FAMILY SHEET FORM</a> <img src="images/dnload.gif" width="20" height="20"><a href="http://www.udaanindia.com/forms/Newzealand/nzis1004-residant%20visa.pdf" target="_blank" class="toplinkadmin">NEWZEALAND 
                            RESIDENT VISA FORM </a><img src="images/dnload.gif" width="20" height="20"><a href="http://www.udaanindia.com/forms/Newzealand/nzis1015-work%20permit.pdf" target="_blank" class="toplinkadmin">NEWZEALAND 
                            WORK PERMIT FORM</a> <img src="images/dnload.gif" width="20" height="20"> 
                            <a href="http://www.udaanindia.com/forms/Newzealand/nzis1017-Tour-Bussi.pdf" target="_blank" class="toplinkadmin"> 
                            BUSINESS AND TOURIST FORM </a><img src="images/dnload.gif" width="20" height="20"><a href="http://www.udaanindia.com/forms/Newzealand/nzis1017-Tour-Bussi.pdf" target="_blank" class="toplinkadmin"> 
                            </a><a href="http://www.udaanindia.com/forms/Newzealand/Newzeland%20Study.pdf" target="_blank" class="toplinkadmin">NEWZEALAND 
                            STUDY FORM</a><a href="http://www.udaanindia.com/forms/Newzealand/nzis1017-Tour-Bussi.pdf" target="_blank" class="toplinkadmin"> 
                            <br>
                            </a><a href="http://www.udaanindia.com/forms/Newzealand/nzis1017-Tour-Bussi.pdf" target="_blank" class="toplinkadmin"> 
                            </a><img src="images/dnload.gif" width="20" height="20"> 
                            <a href="http://www.udaanindia.com/forms/Newzealand/Newzeland%20Transit.pdf" target="_blank" class="toplinkadmin">NEWZEALAND 
                            TRANSIT VISA FORM</a> </p>
                        </td>
                      </tr>
                      <tr bgcolor="BD402C"> 
                        <td colspan="13" valign="middle" height="2"> 
                          <p class="updatetext"><strong>NORWAY</strong></p>
                        </td>
                        <td valign="top" width="86%" height="2"> 
                          <p><img src="images/dnload.gif" width="20" height="20"> 
                            <a href="http://www.udaanindia.com/forms/Norway%20Additional%20Form.pdf" target="_blank" class="toplinkadmin">NORWAY 
                            ADDITIONAL FORM</a> <img src="images/dnload.gif" width="20" height="20"><a href="http://www.udaanindia.com/forms/norway%20residence%20or%20work%20permit.pdf" target="_blank" class="toplinkadmin">NORWAY 
                            RESIDENCE OR WORK FORM </a><img src="images/dnload.gif" width="20" height="20"><a href="http://www.udaanindia.com/forms/norway%20residence%20or%20work%20permit.pdf" target="_blank" class="toplinkadmin"> 
                            </a><a href="http://www.udaanindia.com/forms/NORWAY.pdf" target="_blank" class="toplinkadmin">NORWAY 
                            VISA FORM</a><a href="http://www.udaanindia.com/forms/norway%20residence%20or%20work%20permit.pdf" target="_blank" class="toplinkadmin"> 
                            </a><img src="images/dnload.gif" width="20" height="20"><a href="http://www.udaanindia.com/forms/norway-attorney.pdf" target="_blank" class="toplinkadmin">NORWAY 
                            POWER OF ATTORNEY</a></p>
                        </td>
                      </tr>
                      <tr bgcolor="BD402C"> 
                        <td colspan="13" valign="top" height="2"> 
                          <p class="updatetext"><strong>NAMIBIA</strong></p>
                        </td>
                        <td valign="top" width="86%" height="2"><img src="images/dnload.gif" width="20" height="20"> 
                          <a href="http://www.udaanindia.com/forms/Namibia.pdf" target="_blank" class="toplinkadmin">NAMIBIA 
                          VISA FORM</a> </td>
                      </tr>
                      <tr bgcolor="BD402C"> 
                        <td colspan="13" valign="top" height="2"> 
                          <p class="updatetext"><strong>NEPAL</strong></p>
                        </td>
                        <td valign="top" width="86%" height="2"><img src="images/dnload.gif" width="20" height="20"> 
                          <a href="http://www.udaanindia.com/forms/nepal.pdf" target="_blank" class="toplinkadmin"> 
                          NEPAL VISA FORM</a> </td>
                      </tr>
                      <tr bgcolor="BD402C"> 
                        <td colspan="13" valign="top" height="2"> 
                          <p class="updatetext"><strong>NICARAGUA</strong></p>
                        </td>
                        <td valign="top" width="86%" height="2"><img src="images/dnload.gif" width="20" height="20"> 
                          <a href="http://www.udaanindia.com/forms/Nicaragua.pdf" target="_blank" class="toplinkadmin">NICARAGUA 
                          VISA FORM</a> </td>
                      </tr>
                      <tr bgcolor="BD402C"> 
                        <td colspan="13" valign="middle" height="20"> 
                          <p class="updatetext"><strong>NIGERIA</strong></p>
                        </td>
                        <td valign="top" width="86%" height="20"><img src="images/dnload.gif" width="20" height="20"> 
                          <a href="http://www.udaanindia.com/forms/Nigeria.pdf" target="_blank" class="toplinkadmin">NIGERIA 
                          VISA FORM</a><a href="http://www.udaanindia.com/forms/Nigeria%20Work,Dependent,twp-entry%20permit.pdf" target="_blank" class="toplinkadmin"> 
                          </a><img src="images/dnload.gif" width="20" height="20"> 
                          <a href="http://www.udaanindia.com/forms/NIGERIA%20STR%20EMPLOYMENT%20FORM.pdf" target="_blank" class="toplinkadmin">NIGERIA 
                          STR EMPLOYMENT FORM <br>
                          </a><img src="images/dnload.gif" width="20" height="20"> 
                          <a href="http://www.udaanindia.com/forms/NIGERIA%20STR%20SPOUSE%20OR%20FAMILY%20MEMBER%20FORM.pdf" target="_blank" class="toplinkadmin">NIGERIA 
                          STR SPOUSE OR FAMILY MEMBER FORM</a> </td>
                      </tr>
                      <tr bgcolor="BD402C"> 
                        <td colspan="13" valign="top" height="23"><font face="Verdana" size="6"><b><font color="#FFFFFF"> 
                          <center>
                            <font color="#FFCC00">O</font> 
                          </center>
                          </font></b></font><a name="o"></a></td>
                        <td valign="top" width="86%" height="23">&nbsp;</td>
                      </tr>
                      <tr bgcolor="BD402C"> 
                        <td colspan="13" valign="top" height="2"> 
                          <p class="updatetext"><strong>OMAN</strong></p>
                        </td>
                        <td valign="top" width="86%" height="2"><img src="images/dnload.gif" width="20" height="20"> 
                          <a href="http://www.udaanindia.com/forms/Oman04.pdf" target="_blank" class="toplinkadmin">OMAN 
                          VISA FORM</a> </td>
                      </tr>
                      <tr bgcolor="BD402C"> 
                        <td colspan="13" valign="top" height="2"><font face="Verdana" size="6"><b><font color="#FFFFFF"> 
                          <center>
                            <font color="#FFCC00">P</font> 
                          </center>
                          </font></b></font><a name="p"></a></td>
                        <td valign="top" width="86%" height="2">&nbsp;</td>
                      </tr>
                      <tr bgcolor="BD402C"> 
                        <td colspan="13" valign="top" height="2"> 
                          <p class="updatetext"><strong>PHILIPPINES</strong></p>
                        </td>
                        <td valign="top" width="86%" height="2"><img src="images/dnload.gif" width="20" height="20"> 
                          <a href="http://www.udaanindia.com/forms/Phillipines.pdf" target="_blank" class="toplinkadmin">PHILIPPINES 
                          VISA FORM</a> <img src="images/dnload.gif" width="20" height="20"><a href="http://www.udaanindia.com/forms/Phillipines%20Medical%20visa%20form.pdf" target="_blank" class="toplinkadmin">PHILIPPINES 
                          MEDICAL VISA FORM</a> </td>
                      </tr>
                      <tr bgcolor="BD402C"> 
                        <td colspan="13" valign="top" height="2"> 
                          <p class="updatetext"><strong>PORTUGAL</strong></p>
                        </td>
                        <td valign="top" width="86%" height="2"><img src="images/dnload.gif" width="20" height="20"><a href="http://www.udaanindia.com/forms/PORTUGAL.pdf" target="_blank" class="toplinkadmin">PORTUGAL 
                          VISA FORM</a> </td>
                      </tr>
                      <tr bgcolor="BD402C"> 
                        <td colspan="13" valign="top" height="2"> 
                          <p class="updatetext"><strong>PARAGUAY</strong></P>
                        </td>
                        <td valign="top" width="86%" height="2"><img src="images/dnload.gif" width="20" height="20"><a href="http://www.udaanindia.com/forms/PARAGUAY.pdf" target="_blank" class="toplinkadmin">PARAGUAY 
                          VISA FORM</a></td>
                      </tr>
                      <tr bgcolor="BD402C"> 
                        <td colspan="13" valign="top" height="2"> 
                          <p class="updatetext"><strong>PERU</strong></p>
                        </td>
                        <td valign="top" width="86%" height="2"><img src="images/dnload.gif" width="20" height="20"> 
                          <a href="http://www.udaanindia.com/forms/Peru.pdf" target="_blank" class="toplinkadmin">PERU 
                          VISA FORM</a> </td>
                      </tr>
                      <tr bgcolor="BD402C"> 
                        <td colspan="13" valign="top" height="26"> 
                          <p class="updatetext"><strong>PAKISTAN</strong></p>
                        </td>
                        <td valign="top" width="86%" height="26"><img src="images/dnload.gif" width="20" height="19"> 
                          <a href="http://www.udaanindia.com/forms/Pakistan.pdf" target="_blank" class="toplinkadmin">PAKISTAN 
                          BUSINESS VISA FORM</a> <img src="images/dnload.gif" width="20" height="20"><a href="http://www.udaanindia.com/forms/Pakistan-non-indians.pdf" target="_blank" class="toplinkadmin">PAKISTAN 
                          FOREIGN NATIONAL FORM</a> <img src="images/dnload.gif" width="20" height="19"> 
                          <a href="http://www.udaanindia.com/forms/PAKISTAN%20TOURIST%20FORM.pdf" target="_blank" class="toplinkadmin">PAKISTAN 
                          TOURIST VISA FORM</a> </td>
                      </tr>
                      <tr bgcolor="BD402C"> 
                        <td colspan="13" valign="top" height="2"> 
                          <p class="updatetext"><strong>PAPUA NEW GUINEA</strong></p>
                        </td>
                        <td valign="top" width="86%" height="2"><img src="images/dnload.gif" width="20" height="20"> 
                          <a href="http://www.udaanindia.com/forms/PAPUA%20NEW%20GUINEA.pdf" target="_blank" class="toplinkadmin">PAPUA 
                          NEW GUINEA VISA FORM</a> </td>
                      </tr>
                      <tr bgcolor="BD402C"> 
                        <td colspan="13" valign="top" height="2"> 
                          <p class="updatetext"><strong>PANAMA</strong></p>
                        </td>
                        <td valign="top" width="86%" height="2"><img src="images/dnload.gif" width="20" height="20"> 
                          <a href="http://www.udaanindia.com/forms/Panama.pdf" target="_blank" class="toplinkadmin">PANAMA 
                          VISA FORM</a> </td>
                      </tr>
                      <tr bgcolor="BD402C"> 
                        <td colspan="13" valign="top" height="2"> 
                          <p class="updatetext"><strong>POLAND</strong></p>
                        </td>
                        <td valign="top" width="86%" height="2"><img src="images/dnload.gif" width="20" height="20"> 
                          <a href="http://www.udaanindia.com/forms/POLAND.pdf" target="_blank" class="toplinkadmin">POLAND 
                          VISA FORM</a> </td>
                      </tr>
                      <tr bgcolor="BD402C"> 
                        <td colspan="13" valign="top" height="2"><font face="Verdana" size="6"><b><font color="#FFFFFF"> 
                          <center>
                            <font color="#FFCC00">R</font> 
                          </center>
                          </font></b></font><a name="r"></a></td>
                        <td valign="top" width="86%" height="2">&nbsp;</td>
                      </tr>
                      <tr bgcolor="BD402C"> 
                        <td colspan="13" valign="top" height="2"> 
                          <p class="updatetext"><strong>RUSSIA</strong></p>
                        </td>
                        <td valign="top" width="86%" height="2"><img src="images/dnload.gif" width="20" height="20"> 
                          <a href="http://www.udaanindia.com/forms/Russia.pdf" target="_blank" class="toplinkadmin">RUSSIA 
                          VISA FORM</a> </td>
                      </tr>
                      <tr bgcolor="BD402C"> 
                        <td colspan="13" valign="top" height="2"> 
                          <p class="updatetext"><strong>RWANDA</strong></p>
                        </td>
                        <td valign="top" width="86%" height="2"><img src="images/dnload.gif" width="20" height="20"> 
                          <a href="http://www.udaanindia.com/forms/Rwanda_all.pdf" target="_blank" class="toplinkadmin">RWANDA 
                          VISA FORM</a> </td>
                      </tr>
                      <tr bgcolor="BD402C"> 
                        <td colspan="13" valign="top" height="2"> 
                          <p class="updatetext"><strong>ROMANIA</strong></p>
                        </td>
                        <td valign="top" width="86%" height="2"><img src="images/dnload.gif" width="20" height="20"> 
                          <a href="http://www.udaanindia.com/forms/Romania.pdf" target="_blank" class="toplinkadmin">ROMANIA 
                          VISA FORM</a> </td>
                      </tr>
                      <tr bgcolor="BD402C"> 
                        <td colspan="13" valign="top" height="2"><font face="Verdana" size="6"><b><font color="#FFFFFF"> 
                          <center>
                            <font color="#FFCC00">S</font> 
                          </center>
                          </font></b></font><a name="s"></a></td>
                        <td valign="top" width="86%" height="2">&nbsp;</td>
                      </tr>
                      <tr bgcolor="BD402C"> 
                        <td colspan="13" valign="top" height="2"> 
                          <p class="updatetext"><strong>SINGAPORE</strong></p>
                        </td>
                        <td valign="top" width="86%" height="2"><img src="images/dnload.gif" width="20" height="20"> 
                          <a href="http://www.udaanindia.com/forms/singapore.pdf" target="_blank" class="toplinkadmin">SINGAPORE 
                          VISA FORM</a> </td>
                      </tr>
                      <tr bgcolor="BD402C"> 
                        <td colspan="13" valign="middle" height="40"> 
                          <p class="updatetext"><strong>SOUTH AFRICA</strong></p>
                        </td>
                        <td valign="top" width="86%" height="40"> 
                          <p><img src="images/dnload.gif" width="20" height="20"> 
                            <a href="http://www.udaanindia.com/forms/safrica/safrica.pdf" target="_blank" class="toplinkadmin">SOUTH 
                            AFRICA VISA FORM</a> <img src="images/dnload.gif" width="20" height="20"><a href="http://www.udaanindia.com/forms/safrica/safrica-tourist.pdf" target="_blank" class="toplinkadmin"> 
                            TOURIST VISA FORM (PAGE 1)<br>
                            </a><img src="images/dnload.gif" width="20" height="20"><a href="http://www.udaanindia.com/forms/safrica/safrica2-tourist.pdf" target="_blank" class="toplinkadmin">TOURIST 
                            VISA FORM (PAGE 2) </a><img src="images/dnload.gif" width="20" height="20"> 
                            <a href="http://www.udaanindia.com/forms/safrica/WORK-STUDY-PERMIT.pdf" target="_blank" class="toplinkadmin"> 
                            WORK AND STUDY PERMIT FORM</a> <img src="images/dnload.gif" width="20" height="20"> 
                            <a href="http://www.udaanindia.com/forms/safrica/S.Africa%20Medical%20and%20Radiological%20Report.pdf" target="_blank" class="toplinkadmin">SOUTH 
                            AFRICA MEDICAL AND RADIOLOGICA REPORT</a><a href="http://www.udaanindia.com/forms/safrica/safrica.pdf" target="_blank" class="toplinkadmin"> 
                            </a> </p>
                        </td>
                      </tr>
                      <tr bgcolor="BD402C"> 
                        <td colspan="13" valign="top" height="2"> 
                          <p class="updatetext"><strong>SPAIN</strong></p>
                        </td>
                        <td valign="top" width="86%" height="2"><img src="images/dnload.gif" width="20" height="20"> 
                          <a href="http://www.udaanindia.com/forms/SPAIN.pdf" target="_blank" class="toplinkadmin">SPAIN 
                          VISA FORM</a> <img src="images/dnload.gif" width="20" height="20"> 
                          <a href="http://www.udaanindia.com/forms/Spain%20Authorisation%20Letter.PDF" target="_blank" class="toplinkadmin">SPAIN 
                          AUTHORIZATION FORM</a> </td>
                      </tr>
                      <tr bgcolor="BD402C"> 
                        <td colspan="13" valign="top" height="2"> 
                          <p class="updatetext"><strong>SRI LANKA</strong></p>
                        </td>
                        <td valign="top" width="86%" height="2"><img src="images/dnload.gif" width="20" height="20"> 
                          <a href="http://www.udaanindia.com/forms/Srilanka.pdf" target="_blank" class="toplinkadmin">SRI 
                          LANKA VISA FORM</a> </td>
                      </tr>
                      <tr bgcolor="BD402C"> 
                        <td colspan="13" valign="middle" height="22"> 
                          <p class="updatetext"><strong>SWEDEN</strong></p>
                        </td>
                        <td valign="top" width="86%" height="22"> 
                          <p><img src="images/dnload.gif" width="20" height="20"> 
                            <a href="http://www.udaanindia.com/forms/sweden/appendix-A-Business.pdf" target="_blank" class="toplinkadmin">APPENDIX- 
                            A FORM</a> <img src="images/dnload.gif" width="20" height="20"> 
                            <a href="http://www.udaanindia.com/forms/sweden/appendix-B-Tourist.pdf" target="_blank" class="toplinkadmin">APPENDIX- 
                            B FORM</a> <img src="images/dnload.gif" width="20" height="20"><a href="http://www.udaanindia.com/forms/sweden/appendix-D.pdf" target="_blank" class="toplinkadmin">APPENDIX- 
                            D FORM</a> <br>
                            <img src="images/dnload.gif" width="20" height="20"> 
                            <a href="http://www.udaanindia.com/forms/sweden/workpermit.pdf" target="_blank" class="toplinkadmin">WORK 
                            PERMIT VISA FORM</a> <img src="images/dnload.gif" width="20" height="20"><a href="http://www.udaanindia.com/forms/sweden/entryvisa.pdf" target="_blank" class="toplinkadmin">ENTRY 
                            VISA FORM</a> <img src="images/dnload.gif" width="20" height="20"> 
                            <a href="http://www.udaanindia.com/forms/sweden/SWEDEN%20RESIDENCE%20VISA%20FORM.pdf" target="_blank" class="toplinkadmin">RESIDENCE 
                            VISA FORM</a> <img src="images/dnload.gif" width="20" height="20"> 
                            <a href="http://www.udaanindia.com/forms/sweden/POWER%20OF%20ATTORNEY.pdf" target="_blank" class="toplinkadmin">POWER 
                            OF ATTORNEY</a> </p>
                        </td>
                      </tr>
                      <tr bgcolor="BD402C"> 
                        <td colspan="13" valign="top" height="2"> 
                          <p class="updatetext"><strong>SWITZERLAND</strong></p>
                        </td>
                        <td valign="top" width="86%" height="2"><img src="images/dnload.gif" width="20" height="20"> 
                          <a href="http://www.udaanindia.com/forms/switzerland.pdf" target="_blank" class="toplinkadmin">SWITZERLAND 
                          VISA FORM</a> </td>
                      </tr>
                      <tr bgcolor="BD402C"> 
                        <td colspan="13" valign="top" height="2"> 
                          <p class="updatetext"><strong>SLOVENIA</strong></p>
                        </td>
                        <td valign="top" width="86%" height="2"><img src="images/dnload.gif" width="20" height="20"> 
                          <a href="http://www.udaanindia.com/forms/SlovENIA.pdf" target="_blank" class="toplinkadmin">SLOVENIA 
                          VISA FORM</a> </td>
                      </tr>
                      <tr bgcolor="BD402C"> 
                        <td colspan="13" valign="top" height="2"> 
                          <p class="updatetext"><strong>SLOVAKIA</strong></p>
                        </td>
                        <td valign="top" width="86%" height="2"><img src="images/dnload.gif" width="20" height="20"> 
                          <a href="http://www.udaanindia.com/forms/Slovakia.pdf" target="_blank" class="toplinkadmin">SLOVAKIA 
                          VISA FORM</a> </td>
                      </tr>
                      <tr bgcolor="BD402C"> 
                        <td colspan="13" valign="top" height="2"> 
                          <p class="updatetext"><strong>SENEGAL</strong></p>
                        </td>
                        <td valign="top" width="86%" height="2"><img src="images/dnload.gif" width="20" height="20"> 
                          <a href="http://www.udaanindia.com/forms/Senegal.pdf" target="_blank" class="toplinkadmin">SENEGAL 
                          VISA FORM</a> </td>
                      </tr>
                      <tr bgcolor="BD402C"> 
                        <td colspan="13" valign="top" height="2"> 
                          <p class="updatetext"><strong>SERBIA</strong></P>
                        </td>
                        <td valign="top" width="86%" height="2"><img src="images/dnload.gif" width="20" height="20"> 
                          <a href="http://www.udaanindia.com/forms/SERBIA%20FORM.pdf" target="_blank" class="toplinkadmin">SERBIA 
                          VISA FORM</a> </td>
                      </tr>
                      <tr bgcolor="BD402C"> 
                        <td colspan="13" valign="top" height="2"> 
                          <p class="updatetext"><strong>SUDAN</strong></p>
                        </td>
                        <td valign="top" width="86%" height="2"><img src="images/dnload.gif" width="20" height="20"> 
                          <a href="http://www.udaanindia.com/forms/SUDAN.pdf" target="_blank" class="toplinkadmin">SUDAN 
                          VISA FORM</a> </td>
                      </tr>
                      <tr bgcolor="BD402C"> 
                        <td colspan="13" valign="top" height="2"> 
                          <p class="updatetext"><strong>SYRIA</strong></p>
                        </td>
                        <td valign="top" width="86%" height="2"><img src="images/dnload.gif" width="20" height="20"> 
                          <a href="http://www.udaanindia.com/forms/Syria.pdf" target="_blank" class="toplinkadmin">SYRIA 
                          VISA FORM</a> </td>
                      </tr>
                      <tr bgcolor="BD402C"> 
                        <td colspan="13" valign="top" height="2"> 
                          <p class="updatetext"><strong>SAUDI ARABIA</strong></p>
                        </td>
                        <td valign="top" width="86%" height="2"><img src="images/dnload.gif" width="20" height="20"> 
                          <a href="http://www.udaanindia.com/forms/saudi.pdf" target="_blank" class="toplinkadmin">SAUDI 
                          ARABIA VISA FORM</a> </td>
                      </tr>
                      <tr bgcolor="BD402C"> 
                        <td colspan="13" valign="top" height="2"><font face="Verdana" size="6"><b><font color="#FFFFFF"> 
                          <center>
                            <font color="#FFCC00">T</font> 
                          </center>
                          </font></b></font><a name="t"></a></td>
                        <td valign="top" width="86%" height="2">&nbsp;</td>
                      </tr>
                      <tr bgcolor="BD402C"> 
                        <td colspan="13" valign="top" height="2"> 
                          <p class="updatetext"><strong>THAILAND</strong></p>
                        </td>
                        <td valign="top" width="86%" height="2"><img src="images/dnload.gif" width="21" height="20"> 
                          <a href="http://www.udaanindia.com/forms/Thailand.pdf" target="_blank" class="toplinkadmin">THAILAND 
                          VISA FORM</a> </td>
                      </tr>
                      <tr bgcolor="BD402C"> 
                        <td colspan="13" valign="top" height="2"> 
                          <p class="updatetext"><strong>TAIWAN</strong></p>
                        </td>
                        <td valign="top" width="86%" height="2"><img src="images/dnload.gif" width="21" height="20"> 
                          <a href="http://www.udaanindia.com/forms/TAIWAN.pdf" target="_blank" class="toplinkadmin">TAIWAN 
                          VISA FORM</a> </td>
                      </tr>
                      <tr bgcolor="BD402C"> 
                        <td colspan="13" valign="top" height="2"> 
                          <p class="updatetext"><strong>TANZANIA</strong></p>
                        </td>
                        <td valign="top" width="86%" height="2"><img src="images/dnload.gif" width="21" height="20"> 
                          <a href="http://www.udaanindia.com/forms/Tanzania.pdf" target="_blank" class="toplinkadmin">TANZANIA 
                          VISA FORM</a> </td>
                      </tr>
                      <tr bgcolor="BD402C"> 
                        <td colspan="13" valign="top" height="2"> 
                          <p class="updatetext"><strong>TURKEY</strong></p>
                        </td>
                        <td valign="top" width="86%" height="2"><img src="images/dnload.gif" width="21" height="20"> 
                          <a href="http://www.udaanindia.com/forms/Turkey.pdf" target="_blank" class="toplinkadmin">TURKEY 
                          VISA FORM</a> </td>
                      </tr>
                      <tr bgcolor="BD402C"> 
                        <td colspan="13" valign="top" height="2"> 
                          <p class="updatetext"><strong>TRINIDAD &amp; TOBAGO</strong></p>
                        </td>
                        <td valign="top" width="86%" height="2"><img src="images/dnload.gif" width="21" height="20"> 
                          <a href="http://www.udaanindia.com/forms/Trinidad.pdf" target="_blank" class="toplinkadmin">TRINIDAD 
                          &amp; TOBAGO VISA FORM</a> </td>
                      </tr>
                      <tr bgcolor="BD402C"> 
                        <td colspan="13" valign="top" height="2"> 
                          <p class="updatetext"><strong>TUNISIA</strong></p>
                        </td>
                        <td valign="top" width="86%" height="2"><img src="images/dnload.gif" width="21" height="20"> 
                          <a href="http://www.udaanindia.com/forms/Tunisia.pdf" target="_blank" class="toplinkadmin">TUNISIA 
                          VISA FORM</a> <img src="images/dnload.gif" width="21" height="20"> 
                          <a href="http://www.udaanindia.com/forms/Tunisia%20Additional%20Sheet.pdf" target="_blank" class="toplinkadmin">TUNISIA 
                          ADDITIONAL SHEET FOR BUSINESS VISA </a></td>
                      </tr>
                      <tr bgcolor="BD402C"> 
                        <td colspan="13" valign="top" height="2"> 
                          <p class="updatetext"><strong>TURKMENISTAN</strong> 
                        </td>
                        <td valign="top" width="86%" height="2"><img src="images/dnload.gif" width="21" height="20"> 
                          <a href="http://www.udaanindia.com/forms/TURKMENISTAN.pdf" target="_blank" class="toplinkadmin">TURKMENISTAN 
                          VISA FORM</a> </td>
                      </tr>
                      <tr bgcolor="BD402C"> 
                        <td colspan="13" valign="top" height="2"><font face="Verdana" size="6"><b><font color="#FFFFFF"> 
                          <center>
                            <font color="#FFCC00">U</font> 
                          </center>
                          </font></b></font><a name="u"></a></td>
                        <td valign="top" width="86%" height="2">&nbsp;</td>
                      </tr>
                      <tr bgcolor="BD402C"> 
                        <td colspan="13" valign="middle" height="29"> 
                          <p class="updatetext"><strong>UNITED KINGDOM</strong></p>
                        </td>
                        <td valign="top" width="86%" height="29"> 
                          <p><img src="images/dnload.gif" width="21" height="20"> 
                            <a href="http://www.udaanindia.com/forms/UK/VAF1%202006%20NON-SETTLE,T,B,S.pdf" target="_blank" class="toplinkadmin">BUSINESS,TOURIST 
                            AND STUDENT ( STUDENT LESS THAN SIX MONTHS ) FORM</a> 
                            <img src="images/dnload.gif" width="21" height="19"> 
                            <a href="http://www.udaanindia.com/forms/UK/Transit.pdf" target="_blank" class="toplinkadmin">TRANSIT 
                            VISA FORM <br>
                            </a><img src="images/dnload.gif" width="20" height="20"><a href="http://www.udaanindia.com/forms/UK/VAF2%20-%20Settlement.pdf" target="_blank" class="toplinkadmin">PERMANENT 
                            RESIDENCE FORM</a> <img src="images/dnload.gif" width="21" height="20"><a href="http://www.udaanindia.com/forms/UK/STUDENT%20QUESTIONNAIRE%20FORM.pdf" target="_blank" class="toplinkadmin">STUDENT 
                            QUESTIONNAIRE FORM</a> <img src="images/dnload.gif" width="20" height="20"> 
                            <a href="http://www.udaanindia.com/forms/UK/UK%20CHILD%20VISA%20FORM.pdf" target="_blank" class="toplinkadmin">MINOR 
                            VISA FORM</a> <img src="images/dnload.gif" width="20" height="20"><a href="http://www.udaanindia.com/forms/UK/ADDITIONAL%20WORK%20PERMIT.pdf" target="_blank" class="toplinkadmin"> 
                            ADDITIONAL WORK PERMIT FORM</a> <img src="images/dnload.gif" width="20" height="20"> 
                            <a href="http://www.udaanindia.com/forms/UK/ADDITIONAL%20DOMESTIC%20WORKER.pdf" target="_blank" class="toplinkadmin">ADDITIONAL 
                            DOMESTIC WORKER FORM</a> <img src="images/dnload.gif" width="20" height="20"> 
                            <a href="http://www.udaanindia.com/forms/UK/STUDENT%20MORE%20THAT%20SIX%20MONTHS.pdf" target="_blank" class="toplinkadmin">STUDENT( 
                            MORE THAT SIX MONTHS ) VISA FORM</a> <img src="images/dnload.gif" width="20" height="20"> 
                            <a href="http://www.udaanindia.com/forms/UK/WORK%20PERMIT.pdf" target="_blank" class="toplinkadmin">WORK 
                            PERMIT VISA FORM</a></p>
                        </td>
                      </tr>
                      <tr bgcolor="BD402C"> 
                        <td colspan="13" valign="top" height="2"> 
                          <p class="updatetext"><strong>U.S.A.</strong></p>
                        </td>
                        <td valign="top" width="86%" height="2"><img src="images/dnload.gif" width="21" height="20"> 
                          <a href="http://www.udaanindia.com/forms/USA/DS156-nonimegrant%20visa%20form.pdf" target="_blank" class="toplinkadmin">NON-IMMIGRANT 
                          VISA FORM</a> <img src="images/dnload.gif" width="21" height="20"> 
                          <a href="http://www.udaanindia.com/forms/USA/DS-0157-supplement%20nonimegrant.pdf" target="_blank" class="toplinkadmin">SUPPLEMENT 
                          NON-IMMIGRANT VISA FORM</a> </td>
                      </tr>
                      <tr bgcolor="BD402C"> 
                        <td colspan="13" valign="top" height="2"> 
                          <p class="updatetext"><strong>UGANDA</strong></p>
                        </td>
                        <td valign="top" width="86%" height="2"><img src="images/dnload.gif" width="21" height="20"> 
                          <a href="http://www.udaanindia.com/forms/Uganda.pdf" target="_blank" class="toplinkadmin">UGANDA 
                          VISA FORM</a> </td>
                      </tr>
                      <tr bgcolor="BD402C"> 
                        <td colspan="13" valign="top" height="2"> 
                          <p class="updatetext"><strong>UKRAINE</strong></p>
                        </td>
                        <td valign="top" width="86%" height="2"><img src="images/dnload.gif" width="21" height="20"> 
                          <a href="http://www.udaanindia.com/forms/UKRAINE.pdf" target="_blank" class="toplinkadmin">UKRAINE 
                          VISA FORM</a> </td>
                      </tr>
                      <tr bgcolor="BD402C"> 
                        <td colspan="13" valign="top" height="2"> 
                          <p class="updatetext"><strong>URUGUAY</strong></p>
                        </td>
                        <td valign="top" width="86%" height="2"><img src="images/dnload.gif" width="21" height="20"> 
                          <a href="http://www.udaanindia.com/forms/Uruguary.pdf" target="_blank" class="toplinkadmin">URUGUAY 
                          VISA FORM</a> </td>
                      </tr>
                      <tr bgcolor="BD402C"> 
                        <td colspan="13" valign="top" height="2"> 
                          <p class="updatetext"><strong>UZBEKISTAN</strong></p>
                        </td>
                        <td valign="top" width="86%" height="2"><img src="images/dnload.gif" width="21" height="20"> 
                          <a href="http://www.udaanindia.com/forms/Uzbekistan1.pdf" target="_blank" class="toplinkadmin">UZBEKISTAN 
                          VISA FORM( PAGE 1)</a> <img src="images/dnload.gif" width="21" height="20"><a href="http://www.udaanindia.com/forms/Uzbekistan2.pdf" target="_blank" class="toplinkadmin">UZBEKISTAN 
                          VISA FORM( PAGE 2)</a> </td>
                      </tr>
                      <tr bgcolor="BD402C"> 
                        <td colspan="13" valign="top" height="2"><font face="Verdana" size="6"><b><font color="#FFFFFF"> 
                          <center>
                            <font color="#FFCC00">V</font> 
                          </center>
                          </font></b></font><a name="v"></a></td>
                        <td valign="top" width="86%" height="2">&nbsp;</td>
                      </tr>
                      <tr bgcolor="BD402C"> 
                        <td colspan="13" valign="top" height="2"> 
                          <p class="updatetext"><strong>VIETNAM</strong></p>
                        </td>
                        <td valign="top" width="86%" height="2"><img src="images/dnload.gif" width="21" height="20"> 
                          <a href="http://www.udaanindia.com/forms/vietnam.pdf" target="_blank" class="toplinkadmin">VIETNAM 
                          VISA FORM</a> </td>
                      </tr>
                      <tr bgcolor="BD402C"> 
                        <td colspan="13" valign="top" height="2"> 
                          <p class="updatetext"><strong>VENEZUELA</strong></p>
                        </td>
                        <td valign="top" width="86%" height="2"><img src="images/dnload.gif" width="21" height="20"> 
                          <a href="http://www.udaanindia.com/forms/Venejuela.pdf" target="_blank" class="toplinkadmin">VENEZUELA 
                          VISA FORM</a> </td>
                      </tr>
                      <tr bgcolor="BD402C"> 
                        <td colspan="13" valign="top" height="2"><font face="Verdana"><b><font color="#FFFFFF" size="6"> 
                          <center>
                            <font color="#FFCC00">Y</font> 
                          </center>
                          </font></b></font><a name="y"></a></td>
                        <td valign="top" width="86%" height="2">&nbsp;</td>
                      </tr>
                      <tr bgcolor="BD402C"> 
                        <td colspan="13" valign="top" height="2"> 
                          <p class="updatetext"><strong>YEMEN</strong></p>
                        </td>
                        <td valign="top" width="86%" height="2"><img src="images/dnload.gif" width="21" height="20"> 
                          <a href="http://www.udaanindia.com/forms/Yamen.pdf" target="_blank" class="toplinkadmin">YEMEN 
                          VISA FORM</a> </td>
                      </tr>
                      <tr bgcolor="BD402C"> 
                        <td colspan="13" valign="top" height="2"><font face="Verdana" size="6"><b><font color="#FFFFFF"> 
                          <center>
                            <font color="#FFCC00">Z</font> 
                          </center>
                          </font></b></font><a name="z"></a></td>
                        <td valign="top" width="86%" height="2" bgcolor="BD402C">&nbsp;</td>
                      </tr>
                      <tr bgcolor="BD402C"> 
                        <td colspan="13" valign="top" height="2"> 
                          <p class="updatetext"><strong>ZIMBABWE</strong></p>
                        </td>
                        <td valign="top" width="86%" height="2"><img src="images/dnload.gif" width="21" height="20"> 
                          <a href="http://www.udaanindia.com/forms/zimbabwe.pdf" target="_blank" class="toplinkadmin">ZIMBABWE 
                          VISA FORM</a> </td>
                      </tr>
                      <tr bgcolor="BD402C"> 
                        <td colspan="13" valign="top" height="2"> 
                          <p class="updatetext"><strong>ZAMBIA</strong></p>
                        </td>
                        <td valign="top" width="86%" height="2"><img src="images/dnload.gif" width="21" height="20"> 
                          <a href="http://www.udaanindia.com/forms/Zambia.pdf" target="_blank" class="toplinkadmin">ZAMBIA 
                          VISA FORM</a> </td>
                      </tr>
                    </table>
                  </td>
                </tr>
              </table>
            </td>
                    </tr>
                  </table>
                  </tr>
</td>
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
