<%/*
----------------------------------------------------------------------------------
File Name        : sgu060m_02c1
Author            : Jason
Description        : SGU060M_���@�s����l�k��� - �s�豱��� (javascript)
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
doImport ("ErrorHandle.js, LoadingBar_0_2.js, Form.js, Ajax_0_2.js, ArrayUtil.js");

/** ��l�]�w������T */
var    currPage        =    "<%=request.getRequestURI()%>";
var    printPage        =    "sgu060m_01p1.htm";    //�C�L����
var    editMode        =    "ADD";                //�s��Ҧ�, ADD - �s�W, MOD - �ק�
var    _privateMessageTime    =    -1;                //�T����ܮɶ�(���ۭq�� -1)
var    controlPage        =    "sgu060m_01c2.jsp";    //�����
var    queryObj        =    new queryObj();            //�d�ߤ���

/** ������l�� */
function page_init()
{
    page_init_start_2();

    /** === ��l���]�w === */
    /** ��l�s����� */
    Form.iniFormSet('EDIT', 'AYEAR', 'N1', 'M', 3, 'A', 'F', 3,'S',3);
    Form.iniFormSet('EDIT', 'SMS', 'M', 1, 'A');
    Form.iniFormSet('EDIT', 'STNO', 'N1', 'M', 9,'S',9, 'A');
    Form.iniFormSet('EDIT', 'FATHER_NAME', 'M',  20, 'A');
    Form.iniFormSet('EDIT', 'FATHER_ORIGINAL_COUNTRY', 'M',  2, 'A');
    Form.iniFormSet('EDIT', 'MOTHER_NAME', 'M',  20, 'A');
    Form.iniFormSet('EDIT', 'MOTHER_ORIGINAL_COUNTRY', 'M',  2, 'A');
    Form.iniFormSet('EDIT', 'AUDIT_MK', 'M',  1, 'A');

    /** ================ */

    /** === �]�w�ˮֱ��� === */
    /** �s����� */
    Form.iniFormSet('EDIT', 'AYEAR', 'AA', 'chkForm', '�Ǧ~');
    Form.iniFormSet('EDIT', 'SMS', 'AA', 'chkForm', '�Ǵ�');
    Form.iniFormSet('EDIT', 'STNO', 'AA', 'chkForm', '�Ǹ�');
    Form.iniFormSet('EDIT', 'FATHER_NAME', 'AA', 'chkForm', '���˩m�W');
    Form.iniFormSet('EDIT', 'FATHER_ORIGINAL_COUNTRY', 'AA', 'chkForm', '���˰�O');
    Form.iniFormSet('EDIT', 'MOTHER_NAME', 'AA', 'chkForm', '���˩m�W');
	Form.iniFormSet('EDIT', 'MOTHER_ORIGINAL_COUNTRY', 'AA', 'chkForm', '���˰�O');
    /** ================ */

    page_init_end_2();
}

/** �s�W�\��ɩI�s */
function doAdd()
{
    doAdd_start();

    /** �M����Ū����(KEY)*/
    Form.iniFormSet('EDIT', 'AYEAR', 'R', 0);
    Form.iniFormSet('EDIT', 'SMS', 'R', 0);
    Form.iniFormSet('EDIT', 'STNO', 'R', 0);


    /** ��l�W�h�a�Ӫ� Key ��� */
    iniMasterKeyColumn();

    /** �]�w Focus */
    Form.iniFormSet('EDIT', 'AYEAR', 'FC');

    /** ��l�� Form �C�� */
    Form.iniFormColor();

    /** ����B�z */
    queryObj.endProcess ("�s�W���A����");
}

/** �ק�\��ɩI�s */
function doModify()
{
    /** �]�w�ק�Ҧ� */
    editMode        =    "UPD";
    EditStatus.innerHTML    =    "�ק�";

    /** �M����Ū����(KEY)*/
    Form.iniFormSet('EDIT', 'AYEAR', 'R', 1);
    Form.iniFormSet('EDIT', 'SMS', 'R', 1);
    Form.iniFormSet('EDIT', 'STNO', 'R', 1);


    /** ��l�� Form �C�� */
    Form.iniFormColor();

    /** �]�w Focus */
    Form.iniFormSet('EDIT', 'NEW_RESIDENT', 'FC');
}

/** �s�ɥ\��ɩI�s */
function doSave()
{
    doSave_start();

    /** �P�_�s�W�L�v�����B�z */
    if (editMode == "NONE")
        return;

    /** === �۩w�ˬd === */
    /** ����ˮ֤γ]�w, �����~�B�z�覡�� Form.errAppend(Message) �֭p���~�T�� */
    //if (Form.getInput("EDIT", "SYS_CD") == "")
    //    Form.errAppend("�t�νs�����i�ť�!!");
    /** ================ */

    doSave_end();
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
        if (<%=AUTICFM.securityCheck (session, "EXP")%>)
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