<%/*
----------------------------------------------------------------------------------
File Name		: sgu123r_01c1
Author			: Maggie
Description		: SGU123R_�ץX�s����[�l�k�W�U���- ��ܭ���
Modification Log	:

Vers		Date       	By            	Notes
--------------	--------------	--------------	----------------------------------
0.0.1		106/04/20	Maggie    	Code Generate Create
----------------------------------------------------------------------------------
*/%>
<%@ page contentType="text/html; charset=UTF-8" errorPage="/utility/errorpage.jsp" pageEncoding="MS950"%>
<%@ include file="/utility/header.jsp"%>
<%@ include file="/utility/jspageinit.jsp"%>

/** �פJ javqascript Class */
doImport ("ErrorHandle.js, LoadingBar_0_2.js, Form.js");

/** ��l�]�w������T */
var	printPage		=	"sgu123r_01p1.jsp";	//�C�L����
var	_privateMessageTime	=	-1;			//�T����ܮɶ�(���ۭq�� -1)
var	controlPage		=	"sgu123r_01c2.jsp";
var	noPermissAry		=	new Array();		//�S���v�����}�C

/** ������l�� */
function page_init()
{
	page_init_start();

	/** �v���ˮ� */
	securityCheck();
	
	iniMasterKeyColumn();

	/** === ��l���]�w === */
	/** ��l�C�L��� */	
	Form.iniFormSet('QUERY', 'AYEAR', 'M',  3, 'A', 'F', 3,'N1','s',3);
	Form.iniFormSet('QUERY', 'SMS', 'M',  1, 'A');
	Form.iniFormSet('QUERY', 'AYEAR', 'AA', 'chkForm', '�Ǧ~');
	Form.iniFormSet('QUERY', 'SMS', 'AA', 'chkForm', '�Ǵ�');
	
	/** ================ */

	/** === �]�w�ˮֱ��� === */
	/** �C�L��� */
	
	/** ================ */

	page_init_end();
}

function doExport() {
	
	Form.startChkForm("QUERY");

	/** ��ֿ��~�B�z */
	if (!queryObj.valideMessage (Form))
		return;

	
	Form.setInput('QUERY', 'control_type',		'EXPORT_ALL_MODE');
	Form.doSubmit('QUERY',controlPage,'post','');
	
}

/** ============================= ���ץ��{����m�� ======================================= */
/** �]�w�\���v�� */
function securityCheck()
{
	try
	{
		/** �C�L */
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

/** �ˬd�v�� - ���v��/�L�v��(true/false) */
function chkSecure(secureType)
{
	if (noPermissAry.toString().indexOf(secureType) != -1)
		return false;
	else
		return true
}
/** ====================================================================================== */

/** ��l�W�h�a�Ӫ� Key ��� */
function iniMasterKeyColumn()
{
	/** �D Detail �������B�z */
	if (typeof(keyObj) == "undefined")
		return;
	/** ��� */
	for (keyName in keyObj)
	{
		try {Form.iniFormSet("QUERY", keyName, "V", keyObj[keyName], "R", 0);}catch(ex){};
		try {Form.iniFormSet("EDIT", keyName, "V", keyObj[keyName], "R", 0);}catch(ex){};
	}
	Form.iniFormColor();
}