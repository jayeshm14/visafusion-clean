//______________________________MENU PARAMETERS added by Credence Technologies 01Sep2004
curMenuBorderBgColor = null; // set to null to achieve a flat look
curMenuLiteBgColor = "#FF0000";
curFtFamily = "Verdana, Arial, Helvetica, sans-serif"; // menu item font family
curFtSize = 11; // menu item font size
curFtColor = "#FBD424"; // menu item font color
curFtColorHover = "#000000"; // menu item font color hover
curItemBg = "#B82412"; // menu bgcolor
curItemBgHover = "#FBD424"//"#DAE8F1"; // menu bgcolor hover
curAlign = "left"; // menu item cell align
curValign = "middle"; // menu item cell vertical align
curPad = 0; // menu item cell padding
curSpace = 0; // menu item cell spacing
curTimeOut = 500; // mm default is 1000; issue w/ NS4 where if value is less than 500 then link won't work; added work around in mm_menu.js line 539
curSX = 4; // sub menu X position - not used here
curSY = 100; // menu Y position - not used here
curSrel = true; // menu relative position
curOpq = true; // border visible
curVert = true; // vertical menu
curIdt = 0; // 
curAw = true; //
curAh = true; //
curFtWeight= "normal"; // menu item font weight
curFtDis = "#c0c0c0";
//______________________________________________
/*
new Menu("root",126,20,"Verdana, Arial, Helvetica, sans-serif",10,"#626262","#626262","#ffffff","#DAE8F1","left","middle",3,0,500,0,30,false,true,true,0,false,false);
*/
/*
new Menu("root",126,20,curFtFamily,curFtSize,curFtColor,curFtColorHover,curItemBg,curItemBgHover,curAlign,curValign,curPad,curSpace,curTimeOut,curSX,curSY,curSrel,curOpq,curVert,curIdt,curAw,curAh);
*/

function mmLoadMenus(curPage) {

  if (window.mm_menu_service) return;
  curFile = curPage;


/* Service MENU */
/* -----------------------------------------------*/

/* sub menu */

/*
mm_2_1.hideOnMouseOut=true;
mm_2_1.fontWeight= curFtWeight;
mm_2_1.fontDisabled= curFtDis;
mm_2_1.menuBorder=1;
mm_2_1.menuLiteBgColor=curMenuLiteBgColor;
mm_2_1.menuBorderBgColor=curMenuBorderBgColor;
mm_2_1.bgColor='#677CBA';
*/

  window.mm_menu_service = new Menu("root",140,19,curFtFamily,curFtSize,curFtColor,curFtColorHover,curItemBg,curItemBgHover,curAlign,curValign,curPad,curSpace,curTimeOut,curSX,curSY,curSrel,curOpq,curVert,curIdt,curAw,curAh);
mm_menu_service.addMenuItem("Company","location='about_company_history.htm'");
mm_menu_service.addMenuItem("Management","location='about_management.htm'");
mm_menu_service.addMenuItem("Team","location='about_team_communication.htm'");
mm_menu_service.addMenuItem("Work Process","location='about_workp.htm'");



/*
mm_menu_service.hideOnMouseOut=true;
mm_menu_service.fontWeight= curFtWeight;
mm_menu_service.fontDisabled= curFtDis;
mm_menu_service.menuBorder=0;
mm_menu_service.menuLiteBgColor=curMenuLiteBgColor;
mm_menu_service.menuBorderBgColor=curMenuBorderBgColor;
mm_menu_service.bgColor='#677CBA';

*/

  mm_menu_service.writeMenus();
} // mmLoadMenus()

