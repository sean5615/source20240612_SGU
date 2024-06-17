<%/*
----------------------------------------------------------------------------------
File Name		: stu002m_02c1
Author			: matt
Description		: ���@���y��� - �s�豱��� (javascript)
Modification Log	:

Vers		Date       	By            	Notes
--------------	--------------	--------------	----------------------------------
0.0.1		096/01/24	matt    		Code Generate Create
0.0.2		096/10/05	poto    		�������Y�H����������,�ﱼ�W�l�i�H�ק�
0.0.3		096/11/06	poto    	    �[�c�ק� for QA
0.0.4		097/03/19	lin	    	    �����Ҧr�����ťդ]�i�x�s
----------------------------------------------------------------------------------
*/%>
<%@ page contentType="text/html; charset=UTF-8" errorPage="/utility/errorpage.jsp" pageEncoding="MS950"%>
<%@ include file="/utility/header.jsp"%>
<%@ include file="/utility/jspageinit.jsp"%>

/** �פJ javqascript Class */
doImport ("Query.js, ErrorHandle.js, LoadingBar_0_2.js, Form.js, Ajax_0_2.js, ArrayUtil.js, ReSize.js, SortTable.js");

/** ��l�]�w������T */
var	currPage		=	"<%=request.getRequestURI()%>";
var	printPage		=	"/stu/stu002m_01p1.htm";	//�C�L����
var	editMode		=	"ADD";				//�s��Ҧ�, ADD - �s�W, MOD - �ק�
var	_privateMessageTime	=	-1;				//�T����ܮɶ�(���ۭq�� -1)
var	controlPage		=	"/stu/stu017m_01c2.jsp";	//�����
var	queryObj		=	new queryObj();			//�d�ߤ���

var	lockColumnCount		=	-1;				//��w����
var	listShow		=	false;				//�O�_�@�i�J��ܸ��
var	_privateMessageTime	=	-1;				//�T����ܮɶ�(���ۭq�� -1)
var	pageRangeSize		=	10;				//�e���@����ܴX�����
var	noPermissAry		=	new Array();			//�S���v�����}�C
/** ������l�� */
function page_init()
{
	page_init_start_2();	
	/** === ��l���]�w === */
	/** ��l�s����� */	
	Form.iniFormSet('EDIT', 'IDNO', 'R', 1, 'S', 10, 'M',  10, 'A');
	Form.iniFormSet('EDIT', 'BIRTHDATE', 'R', 1, 'S', 8, 'N1', 'M',  8, 'A', 'DT');
	Form.iniFormSet('EDIT', 'NAME', 'R', 1, 'S', 10, 'M',  10, 'FS'); 
	Form.iniFormSet('EDIT', 'ENG_NAME', 'S', 20, 'M',  20, 'A');
	Form.iniFormSet('EDIT', 'ALIAS', 'S', 20, 'M',  20, 'A');
	Form.iniFormSet('EDIT', 'DMSTADDR_ZIP', 'S', 5, 'N', 'M',  5, 'A');
	Form.iniFormSet('EDIT', 'DMSTADDR', 'S', 50, 'M',  50,'FS');
	Form.iniFormSet('EDIT', 'CRRSADDR_ZIP', 'S', 5, 'N', 'M',  5, 'A');
	Form.iniFormSet('EDIT', 'CRRSADDR', 'S', 50, 'M',  50,'FS');
	/*
	Form.iniFormSet('EDIT', 'AREACODE_OFFICE', 'S', 3, 'N', 'M',  3, 'A');
	Form.iniFormSet('EDIT', 'TEL_OFFICE', 'S', 12, 'N', 'M',  12, 'A');
	Form.iniFormSet('EDIT', 'TEL_OFFICE_EXT', 'S', 5, 'N', 'M',  5, 'A');
	Form.iniFormSet('EDIT', 'AREACODE_HOME', 'S', 3, 'N', 'M',  3, 'A');
	Form.iniFormSet('EDIT', 'TEL_HOME', 'S', 12, 'N', 'M',  12, 'A');
	*/
	Form.iniFormSet('EDIT', 'AREACODE_OFFICE', 'S', 3, 'M',  3, 'A');
	Form.iniFormSet('EDIT', 'TEL_OFFICE', 'S', 12, 'M',  12, 'A');
	Form.iniFormSet('EDIT', 'TEL_OFFICE_EXT', 'S', 5, 'M',  5, 'A');
	Form.iniFormSet('EDIT', 'AREACODE_HOME', 'S', 3, 'M',  3, 'A');
	Form.iniFormSet('EDIT', 'TEL_HOME', 'S', 12, 'M',  12, 'A');
	
	Form.iniFormSet('EDIT', 'MOBILE', 'S', 15, 'N', 'M',  15, 'A');
	Form.iniFormSet('EDIT', 'EMAIL', 'S', 30,'M',  60, 'A');
	Form.iniFormSet('EDIT', 'EMRGNCY_NAME', 'S', 6, 'M',  6);
	Form.iniFormSet('EDIT', 'EMRGNCY_TEL', 'S', 17, 'SE', 'M',  17, 'A');
	Form.iniFormSet('EDIT', 'EMRGNCY_RELATION', 'S', 4, 'M',  2);	
	Form.iniFormSet('EDIT', 'PASSPORT_NO', 'S', 15, 'M',  15);		
	Form.iniFormSet('EDIT', 'SPECIAL_MK','S',120,'M',50 ); 	
	Form.iniFormSet('EDIT', 'NEWNATION','S', 1 ); 	
	Form.iniFormSet('EDIT', 'RESIDENCE_DATE', 'R', 1, 'S', 8, 'N1', 'M',  8, 'A', 'DT');
	Form.iniFormSet('EDIT', 'PARENTS_RACE','S',50,'M',50 ); 	
	Form.iniFormSet('EDIT', 'HANDICAP_TYPE','S',50,'M',50 ); 	
	Form.iniFormSet('EDIT', 'NEW_RESIDENT_CHD','S',80,'M',50 );
	

	//���y���
	Form.iniFormSet('TAB2','STNO','R',1,'S',9);
	Form.iniFormSet('TAB2','NAME','R',1,'S',10);
	//****by poto
	Form.iniFormSet('TAB2','FTSTUD_ENROLL_AYEAR','R',1,'S',3);
	Form.iniFormSet('TAB2','FTSTUD_ENROLL_SMS','D',1);
	Form.iniFormSet('TAB2','SAYEAR','R',1,'S',3);
	Form.iniFormSet('TAB2','SSMS','D',1);
	Form.iniFormSet('TAB2','ESMS','D',1);
	Form.iniFormSet('TAB2','EAYEAR','R',1,'S',3);	
	Form.iniFormSet('TAB2','OTHER_REG_MK','R',1,'S',1);
	Form.iniFormSet('TAB2','TUTOR_CLASS_MK','R',1,'S',1);
	Form.iniFormSet('TAB2','SPCLASS_CODE','R',1,'S',15);
	Form.iniFormSet('TAB2','J_FACULTY_CODE','R',1,'S',15);
	Form.iniFormSet('TAB2','STOP_PRVLG_SAYEAR','N1','F', 3 ,'S',3,'M', 3);	
	Form.iniFormSet('TAB2','STOP_PRVLG_EAYEAR','N1','F', 3 ,'S',3,'M', 3);	
	//***by poto
	Form.iniFormSet('TAB2','CENTER_CODE','R',1,'S',20);
	Form.iniFormSet('TAB2','STTYPE','R',1,'S',10);
	Form.iniFormSet('TAB2','ENROLL_AYEAR','R',1,'S',3);
	Form.iniFormSet('TAB2','ENROLL_SMS','D',1);
	Form.iniFormSet('TAB2','GRAD_AYEAR','R',1,'N1','F', 3 ,'S',3,'M', 3);	
	Form.iniFormSet('TAB2','GRAD_SMS','D',1);
	Form.iniFormSet('TAB2','NOU_EMAIL','R',1,'S',13);
	Form.iniFormSet('TAB2','DROPOUT_AYEAR','R',1,'N1','F', 3 ,'S',3,'M', 3);	
	Form.iniFormSet('TAB2','DROPOUT_SMS','D',1);	
	Form.iniFormSet('TAB2','PRE_MAJOR_FACULTY');
	Form.iniFormSet('TAB2','GRAD_MAJOR_FACULTY','R',1,'S',20);
	Form.iniFormSet('TAB2','DBMAJOR_MK','R',1,'S',1);
	Form.iniFormSet('TAB2','SPCLASS_TYPE','R',1,'S',10);	
	Form.iniFormSet('TAB2','SPECIAL_STTYPE_TYPE', 'M', 1);
	Form.iniFormSet('TAB2','SPECIAL_AYEAR', 'M', 3, 'S', 3, 'F', 3);
	Form.iniFormSet('TAB2','SPECIAL_SMS','M',1);
	_i('TAB2','SPECIAL_STTYPE_TYPE').onchange = function() {changeAyearSms();};
	Form.iniFormSet('TAB2', 'EDUBKGRD','D',1, 'S', 60, 'M',  100);	
	Form.iniFormSet('TAB2','REDUCE_TYPE','R',1,'S',60, 'M', 60);
	Form.iniFormSet('TAB2', 'GRAD_KIND_1','D',30, 'S', 30, 'M',  30);
	Form.iniFormSet('TAB2', 'EDUBKGRD_ABILITY','D',10, 'S', 10, 'M',  10);
	/** �s����� */
	Form.iniFormSet('EDIT', 'SEX', 'AA', 'chkForm', '�ʧO');
	Form.iniFormSet('EDIT', 'BIRTHDATE', 'AA', 'chkForm', '�X�ͤ��');
	Form.iniFormSet('EDIT', 'NAME', 'AA', 'chkForm', '�m�W');	
	Form.iniFormSet('EDIT', 'VOCATION', 'AA', 'chkForm', '¾�~');
	Form.iniFormSet('EDIT', 'EDUBKGRD_GRADE', 'AA', 'chkForm', '�Ǿ�����');	
	Form.iniFormSet('EDIT', 'CRRSADDR_ZIP', 'AA', 'chkForm', '�q�T�a�}�l���ϸ�');
	Form.iniFormSet('EDIT', 'CRRSADDR', 'AA', 'chkForm', '�q�T�a�}');
	Form.iniFormSet('EDIT', 'NATIONCODE', 'AA', 'chkForm', '���y');
	/** ================ */
    //���y���		
	page_init_end_2();		
	var stno=Form.getInput("EDIT","stno");	
	var backTo=Form.getInput("EDIT","backTo");
	var keyString = "";
	if(stno==''){
		if(backTo=="1")
			top.mainFrame.location.href	='stu017m_01v1.jsp?backTo=1';
		else
			top.mainFrame.location.href	='stu017m_01v1.jsp';
	}else{		
		top.stu002m_check="";
		top.detailFrame.location.href	='stu017m_01v1.jsp?stno='+stno;
		top.showDetail();
	}
	changeAyearSms();
}
// by poto 
function page_init_end_2()
{
	/** ����B�z */
	Message.hideProcess();
	
	/*@*/
	try{top.mainFrame.page_init("second");}catch(ex){}
	//by poto 2008/03/03
	if(Form.getInput("EDIT","LINK")!='CCS003M'&&Form.getInput("EDIT","LINK")!='CCS010M'&&Form.getInput("EDIT","LINK")!='CCS011M'&&Form.getInput("EDIT","LINK")!='CCS012M'){			
		doBack();
	}
	
}


/** �s�W�\��ɩI�s */
function doAdd()
{

	doAdd_start();

	/** �M����Ū����(KEY)*/
	Form.iniFormSet('EDIT', 'IDNO', 'R', 0);
	Form.iniFormSet('EDIT', 'BIRTHDATE', 'R', 0);


	/** ��l�W�h�a�Ӫ� Key ��� */
	iniMasterKeyColumn();

	/** �]�w Focus */
	Form.iniFormSet('EDIT', 'IDNO', 'FC');

	/** ��l�� Form �C�� */
	Form.iniFormColor();



	/** ����B�z */
	queryObj.endProcess ("�s�W���A����");
}

/** �ק�\��ɩI�s */
function doModify()
{
	top.stu002m_check = "SAVE";
	/** �]�w�ק�Ҧ� */
	editMode		=	"UPD";
	EditStatus.innerHTML	=	"�ק�";

	/** �M����Ū����(KEY)*/
	Form.iniFormSet('EDIT', 'IDNO', 'R', 1);
	Form.iniFormSet('EDIT', 'BIRTHDATE', 'R', 1);


	/** ��l�� Form �C�� */
	Form.iniFormColor();

	/** �]�w Focus */
	Form.iniFormSet('EDIT', 'NAME', 'FC');
}

/** �s�ɥ\��ɩI�s */
function doSave()
{
	top.stu002m_check = "SAVE";
	doSave_start();

	/** �P�_�s�W�L�v�����B�z */
	if (editMode == "NONE")
		return;
		
	var email = Form.getInput("EDIT","EMAIL");
	if (email != "" && !checkMail(email)) {
		Form.errAppend("�q�l�H�c�榡���~!!");
	}
	
	//���稭���Ҧr��
	if (document.EDIT.IDNO.value == ""){
		Form.errAppend("�����Ҧr�����i����!!");
	}	
	
	//	by poto
	Form.setInput("EDIT","PRE_MAJOR_FACULTY",Form.getInput("TAB2","PRE_MAJOR_FACULTY"));
	Form.setInput("EDIT","STOP_PRVLG_SAYEARSMS",Form.getInput("TAB2","STOP_PRVLG_SAYEAR")+Form.getInput("TAB2","STOP_PRVLG_SSMS"));
	Form.setInput("EDIT","STOP_PRVLG_EAYEARSMS",Form.getInput("TAB2","STOP_PRVLG_EAYEAR")+Form.getInput("TAB2","STOP_PRVLG_ESMS"));
	Form.setInput("EDIT","EDUBKGRD",Form.getInput("TAB2","EDUBKGRD"));
	Form.setInput("EDIT","SPECIAL_STTYPE_TYPE",Form.getInput("TAB2","SPECIAL_STTYPE_TYPE"));
	Form.setInput("EDIT","SPECIAL_AYEAR",Form.getInput("TAB2","SPECIAL_AYEAR"));
	Form.setInput("EDIT","SPECIAL_SMS",Form.getInput("TAB2","SPECIAL_SMS"));	
	/** ================ */

	doSave_end();
	
}

function doOpen1()
{
	var stno = "STNO|"+document.TAB2.STNO.value;
	doOpen(stno, 800, 400, '/stu/stu017m_03.jsp');
}

/** �}�� Detail ���� */
var	queryKeyStr	=	"";
function doOpen(keyStr, width, height, pageName)
{
	/** ��� */
	if (keyStr == null)
		keyStr		=	queryKeyStr;
	else
		queryKeyStr	=	keyStr;

	wdith	=	(width == null) ? 800 : width;
	height	=	(height == null) ? 600 : height;

	/** �N Key �զb URL �᭱�a�J */
	var	keyAry		=	keyStr.split("|");
	var	keyUrlBuff	=	new StringBuffer();

	for (var i = 0; i < keyAry.length; i += 2)
	{
		if (i == 0)
			keyUrlBuff.append ("?" + keyAry[i] + "=" + StrUtil.urlEncode(keyAry[i + 1]));
		else
			keyUrlBuff.append ("&" + keyAry[i] + "=" + StrUtil.urlEncode(keyAry[i + 1]));
	}

	/** 2006/12/07 �s�W�i�ۭq�ǤJ����, ���ǹw�]�� c1 �]�w���� */
	if (pageName == null)
		pageName	=	detailPage;

	/** 2006/12/4 �ѨM�ǪŦr�꦳ Bug �����D */
	var	openUrl	=	"";
	if (keyStr == '' && queryKeyStr == '')
		openUrl	=	_vp + "mainframe_open.jsp?mainPage=" + StrUtil.urlEncode(pageName);
	else
		openUrl	=	_vp + "mainframe_open.jsp?mainPage=" + StrUtil.urlEncode(pageName) + "&keyParam=" + StrUtil.urlEncode(keyUrlBuff.toString());
    var obj = QUERY;//by poto
	WindowUtil.openObjDialog (openUrl, wdith, height,  obj );// by poto
}
/** ============================= ���ץ��{����m�� ======================================= */
/** �]�w�\���v�� */
function securityCheck()
{
	try
	{
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
		if (<%=AUTICFM.securityCheck (session, "EXP")%>)
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

function setADDR(flag) {
	var objnm = "";
	if (flag == "1") {
		objnm = "DMSTADDR";
	} else {
		objnm = "CRRSADDR";
	}
	if (Form.getInput("EDIT",objnm) != "") return;
	var zip_city = Form.getInput("EDIT",objnm + "_ZIP_CITY");
	var zip_town = Form.getInput("EDIT",objnm + "_ZIP_TOWN");
	Form.setInput("EDIT",objnm,zip_city+zip_town);
}

function checkMail( str ) {
	var mailform = /^[-_a-z0-9A-Z\.]+@([-_a-z0-9A-Z]+\.)+[a-z0-9A-Z]{2,3}$/;
	//var mailform = /^.+@.+\..+?/;
	return  mailform.test( str );
}


function doTab(total, num)
{
	for (var i = 1; i <= total; i++)
	{
		eval('TabCnt' + i).style.display	=	'none';
		eval('TabBtn' + i).className	=	'tab_non_select';
	}
	eval('TabCnt' + num).style.display	=	'';
	eval('TabBtn' + num).className		=	'tab_select';
}

function iniGrid(stat)
{
	_i('QUERY','ASYS').value = _i('EDIT','ASYS').value;
	var	gridObj	=	new Grid();

	iniGrid_start(gridObj)

	/** �]�w���Y */
	gridObj.heaherHTML.append
	(
		"<table id=\"RsultTable\" class='sortable' width=\"100%\" border=\"1\" cellpadding=\"2\" cellspacing=\"0\" bordercolor=\"#E6E6E6\" summary=\"�ƪ��Ϊ��\">\
				<tr class=\"mtbGreenBg\">\
				<td resize='on' nowrap>�Ǧ~��</td>\
				<td resize='on' nowrap>�Ǹ�</td>\
				<td resize='on' nowrap>�m�W</td>\
				<td resize='on' nowrap>���W�����O</td>\
				<td resize='on' nowrap>���ߥN��</td>\
				<td resize='on' nowrap>��ҧ_</td>\
				<td resize='on' nowrap>�űM��էO</td>\
				<td resize='on' nowrap>��K���O</td>\
				<td resize='on' nowrap>���y���A</td>\
				<td resize='on' nowrap>���D�׵��O</td>\
				<td resize='on' nowrap>���ץͤJ�ǾǦ~��</td>\
				<td resize='on' nowrap>���ʻ���</td>\
				<td resize='on' nowrap>���ʤ��</td>\
				<td resize='on' nowrap>ú�O���O</td>\
				<td resize='on' nowrap>���ʤH���b��</td>\
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
		/** �����϶��P�B */
		Form.setInput ("QUERY", "pageSize",	Form.getInput("RESULT", "_scrollSize"));
		Form.setInput ("QUERY", "pageNo",	Form.getInput("RESULT", "_goToPage"));
		
		/** �B�z�s�u����� */
		var	callBack	=	function iniGrid.callBack(ajaxData)
		{

				/** �]�w�� */
				var	keyValue	=	"";
				var	editStr		=	"";
				var	delStr		=	"";
				var J_FACULTY_CODE = "";
				var CHOICE_YN = "";
				
				var	exportBuff	=	new StringBuffer();

				for (var i = 0; i < ajaxData.data.length; i++, gridObj.rowCount++)
				{
					if(_i('QUERY','ASYS').value=="2")
						J_FACULTY_CODE = ajaxData.data[i].J_FACULTY_CODE;
					else
						J_FACULTY_CODE = "";
					if(ajaxData.data[i].TAKE_ABNDN=="N" && (ajaxData.data[i].PAYMENT_STATUS_CODE=="2" || ajaxData.data[i].PAYMENT_STATUS_CODE=="4"))
						CHOICE_YN = "Y";
					else
						CHOICE_YN = "N";
					gridObj.gridHtml.append
					(
						"<tr class=\"listColor0" + ((gridObj.rowCount % 2) + 1) + "\">\
							<td nowrap>" + ajaxData.data[i].AYEAR + ajaxData.data[i].SMS_DESC + "&nbsp;</td>\
							<td>" + ajaxData.data[i].STNO + "&nbsp;</td>\
							<td nowrap>" + ajaxData.data[i].NAME + "&nbsp;</td>\
							<td>" + ajaxData.data[i].STTYPE_DESC + "&nbsp;</td>\
							<td>" + ajaxData.data[i].CENTER_CODE_DESC + "&nbsp;</td>\
							<td>" + CHOICE_YN + "&nbsp;</td>\
							<td>" + J_FACULTY_CODE + "&nbsp;</td>\
							<td>" + ajaxData.data[i].REDUCE_TYPE_DESC + "&nbsp;</td>\
							<td>" + ajaxData.data[i].ENROLL_STATUS_NAME + "&nbsp;</td>\
							<td>" + ajaxData.data[i].DBMAJOR_MK + "&nbsp;</td>\
							<td>" + ajaxData.data[i].FTSTUD_ENROLL_AYEARSMS + "&nbsp;</td>\
							<td>" + ajaxData.data[i].UPD_RMK + "&nbsp;</td>\
							<td>" + ajaxData.data[i].UPD_DATE + "&nbsp;</td>\
							<td>" + ajaxData.data[i].PAYMENT_STATUS + "&nbsp;</td>\
							<td>" + ajaxData.data[i].UPD_USER_ID + "&nbsp;</td>\
						</tr>"
					);
				}
				gridObj.gridHtml.append ("</table>");
				Form.setInput ("RESULT", "ALL_CONTENT", exportBuff.toString());		

				/** �L�ŦX��� */
				if (ajaxData.data.length == 0)
					gridObj.gridHtml.append ("<font color=red><b>�@�@�@�d�L�ŦX���!!</b></font>");

				iniGrid_end(ajaxData, gridObj);	
				DEP_CHECK(Form.getInput("EDIT","DEP_CODE"),Form.getInput("EDIT","SGU_CODE"));//�v���P�_				
		}
		sendFormData("QUERY", controlPage, "EDIT_QUERY_MODE3", callBack);
	}
}

function iniGrid_middle()
{
	/** �����϶��P�B */
	Form.setInput ("QUERY", "pageSize",	Form.getInput("RESULT", "_scrollSize"));
	Form.setInput ("QUERY", "pageNo",	Form.getInput("RESULT", "_goToPage"));   
	return sendFormData("QUERY", controlPage, "EDIT_QUERY_MODE3");
}/**
���U�s��ɩI�s
@param    args[0]    ��ưѼ�, �ܼƦW�� (KEY)
@param    args[1]    ���ưѼ�, �ܼƭ� (KEY)
*/
function doEdit_2(arguments)
{
    /** �}�l�B�z */	
    Message.showProcess();
	eval('TabCnt1').style.display	=	'none';
	eval('TabBtn1').className	=	'tab_non_select';
	eval('TabCnt2').style.display	=	'';
	eval('TabBtn2').className	=	'tab_select';
	eval('TabCnt3').style.display	=	'none';
	eval('TabBtn3').className	=	'tab_non_select';
	var editAry = "";
	if(arguments[0]==null)
		editAry = arguments.split("|");
	else
		editAry = arguments[0].split("|");
	var tmpValue = "";
    var k=0;
    for (i = 0; i < editAry.length; i += 2) {
        Form.setInput("EDIT", editAry[i], editAry[i + 1]);
		tmpValue += editAry[i] + "|" + editAry[i + 1];
		if(i+2 != editAry.length)
			tmpValue += "|";
    }	
	Form.setInput("EDIT", "TMPV", tmpValue);
    /** �e���ݳB�z */
    var callBack = function doEdit_2.callBack(ajaxData) {
        if (ajaxData == null)
            return;
        /** ���ƨ�e�� */   		
        for (column in ajaxData.data[0]) {		
            try {			
                Form.iniFormSet("EDIT",    column, "KV", ajaxData.data[0][column]);				
                /** �ץ��Y���}���۰ʱa�X */
					
                _i("EDIT", column).fireEvent("onblur");
            } catch(ex){}
        }		
        /** �]�w���ק�Ҧ� */
        doModify();
    }
	/** �e���ݳB�z */
    var callBack1 = function doEdit_2.callBack1(ajaxData) {
        if (ajaxData == null)
            return;
        /** ���ƨ�e�� */   		
        for (column in ajaxData.data[0]) {					
            try {
				if(column=="ENROLL_STATUS") {
					document.getElementById("ENROLL_STATUS").innerHTML = "<font color='red' size='2'>" + ajaxData.data[0][column] + "</font>";
				} else if(column=="GRAD_KIND") {
				//20200529�s�[�J �����쥻�����w���A �̾�grad_kind�ӧP�_�O�_��w
					if("D" == ajaxData.data[0][column]) {
						Form.iniFormSet('TAB2', 'EDUBKGRD', 'D', 1,'R',1);
						Form.iniFormSet('TAB2', 'EDUBKGRD_AYEAR', 'D', 1,'R',1);
						Form.iniFormSet('TAB2', 'EDUBKGRD_GRADE', 'D', 1,'R',1);
					}
				} else if(column=="EDUBKGRDABILITY"){
					document.getElementById("EduabilType").innerHTML = "<font>" + ajaxData.data[0][column] + "</font>";
				}else{
					Form.iniFormSet("TAB2",    column, "KV", ajaxData.data[0][column]);				
					/** �ץ��Y���}���۰ʱa�X */
				    _i("TAB2", column).fireEvent("onblur");
				}
				
            } catch(ex){}
        }
        
			
        /** �]�w���ק�Ҧ� */
        doModify();
		Form.setInput("QUERY","STNO",Form.getInput("TAB2","STNO"));
		iniGrid();			
    }	
    sendFormData("EDIT", controlPage, "EDIT_QUERY_MODE", callBack);	
    sendFormData("EDIT", controlPage, "EDIT_QUERY_MODE2", callBack1);		
    Message.hideProcess();
   
}


function DEP_CHECK(DEP_CODE,SGU_CODE){		
	Form.disableAll('TAB2',true);
	Form.disableAll('EDIT',true);	
	document.getElementById("a1").disabled = false; 	
	document.getElementById("a2").disabled = false; 
	document.getElementById("a5").disabled = false; 	
	if(SGU_CODE=='530'||DEP_CODE=='511'){
		document.getElementById("SPECIAL_MK_DATA").style.display = "";
	}
	Form.iniFormColor();
}

//by poto 2007/11/26
/** �s�ɥ\��ɩI�s���� */
function doSave_end()
{
	/** �ˮֳ]�w���*/	
	Form.startChkForm("EDIT");

	/** ��ֿ��~�B�z */
	if (!queryObj.valideMessage (Form))
		return;

	/** = �e�X��� = */
	/** �]�w���A */
	var	actionMode	=	"";
	if (editMode == "ADD")
		actionMode	=	"ADD_MODE";
	else
		actionMode	=	"EDIT_MODE";

	/** �ǰe�ܫ�ݦs�� */
	var	callBack	=	function doSave_end.callBack(ajaxData)
	{
		if (ajaxData == null)
			return;

		/** ��Ʒs�W���\�T�� */
		if (editMode == "ADD")
		{
			/** �]�w���s�W�Ҧ� */
			doAdd();
			alert("��Ʒs�W���\!");
			//Message.openSuccess("A01");
		}
		/** ��ƭק令�\�T�� */
		else
		{
			alert("��ƭק令�\!");
			//Message.openSuccess("A02", function (){top.hideView();});
			/** nono mark 2006/11/16 */
			//top.mainFrame.iniGrid();
			top.hideView();
		}
		/** ���] Grid 2006/11/16 nono add, 2007/01/07 �վ�P�_�覡 */	
		//by poto 2008/03/03
		if(Form.getInput("EDIT","LINK")=='CCS003M'||Form.getInput("EDIT","LINK")=='CCS010M'||Form.getInput("EDIT","LINK")=='CCS011M'||Form.getInput("EDIT","LINK")=='CCS012M'){		
			window.close();
		}else if (chkHasQuery()){				
			top.mainFrame.iniGrid();
		}		
	}
	sendFormData("EDIT", controlPage, actionMode, callBack, "111");
	doEdit_2(_i('EDIT', 'TMPV').value);
}

function chkHasQuery()
{
	/** 2007/03/26 �W�[��l�Y��ܧP�_���d�߹L�B�z */	
	if (top.mainFrame.listShow){	
		return true;
	}	
	//by poto 2007/11/26 ���ꪺ��k �ݭק�
	if(top.mainFrame.document.forms["QUERY"].length==16){
		return false;
	}
	for (var i = 0; i < top.mainFrame.document.forms["QUERY"].length; i++)
	{	
		if (typeof(top.mainFrame.document.forms["QUERY"].elements[i].chkForm) != "undefined" && top.mainFrame.document.forms["QUERY"].elements[i].value == '')
			return false;
	}
	return true;
}

function doBack()
{
	/** �����s�W Frame */
	//by poto 2008/03/03	
	if(Form.getInput("EDIT","LINK")=='CCS003M'||Form.getInput("EDIT","LINK")=='CCS010M'||Form.getInput("EDIT","LINK")=='CCS011M'||Form.getInput("EDIT","LINK")=='CCS012M'){			
		window.close();
	}else{	
		top.hideView();
	}
}

/**�Y���ʺ��ͩνп�ܡA�M�Ű_�l�Ǧ~��*/
function changeAyearSms()
{
	if(_i('TAB2', 'SPECIAL_STTYPE_TYPE').value == "" || _i('TAB2', 'SPECIAL_STTYPE_TYPE').value == "1")
	{
		_i('TAB2', 'SPECIAL_AYEAR').value = "";
		_i('TAB2', 'SPECIAL_SMS').value = "";
		/*
		Form.iniFormSet('TAB2', 'SPECIAL_AYEAR', 'D', 1);
		Form.iniFormSet('TAB2', 'SPECIAL_SMS', 'D', 1);
		*/
	}else{
		/*
		Form.iniFormSet('TAB2', 'SPECIAL_AYEAR', 'D', 0);
		Form.iniFormSet('TAB2', 'SPECIAL_SMS', 'D', 0);
		*/
	}
	/** ��l�� Form �C�� */
	Form.iniFormColor();
}

/** �s�ɥ\��ɩI�s */
function doSave1()
{
	top.stu002m_check = "SAVE";
	doSave_start();

	/** �P�_�s�W�L�v�����B�z */
	if (editMode == "NONE")
		return;

	/** === �۩w�ˬd === */

	var email = Form.getInput("EDIT","EMAIL");
	if (email != "" && !checkMail(email)) {
		Form.errAppend("�q�l�H�c�榡���~!!");
	}
	
	//�s�W�ˮְ��v�_���Ǧ~��---START    2008/06/03   by barry   
	if(_i('TAB2', 'STOP_PRVLG_SAYEAR').value != "" || _i('TAB2', 'STOP_PRVLG_SSMS').value != "" || _i('TAB2', 'STOP_PRVLG_EAYEAR').value != "" || _i('TAB2', 'STOP_PRVLG_ESMS').value != "")
	{
		if(_i('TAB2', 'STOP_PRVLG_SAYEAR').value == "")
			Form.errAppend("�п�J���v�_�Ǧ~!!");
		if(_i('TAB2', 'STOP_PRVLG_SSMS').value == "")
			Form.errAppend("�п�J���v�_�Ǵ�!!");
		if(_i('TAB2', 'STOP_PRVLG_EAYEAR').value == "")
			Form.errAppend("�п�J���v���Ǧ~!!");
		if(_i('TAB2', 'STOP_PRVLG_ESMS').value == "")
			Form.errAppend("�п�J���v���Ǵ�!!");
		if(_i('TAB2', 'STOP_PRVLG_SAYEAR').value != "" && _i('TAB2', 'STOP_PRVLG_SSMS').value != "" && _i('TAB2', 'STOP_PRVLG_EAYEAR').value != "" && _i('TAB2', 'STOP_PRVLG_ESMS').value != "")
		{
			var stopAyearSmsS = _i('TAB2', 'STOP_PRVLG_SAYEAR').value;
			var stopAyearSmsE = _i('TAB2', 'STOP_PRVLG_EAYEAR').value;
			if(_i('TAB2', 'STOP_PRVLG_SSMS').value == "3")
				stopAyearSmsS += "0";
			else
				stopAyearSmsS += _i('TAB2', 'STOP_PRVLG_SSMS').value;
			
			if(_i('TAB2', 'STOP_PRVLG_ESMS').value == "3")
				stopAyearSmsE += "0";
			else
				stopAyearSmsE += _i('TAB2', 'STOP_PRVLG_ESMS').value;
			
			if(stopAyearSmsS - stopAyearSmsE > 0)
				Form.errAppend("���v�_�Ǧ~�������j��ε����v���Ǧ~��!!");
		}
	}
	//�s�W�ˮְ��v�_���Ǧ~��---END    2008/06/03   by barry   
	
	//�s�W�ˮ֯S��͵��O �_�l�Ǧ~��---START  2008/07/30 by barry
	if(_i('TAB2', 'SPECIAL_STTYPE_TYPE').value != "")
	{
		if(_i('TAB2', 'SPECIAL_STTYPE_TYPE').value != "1")
		{
			if(_i('TAB2', 'SPECIAL_AYEAR').value == "" || _i('TAB2', 'SPECIAL_SMS').value == "")
			{
				Form.errAppend("�D�ʺ��͡A������J�_�l�Ǧ~��");
			}
		}
	}
	//�s�W�ˮ֯S��͵��O �_�l�Ǧ~��---END  2008/07/30 by barry
	
	//	by poto
	Form.setInput("EDIT","PRE_MAJOR_FACULTY",Form.getInput("TAB2","PRE_MAJOR_FACULTY"));
	Form.setInput("EDIT","STOP_PRVLG_SAYEARSMS",Form.getInput("TAB2","STOP_PRVLG_SAYEAR")+Form.getInput("TAB2","STOP_PRVLG_SSMS"));
	Form.setInput("EDIT","STOP_PRVLG_EAYEARSMS",Form.getInput("TAB2","STOP_PRVLG_EAYEAR")+Form.getInput("TAB2","STOP_PRVLG_ESMS"));
	Form.setInput("EDIT","EDUBKGRD",Form.getInput("TAB2","EDUBKGRD"));
	Form.setInput("EDIT","SPECIAL_STTYPE_TYPE",Form.getInput("TAB2","SPECIAL_STTYPE_TYPE"));
	Form.setInput("EDIT","SPECIAL_AYEAR",Form.getInput("TAB2","SPECIAL_AYEAR"));
	Form.setInput("EDIT","SPECIAL_SMS",Form.getInput("TAB2","SPECIAL_SMS"));
	/** ================ */

	doSave1_end();
}

function doSave1_end()
{
	/** �ˮֳ]�w���*/	
	Form.startChkForm("EDIT");

	/** ��ֿ��~�B�z */
	if (!queryObj.valideMessage (Form))
		return;

	/** = �e�X��� = */
	/** �]�w���A */
	var	actionMode	=	"";
	if (editMode == "ADD")
		actionMode	=	"ADD_MODE";
	else
		actionMode	=	"EDIT_MODE";
	Form.iniFormSet('TAB2', 'SPECIAL_AYEAR', 'D', 0);
	Form.iniFormSet('TAB2', 'SPECIAL_SMS', 'D', 0);
	/** �ǰe�ܫ�ݦs�� */
	var	callBack	=	function doSave_end.callBack(ajaxData)
	{
		if (ajaxData == null){
			return;
		}		
		alert("��ƭק令�\!");
		Message.hideProcess();
		//by poto 2008/03/03
		if(Form.getInput("EDIT","LINK")=='CCS003M'||Form.getInput("EDIT","LINK")=='CCS010M'||Form.getInput("EDIT","LINK")=='CCS011M'||Form.getInput("EDIT","LINK")=='CCS012M'){		
			window.close();
		}
	}
	sendFormData("EDIT", controlPage, actionMode, callBack, "111");
	changeAyearSms();
	doEdit_2(_i('EDIT', 'TMPV').value);
}

function doClose1()
{
	window.close();
}