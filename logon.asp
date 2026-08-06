<%
'if session("priv")="emp" then
'response.clear
'response.redirect "Administrator.asp?uname="&session("uname")
'end if
'if session("priv")="adm" then
'response.clear
'response.redirect "Employee.asp?uname="&session("uname")
'end if
'if session("priv")="agt" then
'response.clear
'response.redirect "Agent.asp?uname="&session("uname")
'end if
session.abandon
%>
<!-- #include file="connection.asp" -->
<html>
<head>
<title>Udaan India Pvt. Ltd.</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="styles.css" type="text/css">
 <link rel="stylesheet" href="css\adminlte.min.css">
 <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
  <!--begin::Fonts-->
  <script src="js\adminlte.min.js"></script>
<SCRIPT language=Javascript>  
function initArray(n) {

this.length = n; 
for (var i =1; i <= n; i++) 
{ this[i] = ' ' }
 } 
slide = new initArray(2);
 slide[0]="Welcom to Udaan India Private Limited: Visa ! Come Get It:" ;
 slide[1]="www.udaanindia.com:" ;
 var delay1 = 3; 
 var delay2 = 3; 
 var text = slide[0] + " " ;
 var str = " " ;
 var leftmsg = ""; 
 var nextmsg = 0; 
 
 function setMessage() 
 { 
 if (str.length == 1) 
 	{ while (text.substring(0, 1) == " ") 
		{ 
			leftmsg += str; 
			str = text.substring(0, 1); 
			text = text.substring(1, text.length); 
		} 
	 leftmsg += str; 
	 str = text.substring(0, 1) ;
	 text = text.substring(1, text.length) ;
	 for (var x = 0; x < 120; x++) 
	 	{ str = " " + str }; 
	} 
 else 
 	{ 	
		str = str.substring(10, str.length) ;
	} 
	window.status = leftmsg + str; 
if (text == "") 
	{ 
	str = " " ;
	nextmsg++ ;
		if (nextmsg > slide.length) 
			{ 
				nextmsg = 0; 
			} 
	text = slide[nextmsg] + " " ;
	leftmsg = "" ;
	setTimeout('setMessage()',delay2); 
	} 
else 
	{ 
	setTimeout('setMessage()',delay1); 
	} 
} 
setMessage();
</SCRIPT>
<script language="JavaScript">
<!--
function MM_preloadImages() { //v3.0
  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}

function MM_swapImgRestore() { //v3.0
  var i,x,a=document.MM_sr; for(i=0;a&&i<a.length&&(x=a[i])&&x.oSrc;i++) x.src=x.oSrc;
}

function MM_findObj(n, d) { //v3.0
  var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
    d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document); return x;
}

function MM_swapImage() { //v3.0
  var i,j=0,x,a=MM_swapImage.arguments; document.MM_sr=new Array; for(i=0;i<(a.length-2);i+=3)
   if ((x=MM_findObj(a[i]))!=null){document.MM_sr[j++]=x; if(!x.oSrc) x.oSrc=x.src; x.src=a[i+2];}
}
//-->
</script>
<style type="text/css">
<!--
a.ud {  font-family: Arial, Helvetica, sans-serif; font-size: 8pt; font-weight: bold; color: #333333; text-decoration: none}
a.ud:hover {  font-family: Arial, Helvetica, sans-serif; font-size: 8pt; font-weight: bold; color: #FF0000; text-decoration: none}
input.ud {  font-family: Arial, Helvetica, sans-serif; font-size: 9pt; font-style: normal; background-color: #FFBC48; border-top-width: 0px; border-right-width: 0px; border-bottom-width: 0px; border-left-width: 0px}
-->
</style>
</head>
<%
if len(connectionStatus) > 0 then
    if instr(1, connectionStatus, "failed", 1) > 0 then
%>
<div style="color:white;font-weight:bold;padding:10px;margin:10px;border:2px solid red;background-color:#cc0000;">
<strong>Database Connection Error:</strong><br>
<%=connectionStatus%><br>
<strong>Login cannot proceed.</strong>
</div>
<%
    else
%>
<!--<div style="color:green;font-weight:bold;padding:5px;margin:5px;border:1px solid green;background-color:#e6ffe6;font-size:11px;">
<%=connectionStatus%>
</div>-->
<%
    end if
end if
%>
<!--begin::Body-->
  <!--begin::Body-->
  <body class="layout-fixed sidebar-expand-lg bg-body-tertiary">
    <!--begin::App Wrapper-->
    <div class="app-wrapper">
      <!--begin::Header-->
      <nav class="app-header navbar navbar-expand bg-body">
        <!--begin::Container-->
        <div class="container-fluid">
          <!--begin::Start Navbar Links-->
          <ul class="navbar-nav">
            <li class="nav-item">
              
            </li>
            <li class="nav-item d-none d-md-block">
              <a href="Default.asp" class="nav-link"><i class="nav-icon bi bi-house"></i> Home</a>
            </li>
            <li class="nav-item d-none d-md-block">
              <a href="profile.asp" class="nav-link"><i class="nav-icon bi bi-people"></i> Profile</a>
            </li>
            <li class="nav-item d-none d-md-block">
              <a href="update.asp" class="nav-link"><i class="nav-icon bi bi-check-circle"></i> Update</a>
            </li>
            <li class="nav-item d-none d-md-block">
              <a href="registration.asp" class="nav-link"><i class="nav-icon bi bi-person-badge"></i> Registration</a>
            </li>
            <li class="nav-item d-none d-md-block">
              <a href="contactus.asp" class="nav-link"><i class="nav-icon bi bi-phone"></i> Contact Us</a>
            </li>
            <li class="nav-item d-none d-md-block">
              <a href="queries.asp" class="nav-link"><i class="nav-icon bi bi-question-circle"></i> Queries</a>
            </li>
            <li class="nav-item d-none d-md-block">
              <a href="logon.asp" class="nav-link"><i class="nav-icon bi bi-person-circle"></i> Logon</a>
            </li>
          </ul>
          <!--end::Start Navbar Links-->

          <!--begin::End Navbar Links-->
          <ul class="navbar-nav ms-auto">
            <!--begin::Navbar Search-->
            <li class="nav-item">
              <a class="nav-link" data-widget="navbar-search" href="#" role="button">
                <i class="bi bi-search"></i>
              </a>
            </li>
            <!--end::Navbar Search-->

            <!--begin::Messages Dropdown Menu-->
            <li class="nav-item dropdown">
              <a class="nav-link" data-bs-toggle="dropdown" href="#">
                <i class="bi bi-chat-text"></i>
                <span class="navbar-badge badge text-bg-danger">3</span>
              </a>
              <div class="dropdown-menu dropdown-menu-lg dropdown-menu-end">
                <a href="#" class="dropdown-item">
                  <!--begin::Message-->
                  <div class="d-flex">
                    <div class="flex-shrink-0">
                      <img
                        src="./assets/img/user1-128x128.jpg"
                        alt="User Avatar"
                        class="img-size-50 rounded-circle me-3"
                      />
                    </div>
                    <div class="flex-grow-1">
                      <h3 class="dropdown-item-title">
                        Brad Diesel
                        <span class="float-end fs-7 text-danger"
                          ><i class="bi bi-star-fill"></i
                        ></span>
                      </h3>
                      <p class="fs-7">Call me whenever you can...</p>
                      <p class="fs-7 text-secondary">
                        <i class="bi bi-clock-fill me-1"></i> 4 Hours Ago
                      </p>
                    </div>
                  </div>
                  <!--end::Message-->
                </a>
                <div class="dropdown-divider"></div>
                <a href="#" class="dropdown-item">
                  <!--begin::Message-->
                  <div class="d-flex">
                    <div class="flex-shrink-0">
                      <img
                        src="./assets/img/user8-128x128.jpg"
                        alt="User Avatar"
                        class="img-size-50 rounded-circle me-3"
                      />
                    </div>
                    <div class="flex-grow-1">
                      <h3 class="dropdown-item-title">
                        John Pierce
                        <span class="float-end fs-7 text-secondary">
                          <i class="bi bi-star-fill"></i>
                        </span>
                      </h3>
                      <p class="fs-7">I got your message bro</p>
                      <p class="fs-7 text-secondary">
                        <i class="bi bi-clock-fill me-1"></i> 4 Hours Ago
                      </p>
                    </div>
                  </div>
                  <!--end::Message-->
                </a>
                <div class="dropdown-divider"></div>
                <a href="#" class="dropdown-item">
                  <!--begin::Message-->
                  <div class="d-flex">
                    <div class="flex-shrink-0">
                      <img
                        src="./assets/img/user3-128x128.jpg"
                        alt="User Avatar"
                        class="img-size-50 rounded-circle me-3"
                      />
                    </div>
                    <div class="flex-grow-1">
                      <h3 class="dropdown-item-title">
                        Nora Silvester
                        <span class="float-end fs-7 text-warning">
                          <i class="bi bi-star-fill"></i>
                        </span>
                      </h3>
                      <p class="fs-7">The subject goes here</p>
                      <p class="fs-7 text-secondary">
                        <i class="bi bi-clock-fill me-1"></i> 4 Hours Ago
                      </p>
                    </div>
                  </div>
                  <!--end::Message-->
                </a>
                <div class="dropdown-divider"></div>
                <a href="#" class="dropdown-item dropdown-footer">See All Messages</a>
              </div>
            </li>
            <!--end::Messages Dropdown Menu-->

            <!--begin::Notifications Dropdown Menu-->
            <li class="nav-item dropdown">
              <a class="nav-link" data-bs-toggle="dropdown" href="#">
                <i class="bi bi-bell-fill"></i>
                <span class="navbar-badge badge text-bg-warning">15</span>
              </a>
              <div class="dropdown-menu dropdown-menu-lg dropdown-menu-end">
                <span class="dropdown-item dropdown-header">15 Notifications</span>
                <div class="dropdown-divider"></div>
                <a href="#" class="dropdown-item">
                  <i class="bi bi-envelope me-2"></i> 4 new messages
                  <span class="float-end text-secondary fs-7">3 mins</span>
                </a>
                <div class="dropdown-divider"></div>
                <a href="#" class="dropdown-item">
                  <i class="bi bi-people-fill me-2"></i> 8 friend requests
                  <span class="float-end text-secondary fs-7">12 hours</span>
                </a>
                <div class="dropdown-divider"></div>
                <a href="#" class="dropdown-item">
                  <i class="bi bi-file-earmark-fill me-2"></i> 3 new reports
                  <span class="float-end text-secondary fs-7">2 days</span>
                </a>
                <div class="dropdown-divider"></div>
                <a href="#" class="dropdown-item dropdown-footer"> See All Notifications </a>
              </div>
            </li>
            <!--end::Notifications Dropdown Menu-->

            <!--begin::Fullscreen Toggle-->
            <li class="nav-item">
              <a class="nav-link" href="#" data-lte-toggle="fullscreen">
                <i data-lte-icon="maximize" class="bi bi-arrows-fullscreen"></i>
                <i data-lte-icon="minimize" class="bi bi-fullscreen-exit" style="display: none"></i>
              </a>
            </li>
            <!--end::Fullscreen Toggle-->

            <!--begin::User Menu Dropdown-->
            <li class="nav-item dropdown user-menu">
              <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown">
                <img
                  src="./assets/img/user2-160x160.jpg"
                  class="user-image rounded-circle shadow"
                  alt="User Image"
                />
                <span class="d-none d-md-inline">Alexander Pierce</span>
              </a>
              <ul class="dropdown-menu dropdown-menu-lg dropdown-menu-end">
                <!--begin::User Image-->
                <li class="user-header text-bg-primary">
                  <img
                    src="./assets/img/user2-160x160.jpg"
                    class="rounded-circle shadow"
                    alt="User Image"
                  />
                  <p>
                    Alexander Pierce - Web Developer
                    <small>Member since Nov. 2023</small>
                  </p>
                </li>
                <!--end::User Image-->
                <!--begin::Menu Body-->
                <li class="user-body">
                  <!--begin::Row-->
                  <div class="row">
                    <div class="col-4 text-center">
                      <a href="#">Followers</a>
                    </div>
                    <div class="col-4 text-center">
                      <a href="#">Sales</a>
                    </div>
                    <div class="col-4 text-center">
                      <a href="#">Friends</a>
                    </div>
                  </div>
                  <!--end::Row-->
                </li>
                <!--end::Menu Body-->
                <!--begin::Menu Footer-->
                <li class="user-footer">
                  <a href="#" class="btn btn-outline-secondary">Profile</a>
                  <a href="#" class="btn btn-outline-danger float-end">Sign out</a>
                </li>
                <!--end::Menu Footer-->
              </ul>
            </li>
            <!--end::User Menu Dropdown-->
          </ul>
          <!--end::End Navbar Links-->
        </div>
        <!--end::Container-->
      </nav>
      <!--end::Header-->
      <!--end::Header-->
    
                    <!--begin::App Main-->
      <main class="app-main">
        <!--begin::App Content Header-->
        <div class="app-content-header">
          <!--begin::Container-->
          <div class="container-fluid">
            <!--begin::Row-->
            <!--<div class="row">
              <div class="col-sm-6">
                <h3 class="mb-0">Dashboard</h3>
              </div>
              <div class="col-sm-6">
                <ol class="breadcrumb float-sm-end">
                  <li class="breadcrumb-item"><a href="#">Home</a></li>
                  <li class="breadcrumb-item active" aria-current="page">Dashboard</li>
                </ol>
              </div>
            </div>-->
            <!--end::Row-->
          </div>
          <!--end::Container-->
        </div>
        <!--end::App Content Header-->
        <!--begin::App Content-->
        <div class="app-content">
          <!--begin::Container-->
          <div class="container-fluid">
            <!--begin::Row-->
            <div class="row">
    <div class="login-box">
      <div class="login-logo">
        <a href="../index2.html"><b>Royal</b>Routes</a>
      </div>
      <!-- /.login-logo -->
      <div class="card">
        <div class="card-body login-card-body">
          <p class="login-box-msg">Sign in to start your session</p>
          <form method="post" action="authenticate.asp" name="form1">
            <div class="input-group mb-3">
                                      <input type="text" name="username" class="form-control" placeholder="User Id"/>
                                     <div class="input-group-text">
                <span class="bi bi-envelope"></span>
              </div>
            </div><div class="input-group mb-3">
                                      <input type="password" name="pass" class="form-control" placeholder="Password">
<div class="input-group-text">
                <span class="bi bi-lock-fill"></span>
              </div>
            </div><div class="row">
              <div class="col-8">
                <div class="form-check">
                  <input class="form-check-input" type="checkbox" value="" id="flexCheckDefault" />
                  <label class="form-check-label" for="flexCheckDefault"> Remember Me </label>
                </div>
              </div>
              <!-- /.col -->
              <div class="col-4">
                <div class="d-grid gap-2">
                                        <input class="btn btn-primary" type="submit" name="Submit" value="Logon">
                                      </d</div>
              </div>
              <!-- /.col -->
            </div>
                                   <p class="mb-0">For new Registration<a href="registration.asp"> 
                                        click here</a>
                                   </p>
									
                    
                                  
                                </form>
        </div>
      </div>
    </div>
            </div>
          </div>
        </div>
      </main>
    </div>
    </BODY>
</HTML>