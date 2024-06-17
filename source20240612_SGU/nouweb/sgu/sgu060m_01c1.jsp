<%/*
----------------------------------------------------------------------------------
File Name        : sgu060m_01c1
Author            : Jason
Description        : SGU060M_���@�s����l�k��� - ����� (javascript)
Modification Log    :

Vers        Date           By                Notes
--------------    --------------    --------------    ----------------------------------
0.0.1        096/07/25    Jason        Code Generate Create
----------------------------------------------------------------------------------
*/%>
<%@ page contentType="text/html; charset=UTF-8" errorPage="/utility/errorpage.jsp" pageEncoding="MS950"%>
<%@ include file="/utility/header.jsp"%>
<%@ include file="/utility/jspageinit.jsp"%>

/** �פJ javqascript Class */
doImport ("Query.js, ErrorHandle.js, LoadingBar_0_2.js, Form.js, Ajax_0_2.js, ArrayUtil.js, ReSize.js, SortTable.js");

/** ��l�]�w������T */
var    printPage        =    "sgu060m_01p1.jsp";    //�C�L����
var    editMode        =    "ADD";                //�s��Ҧ�, ADD - �s�W, MOD - �ק�
var    lockColumnCount        =    -1;                //��w����
var    listShow        =    false;                //�O�_�@�i�J��ܸ��
var    _privateMessageTime    =    -1;                //�T����ܮɶ�(���ۭq�� -1)
var    pageRangeSize        =    10;                //�e���@����ܴX�����
var    controlPage        =    "sgu060m_01c2.jsp";    //�����
var    checkObj        =    new checkObj();            //�ֿ露��
var    queryObj        =    new queryObj();            //�d�ߤ���
var    importSelect        =    false;                //�פJ������\��
var    noPermissAry        =    new Array();            //�S���v�����}�C

/** ������l�� */
function page_init(loadTime)
{
    if (loadTime != "second")
        page_init_start();


    /** �v���ˮ� */
    securityCheck();

    /** === ��l���]�w === */
    /** ��l�W�h�a�Ӫ� Key ��� */
    iniMasterKeyColumn();

    /** ��l�d����� */
    Form.iniFormSet('QUERY', 'AYEAR', 'N1', 'M', 3, 'A', 'F', 3,'S',3);
    Form.iniFormSet('QUERY', 'SMS', 'M', 1, 'A');
    Form.iniFormSet('QUERY', 'STNO', 'N1', 'M', 9,'S',9, 'A');


    /** === �]�w�ˮֱ��� === */
    /** �d����� */
    //Form.iniFormSet('QUERY', 'AYEAR', 'AA', 'chkForm', '�Ǧ~');
    //Form.iniFormSet('QUERY', 'SMS', 'AA', 'chkForm', '�Ǵ�');

    /** ================ */

    if (loadTime != "second")
        page_init_end();
}

/**
��l�� Grid ���e
@param    stat    �I�s���A(init -> ������l��)
*/
function iniGrid(stat)
{
    var    gridObj    =    new Grid();

    iniGrid_start(gridObj)

    /** �]�w���Y */
    gridObj.heaherHTML.append
    (
        "<table id=\"RsultTable\" class='sortable' width=\"100%\" border=\"1\" cellpadding=\"2\" cellspacing=\"0\" bordercolor=\"#E6E6E6\" summary=\"�ƪ��Ϊ��\">\
                <tr class=\"mtbGreenBg\">\
                <td width=20>&nbsp;</td>\
                <td width=20>&nbsp;</td>\
                <td resize='on' nowrap>�Ǧ~��</td>\
                <td resize='on' nowrap>�ǥͩm�W</td>\
                <td resize='on' nowrap>�Ǹ�</td>\
                <td resize='on' nowrap>���ߧO</td>\
                <td resize='on' nowrap>�����O</td>\
                <td resize='on' nowrap>�����Ҧr��</td>\
                <td resize='on' nowrap>�X�ͤ��</td>\
                <td resize='on' nowrap>�ʧO</td>\
                <td resize='on' nowrap>��ʹq��</td>\
                <td resize='on' nowrap>���˩m�W</td>\
                <td resize='on' nowrap>���˰�O</td>\
                <td resize='on' nowrap>���˩m�W</td>\
                <td resize='on' nowrap>���˰�O</td>\
                <td resize='on' nowrap>�f��</td>\
            </tr>"
    );

    if (stat == "init" && !listShow)
    {
        /** ��l�ƤΤ���ܸ�ƥu�q���Y */
        document.getElementById("grid-scroll").innerHTML    =    gridObj.heaherHTML.toString().replace(/\t/g, "") + "</table>";
        Message.hideProcess();
    }
    else
    {
        /** �����϶��P�B */
        Form.setInput ("QUERY", "pageSize",    Form.getInput("RESULT", "_scrollSize"));
        Form.setInput ("QUERY", "pageNo",    Form.getInput("RESULT", "_goToPage"));

        /** �B�z�s�u����� */
        var    callBack    =    function iniGrid.callBack(ajaxData)
        {
            if (ajaxData == null)
                return;

            /** �]�w�� */
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
                /** �P�_�v�� */
                if (chkSecure("DEL"))
                    delStr    =    "onkeypress=\"doDelete('" + keyValue + "');\"onclick=\"doDelete('" + keyValue + "');\"><a href=\"javascript:void(0)\">�R</a>";
                else
                    delStr    =    ">�R";

                if (chkSecure("UPD"))
                    editStr    =    "onkeypress=\"doEdit('" + keyValue + "');\"onclick=\"doEdit('" + keyValue + "');\"><a href=\"javascript:void(0)\">�s</a>";
                else
                    editStr    =    ">�s";
                    
                }else if( TABLE_RMK =='SOLT003'){					
					editStr    =    "onkeypress=\"setStno('"+ajaxData.data[i].STNO+"');doAdd();\"onclick=\"setStno('"+ajaxData.data[i].STNO+"');doAdd();\"><a\">�ۥ͸��</a>";
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

            /** �L�ŦX��� */
            if (ajaxData.data.length == 0)
                gridObj.gridHtml.append ("<font color=red><b>�@�@�@�d�L�ŦX���!!</b></font>");

            iniGrid_end(ajaxData, gridObj, keyValue);
        }
        sendFormData("QUERY", controlPage, "QUERY_MODE", callBack);
    }
}

/** �B�z�ץX�ʧ@ */
function doExport(type)
{
    var    header        =    "�Ǧ~, �Ǵ�, �Ǹ�, �����a���ڧO\r\n";

    /** �B�z�פJ�\�� �ץX����, ���D, �@���X��, �{���W��, �e��, ���� */
    processExport(type, header, 4, 'sgu060m', 500, 200);
}

/** �d�ߥ\��ɩI�s */
function doQuery()
{
    doQuery_start();

    /** === �۩w�ˬd === */
    /** ����ˮ֤γ]�w, �����~�B�z�覡�� Form.errAppend(Message) �֭p���~�T�� */
    //if (Form.getInput("QUERY", "SYS_CD") == "")
    //    Form.errAppend("�t�νs�����i�ť�!!");
    /** ================ */

    return doQuery_end();
}

/** �s�W�\��ɩI�s */
function doAdd()
{
    /** �}�ҷs�W Frame */
    top.showView();

    /** �I�s�s�W */
    top.viewFrame.doAdd();
}

/** ============================= ���ץ��{����m�� ======================================= */
/** �]�w�\���v�� */
function securityCheck()
{
    try
    {
        /** �d�� */
        if (!<%=AUTICFM.securityCheck (session, "QRY")%>)
        {
            noPermissAry[noPermissAry.length]    =    "QRY";
            try{Form.iniFormSet("QUERY", "QUERY_BTN", "D", 1);}catch(ex){}
        }
        /** �s�W */
        if (!<%=AUTICFM.securityCheck (session, "ADD")%>)
        {
            noPermissAry[noPermissAry.length]    =    "ADD";
            editMode    =    "NONE";
            try{Form.iniFormSet("EDIT", "ADD_BTN", "D", 1);}catch(ex){}
        }
        /** �ק� */
        if (!<%=AUTICFM.securityCheck (session, "UPD")%>)
        {
            noPermissAry[noPermissAry.length]    =    "UPD";
        }
        /** �s�W�έק� */
        if (!chkSecure("ADD") && !chkSecure("UPD"))
        {
            try{Form.iniFormSet("EDIT", "SAVE_BTN", "D", 1);}catch(ex){}
        }
        /** �R�� */
        if (!<%=AUTICFM.securityCheck (session, "DEL")%>)
        {
            noPermissAry[noPermissAry.length]    =    "DEL";
            try{Form.iniFormSet("RESULT", "DEL_BTN", "D", 1);}catch(ex){}
        }
        /** �ץX */
        if (!<%=AUTICFM.securityCheck (session, "EXP")%>)
        {
            noPermissAry[noPermissAry.length]    =    "EXP";
            try{Form.iniFormSet("RESULT", "EXPORT_BTN", "D", 1);}catch(ex){}
            try{Form.iniFormSet("QUERY", "EXPORT_ALL_BTN", "D", 1);}catch(ex){}
        }
        /** �C�L */
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

/** �ˬd�v�� - ���v��/�L�v��(true/false) */
function chkSecure(secureType)
{
    if (noPermissAry.toString().indexOf(secureType) != -1)
        return false;
    else
        return true
}
/** ====================================================================================== */

// �s�W�ۥͷs����l�k���
function doSolBatchAdd(){
	/** �ˮֳ]�w���*/
	Form.startChkForm("QUERY");

	/** ��ֿ��~�B�z */
	if (!queryObj.valideMessage (Form))
		return;
	
	if(!confirm(''+_i("QUERY", "AYEAR").value+_i('QUERY', 'SMS').options[_i('QUERY', 'SMS').selectedIndex].text+'�Ǧ~����ơA�O�_�~��(Y/N)?')){
		return;
	}	
	
	var	callBack	=	function doSolBatchAdd.callBack(ajaxData) 
	{
		alert('�s�W����');
		iniGrid();
	}
	sendFormData("QUERY", controlPage, "DO_SOL_BATCH_ADD_MODE", callBack);
}