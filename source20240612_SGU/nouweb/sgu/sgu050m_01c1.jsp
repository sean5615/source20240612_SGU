<%/*
----------------------------------------------------------------------------------
File Name		: sgu050m_01c1
Author			: �T�W
Description		: sgu050m_ �@�ΥN�X���@ - ����� (javascript)
Modification Log	:

Vers		Date       	By            	Notes
--------------	--------------	--------------	----------------------------------
0.0.1		095/10/26	�T�W    	Code Generate Create
----------------------------------------------------------------------------------
*/%>
<%@ page contentType="text/html; charset=UTF-8" errorPage="/utility/errorpage.jsp" pageEncoding="MS950"%>
<%@ include file="/utility/header.jsp"%>
<%@ include file="/utility/jspageinit.jsp"%>

/** �פJ javqascript Class */
doImport ("Query.js, ErrorHandle.js, LoadingBar_0_2.js, Form.js, Ajax_0_2.js, ArrayUtil.js, ReSize.js, SortTable.js");

/** ��l�]�w������T */
var	printPage		=	"/sgu/sgu050m_01p1.jsp";	//�C�L����
var	editMode		=	"ADD";				//�s��Ҧ�, ADD - �s�W, MOD - �ק�
var	lockColumnCount		=	-1;				//��w����
var	listShow		=	false;				//�O�_�@�i�J��ܸ��
var	_privateMessageTime	=	-1;				//�T����ܮɶ�(���ۭq�� -1)
var	pageRangeSize		=	10;				//�e���@����ܴX�����
var	controlPage		=	"/sgu/sgu050m_01c2.jsp";	//�����
var	checkObj		=	new checkObj();			//�ֿ露��
var	queryObj		=	new queryObj();			//�d�ߤ���
var	importSelect		=	false;				//�פJ������\��
var	noPermissAry		=	new Array();			//�S���v�����}�C

/** ������l�� */
function page_init()
{
	page_init_start();
	
	
	/** �v���ˮ� */
	securityCheck();

	/** === ��l���]�w === */
	/** ��l�W�h�a�Ӫ� Key ��� */
	iniMasterKeyColumn();

	/** ��l�d����� */
	Form.iniFormSet('QUERY', 'KIND', 'M',  18, 'A', 'SE', 'U');
	Form.iniFormSet('QUERY', 'KIND_NAME', 'R', 1, 'M',  20, 'A');

	/** ��l�s����� */
	Form.iniFormSet('EDIT', 'KIND', 'R', 1, 'SE', 'M',  18, 'U', 'A', 'D', 1);
	Form.iniFormSet('EDIT', 'KIND_NAME', 'M',  20, 'A', 'D', 1);
	Form.iniFormSet('EDIT', 'CODE', 'R', 1, 'EN', 'M',  4, 'U', 'A', 'D', 1);
	Form.iniFormSet('EDIT', 'CODE_NAME', 'M',  20, 'A', 'D', 1);
	Form.iniFormSet('EDIT', 'HANDICAP_EDU_CODE', 'M',  2, 'EN');
	Form.iniFormSet('EDIT', 'HANDICAP_EDU_NAME', 'M',  20);

	loadind_.showLoadingBar (15, "��l��짹��");
	/** ================ */

	/** === �]�w�ˮֱ��� === */
	/** �d����� */

	/** �s����� */
	//Form.iniFormSet('EDIT', 'HANDICAP_EDU_NAME', 'AA', 'chkForm', '�S�к��W��');
	Form.iniFormSet('EDIT', 'HANDICAP_EDU_CODE', 'AA', 'chkForm', '�S�к��N�X');
	Form.iniFormSet('EDIT', 'KIND', 'AA', 'chkForm', '�N�X����');
	Form.iniFormSet('EDIT', 'CODE', 'AA', 'chkForm', '�N�X');
	Form.iniFormSet('EDIT', 'KIND_NAME', 'AA', 'chkForm', '�N�X�����W��');
	Form.iniFormSet('EDIT', 'CODE_NAME', 'AA', 'chkForm', '�N�X�W��');

	loadind_.showLoadingBar (20, "�]�w�ֱ��󧹦�");
	/** ================ */

	page_init_end();
}

/**
��l�� Grid ���e
@param	stat	�I�s���A(init -> ������l��)
*/
function iniGrid(stat)
{
	var	gridObj	=	new Grid();

	iniGrid_start(gridObj)

	/** �]�w���Y */
	gridObj.heaherHTML.append
	(
		"<table id=\"RsultTable\" class='sortable' width=\"100%\" border=\"1\" cellpadding=\"2\" cellspacing=\"0\" bordercolor=\"#E6E6E6\">\
			<tr class=\"mtbGreenBg\">\
				<td width=20>&nbsp;</td>\
				<td width=20>&nbsp;</td>\
				<td resize='on' nowrap>�N�X����</td>\
				<td resize='on' nowrap>�N�X�����W��</td>\
				<td resize='on' nowrap>�N�X</td>\
				<td resize='on' nowrap>�N�X�W��</td>\
				<td resize='on' nowrap>�S�к��N�X</td>\
				<td resize='on' nowrap>�S�к��W��</td>\
			</tr>"
	);

	if (stat == "init" && !listShow)
	{
		/** ��l�ƤΤ���ܸ�ƥu�q���Y */
		document.getElementById("grid-scroll").innerHTML	=	gridObj.heaherHTML.toString().replace(/\t/g, "") + "</table>";
		Message.hideProcess();
	}
	else
	{
		/** �B�z�s�u����� */
		/** �����϶��P�B */
		Form.setInput ("QUERY", "pageSize",	Form.getInput("RESULT", "_scrollSize"));
		Form.setInput ("QUERY", "pageNo",	Form.getInput("RESULT", "_goToPage"));
		
		/** �B�z�s�u����� */
		var	callBack	=	function iniGrid.callBack(ajaxData)
		{
		if (ajaxData == null)
			return;

		/** �]�w�� */
		var	keyValue	=	"";
		var	editStr		=	"";
		var	delStr		=	"";
		var	exportBuff	=	new StringBuffer();
		
		for (var i = 0; i < ajaxData.data.length; i++, gridObj.rowCount++)
		{
			keyValue	=	"KIND|" + ajaxData.data[i].KIND + "|CODE|" + ajaxData.data[i].CODE;

			/** �P�_�v�� */
			if (chkSecure("DEL"))
				delStr	=	"onkeypress=\"doDelete('" + keyValue + "');\"onclick=\"doDelete('" + keyValue + "');\"><a href=\"javascript:void(0)\">�R</a>";
			else
				delStr	=	">�R";

			if (chkSecure("UPD"))
				editStr	=	"onkeypress=\"doEdit('" + keyValue + "');\"onclick=\"doEdit('" + keyValue + "');\"><a href=\"javascript:void(0)\">�s</a>";
			else
				editStr	=	">�s";

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

		/** �L�ŦX��� */
		if (ajaxData.data.length == 0)
			gridObj.gridHtml.append ("<font color=red><b>�@�@�@�d�L�ŦX���!!</b></font>");

		iniGrid_end(ajaxData, gridObj);
		}
		sendFormData("QUERY", controlPage, "QUERY_MODE", callBack);
		
	}
}

/** �d�ߥ\��ɩI�s */
function doQuery()
{
	doQuery_start();

	/** === �۩w�ˬd === */
	loadind_.showLoadingBar (8, "�۩w�ˮֶ}�l");

	/** ����ˮ֤γ]�w, �����~�B�z�覡�� Form.errAppend(Message) �֭p���~�T�� */
	//if (Form.getInput("QUERY", "SYS_CD") == "")
	//	Form.errAppend("�t�νs�����i�ť�!!");

	loadind_.showLoadingBar (10, "�۩w�ˮ֧���");
	/** ================ */

	return doQuery_end();
}

/** �ק�\��ɩI�s */
function doModify()
{
	/** �]�w�ק�Ҧ� */
	editMode		=	"UPD";
	EditStatus.innerHTML	=	"�ק�";

}

/** �s�ɥ\��ɩI�s */
function doSave()
{
	doSave_start();
	
	/** �P�_�s�W�L�v�����B�z */
	if (editMode == "NONE"){
		Message.hideProcess();
		return;
	}
	
	/** === �۩w�ˬd === */
	//loadind_.showLoadingBar (8, "�۩w�ˮֶ}�l");

	/** ����ˮ֤γ]�w, �����~�B�z�覡�� Form.errAppend(Message) �֭p���~�T�� */
	//if (Form.getInput("QUERY", "SYS_CD") == "")
	//	Form.errAppend("�t�νs�����i�ť�!!");

	//loadind_.showLoadingBar (10, "�۩w�ˮ֧���");
	/** ================ */

	doSave_end();
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
			noPermissAry[noPermissAry.length]	=	"QRY";
			try{Form.iniFormSet("QUERY", "QUERY_BTN", "D", 1);}catch(ex){}
		}
		/** �s�W */
		if (!<%=AUTICFM.securityCheck (session, "ADD")%>)
		{
			noPermissAry[noPermissAry.length]	=	"ADD";
			editMode	=	"NONE";
			try{Form.iniFormSet("EDIT", "ADD_BTN", "D", 1);}catch(ex){}
		}
		/** �ק� */
		if (!<%=AUTICFM.securityCheck (session, "UPD")%>)
		{
			noPermissAry[noPermissAry.length]	=	"UPD";
		}
		/** �s�W�έק� */
		if (!chkSecure("ADD") && !chkSecure("UPD"))
		{
			try{Form.iniFormSet("EDIT", "SAVE_BTN", "D", 1);}catch(ex){}
		}
		/** �R�� */
		if (!<%=AUTICFM.securityCheck (session, "DEL")%>)
		{
			noPermissAry[noPermissAry.length]	=	"DEL";
			try{Form.iniFormSet("RESULT", "DEL_BTN", "D", 1);}catch(ex){}
		}
		/** �ץX */
		if (!<%=AUTICFM.securityCheck (session, "EXP")%>)
		{
			noPermissAry[noPermissAry.length]	=	"EXP";
			try{Form.iniFormSet("RESULT", "EXPORT_BTN", "D", 1);}catch(ex){}
			try{Form.iniFormSet("QUERY", "EXPORT_ALL_BTN", "D", 1);}catch(ex){}
		}
		/** �C�L */
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

/** �ˬd�v�� - ���v��/�L�v��(true/false) */
function chkSecure(secureType)
{
	if (noPermissAry.toString().indexOf(secureType) != -1)
		return false;
	else
		return true
}
/** ====================================================================================== */


/** �s�W�\��ɩI�s */
function doAdd()
{
	doAdd_start();

	/** �M����Ū����(KEY)*/

	/** ��l�W�h�a�Ӫ� Key ��� */
	iniMasterKeyColumn();

	/** �]�w Focus */

	/** ��l�� Form �C�� */
	Form.iniFormColor();

	/** ����B�z */
	queryObj.endProcess ("�s�W���A����");
}