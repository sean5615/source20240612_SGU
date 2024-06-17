<%/*
----------------------------------------------------------------------------------
File Name		: sgu123r_01c1
Author			: Maggie
Description		: SGU123R_匯出新住民暨子女名冊資料- 顯示頁面
Modification Log	:

Vers		Date       	By            	Notes
--------------	--------------	--------------	----------------------------------
0.0.1		106/04/20	Maggie    	Code Generate Create
----------------------------------------------------------------------------------
*/%>
<%@ page contentType="text/html; charset=UTF-8" errorPage="/utility/errorpage.jsp" pageEncoding="MS950"%>
<%@ include file="/utility/header.jsp"%>
<%@ include file="/utility/jspageinit.jsp"%>

/** 匯入 javqascript Class */
doImport ("ErrorHandle.js, LoadingBar_0_2.js, Form.js");

/** 初始設定頁面資訊 */
var	printPage		=	"sgu123r_01p1.jsp";	//列印頁面
var	_privateMessageTime	=	-1;			//訊息顯示時間(不自訂為 -1)
var	controlPage		=	"sgu123r_01c2.jsp";
var	noPermissAry		=	new Array();		//沒有權限的陣列

/** 網頁初始化 */
function page_init()
{
	page_init_start();

	/** 權限檢核 */
	securityCheck();
	
	iniMasterKeyColumn();

	/** === 初始欄位設定 === */
	/** 初始列印欄位 */	
	Form.iniFormSet('QUERY', 'AYEAR', 'M',  3, 'A', 'F', 3,'N1','s',3);
	Form.iniFormSet('QUERY', 'SMS', 'M',  1, 'A');
	Form.iniFormSet('QUERY', 'AYEAR', 'AA', 'chkForm', '學年');
	Form.iniFormSet('QUERY', 'SMS', 'AA', 'chkForm', '學期');
	
	/** ================ */

	/** === 設定檢核條件 === */
	/** 列印欄位 */
	
	/** ================ */

	page_init_end();
}

function doExport() {
	
	Form.startChkForm("QUERY");

	/** 減核錯誤處理 */
	if (!queryObj.valideMessage (Form))
		return;

	
	Form.setInput('QUERY', 'control_type',		'EXPORT_ALL_MODE');
	Form.doSubmit('QUERY',controlPage,'post','');
	
}

/** ============================= 欲修正程式放置區 ======================================= */
/** 設定功能權限 */
function securityCheck()
{
	try
	{
		/** 列印 */
		if (!<%=AUTICFM.securityCheck (session, "PRT")%>)
		{
			noPermissAry[noPermissAry.length]	=	"PRT";
			try{Form.iniFormSet("QUERY", "PRT_ALL_BTN", "D", 1);}catch(ex){}
		}
	}
	catch (ex)
	{
	}
}

/** 檢查權限 - 有權限/無權限(true/false) */
function chkSecure(secureType)
{
	if (noPermissAry.toString().indexOf(secureType) != -1)
		return false;
	else
		return true
}
/** ====================================================================================== */

/** 初始上層帶來的 Key 資料 */
function iniMasterKeyColumn()
{
	/** 非 Detail 頁面不處理 */
	if (typeof(keyObj) == "undefined")
		return;
	/** 塞值 */
	for (keyName in keyObj)
	{
		try {Form.iniFormSet("QUERY", keyName, "V", keyObj[keyName], "R", 0);}catch(ex){};
		try {Form.iniFormSet("EDIT", keyName, "V", keyObj[keyName], "R", 0);}catch(ex){};
	}
	Form.iniFormColor();
}