<%/*
----------------------------------------------------------------------------------
File Name        : sgu060m_02c1
Author            : Jason
Description        : SGU060M_維護新住民子女資料 - 編輯控制頁面 (javascript)
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
doImport ("ErrorHandle.js, LoadingBar_0_2.js, Form.js, Ajax_0_2.js, ArrayUtil.js");

/** 初始設定頁面資訊 */
var    currPage        =    "<%=request.getRequestURI()%>";
var    printPage        =    "sgu060m_01p1.htm";    //列印頁面
var    editMode        =    "ADD";                //編輯模式, ADD - 新增, MOD - 修改
var    _privateMessageTime    =    -1;                //訊息顯示時間(不自訂為 -1)
var    controlPage        =    "sgu060m_01c2.jsp";    //控制頁面
var    queryObj        =    new queryObj();            //查詢元件

/** 網頁初始化 */
function page_init()
{
    page_init_start_2();

    /** === 初始欄位設定 === */
    /** 初始編輯欄位 */
    Form.iniFormSet('EDIT', 'AYEAR', 'N1', 'M', 3, 'A', 'F', 3,'S',3);
    Form.iniFormSet('EDIT', 'SMS', 'M', 1, 'A');
    Form.iniFormSet('EDIT', 'STNO', 'N1', 'M', 9,'S',9, 'A');
    Form.iniFormSet('EDIT', 'FATHER_NAME', 'M',  20, 'A');
    Form.iniFormSet('EDIT', 'FATHER_ORIGINAL_COUNTRY', 'M',  2, 'A');
    Form.iniFormSet('EDIT', 'MOTHER_NAME', 'M',  20, 'A');
    Form.iniFormSet('EDIT', 'MOTHER_ORIGINAL_COUNTRY', 'M',  2, 'A');
    Form.iniFormSet('EDIT', 'AUDIT_MK', 'M',  1, 'A');

    /** ================ */

    /** === 設定檢核條件 === */
    /** 編輯欄位 */
    Form.iniFormSet('EDIT', 'AYEAR', 'AA', 'chkForm', '學年');
    Form.iniFormSet('EDIT', 'SMS', 'AA', 'chkForm', '學期');
    Form.iniFormSet('EDIT', 'STNO', 'AA', 'chkForm', '學號');
    Form.iniFormSet('EDIT', 'FATHER_NAME', 'AA', 'chkForm', '父親姓名');
    Form.iniFormSet('EDIT', 'FATHER_ORIGINAL_COUNTRY', 'AA', 'chkForm', '父親國別');
    Form.iniFormSet('EDIT', 'MOTHER_NAME', 'AA', 'chkForm', '母親姓名');
	Form.iniFormSet('EDIT', 'MOTHER_ORIGINAL_COUNTRY', 'AA', 'chkForm', '母親國別');
    /** ================ */

    page_init_end_2();
}

/** 新增功能時呼叫 */
function doAdd()
{
    doAdd_start();

    /** 清除唯讀項目(KEY)*/
    Form.iniFormSet('EDIT', 'AYEAR', 'R', 0);
    Form.iniFormSet('EDIT', 'SMS', 'R', 0);
    Form.iniFormSet('EDIT', 'STNO', 'R', 0);


    /** 初始上層帶來的 Key 資料 */
    iniMasterKeyColumn();

    /** 設定 Focus */
    Form.iniFormSet('EDIT', 'AYEAR', 'FC');

    /** 初始化 Form 顏色 */
    Form.iniFormColor();

    /** 停止處理 */
    queryObj.endProcess ("新增狀態完成");
}

/** 修改功能時呼叫 */
function doModify()
{
    /** 設定修改模式 */
    editMode        =    "UPD";
    EditStatus.innerHTML    =    "修改";

    /** 清除唯讀項目(KEY)*/
    Form.iniFormSet('EDIT', 'AYEAR', 'R', 1);
    Form.iniFormSet('EDIT', 'SMS', 'R', 1);
    Form.iniFormSet('EDIT', 'STNO', 'R', 1);


    /** 初始化 Form 顏色 */
    Form.iniFormColor();

    /** 設定 Focus */
    Form.iniFormSet('EDIT', 'NEW_RESIDENT', 'FC');
}

/** 存檔功能時呼叫 */
function doSave()
{
    doSave_start();

    /** 判斷新增無權限不處理 */
    if (editMode == "NONE")
        return;

    /** === 自定檢查 === */
    /** 資料檢核及設定, 當有錯誤處理方式為 Form.errAppend(Message) 累計錯誤訊息 */
    //if (Form.getInput("EDIT", "SYS_CD") == "")
    //    Form.errAppend("系統編號不可空白!!");
    /** ================ */

    doSave_end();
}

/** ============================= 欲修正程式放置區 ======================================= */
/** 設定功能權限 */
function securityCheck()
{
    try
    {
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
        if (<%=AUTICFM.securityCheck (session, "EXP")%>)
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