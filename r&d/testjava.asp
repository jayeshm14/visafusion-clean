<HTML><HEAD><TITLE></TITLE>
<style>.spanstyle {
	COLOR: RED; FONT-FAMILY: Verdana; FONT-SIZE: 8pt; FONT-WEIGHT: bold; POSITION: absolute; TOP: -50px; VISIBILITY: visible
}
</style>
<SCRIPT LANGUAGE="JavaScript">
<!-- Begin
var x, y;
var step = 10;
var flag = 0;

var message = "UDAAN INDIA PVT. LTD. ";
message = message.split("");
var xpos = new Array();
for (i = 0; i <= message.length - 1; i++) {
xpos[i] = -50;
}
var ypos = new Array();
for (i = 0; i <= message.length - 1; i++) {
ypos[i]= -50;
}
function handlerMM(e) {
x = (document.layers) ? e.pageX : document.body.scrollLeft + event.clientX;
y = (document.layers) ? e.pageY : document.body.scrollTop + event.clientY;
flag = 1;
}
function makesnake() {
if (flag == 1 && document.all) {
for (i = message.length - 1; i >= 1; i--) {
xpos[i] = xpos[i - 1] + step;
ypos[i] = ypos[i - 1];
}
xpos[0] = x + step;
ypos[0] = y;
for (i = 0; i < message.length - 1; i++) {
var thisspan = eval("span" + (i) + ".style");
thisspan.posLeft = xpos[i];
thisspan.posTop = ypos[i];
   }
}
else if (flag==1 && document.layers) {
for (i = message.length - 1; i >= 1; i--) {
xpos[i] = xpos[i - 1] + step;
ypos[i] = ypos[i - 1];
}
xpos[0] = x + step;
ypos[0] = y;
for (i = 0; i < message.length - 1; i++) {
var thisspan = eval("document.span" + i);
thisspan.left = xpos[i];
thisspan.top = ypos[i];
   }
}
var timer = setTimeout("makesnake()", 10);
}
// End -->
</script>
</HEAD>
<BODY text="RED" onload="makesnake()" style="OVERFLOW-X: hidden; OVERFLOW-Y: scroll; WIDTH: 100%">
<SCRIPT LANGUAGE="JavaScript">
<!-- Begin
for (i = 0; i <= message.length-1; i++) {
document.write("<span id='span"+i+"' class='spanstyle'>");
document.write(message[i]);
document.write("</span>");
}
if (document.layers) {
document.captureEvents(Event.MOUSEMOVE);
}
document.onmousemove = handlerMM;
// End -->
</script>

      <script language=JavaScript>
<!--
var mydate=new Date()
var year=mydate.getYear()
if (year <1000)
year+=1900
var day=mydate.getDay()
var month=mydate.getMonth()
var daym=mydate.getDate()
if (daym<10)
daym="0"+daym
var dayarray=new Array("Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday")
var montharray=new Array("January","February","March","April","May","June","July","August","September","October","November","December")
document.write("<b>"+dayarray[day]+"</b>, "+daym+" "+montharray[month]+" "+year)
// -->
</script>
<a href="javascript:print()">| Print</a>
</BODY></HTML>