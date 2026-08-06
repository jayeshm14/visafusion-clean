<HTML><HEAD><TITLE></TITLE>
<style>.spanstyle {
	COLOR: RED; FONT-FAMILY: Verdana; FONT-SIZE: 8pt; FONT-WEIGHT: bold; POSITION: absolute; TOP: -50px; VISIBILITY: visible
}
</style>
>>>>>>>>>>>>>>> Fall <<<<<<<<<<<<<<<<<<<<<<<<<<
<script language="JavaScript1.2">

//Autumn leaves- by Kurt Grigg (kurt.grigg@virgin.net)
//Modified by Dynamic Drive for NS6 functionality
//visit http://www.dynamicdrive.com for this script

//Pre-load your image below!
grphcs=new Array(6)
Image0=new Image();
Image0.src=grphcs[0]="images/umaround.jpg";
Image1=new Image();
Image1.src=grphcs[1]="images/umaround.jpg"
Image2=new Image();
Image2.src=grphcs[2]="images/umaround.jpg"
Image3=new Image();
Image3.src=grphcs[3]="images/umaround.jpg"
Image4=new Image();
Image4.src=grphcs[4]="images/umaround.jpg"
Image5=new Image();
Image5.src=grphcs[5]="images/umaround.jpg" 

Amount=8;
Ypos=new Array();
Xpos=new Array();
Speed=new Array();
Step=new Array();
Cstep=new Array();
ns=(document.layers)?1:0;
ns6=(document.getElementById&&!document.all)?1:0;

if (ns){
for (i = 0; i < Amount; i++){
var P=Math.floor(Math.random()*grphcs.length);
rndPic=grphcs[P];
document.write("<LAYER NAME='sn"+i+"' LEFT=0 TOP=0><img src="+rndPic+"></LAYER>");
}
}
else{
document.write('<div style="position:absolute;top:0px;left:0px"><div style="position:relative">');
for (i = 0; i < Amount; i++){
var P=Math.floor(Math.random()*grphcs.length);
rndPic=grphcs[P];
document.write('<img id="si'+i+'" src="'+rndPic+'" style="position:absolute;top:0px;left:0px">');
}
document.write('</div></div>');
}
WinHeight=(ns||ns6)?window.innerHeight:window.document.body.clientHeight;
WinWidth=(ns||ns6)?window.innerWidth-70:window.document.body.clientWidth;
for (i=0; i < Amount; i++){                                                                
 Ypos[i] = Math.round(Math.random()*WinHeight);
 Xpos[i] = Math.round(Math.random()*WinWidth);
 Speed[i]= Math.random()*5+3;
 Cstep[i]=0;
 Step[i]=Math.random()*0.1+0.05;
}
function fall(){
var WinHeight=(ns||ns6)?window.innerHeight:window.document.body.clientHeight;
var WinWidth=(ns||ns6)?window.innerWidth-70:window.document.body.clientWidth;
var hscrll=(ns||ns6)?window.pageYOffset:document.body.scrollTop;
var wscrll=(ns||ns6)?window.pageXOffset:document.body.scrollLeft;
for (i=0; i < Amount; i++){
sy = Speed[i]*Math.sin(90*Math.PI/180);
sx = Speed[i]*Math.cos(Cstep[i]);
Ypos[i]+=sy;
Xpos[i]+=sx; 
if (Ypos[i] > WinHeight){
Ypos[i]=-60;
Xpos[i]=Math.round(Math.random()*WinWidth);
Speed[i]=Math.random()*5+3;
}
if (ns){
document.layers['sn'+i].left=Xpos[i];
document.layers['sn'+i].top=Ypos[i]+hscrll;
}
else if (ns6){
document.getElementById("si"+i).style.left=Math.min(WinWidth,Xpos[i]);
document.getElementById("si"+i).style.top=Ypos[i]+hscrll;
}
else{
eval("document.all.si"+i).style.left=Xpos[i];
eval("document.all.si"+i).style.top=Ypos[i]+hscrll;
} 
Cstep[i]+=Step[i];
}
setTimeout('fall()',20);
}

fall();
//-->
</script>
>>>>>>>>>>>>>>> Fall <<<<<<<<<<<<<<<<<<<<<<<<<<


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

