<%/*
----------------------------------------------------------------------------------
File Name		: sgu050m_01c1
Author			: 俊名
Description		: sgu050m_ 共用代碼維護 - 控制頁面 (javascript)
Modification Log	:

Vers		Date       	By            	Notes
--------------	--------------	--------------	----------------------------------
0.0.1		095/10/26	俊名    	Code Generate Create
----------------------------------------------------------------------------------
*/%>
<%@ page contentType="text/html; charset=UTF-8" errorPage="/utility/errorpage.jsp" pageEncoding="MS950"%>
<%@ include file="/utility/header.jsp"%>
<%@ include file="/utility/jspageinit.jsp"%>

/** 匯入 javqascript Class */
doImport ("Query.js, ErrorHandle.js, LoadingBar_0_2.js, Form.js, Ajax_0_2.js, ArrayUtil.js, ReSize.js, SortTable.js");

/** 初始設定頁面資訊 */
var	printPage		=	"/sgu/sgu050m_01p1.jsp";	//列印頁面
var	editMode		=	"ADD";				//編輯模式, ADD - 新增, MOD - 修改
var	lockColumnCount		=	-1;				//鎖定欄位數
var	listShow		=	false;				//是否一進入顯示資料
var	_privateMessageTime	=	-1;				//訊息顯示時間(不自訂為 -1)
var	pageRangeSize		=	10;				//畫面一次顯示幾頁資料
var	controlPage		=	"/sgu/sgu050m_01c2.jsp";	//控制頁面
var	checkObj		=	new checkObj();			//核選元件
var	queryObj		=	new queryObj();			//查詢元件
var	importSelect		=	false;				//匯入選取欄位功能
var	noPermissAry		=	new Array();			//沒有權限的陣列

/** 網頁初始化 */
function page_init()
{
	page_init_start();
	
	
	/** 權限檢核 */
	securityCheck();

	/** === 初始欄位設定 === */
	/** 初始上層帶來的 Key 資料 */
	iniMasterKeyColumn();

	/** 初始查詢欄位 */
	Form.iniFormSet('QUERY', 'KIND', 'M',  18, 'A', 'SE', 'U');
	Form.iniFormSet('QUERY', 'KIND_NAME', 'R', 1, 'M',  20, 'A');

	/** 初始編輯欄位 */
	Form.iniFormSet('EDIT', 'KIND', 'R', 1, 'SE', 'M',  18, 'U', 'A', 'D', 1);
	Form.iniFormSet('EDIT', 'KIND_NAME', 'M',  20, 'A', 'D', 1);
	Form.iniFormSet('EDIT', 'CODE', 'R', 1, 'EN', 'M',  4, 'U', 'A', 'D', 1);
	Form.iniFormSet('EDIT', 'CODE_NAME', 'M',  20, 'A', 'D', 1);
	Form.iniFormSet('EDIT', 'HANDICAP_EDU_CODE', 'M',  2, 'EN');
	Form.iniFormSet('EDIT', 'HANDICAP_EDU_NAME', 'M',  20);

	loadind_.showLoadingBar (15, "初始欄位完成");
	/** ================ */

	/** === 設定檢核條件 === */
	/** 查詢欄位 */

	/** 編輯欄位 */
	//Form.iniFormSet('EDIT', 'HANDICAP_EDU_NAME', 'AA', 'chkForm', '特教網名稱');
	Form.iniFormSet('EDIT', 'HANDICAP_EDU_CODE', 'AA', 'chkForm', '特教網代碼');
	Form.iniFormSet('EDIT', 'KIND', 'AA', 'chkForm', '代碼種類');
	Form.iniFormSet('EDIT', 'CODE', 'AA', 'chkForm', '代碼');
	Form.iniFormSet('EDIT', 'KIND_NAME', 'AA', 'chkForm', '代碼種類名稱');
	Form.iniFormSet('EDIT', 'CODE_NAME', 'AA', 'chkForm', '代碼名稱');

	loadind_.showLoadingBar (20, "設定核條件完成");
	/** ================ */

	page_init_end();
}

/**
初始化 Grid 內容
@param	stat	呼叫狀態(init -> 網頁初始化)
*/
function iniGrid(stat)
{
	var	gridObj	=	new Grid();

	iniGrid_start(gridObj)

	/** 設定表頭 */
	gridObj.heaherHTML.append
	(
		"<table id=\"RsultTable\" class='sortable' width=\"100%\" border=\"1\" cellpadding=\"2\" cellspacing=\"0\" bordercolor=\"#E6E6E6\">\
			<tr class=\"mtbGreenBg\">\
				<td width=20>&nbsp;</td>\
				<td width=20>&nbsp;</td>\
				<td resize='on' nowrap>代碼種類</td>\
				<td resize='on' nowrap>代碼種類名稱</td>\
				<td resize='on' nowrap>代碼</td>\
				<td resize='on' nowrap>代碼名稱</td>\
				<td resize='on' nowrap>特教網代碼</td>\
				<td resize='on' nowrap>特教網名稱</td>\
			</tr>"
	);

	if (stat == "init" && !listShow)
	{
		/** 初始化及不顯示資料只秀表頭 */
		document.getElementById("grid-scroll").innerHTML	=	gridObj.heaherHTML.toString().replace(/\t/g, "") + "</table>";
		Message.hideProcess();
	}
	else
	{
		/** 處理連線取資料 */
		/** 頁次區間同步 */
		Form.setInput ("QUERY", "pageSize",	Form.getInput("RESULT", "_scrollSize"));
		Form.setInput ("QUERY", "pageNo",	Form.getInput("RESULT", "_goToPage"));
		
		/** 處理連線取資料 */
		var	callBack	=	function iniGrid.callBack(ajaxData)
		{
		if (ajaxData == null)
			return;

		/** 設定表身 */
		var	keyValue	=	"";
		var	editStr		=	"";
		var	delStr		=	"";
		var	exportBuff	=	new StringBuffer();
		
		for (var i = 0; i < ajaxData.data.length; i++, gridObj.rowCount++)
		{
			keyValue	=	"KIND|" + ajaxData.data[i].KIND + "|CODE|" + ajaxData.data[i].CODE;

			/** 判斷權限 */
			if (chkSecure("DEL"))
				delStr	=	"onkeypress=\"doDelete('" + keyValue + "');\"onclick=\"doDelete('" + keyValue + "');\"><a href=\"javascript:void(0)\">刪</a>";
			else
				delStr	=	">刪";

			if (chkSecure("UPD"))
				editStr	=	"onkeypress=\"doEdit('" + keyValue + "');\"onclick=\"doEdit('" + keyValue + "');\"><a href=\"javascript:void(0)\">編</a>";
			else
				editStr	=	">編";

			gridObj.gridHtml.append
			(
				"<tr class=\"listColor0" + ((gridObj.rowCount % 2) + 1) + "\">\
					<td align=center><input type=checkbox name='chkBox' value=\"" + keyValue + "\"></td>\
					<td align=center " + editStr + "</td>\
					<td>" + ajaxData.data[i].KIND + "&nbsp;</td>\
					<td>" + ajaxData.data[i].KIND_NAME + "&nbsp;</td>\
					<td>" + ajaxData.data[i].CODE + "&nbsp;</td>\
					<td>" + ajaxData.data[i].CODE_NAME + "&nbsp;</td>\
					<td>" + (ajaxData.data[i].HANDICAP_EDU_CODE==null?"&nbsp;":ajaxData.data[i].HANDICAP_EDU_CODE) + "&nbsp;</td>\
					<td>" + (ajaxData.data[i].HANDICAP_EDU_NAME==null?"&nbsp;":ajaxData.data[i].HANDICAP_EDU_NAME) + "&nbsp;</td>\
				</tr>"
			);
		}
		gridObj.gridHtml.append ("</table>");
		Form.setInput ("RESULT", "ALL_CONTENT", exportBuff.toString());

		/** 無符合資料 */
		if (ajaxData.data.length == 0)
			gridObj.gridHtml.append ("<font color=red><b>　　　查無符合資料!!</b></font>");

		iniGrid_end(ajaxData, gridObj);
		}
		sendFormData("QUERY", controlPage, "QUERY_MODE", callBack);
		
	}
}

/** 查詢功能時呼叫 */
function doQuery()
{
	doQuery_start();

	/** === 自定檢查 === */
	loadind_.showLoadingBar (8, "自定檢核開始");

	/** 資料檢核及設定, 當有錯誤處理方式為 Form.errAppend(Message) 累計錯誤訊息 */
	//if (Form.getInput("QUERY", "SYS_CD") == "")
	//	Form.errAppend("系統編號不可空白!!");

	loadind_.showLoadingBar (10, "自定檢核完成");
	/** ================ */

	return doQuery_end();
}

/** 修改功能時呼叫 */
function doModify()
{
	/** 設定修改模式 */
	editMode		=	"UPD";
	EditStatus.innerHTML	=	"修改";

}

/** 存檔功能時呼叫 */
function doSave()
{
	doSave_start();
	
	/** 判斷新增無權限不處理 */
	if (editMode == "NONE"){
		Message.hideProcess();
		return;
	}
	
	/** === 自定檢查 === */
	//loadind_.showLoadingBar (8, "自定檢核開始");

	/** 資料檢核及設定, 當有錯誤處理方式為 Form.errAppend(Message) 累計錯誤訊息 */
	//if (Form.getInput("QUERY", "SYS_CD") == "")
	//	Form.errAppend("系統編號不可空白!!");

	//loadind_.showLoadingBar (10, "自定檢核完成");
	/** ================ */

	doSave_end();
}

/** ============================= 欲修正程式放置區 ======================================= */
/** 設定功能權限 */
function securityCheck()
{
	try
	{
		/** 查詢 */
		if (!<%=AUTICFM.securityCheck (session, "QRY")%>)
		{
			noPermissAry[noPermissAry.length]	=	"QRY";
			try{Form.iniFormSet("QUERY", "QUERY_BTN", "D", 1);}catch(ex){}
		}
		/** 新增 */
		if (!<%=AUTICFM.securityCheck (session, "ADD")%>)
		{
			noPermissAry[noPermissAry.length]	=	"ADD";
			editMode	=	"NONE";
			try{Form.iniFormSet("EDIT", "ADD_BTN", "D", 1);}catch(ex){}
		}
		/** 修改 */
		if (!<%=AUTICFM.securityCheck (session, "UPD")%>)
		{
			noPermissAry[noPermissAry.length]	=	"UPD";
		}
		/** 新增及修改 */
		if (!chkSecure("ADD") && !chkSecure("UPD"))
		{
			try{Form.iniFormSet("EDIT", "SAVE_BTN", "D", 1);}catch(ex){}
		}
		/** 刪除 */
		if (!<%=AUTICFM.securityCheck (session, "DEL")%>)
		{
			noPermissAry[noPermissAry.length]	=	"DEL";
			try{Form.iniFormSet("RESULT", "DEL_BTN", "D", 1);}catch(ex){}
		}
		/** 匯出 */
		if (!<%=AUTICFM.securityCheck (session, "EXP")%>)
		{
			noPermissAry[noPermissAry.length]	=	"EXP";
			try{Form.iniFormSet("RESULT", "EXPORT_BTN", "D", 1);}catch(ex){}
			try{Form.iniFormSet("QUERY", "EXPORT_ALL_BTN", "D", 1);}catch(ex){}
		}
		/** 列印 */
		if (!<%=AUTICFM.securityCheck (session, "PRT")%>)
		{
			noPermissAry[noPermissAry.length]	=	"PRT";
			try{Form.iniFormSet("RESULT", "PRT_BTN", "D", 1);}catch(ex){}
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


/** 新增功能時呼叫 */
function doAdd()
{
	doAdd_start();

	/** 清除唯讀項目(KEY)*/

	/** 初始上層帶來的 Key 資料 */
	iniMasterKeyColumn();

	/** 設定 Focus */

	/** 初始化 Form 顏色 */
	Form.iniFormColor();

	/** 停止處理 */
	queryObj.endProcess ("新增狀態完成");
}