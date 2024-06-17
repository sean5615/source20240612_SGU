<%/*
----------------------------------------------------------------------------------
File Name        : sgu060m_01c1
Author            : Jason
Description        : SGU060M_維護新住民子女資料 - 控制頁面 (javascript)
Modification Log    :

Vers        Date           By                Notes
--------------    --------------    --------------    ----------------------------------
0.0.1        096/07/25    Jason        Code Generate Create
----------------------------------------------------------------------------------
*/%>
<%@ page contentType="text/html; charset=UTF-8" errorPage="/utility/errorpage.jsp" pageEncoding="MS950"%>
<%@ include file="/utility/header.jsp"%>
<%@ include file="/utility/jspageinit.jsp"%>

/** 匯入 javqascript Class */
doImport ("Query.js, ErrorHandle.js, LoadingBar_0_2.js, Form.js, Ajax_0_2.js, ArrayUtil.js, ReSize.js, SortTable.js");

/** 初始設定頁面資訊 */
var    printPage        =    "sgu060m_01p1.jsp";    //列印頁面
var    editMode        =    "ADD";                //編輯模式, ADD - 新增, MOD - 修改
var    lockColumnCount        =    -1;                //鎖定欄位數
var    listShow        =    false;                //是否一進入顯示資料
var    _privateMessageTime    =    -1;                //訊息顯示時間(不自訂為 -1)
var    pageRangeSize        =    10;                //畫面一次顯示幾頁資料
var    controlPage        =    "sgu060m_01c2.jsp";    //控制頁面
var    checkObj        =    new checkObj();            //核選元件
var    queryObj        =    new queryObj();            //查詢元件
var    importSelect        =    false;                //匯入選取欄位功能
var    noPermissAry        =    new Array();            //沒有權限的陣列

/** 網頁初始化 */
function page_init(loadTime)
{
    if (loadTime != "second")
        page_init_start();


    /** 權限檢核 */
    securityCheck();

    /** === 初始欄位設定 === */
    /** 初始上層帶來的 Key 資料 */
    iniMasterKeyColumn();

    /** 初始查詢欄位 */
    Form.iniFormSet('QUERY', 'AYEAR', 'N1', 'M', 3, 'A', 'F', 3,'S',3);
    Form.iniFormSet('QUERY', 'SMS', 'M', 1, 'A');
    Form.iniFormSet('QUERY', 'STNO', 'N1', 'M', 9,'S',9, 'A');


    /** === 設定檢核條件 === */
    /** 查詢欄位 */
    //Form.iniFormSet('QUERY', 'AYEAR', 'AA', 'chkForm', '學年');
    //Form.iniFormSet('QUERY', 'SMS', 'AA', 'chkForm', '學期');

    /** ================ */

    if (loadTime != "second")
        page_init_end();
}

/**
初始化 Grid 內容
@param    stat    呼叫狀態(init -> 網頁初始化)
*/
function iniGrid(stat)
{
    var    gridObj    =    new Grid();

    iniGrid_start(gridObj)

    /** 設定表頭 */
    gridObj.heaherHTML.append
    (
        "<table id=\"RsultTable\" class='sortable' width=\"100%\" border=\"1\" cellpadding=\"2\" cellspacing=\"0\" bordercolor=\"#E6E6E6\" summary=\"排版用表格\">\
                <tr class=\"mtbGreenBg\">\
                <td width=20>&nbsp;</td>\
                <td width=20>&nbsp;</td>\
                <td resize='on' nowrap>學年期</td>\
                <td resize='on' nowrap>學生姓名</td>\
                <td resize='on' nowrap>學號</td>\
                <td resize='on' nowrap>中心別</td>\
                <td resize='on' nowrap>身分別</td>\
                <td resize='on' nowrap>身分證字號</td>\
                <td resize='on' nowrap>出生日期</td>\
                <td resize='on' nowrap>性別</td>\
                <td resize='on' nowrap>行動電話</td>\
                <td resize='on' nowrap>父親姓名</td>\
                <td resize='on' nowrap>父親國別</td>\
                <td resize='on' nowrap>母親姓名</td>\
                <td resize='on' nowrap>母親國別</td>\
                <td resize='on' nowrap>審核</td>\
            </tr>"
    );

    if (stat == "init" && !listShow)
    {
        /** 初始化及不顯示資料只秀表頭 */
        document.getElementById("grid-scroll").innerHTML    =    gridObj.heaherHTML.toString().replace(/\t/g, "") + "</table>";
        Message.hideProcess();
    }
    else
    {
        /** 頁次區間同步 */
        Form.setInput ("QUERY", "pageSize",    Form.getInput("RESULT", "_scrollSize"));
        Form.setInput ("QUERY", "pageNo",    Form.getInput("RESULT", "_goToPage"));

        /** 處理連線取資料 */
        var    callBack    =    function iniGrid.callBack(ajaxData)
        {
            if (ajaxData == null)
                return;

            /** 設定表身 */
            var    keyValue    =    "";
            var    editStr        =   "";
            var    delStr        =    "";
            var    exportBuff    =    new StringBuffer();
            var	   FLAG		=	"";

            for (var i = 0; i < ajaxData.data.length; i++, gridObj.rowCount++)
            {
                keyValue    =    "AYEAR|" + ajaxData.data[i].AYEAR + "|SMS|" + ajaxData.data[i].SMS + "|STNO|" + ajaxData.data[i].STNO ;
				
				keyValueDel = "AYEAR|" + ajaxData.data[i].AYEAR +
							  "|SMS|" + ajaxData.data[i].SMS +
							  "|STNO|" + ajaxData.data[i].STNO;
				
				var TABLE_RMK =ajaxData.data[i].TABLE_RMK;
				
				top.TABLE_RMK = TABLE_RMK;
				if( TABLE_RMK =='SGUT039'){
                /** 判斷權限 */
                if (chkSecure("DEL"))
                    delStr    =    "onkeypress=\"doDelete('" + keyValue + "');\"onclick=\"doDelete('" + keyValue + "');\"><a href=\"javascript:void(0)\">刪</a>";
                else
                    delStr    =    ">刪";

                if (chkSecure("UPD"))
                    editStr    =    "onkeypress=\"doEdit('" + keyValue + "');\"onclick=\"doEdit('" + keyValue + "');\"><a href=\"javascript:void(0)\">編</a>";
                else
                    editStr    =    ">編";
                    
                }else if( TABLE_RMK =='SOLT003'){					
					editStr    =    "onkeypress=\"setStno('"+ajaxData.data[i].STNO+"');doAdd();\"onclick=\"setStno('"+ajaxData.data[i].STNO+"');doAdd();\"><a\">招生資料</a>";
					FLAG 	= 	"disabled";
				}

                gridObj.gridHtml.append
                (
                    "<tr class=\"listColor0" + ((gridObj.rowCount % 2) + 1) + "\">\
                        <td align=center><input type=checkbox name='chkBox' value=\"" + keyValueDel + "\" " + FLAG  + "></td>\
                        <td align=center " + editStr + "</td>\
                        <td>" + ajaxData.data[i].AYEAR + ajaxData.data[i].CSMS + "&nbsp;</td>\
                        <td>" + ajaxData.data[i].NAME + "&nbsp;</td>\
                        <td>" + ajaxData.data[i].STNO + "&nbsp;</td>\
                        <td>" + ajaxData.data[i].CENTER_ABBRNAME + "&nbsp;</td>\
                        <td>" + ajaxData.data[i].STTYPE1 + "&nbsp;</td>\
                        <td>" + ajaxData.data[i].IDNO + "&nbsp;</td>\
                        <td>" + ajaxData.data[i].BIRTHDATE + "&nbsp;</td>\
                        <td>" + ajaxData.data[i].SEX1 + "&nbsp;</td>\
                        <td>" + ajaxData.data[i].MOBILE + "&nbsp;</td>\
                        <td>" + ajaxData.data[i].FATHER_NAME + "&nbsp;</td>\
                        <td>" + ajaxData.data[i].CFATHER_ORIGINAL_COUNTRY + "&nbsp;</td>\
                        <td>" + ajaxData.data[i].MOTHER_NAME + "&nbsp;</td>\
                        <td>" + ajaxData.data[i].CMOTHER_ORIGINAL_COUNTRY + "&nbsp;</td>\
                        <td>" + ajaxData.data[i].AUDIT_MK1 + "&nbsp;</td>\
                    </tr>"
                );

                exportBuff.append
                (
                    ajaxData.data[i].NAME + "," +
                    ajaxData.data[i].STNO + "," +
                    ajaxData.data[i].CENTER_CODE1 + "," +
                    ajaxData.data[i].STTYPE1 + "," +
                    ajaxData.data[i].IDNO + "," +
                    ajaxData.data[i].BIRTHDATE + "," +
                    ajaxData.data[i].SEX1 + "," +
                    ajaxData.data[i].MOBILE + "," +
                    ajaxData.data[i].FATHER_NAME1 + "," +
                    ajaxData.data[i].FATHER_ORIGINAL_COUNTRY1 + "," +
                    ajaxData.data[i].MOTHER_NAME1 + "," +
                    ajaxData.data[i].MOTHER_ORIGINAL_COUNTRY1 + "\r\n"
                );
            }
            gridObj.gridHtml.append ("</table>");
            Form.setInput ("RESULT", "ALL_CONTENT", exportBuff.toString());

            /** 無符合資料 */
            if (ajaxData.data.length == 0)
                gridObj.gridHtml.append ("<font color=red><b>　　　查無符合資料!!</b></font>");

            iniGrid_end(ajaxData, gridObj, keyValue);
        }
        sendFormData("QUERY", controlPage, "QUERY_MODE", callBack);
    }
}

/** 處理匯出動作 */
function doExport(type)
{
    var    header        =    "學年, 學期, 學號, 原住民家長族別\r\n";

    /** 處理匯入功能 匯出種類, 標題, 一次幾筆, 程式名稱, 寬度, 高度 */
    processExport(type, header, 4, 'sgu060m', 500, 200);
}

/** 查詢功能時呼叫 */
function doQuery()
{
    doQuery_start();

    /** === 自定檢查 === */
    /** 資料檢核及設定, 當有錯誤處理方式為 Form.errAppend(Message) 累計錯誤訊息 */
    //if (Form.getInput("QUERY", "SYS_CD") == "")
    //    Form.errAppend("系統編號不可空白!!");
    /** ================ */

    return doQuery_end();
}

/** 新增功能時呼叫 */
function doAdd()
{
    /** 開啟新增 Frame */
    top.showView();

    /** 呼叫新增 */
    top.viewFrame.doAdd();
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
            noPermissAry[noPermissAry.length]    =    "QRY";
            try{Form.iniFormSet("QUERY", "QUERY_BTN", "D", 1);}catch(ex){}
        }
        /** 新增 */
        if (!<%=AUTICFM.securityCheck (session, "ADD")%>)
        {
            noPermissAry[noPermissAry.length]    =    "ADD";
            editMode    =    "NONE";
            try{Form.iniFormSet("EDIT", "ADD_BTN", "D", 1);}catch(ex){}
        }
        /** 修改 */
        if (!<%=AUTICFM.securityCheck (session, "UPD")%>)
        {
            noPermissAry[noPermissAry.length]    =    "UPD";
        }
        /** 新增及修改 */
        if (!chkSecure("ADD") && !chkSecure("UPD"))
        {
            try{Form.iniFormSet("EDIT", "SAVE_BTN", "D", 1);}catch(ex){}
        }
        /** 刪除 */
        if (!<%=AUTICFM.securityCheck (session, "DEL")%>)
        {
            noPermissAry[noPermissAry.length]    =    "DEL";
            try{Form.iniFormSet("RESULT", "DEL_BTN", "D", 1);}catch(ex){}
        }
        /** 匯出 */
        if (!<%=AUTICFM.securityCheck (session, "EXP")%>)
        {
            noPermissAry[noPermissAry.length]    =    "EXP";
            try{Form.iniFormSet("RESULT", "EXPORT_BTN", "D", 1);}catch(ex){}
            try{Form.iniFormSet("QUERY", "EXPORT_ALL_BTN", "D", 1);}catch(ex){}
        }
        /** 列印 */
        if (!<%=AUTICFM.securityCheck (session, "PRT")%>)
        {
            noPermissAry[noPermissAry.length]    =    "PRT";
            try{Form.iniFormSet("RESULT", "PRT_BTN", "D", 1);}catch(ex){}
            try{Form.iniFormSet("QUERY", "PRT_ALL_BTN", "D", 1);}catch(ex){}
        }
        /** RT1 */
        if (!<%=AUTICFM.securityCheck (session, "RT1")%>)
        {
            noPermissAry[noPermissAry.length]    =    "RT1";
            try{Form.iniFormSet("QUERY", "RT1_BTN", "D", 1);}catch(ex){}
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

// 新增招生新住民子女資料
function doSolBatchAdd(){
	/** 檢核設定欄位*/
	Form.startChkForm("QUERY");

	/** 減核錯誤處理 */
	if (!queryObj.valideMessage (Form))
		return;
	
	if(!confirm(''+_i("QUERY", "AYEAR").value+_i('QUERY', 'SMS').options[_i('QUERY', 'SMS').selectedIndex].text+'學年期資料，是否繼續(Y/N)?')){
		return;
	}	
	
	var	callBack	=	function doSolBatchAdd.callBack(ajaxData) 
	{
		alert('新增完畢');
		iniGrid();
	}
	sendFormData("QUERY", controlPage, "DO_SOL_BATCH_ADD_MODE", callBack);
}